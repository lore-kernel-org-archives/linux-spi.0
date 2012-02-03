From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH v2] spi: create a message queueing infrastructure
Date: Fri, 3 Feb 2012 15:03:56 +0100
Message-ID: <1328277836-4598-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This rips the message queue in the PL022 driver out and pushes
it into (optional) common infrastructure. Drivers that want to
use the message pumping thread will need to define the new
per-messags transfer methods and leave the deprecated transfer()
method as NULL.

Most of the design is described in the documentation changes that
are included in this patch.

Since there is a queue that need to be stopped when the system
is suspending/resuming, two new calls are implemented for the
device drivers to call in their suspend()/resume() functions:
spi_master_suspend() and spi_master_resume().

ChangeLog v1->v2:
- Remove Kconfig entry and do not make the queue support optional
  at all, instead be more agressive and have it as part of the
  compulsory infrastructure.
- If the .transfer() method is implemented, delete print a small
  deprecation notice and do not start the transfer pump.
- Fix a bitrotted comment.

Cc: Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/spi/spi-summary |   58 ++++++--
 drivers/spi/spi-pl022.c       |  303 +++++++------------------------------
 drivers/spi/spi.c             |  339 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/spi/spi.h       |   51 ++++++
 4 files changed, 487 insertions(+), 264 deletions(-)

diff --git a/Documentation/spi/spi-summary b/Documentation/spi/spi-summary
index 4884cb3..7312ec1 100644
--- a/Documentation/spi/spi-summary
+++ b/Documentation/spi/spi-summary
@@ -1,7 +1,7 @@
 Overview of Linux kernel SPI support
 ====================================
 
-21-May-2007
+02-Feb-2012
 
 What is SPI?
 ------------
@@ -483,9 +483,9 @@ also initialize its own internal state.  (See below about bus numbering
 and those methods.)
 
 After you initialize the spi_master, then use spi_register_master() to
-publish it to the rest of the system.  At that time, device nodes for
-the controller and any predeclared spi devices will be made available,
-and the driver model core will take care of binding them to drivers.
+publish it to the rest of the system. At that time, device nodes for the
+controller and any predeclared spi devices will be made available, and
+the driver model core will take care of binding them to drivers.
 
 If you need to remove your SPI controller driver, spi_unregister_master()
 will reverse the effect of spi_register_master().
@@ -521,21 +521,53 @@ SPI MASTER METHODS
 		** When you code setup(), ASSUME that the controller
 		** is actively processing transfers for another device.
 
-    master->transfer(struct spi_device *spi, struct spi_message *message)
-    	This must not sleep.  Its responsibility is arrange that the
-	transfer happens and its complete() callback is issued.  The two
-	will normally happen later, after other transfers complete, and
-	if the controller is idle it will need to be kickstarted.
-
     master->cleanup(struct spi_device *spi)
 	Your controller driver may use spi_device.controller_state to hold
 	state it dynamically associates with that device.  If you do that,
 	be sure to provide the cleanup() method to free that state.
 
+    master->prepare_transfer_hardware(struct spi_master *master)
+	This will be called by the queue mechanism to signal to the driver
+	that a message is coming in soon, so the subsystem requests the
+	driver to prepare the transfer hardware by issuing this call.
+	This may sleep.
+
+    master->unprepare_transfer_hardware(struct spi_master *master)
+	This will be called by the queue mechanism to signal to the driver
+	that there are no more messages pending in the queue and it may
+	relax the hardware (e.g. by power management calls). This may sleep.
+
+    master->transfer_one_message(struct spi_master *master,
+				 struct spi_message *mesg)
+	The subsystem calls the driver to transfer a single message while
+	queuing transfers that arrive in the meantime. When the driver is
+	finished with this message, it must call
+	spi_finalize_current_message() so the subsystem can issue the next
+	transfer. This may sleep.
+
+    DEPRECATED METHODS
+
+    master->transfer(struct spi_device *spi, struct spi_message *message)
+	This must not sleep. Its responsibility is arrange that the
+	transfer happens and its complete() callback is issued. The two
+	will normally happen later, after other transfers complete, and
+	if the controller is idle it will need to be kickstarted. This
+	method is not used on queued controllers and must be NULL if
+	transfer_one_message() and (un)prepare_transfer_hardware() are
+	implemented.
+
 
 SPI MESSAGE QUEUE
 
