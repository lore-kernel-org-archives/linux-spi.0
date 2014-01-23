From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH RFC 4/4] spi: dw: migrate to generic queue infrastructure
Date: Thu, 23 Jan 2014 15:05:59 +0200
Message-ID: <cb13f97edb9250d51bc03d27bcc3ddda93821bf9.1390481413.git.baruch@tkos.co.il>
References: <cover.1390481412.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1390481412.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/spi/spi-dw.c | 183 ++++-----------------------------------------------
 drivers/spi/spi-dw.h |   8 ---
 2 files changed, 12 insertions(+), 179 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 595761593492..39a57adaf1fd 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -37,9 +37,6 @@
 #define DONE_STATE	((void *)2)
 #define ERROR_STATE	((void *)-1)
 
-#define QUEUE_RUNNING	0
-#define QUEUE_STOPPED	1
-
 #define MRST_SPI_DEASSERT	0
 #define MRST_SPI_ASSERT		1
 
@@ -264,20 +261,16 @@ static int map_dma_buffers(struct dw_spi *dws)
 static void giveback(struct dw_spi *dws)
 {
 	struct spi_transfer *last_transfer;
-	unsigned long flags;
 	struct spi_message *msg;
 	int cs_gpio = dws->cur_msg->spi->cs_gpio;
 	u16 mode = dws->cur_msg->spi->mode;
 
-	spin_lock_irqsave(&dws->lock, flags);
 	msg = dws->cur_msg;
 	dws->cur_msg = NULL;
 	dws->cur_transfer = NULL;
 	dws->prev_chip = dws->cur_chip;
 	dws->cur_chip = NULL;
 	dws->dma_mapped = 0;
-	queue_work(dws->workqueue, &dws->pump_messages);
-	spin_unlock_irqrestore(&dws->lock, flags);
 
 	last_transfer = list_entry(msg->transfers.prev,
 					struct spi_transfer,
@@ -290,9 +283,7 @@ static void giveback(struct dw_spi *dws)
 			gpio_set_value(cs_gpio, !(mode & SPI_CS_HIGH));
 	}
 
-	msg->state = NULL;
-	if (msg->complete)
-		msg->complete(msg->context);
+	spi_finalize_current_message(dws->master);
 }
 
 static void int_error_stop(struct dw_spi *dws, const char *msg)
@@ -544,30 +535,12 @@ early_exit:
 	return;
 }
 
-static void pump_messages(struct work_struct *work)
+static int dw_spi_transfer_one_message(struct spi_master *master,
+		struct spi_message *msg)
 {
-	struct dw_spi *dws =
-		container_of(work, struct dw_spi, pump_messages);
-	unsigned long flags;
-
-	/* Lock queue and check for queue work */
-	spin_lock_irqsave(&dws->lock, flags);
-	if (list_empty(&dws->queue) || dws->run == QUEUE_STOPPED) {
-		dws->busy = 0;
-		spin_unlock_irqrestore(&dws->lock, flags);
-		return;
-	}
-
-	/* Make sure we are not already running a message */
-	if (dws->cur_msg) {
-		spin_unlock_irqrestore(&dws->lock, flags);
-		return;
-	}
-
-	/* Extract head of queue */
-	dws->cur_msg = list_entry(dws->queue.next, struct spi_message, queue);
-	list_del_init(&dws->cur_msg->queue);
+	struct dw_spi *dws = spi_master_get_devdata(master);
 
+	dws->cur_msg = msg;
 	/* Initial message state*/
 	dws->cur_msg->state = START_STATE;
 	dws->cur_transfer = list_entry(dws->cur_msg->transfers.next,
@@ -575,46 +548,9 @@ static void pump_messages(struct work_struct *work)
 						transfer_list);
 	dws->cur_chip = spi_get_ctldata(dws->cur_msg->spi);
 
-	/* Mark as busy and launch transfers */
+	/* Launch transfers */
 	tasklet_schedule(&dws->pump_transfers);
 
-	dws->busy = 1;
-	spin_unlock_irqrestore(&dws->lock, flags);
-}
-
-/* spi_device use this to queue in their spi_msg */
-static int dw_spi_transfer(struct spi_device *spi, struct spi_message *msg)
-{
-	struct dw_spi *dws = spi_master_get_devdata(spi->master);
-	unsigned long flags;
-
-	spin_lock_irqsave(&dws->lock, flags);
-
-	if (dws->run == QUEUE_STOPPED) {
-		spin_unlock_irqrestore(&dws->lock, flags);
-		return -ESHUTDOWN;
-	}
-
-	msg->actual_length = 0;
-	msg->status = -EINPROGRESS;
-	msg->state = START_STATE;
-
-	list_add_tail(&msg->queue, &dws->queue);
-
-	if (dws->run == QUEUE_RUNNING && !dws->busy) {
-
-		if (dws->cur_transfer || dws->cur_msg)
-			queue_work(dws->workqueue,
-					&dws->pump_messages);
-		else {
-			/* If no other data transaction in air, just go */
-			spin_unlock_irqrestore(&dws->lock, flags);
-			pump_messages(&dws->pump_messages);
-			return 0;
-		}
-	}
-
-	spin_unlock_irqrestore(&dws->lock, flags);
 	return 0;
 }
 
@@ -704,81 +640,6 @@ static void dw_spi_cleanup(struct spi_device *spi)
 	kfree(chip);
 }
 