-The bulk of the driver will be managing the I/O queue fed by transfer().
+If you are happy with the standard queueing mechanism provided by the
+SPI subsystem, just implement the queued methods specified above. Using
+the message queue has the upside of centralizing a lot of code and
+providing pure process-context execution of methods. The message queue
+can also be elevated to realtime priority on high-priority SPI traffic.
+
+Unless the queueing mechanism in the SPI subsystem is selected, the bulk
+of the driver will be managing the I/O queue fed by the now deprecated
+function transfer().
 
 That queue could be purely conceptual.  For example, a driver used only
 for low-frequency sensor access might be fine using synchronous PIO.
@@ -561,4 +593,6 @@ Stephen Street
 Mark Underwood
 Andrew Victor
 Vitaly Wool
-
+Grant Likely
+Mark Brown
+Linus Walleij
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 81847c9..b3cf496 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -29,7 +29,6 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/spi/spi.h>
-#include <linux/kthread.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -41,7 +40,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/scatterlist.h>
 #include <linux/pm_runtime.h>
-#include <linux/sched.h>
 
 /*
  * This macro is used to define some register default values.
@@ -367,15 +365,7 @@ struct pl022 {
 	struct clk			*clk;
 	struct spi_master		*master;
 	struct pl022_ssp_controller	*master_info;
-	/* Driver message pump */
-	struct kthread_worker		kworker;
-	struct task_struct		*kworker_task;
-	struct kthread_work		pump_messages;
-	spinlock_t			queue_lock;
-	struct list_head		queue;
-	bool				busy;
-	bool				running;
-	/* Message transfer pump */
+	/* Message per-transfer pump */
 	struct tasklet_struct		pump_transfers;
 	struct spi_message		*cur_msg;
 	struct spi_transfer		*cur_transfer;
@@ -397,6 +387,7 @@ struct pl022 {
 	struct sg_table			sgt_rx;
 	struct sg_table			sgt_tx;
 	char				*dummypage;
+	bool				dma_running;
 #endif
 };
 