-static int init_queue(struct dw_spi *dws)
-{
-	INIT_LIST_HEAD(&dws->queue);
-	spin_lock_init(&dws->lock);
-
-	dws->run = QUEUE_STOPPED;
-	dws->busy = 0;
-
-	tasklet_init(&dws->pump_transfers,
-			pump_transfers,	(unsigned long)dws);
-
-	INIT_WORK(&dws->pump_messages, pump_messages);
-	dws->workqueue = create_singlethread_workqueue(
-					dev_name(dws->master->dev.parent));
-	if (dws->workqueue == NULL)
-		return -EBUSY;
-
-	return 0;
-}
-
-static int start_queue(struct dw_spi *dws)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&dws->lock, flags);
-
-	if (dws->run == QUEUE_RUNNING || dws->busy) {
-		spin_unlock_irqrestore(&dws->lock, flags);
-		return -EBUSY;
-	}
-
-	dws->run = QUEUE_RUNNING;
-	dws->cur_msg = NULL;
-	dws->cur_transfer = NULL;
-	dws->cur_chip = NULL;
-	dws->prev_chip = NULL;
-	spin_unlock_irqrestore(&dws->lock, flags);
-
-	queue_work(dws->workqueue, &dws->pump_messages);
-
-	return 0;
-}
-
-static int stop_queue(struct dw_spi *dws)
-{
-	unsigned long flags;
-	unsigned limit = 50;
-	int status = 0;
-
-	spin_lock_irqsave(&dws->lock, flags);
-	dws->run = QUEUE_STOPPED;
-	while ((!list_empty(&dws->queue) || dws->busy) && limit--) {
-		spin_unlock_irqrestore(&dws->lock, flags);
-		msleep(10);
-		spin_lock_irqsave(&dws->lock, flags);
-	}
-
-	if (!list_empty(&dws->queue) || dws->busy)
-		status = -EBUSY;
-	spin_unlock_irqrestore(&dws->lock, flags);
-
-	return status;
-}
-
-static int destroy_queue(struct dw_spi *dws)
-{
-	int status;
-
-	status = stop_queue(dws);
-	if (status != 0)
-		return status;
-	destroy_workqueue(dws->workqueue);
-	return 0;
-}
-
 /* Restart the controller, disable all interrupts, clean rx fifo */
 static void spi_hw_init(struct dw_spi *dws)
 {
@@ -835,7 +696,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	master->num_chipselect = dws->num_cs;
 	master->cleanup = dw_spi_cleanup;
 	master->setup = dw_spi_setup;
-	master->transfer = dw_spi_transfer;
+	master->transfer_one_message = dw_spi_transfer_one_message;
 
 	/* Basic HW init */
 	spi_hw_init(dws);
@@ -848,33 +709,21 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		}
 	}
 
-	/* Initial and start queue */
-	ret = init_queue(dws);
-	if (ret) {
-		dev_err(&master->dev, "problem initializing queue\n");
-		goto err_diable_hw;
-	}
-	ret = start_queue(dws);
-	if (ret) {
-		dev_err(&master->dev, "problem starting queue\n");
-		goto err_diable_hw;
-	}
+	tasklet_init(&dws->pump_transfers, pump_transfers, (unsigned long)dws);
 
 	spi_master_set_devdata(master, dws);
 	ret = devm_spi_register_master(dev, master);
 	if (ret) {
 		dev_err(&master->dev, "problem registering spi master\n");
-		goto err_queue_alloc;
+		goto err_dma_exit;
 	}
 
 	mrst_spi_debugfs_init(dws);
 	return 0;
 
-err_queue_alloc:
-	destroy_queue(dws);
+err_dma_exit:
 	if (dws->dma_ops && dws->dma_ops->dma_exit)
 		dws->dma_ops->dma_exit(dws);
-err_diable_hw:
 	spi_enable_chip(dws, 0);
 err_free_master:
 	spi_master_put(master);
@@ -884,18 +733,10 @@ EXPORT_SYMBOL_GPL(dw_spi_add_host);
 
 void dw_spi_remove_host(struct dw_spi *dws)
 {
-	int status = 0;
-
 	if (!dws)
 		return;
 	mrst_spi_debugfs_remove(dws);
 
-	/* Remove the queue */
-	status = destroy_queue(dws);
-	if (status != 0)
-		dev_err(&dws->master->dev,
-			"dw_spi_remove: workqueue will not complete, message memory not freed\n");
-
 	if (dws->dma_ops && dws->dma_ops->dma_exit)
 		dws->dma_ops->dma_exit(dws);
 	spi_enable_chip(dws, 0);
@@ -908,7 +749,7 @@ int dw_spi_suspend_host(struct dw_spi *dws)
 {
 	int ret = 0;
 
-	ret = stop_queue(dws);
+	ret = spi_master_suspend(dws->master);
 	if (ret)
 		return ret;
 	spi_enable_chip(dws, 0);
@@ -922,7 +763,7 @@ int dw_spi_resume_host(struct dw_spi *dws)
 	int ret;
 
 	spi_hw_init(dws);
-	ret = start_queue(dws);
+	ret = spi_master_resume(dws->master);
 	if (ret)
 		dev_err(&dws->master->dev, "fail to start queue (%d)\n", ret);
 	return ret;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 4a3a6d764b48..39844f262bd1 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -105,14 +105,6 @@ struct dw_spi {
 	u16			bus_num;
 	u16			num_cs;		/* supported slave numbers */
 
-	/* Driver message queue */
-	struct workqueue_struct	*workqueue;
-	struct work_struct	pump_messages;
-	spinlock_t		lock;
-	struct list_head	queue;
-	int			busy;
-	int			run;
-
 	/* Message Transfer pump */
 	struct tasklet_struct	pump_transfers;
 
-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