@@ -451,8 +442,6 @@ static void null_cs_control(u32 command)
 static void giveback(struct pl022 *pl022)
 {
 	struct spi_transfer *last_transfer;
-	unsigned long flags;
-	struct spi_message *msg;
 	pl022->next_msg_cs_active = false;
 
 	last_transfer = list_entry(pl022->cur_msg->transfers.prev,
@@ -480,15 +469,8 @@ static void giveback(struct pl022 *pl022)
 		 * sent the current message could be unloaded, which
 		 * could invalidate the cs_control() callback...
 		 */
-
 		/* get a pointer to the next message, if any */
-		spin_lock_irqsave(&pl022->queue_lock, flags);
-		if (list_empty(&pl022->queue))
-			next_msg = NULL;
-		else
-			next_msg = list_entry(pl022->queue.next,
-					struct spi_message, queue);
-		spin_unlock_irqrestore(&pl022->queue_lock, flags);
+		next_msg = spi_get_next_queued_message(pl022->master);
 
 		/*
 		 * see if the next and current messages point
@@ -500,19 +482,13 @@ static void giveback(struct pl022 *pl022)
 			pl022->cur_chip->cs_control(SSP_CHIP_DESELECT);
 		else
 			pl022->next_msg_cs_active = true;
+
 	}
 
-	spin_lock_irqsave(&pl022->queue_lock, flags);
-	msg = pl022->cur_msg;
+	spi_finalize_current_message(pl022->master);
 	pl022->cur_msg = NULL;
 	pl022->cur_transfer = NULL;
 	pl022->cur_chip = NULL;
-	queue_kthread_work(&pl022->kworker, &pl022->pump_messages);
-	spin_unlock_irqrestore(&pl022->queue_lock, flags);
-
-	msg->state = NULL;
-	if (msg->complete)
-		msg->complete(msg->context);
 }
 
 /**
@@ -1066,6 +1042,7 @@ static int configure_dma(struct pl022 *pl022)
 	dmaengine_submit(txdesc);
 	dma_async_issue_pending(rxchan);
 	dma_async_issue_pending(txchan);
+	pl022->dma_running = true;
 
 	return 0;
 
@@ -1144,11 +1121,12 @@ static void terminate_dma(struct pl022 *pl022)
 	dmaengine_terminate_all(rxchan);
 	dmaengine_terminate_all(txchan);
 	unmap_free_dma_scatter(pl022);
+	pl022->dma_running = false;
 }
 
 static void pl022_dma_remove(struct pl022 *pl022)
 {
-	if (pl022->busy)
+	if (pl022->dma_running)
 		terminate_dma(pl022);
 	if (pl022->dma_tx_channel)
 		dma_release_channel(pl022->dma_tx_channel);
@@ -1496,73 +1474,20 @@ out:
 	return;
 }
 
-/**
- * pump_messages - kthread work function which processes spi message queue
- * @work: pointer to kthread work struct contained in the pl022 private struct
- *
- * This function checks if there is any spi message in the queue that
- * needs processing and delegate control to appropriate function
- * do_polling_transfer()/do_interrupt_dma_transfer()
- * based on the kind of the transfer
- *
- */
-static void pump_messages(struct kthread_work *work)
+static int pl022_transfer_one_message(struct spi_master *master,
+				      struct spi_message *msg)
 {
-	struct pl022 *pl022 =
-		container_of(work, struct pl022, pump_messages);
-	unsigned long flags;
-	bool was_busy = false;
-
-	/* Lock queue and check for queue work */
-	spin_lock_irqsave(&pl022->queue_lock, flags);
-	if (list_empty(&pl022->queue) || !pl022->running) {
-		if (pl022->busy) {
-			/* nothing more to do - disable spi/ssp and power off */
-			writew((readw(SSP_CR1(pl022->virtbase)) &
-				(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
-
-			if (pl022->master_info->autosuspend_delay > 0) {
-				pm_runtime_mark_last_busy(&pl022->adev->dev);
-				pm_runtime_put_autosuspend(&pl022->adev->dev);
-			} else {
-				pm_runtime_put(&pl022->adev->dev);
-			}
-		}
-		pl022->busy = false;
-		spin_unlock_irqrestore(&pl022->queue_lock, flags);
-		return;
-	}
-
-	/* Make sure we are not already running a message */
-	if (pl022->cur_msg) {
-		spin_unlock_irqrestore(&pl022->queue_lock, flags);
-		return;
-	}
-	/* Extract head of queue */
-	pl022->cur_msg =
-	    list_entry(pl022->queue.next, struct spi_message, queue);
-
-	list_del_init(&pl022->cur_msg->queue);
-	if (pl022->busy)
-		was_busy = true;
-	else
-		pl022->busy = true;
-	spin_unlock_irqrestore(&pl022->queue_lock, flags);
+	struct pl022 *pl022 = spi_master_get_devdata(master);
 
 	/* Initial message state */
-	pl022->cur_msg->state = STATE_START;
-	pl022->cur_transfer = list_entry(pl022->cur_msg->transfers.next,
-					    struct spi_transfer, transfer_list);
+	pl022->cur_msg = msg;
+	msg->state = STATE_START;
+
+	pl022->cur_transfer = list_entry(msg->transfers.next,
+					 struct spi_transfer, transfer_list);
 
 	/* Setup the SPI using the per chip configuration */
-	pl022->cur_chip = spi_get_ctldata(pl022->cur_msg->spi);
-	if (!was_busy)
-		/*
-		 * We enable the core voltage and clocks here, then the clocks
-		 * and core will be disabled when this thread is run again
-		 * and there is no more work to be done.
-		 */
-		pm_runtime_get_sync(&pl022->adev->dev);
+	pl022->cur_chip = spi_get_ctldata(msg->spi);
 
 	restore_state(pl022);
 	flush(pl022);
@@ -1571,119 +1496,37 @@ static void pump_messages(struct kthread_work *work)
 		do_polling_transfer(pl022);
 	else
 		do_interrupt_dma_transfer(pl022);
-}
-
-static int __init init_queue(struct pl022 *pl022)
-{
-	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
-
-	INIT_LIST_HEAD(&pl022->queue);
-	spin_lock_init(&pl022->queue_lock);
-
-	pl022->running = false;
-	pl022->busy = false;
-
-	tasklet_init(&pl022->pump_transfers, pump_transfers,
-			(unsigned long)pl022);
-
-	init_kthread_worker(&pl022->kworker);
-	pl022->kworker_task = kthread_run(kthread_worker_fn,
-					&pl022->kworker,
-					dev_name(pl022->master->dev.parent));
-	if (IS_ERR(pl022->kworker_task)) {
-		dev_err(&pl022->adev->dev,
-			"failed to create message pump task\n");
-		return -ENOMEM;
-	}
-	init_kthread_work(&pl022->pump_messages, pump_messages);
-
-	/*
-	 * Board config will indicate if this controller should run the
-	 * message pump with high (realtime) priority to reduce the transfer
-	 * latency on the bus by minimising the delay between a transfer
-	 * request and the scheduling of the message pump thread. Without this
-	 * setting the message pump thread will remain at default priority.
-	 */
-	if (pl022->master_info->rt) {
-		dev_info(&pl022->adev->dev,
-			"will run message pump with realtime priority\n");
-		sched_setscheduler(pl022->kworker_task, SCHED_FIFO, &param);
-	}
 
 	return 0;
 }
 
-static int start_queue(struct pl022 *pl022)
+static int pl022_prepare_transfer_hardware(struct spi_master *master)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&pl022->queue_lock, flags);
-
-	if (pl022->running || pl022->busy) {
-		spin_unlock_irqrestore(&pl022->queue_lock, flags);
-		return -EBUSY;
-	}
-
-	pl022->running = true;
-	pl022->cur_msg = NULL;
-	pl022->cur_transfer = NULL;
-	pl022->cur_chip = NULL;
-	pl022->next_msg_cs_active = false;
-	spin_unlock_irqrestore(&pl022->queue_lock, flags);
-
-	queue_kthread_work(&pl022->kworker, &pl022->pump_messages);
+	struct pl022 *pl022 = spi_master_get_devdata(master);
 
+	/*
+	 * Just make sure we have all we need to run the transfer by syncing
+	 * with the runtime PM framework.
+	 */
+	pm_runtime_get_sync(&pl022->adev->dev);
 	return 0;
 }
 
-static int stop_queue(struct pl022 *pl022)
+static int pl022_unprepare_transfer_hardware(struct spi_master *master)
 {
-	unsigned long flags;
-	unsigned limit = 500;
-	int status = 0;
+	struct pl022 *pl022 = spi_master_get_devdata(master);
 
-	spin_lock_irqsave(&pl022->queue_lock, flags);
+	/* nothing more to do - disable spi/ssp and power off */
+	writew((readw(SSP_CR1(pl022->virtbase)) &
+		(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
 
-	/* This is a bit lame, but is optimized for the common execution path.
-	 * A wait_queue on the pl022->busy could be used, but then the common
-	 * execution path (pump_messages) would be required to call wake_up or
-	 * friends on every SPI message. Do this instead */
-	while ((!list_empty(&pl022->queue) || pl022->busy) && limit--) {
-		spin_unlock_irqrestore(&pl022->queue_lock, flags);
-		msleep(10);
-		spin_lock_irqsave(&pl022->queue_lock, flags);
+	if (pl022->master_info->autosuspend_delay > 0) {
+		pm_runtime_mark_last_busy(&pl022->adev->dev);
+		pm_runtime_put_autosuspend(&pl022->adev->dev);
+	} else {
+		pm_runtime_put(&pl022->adev->dev);
 	}
 
-	if (!list_empty(&pl022->queue) || pl022->busy)
-		status = -EBUSY;
-	else
-		pl022->running = false;
-
-	spin_unlock_irqrestore(&pl022->queue_lock, flags);
-
-	return status;
-}
-
-static int destroy_queue(struct pl022 *pl022)
-{
-	int status;
-
-	status = stop_queue(pl022);
-
-	/*
-	 * We are unloading the module or failing to load (only two calls
-	 * to this routine), and neither call can handle a return value.
-	 * However, flush_kthread_worker will block until all work is done.
-	 * If the reason that stop_queue timed out is that the work will never
-	 * finish, then it does no good to call flush/stop thread, so
-	 * return anyway.
-	 */
-	if (status != 0)
-		return status;
-
-	flush_kthread_worker(&pl022->kworker);
-	kthread_stop(pl022->kworker_task);
-
 	return 0;
 }
 
@@ -1803,38 +1646,6 @@ static int verify_controller_parameters(struct pl022 *pl022,
 	return 0;
 }
 
-/**
- * pl022_transfer - transfer function registered to SPI master framework
- * @spi: spi device which is requesting transfer
- * @msg: spi message which is to handled is queued to driver queue
- *
- * This function is registered to the SPI framework for this SPI master
- * controller. It will queue the spi_message in the queue of driver if
- * the queue is not stopped and return.
- */
-static int pl022_transfer(struct spi_device *spi, struct spi_message *msg)
-{
-	struct pl022 *pl022 = spi_master_get_devdata(spi->master);
-	unsigned long flags;
-
-	spin_lock_irqsave(&pl022->queue_lock, flags);
-
-	if (!pl022->running) {
-		spin_unlock_irqrestore(&pl022->queue_lock, flags);
-		return -ESHUTDOWN;
-	}
-	msg->actual_length = 0;
-	msg->status = -EINPROGRESS;
-	msg->state = STATE_START;
-
-	list_add_tail(&msg->queue, &pl022->queue);
-	if (pl022->running && !pl022->busy)
-		queue_kthread_work(&pl022->kworker, &pl022->pump_messages);
-
-	spin_unlock_irqrestore(&pl022->queue_lock, flags);
-	return 0;
-}
-
 static inline u32 spi_rate(u32 rate, u16 cpsdvsr, u16 scr)
 {
 	return rate / (cpsdvsr * (1 + scr));
@@ -2197,7 +2008,10 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	master->num_chipselect = platform_info->num_chipselect;
 	master->cleanup = pl022_cleanup;
 	master->setup = pl022_setup;
-	master->transfer = pl022_transfer;
+	master->prepare_transfer_hardware = pl022_prepare_transfer_hardware;
+	master->transfer_one_message = pl022_transfer_one_message;
+	master->unprepare_transfer_hardware = pl022_unprepare_transfer_hardware;
+	master->rt = platform_info->rt;
 
 	/*
 	 * Supports mode 0-3, loopback, and active low CS. Transfers are
@@ -2241,6 +2055,10 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_no_clk_en;
 	}
 
+	/* Initialize transfer pump */
+	tasklet_init(&pl022->pump_transfers, pump_transfers,
+		     (unsigned long)pl022);
+
 	/* Disable SSP */
 	writew((readw(SSP_CR1(pl022->virtbase)) & (~SSP_CR1_MASK_SSE)),
 	       SSP_CR1(pl022->virtbase));
@@ -2260,17 +2078,6 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 			platform_info->enable_dma = 0;
 	}
 
-	/* Initialize and start queue */
-	status = init_queue(pl022);
-	if (status != 0) {
-		dev_err(&adev->dev, "probe - problem initializing queue\n");
-		goto err_init_queue;
-	}
-	status = start_queue(pl022);
-	if (status != 0) {
-		dev_err(&adev->dev, "probe - problem starting queue\n");
-		goto err_start_queue;
-	}
 	/* Register with the SPI framework */
 	amba_set_drvdata(adev, pl022);
 	status = spi_register_master(master);
@@ -2296,9 +2103,6 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	return 0;
 
  err_spi_register:
- err_start_queue:
- err_init_queue:
-	destroy_queue(pl022);
 	if (platform_info->enable_dma)
 		pl022_dma_remove(pl022);
 
@@ -2334,9 +2138,6 @@ pl022_remove(struct amba_device *adev)
 	 */
 	pm_runtime_get_noresume(&adev->dev);
 
-	/* Remove the queue */
-	if (destroy_queue(pl022) != 0)
-		dev_err(&adev->dev, "queue remove failed\n");
 	load_ssp_default_config(pl022);
 	if (pl022->master_info->enable_dma)
 		pl022_dma_remove(pl022);
@@ -2358,12 +2159,12 @@ pl022_remove(struct amba_device *adev)
 static int pl022_suspend(struct device *dev)
 {
 	struct pl022 *pl022 = dev_get_drvdata(dev);
-	int status = 0;
+	int ret;
 
-	status = stop_queue(pl022);
-	if (status) {
-		dev_warn(dev, "suspend cannot stop queue\n");
-		return status;
+	ret = spi_master_suspend(pl022->master);
+	if (ret) {
+		dev_warn(dev, "cannot suspend master\n");
+		return ret;
 	}
 
 	dev_dbg(dev, "suspended\n");
@@ -2373,16 +2174,16 @@ static int pl022_suspend(struct device *dev)
 static int pl022_resume(struct device *dev)
 {
 	struct pl022 *pl022 = dev_get_drvdata(dev);
-	int status = 0;
+	int ret;
 
 	/* Start the queue running */
-	status = start_queue(pl022);
-	if (status)
-		dev_err(dev, "problem starting queue (%d)\n", status);
+	ret = spi_master_resume(pl022->master);
+	if (ret)
+		dev_err(dev, "problem starting queue (%d)\n", ret);
 	else
 		dev_dbg(dev, "resumed\n");
 
-	return status;
+	return ret;
 }
 #endif	/* CONFIG_PM */
 
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b2ccdea..909e303 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -30,6 +30,9 @@
 #include <linux/of_spi.h>
 #include <linux/pm_runtime.h>
 #include <linux/export.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
 
 static void spidev_release(struct device *dev)
 {
@@ -507,6 +510,293 @@ spi_register_board_info(struct spi_board_info const *info, unsigned n)
 
 /*-------------------------------------------------------------------------*/
 
+/**
+ * spi_pump_messages - kthread work function which processes spi message queue
+ * @work: pointer to kthread work struct contained in the master struct
+ *
+ * This function checks if there is any spi message in the queue that
+ * needs processing and if so call out to the driver to initialize hardware
+ * and transfer each message.
+ *
+ */
+static void spi_pump_messages(struct kthread_work *work)
+{
+	struct spi_master *master =
+		container_of(work, struct spi_master, pump_messages);
+	unsigned long flags;
+	bool was_busy = false;
+	int ret;
+
+	/* Lock queue and check for queue work */
+	spin_lock_irqsave(&master->queue_lock, flags);
+	if (list_empty(&master->queue) || !master->running) {
+		if (master->busy) {
+			ret = master->unprepare_transfer_hardware(master);
+			if (ret) {
+				dev_err(&master->dev,
+					"failed to unprepare transfer hardware\n");
+				return;
+			}
+		}
+		master->busy = false;
+		spin_unlock_irqrestore(&master->queue_lock, flags);
+		return;
+	}
+
+	/* Make sure we are not already running a message */
+	if (master->cur_msg) {
+		spin_unlock_irqrestore(&master->queue_lock, flags);
+		return;
+	}
+	/* Extract head of queue */
+	master->cur_msg =
+	    list_entry(master->queue.next, struct spi_message, queue);
+
+	list_del_init(&master->cur_msg->queue);
+	if (master->busy)
+		was_busy = true;
+	else
+		master->busy = true;
+	spin_unlock_irqrestore(&master->queue_lock, flags);
+
+	if (!was_busy) {
+		ret = master->prepare_transfer_hardware(master);
+		if (ret) {
+			dev_err(&master->dev,
+				"failed to prepare transfer hardware\n");
+			return;
+		}
+	}
+
+	ret = master->transfer_one_message(master, master->cur_msg);
+	if (ret) {
+		dev_err(&master->dev,
+			"failed to transfer one message from queue\n");
+		return;
+	}
+}
+
+static int spi_init_queue(struct spi_master *master)
+{
+	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
+
+	INIT_LIST_HEAD(&master->queue);
+	spin_lock_init(&master->queue_lock);
+
+	master->running = false;
+	master->busy = false;
+
+	init_kthread_worker(&master->kworker);
+	master->kworker_task = kthread_run(kthread_worker_fn,
+					   &master->kworker,
+					   dev_name(&master->dev));
+	if (IS_ERR(master->kworker_task)) {
+		dev_err(&master->dev, "failed to create message pump task\n");
+		return -ENOMEM;
+	}
+	init_kthread_work(&master->pump_messages, spi_pump_messages);
+
+	/*
+	 * Master config will indicate if this controller should run the
+	 * message pump with high (realtime) priority to reduce the transfer
+	 * latency on the bus by minimising the delay between a transfer
+	 * request and the scheduling of the message pump thread. Without this
+	 * setting the message pump thread will remain at default priority.
+	 */
+	if (master->rt) {
+		dev_info(&master->dev,
+			"will run message pump with realtime priority\n");
+		sched_setscheduler(master->kworker_task, SCHED_FIFO, &param);
+	}
+
+	return 0;
+}
+
+/**
+ * spi_get_next_queued_message() - called by driver to check for queued
+ * messages
+ * @master: the master to check for queued messages
+ *
+ * If there are more messages in the queue, the next message is returned from
+ * this call.
+ */
+struct spi_message *spi_get_next_queued_message(struct spi_master *master)
+{
+	struct spi_message *next;
+	unsigned long flags;
+
+	/* get a pointer to the next message, if any */
+	spin_lock_irqsave(&master->queue_lock, flags);
+	if (list_empty(&master->queue))
+		next = NULL;
+	else
+		next = list_entry(master->queue.next,
+				  struct spi_message, queue);
+	spin_unlock_irqrestore(&master->queue_lock, flags);
+
+	return next;
+}
+EXPORT_SYMBOL_GPL(spi_get_next_queued_message);
+
+/**
+ * spi_finalize_current_message() - the current message is complete
+ * @master: the master to return the message to
+ *
+ * Called by the driver to notify the core that the message in the front of the
+ * queue is complete and can be removed from the queue.
+ */
+void spi_finalize_current_message(struct spi_master *master)
+{
+	struct spi_message *mesg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&master->queue_lock, flags);
+	mesg = master->cur_msg;
+	master->cur_msg = NULL;
+
+	queue_kthread_work(&master->kworker, &master->pump_messages);
+	spin_unlock_irqrestore(&master->queue_lock, flags);
+
+	mesg->state = NULL;
+	if (mesg->complete)
+		mesg->complete(mesg->context);
+}
+EXPORT_SYMBOL_GPL(spi_finalize_current_message);
+
+static int spi_start_queue(struct spi_master *master)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&master->queue_lock, flags);
+
+	if (master->running || master->busy) {
+		spin_unlock_irqrestore(&master->queue_lock, flags);
+		return -EBUSY;
+	}
+
+	master->running = true;
+	master->cur_msg = NULL;
+	spin_unlock_irqrestore(&master->queue_lock, flags);
+
+	queue_kthread_work(&master->kworker, &master->pump_messages);
+
+	return 0;
+}
+
+static int spi_stop_queue(struct spi_master *master)
+{
+	unsigned long flags;
+	unsigned limit = 500;
+	int ret = 0;
+
+	spin_lock_irqsave(&master->queue_lock, flags);
+
+	/*
+	 * This is a bit lame, but is optimized for the common execution path.
+	 * A wait_queue on the master->busy could be used, but then the common
+	 * execution path (pump_messages) would be required to call wake_up or
+	 * friends on every SPI message. Do this instead.
+	 */
+	while ((!list_empty(&master->queue) || master->busy) && limit--) {
+		spin_unlock_irqrestore(&master->queue_lock, flags);
+		msleep(10);
+		spin_lock_irqsave(&master->queue_lock, flags);
+	}
+
+	if (!list_empty(&master->queue) || master->busy)
+		ret = -EBUSY;
+	else
+		master->running = false;
+
+	spin_unlock_irqrestore(&master->queue_lock, flags);
+
+	if (ret) {
+		dev_warn(&master->dev,
+			 "could not stop message queue\n");
+		return ret;
+	}
+	return ret;
+}
+
+static int spi_destroy_queue(struct spi_master *master)
+{
+	int ret;
+
+	ret = spi_stop_queue(master);
+
+	/*
+	 * flush_kthread_worker will block until all work is done.
+	 * If the reason that stop_queue timed out is that the work will never
+	 * finish, then it does no good to call flush/stop thread, so
+	 * return anyway.
+	 */
+	if (ret) {
+		dev_err(&master->dev, "problem destroying queue\n");
+		return ret;
+	}
+
+	flush_kthread_worker(&master->kworker);
+	kthread_stop(master->kworker_task);
+
+	return 0;
+}
+
+/**
+ * spi_queued_transfer - transfer function for queued transfers
+ * @spi: spi device which is requesting transfer
+ * @msg: spi message which is to handled is queued to driver queue
+ */
+static int spi_queued_transfer(struct spi_device *spi, struct spi_message *msg)
+{
+	struct spi_master *master = spi->master;
+	unsigned long flags;
+
+	spin_lock_irqsave(&master->queue_lock, flags);
+
+	if (!master->running) {
+		spin_unlock_irqrestore(&master->queue_lock, flags);
+		return -ESHUTDOWN;
+	}
+	msg->actual_length = 0;
+	msg->status = -EINPROGRESS;
+
+	list_add_tail(&msg->queue, &master->queue);
+	if (master->running && !master->busy)
+		queue_kthread_work(&master->kworker, &master->pump_messages);
+
+	spin_unlock_irqrestore(&master->queue_lock, flags);
+	return 0;
+}
+
+static int spi_master_initialize_queue(struct spi_master *master)
+{
+	int ret;
+
+	master->queued = true;
+	master->transfer = spi_queued_transfer;
+
+	/* Initialize and start queue */
+	ret = spi_init_queue(master);
+	if (ret) {
+		dev_err(&master->dev, "problem initializing queue\n");
+		goto err_init_queue;
+	}
+	ret = spi_start_queue(master);
+	if (ret) {
+		dev_err(&master->dev, "problem starting queue\n");
+		goto err_start_queue;
+	}
+
+	return 0;
+
+err_start_queue:
+err_init_queue:
+	spi_destroy_queue(master);
+	return ret;
+}
+
+/*-------------------------------------------------------------------------*/
+
 static void spi_master_release(struct device *dev)
 {
 	struct spi_master *master;
@@ -522,6 +812,7 @@ static struct class spi_master_class = {
 };
 
 
+
 /**
  * spi_alloc_master - allocate SPI master controller
  * @dev: the controller, possibly using the platform_bus
@@ -621,6 +912,17 @@ int spi_register_master(struct spi_master *master)
 	dev_dbg(dev, "registered master %s%s\n", dev_name(&master->dev),
 			dynamic ? " (dynamic)" : "");
 
+	/* If we're using a queued driver, start the queue */
+	if (master->transfer)
+		dev_info(dev, "master is unqueued, this is deprecated\n");
+	else {
+		status = spi_master_initialize_queue(master);
+		if (status) {
+			device_unregister(&master->dev);
+			goto done;
+		}
+	}
+
 	mutex_lock(&board_lock);
 	list_add_tail(&master->list, &spi_master_list);
 	list_for_each_entry(bi, &board_list, list)
@@ -636,7 +938,6 @@ done:
 }
 EXPORT_SYMBOL_GPL(spi_register_master);
 
-
 static int __unregister(struct device *dev, void *null)
 {
 	spi_unregister_device(to_spi_device(dev));
@@ -657,6 +958,11 @@ void spi_unregister_master(struct spi_master *master)
 {
 	int dummy;
 
+	if (master->queued) {
+		if (spi_destroy_queue(master))
+			dev_err(&master->dev, "queue remove failed\n");
+	}
+
 	mutex_lock(&board_lock);
 	list_del(&master->list);
 	mutex_unlock(&board_lock);
@@ -666,6 +972,37 @@ void spi_unregister_master(struct spi_master *master)
 }
 EXPORT_SYMBOL_GPL(spi_unregister_master);
 
+int spi_master_suspend(struct spi_master *master)
+{
+	int ret;
+
+	/* Basically no-ops for non-queued masters */
+	if (!master->queued)
+		return 0;
+
+	ret = spi_destroy_queue(master);
+	if (ret)
+		dev_err(&master->dev, "queue remove failed\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_master_suspend);
+
+int spi_master_resume(struct spi_master *master)
+{
+	int ret;
+
+	if (!master->queued)
+		return 0;
+
+	ret = spi_start_queue(master);
+	if (ret)
+		dev_err(&master->dev, "queue restart failed\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_master_resume);
+
 static int __spi_master_match(struct device *dev, void *data)
 {
 	struct spi_master *m;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 176fce9..f9e30a5 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -22,6 +22,7 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
+#include <linux/kthread.h>
 
 /*
  * INTERFACES between SPI master-side drivers and SPI infrastructure.
@@ -235,6 +236,27 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	the device whose settings are being modified.
  * @transfer: adds a message to the controller's transfer queue.
  * @cleanup: frees controller-specific state
+ * @queued: whether this master is providing an internal message queue
+ * @kworker: thread struct for message pump
+ * @kworker_task: pointer to task for message pump kworker thread
+ * @pump_messages: work struct for scheduling work to the message pump
+ * @queue_lock: spinlock to syncronise access to message queue
+ * @queue: message queue
+ * @cur_msg: the currently in-flight message
+ * @busy: message pump is busy
+ * @running: message pump is running
+ * @rt: whether this queue is set to run as a realtime task
+ * @prepare_transfer_hardware: a message will soon arrive from the queue
+ *	so the subsystem requests the driver to prepare the transfer hardware
+ *	by issuing this call
+ * @transfer_one_message: the subsystem calls the driver to transfer a single
+ *	message while queuing transfers that arrive in the meantime. When the
+ *	driver is finished with this message, it must call
+ *	spi_finalize_current_message() so the subsystem can issue the next
+ *	transfer
+ * @prepare_transfer_hardware: there are currently no more messages on the
+ *	queue so the subsystem notifies the driver that it may relax the
+ *	hardware by issuing this call
  *
  * Each SPI master controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -318,6 +340,28 @@ struct spi_master {
 
 	/* called on release() to free memory provided by spi_master */
 	void			(*cleanup)(struct spi_device *spi);
+
+	/*
+	 * These hooks are for drivers that want to use the generic
+	 * master transfer queueing mechanism. If these are used, the
+	 * transfer() function above must NOT be specified by the driver.
+	 * Over time we expect SPI drivers to be phased over to this API.
+	 */
+	bool				queued;
+	struct kthread_worker		kworker;
+	struct task_struct		*kworker_task;
+	struct kthread_work		pump_messages;
+	spinlock_t			queue_lock;
+	struct list_head		queue;
+	struct spi_message		*cur_msg;
+	bool				busy;
+	bool				running;
+	bool				rt;
+
+	int (*prepare_transfer_hardware)(struct spi_master *master);
+	int (*transfer_one_message)(struct spi_master *master,
+				    struct spi_message *mesg);
+	int (*unprepare_transfer_hardware)(struct spi_master *master);
 };
 
 static inline void *spi_master_get_devdata(struct spi_master *master)
@@ -343,6 +387,13 @@ static inline void spi_master_put(struct spi_master *master)
 		put_device(&master->dev);
 }
 
+/* PM calls that need to be issued by the driver */
+extern int spi_master_suspend(struct spi_master *master);
+extern int spi_master_resume(struct spi_master *master);
+
+/* Calls the driver make to interact with the message queue */
+extern struct spi_message *spi_get_next_queued_message(struct spi_master *master);
+extern void spi_finalize_current_message(struct spi_master *master);
 
 /* the spi driver core manages memory for the spi_master classdev */
 extern struct spi_master *
-- 
1.7.8


------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
