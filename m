From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] spi/s3c64xx: Convert to using core message queue
Date: Wed, 15 Feb 2012 14:48:32 -0800
Message-ID: <1329346112-1647-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Cc: spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Kukjin Kim <kgene.kim@samsung.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Convert the s3c64xx driver to using the new message queue factored out of
the pl022 driver by Linus Walleij, saving us a nice block of code and
getting the benefits of improvements implemented in the core.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

Only lightly tested thus far.  Linus, it'd be really nice if you could
add this to your patch queue for this feature until it's merged by
Grant.

 drivers/spi/spi-s3c64xx.c |  125 ++++++++-------------------------------------
 1 files changed, 22 insertions(+), 103 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b899af66..1174d80 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -128,8 +128,6 @@
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
 
-#define SUSPND    (1<<0)
-#define SPIBUSY   (1<<1)
 #define RXBUSY    (1<<2)
 #define TXBUSY    (1<<3)
 
@@ -144,10 +142,8 @@ struct s3c64xx_spi_dma_data {
  * @clk: Pointer to the spi clock.
  * @src_clk: Pointer to the clock used to generate SPI signals.
  * @master: Pointer to the SPI Protocol master.
- * @workqueue: Work queue for the SPI xfer requests.
  * @cntrlr_info: Platform specific data for the controller this driver manages.
  * @tgl_spi: Pointer to the last CS left untoggled by the cs_change hint.
- * @work: Work
  * @queue: To log SPI xfer requests.
  * @lock: Controller specific lock.
  * @state: Set of FLAGS to indicate status.
@@ -167,10 +163,8 @@ struct s3c64xx_spi_driver_data {
 	struct clk                      *src_clk;
 	struct platform_device          *pdev;
 	struct spi_master               *master;
-	struct workqueue_struct	        *workqueue;
 	struct s3c64xx_spi_info  *cntrlr_info;
 	struct spi_device               *tgl_spi;
-	struct work_struct              work;
 	struct list_head                queue;
 	spinlock_t                      lock;
 	unsigned long                   sfr_start;
@@ -637,9 +631,10 @@ static void s3c64xx_spi_unmap_mssg(struct s3c64xx_spi_driver_data *sdd,
 	}
 }
 
-static void handle_msg(struct s3c64xx_spi_driver_data *sdd,
-					struct spi_message *msg)
+static int s3c64xx_spi_transfer_one_message(struct spi_master *master,
+					    struct spi_message *msg)
 {
+	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	struct spi_device *spi = msg->spi;
 	struct s3c64xx_spi_csinfo *cs = spi->controller_data;
@@ -771,13 +766,15 @@ out:
 
 	if (msg->complete)
 		msg->complete(msg->context);
+
+	spi_finalize_current_message(master);
+
+	return 0;
 }
 
-static void s3c64xx_spi_work(struct work_struct *work)
+static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 {
-	struct s3c64xx_spi_driver_data *sdd = container_of(work,
-					struct s3c64xx_spi_driver_data, work);
-	unsigned long flags;
+	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
 
 	/* Acquire DMA channels */
 	while (!acquire_dma(sdd))
@@ -785,61 +782,18 @@ static void s3c64xx_spi_work(struct work_struct *work)
 
 	pm_runtime_get_sync(&sdd->pdev->dev);
 
-	spin_lock_irqsave(&sdd->lock, flags);
-
-	while (!list_empty(&sdd->queue)
-				&& !(sdd->state & SUSPND)) {
-
-		struct spi_message *msg;
-
-		msg = container_of(sdd->queue.next, struct spi_message, queue);
-
-		list_del_init(&msg->queue);
-
-		/* Set Xfer busy flag */
-		sdd->state |= SPIBUSY;
-
-		spin_unlock_irqrestore(&sdd->lock, flags);
-
-		handle_msg(sdd, msg);
-
-		spin_lock_irqsave(&sdd->lock, flags);
-
-		sdd->state &= ~SPIBUSY;
-	}
+	return 0;
+}
 
-	spin_unlock_irqrestore(&sdd->lock, flags);
+static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
+{
+	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
 
 	/* Free DMA channels */
 	sdd->ops->release(sdd->rx_dma.ch, &s3c64xx_spi_dma_client);
 	sdd->ops->release(sdd->tx_dma.ch, &s3c64xx_spi_dma_client);
 
 	pm_runtime_put(&sdd->pdev->dev);
-}
-
-static int s3c64xx_spi_transfer(struct spi_device *spi,
-						struct spi_message *msg)
-{
-	struct s3c64xx_spi_driver_data *sdd;
-	unsigned long flags;
-
-	sdd = spi_master_get_devdata(spi->master);
-
-	spin_lock_irqsave(&sdd->lock, flags);
-
-	if (sdd->state & SUSPND) {
-		spin_unlock_irqrestore(&sdd->lock, flags);
-		return -ESHUTDOWN;
-	}
-
-	msg->status = -EINPROGRESS;
-	msg->actual_length = 0;
-
-	list_add_tail(&msg->queue, &sdd->queue);
-
-	queue_work(sdd->workqueue, &sdd->work);
-
-	spin_unlock_irqrestore(&sdd->lock, flags);
 
 	return 0;
 }
@@ -879,13 +833,6 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 		}
 	}
 
-	if (sdd->state & SUSPND) {
-		spin_unlock_irqrestore(&sdd->lock, flags);
-		dev_err(&spi->dev,
-			"setup: SPI-%d not active!\n", spi->master->bus_num);
-		return -ESHUTDOWN;
-	}
-
 	spin_unlock_irqrestore(&sdd->lock, flags);
 
 	if (spi->bits_per_word != 8
@@ -1073,7 +1020,9 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 
 	master->bus_num = pdev->id;
 	master->setup = s3c64xx_spi_setup;
-	master->transfer = s3c64xx_spi_transfer;
+	master->prepare_transfer_hardware = s3c64xx_spi_prepare_transfer;
+	master->transfer_one_message = s3c64xx_spi_transfer_one_message;
+	master->unprepare_transfer_hardware = s3c64xx_spi_unprepare_transfer;
 	master->num_chipselect = sci->num_cs;
 	master->dma_alignment = 8;
 	/* the spi->mode bits understood by this driver: */
@@ -1128,27 +1077,18 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 		goto err6;
 	}
 
-	sdd->workqueue = create_singlethread_workqueue(
-						dev_name(master->dev.parent));
-	if (sdd->workqueue == NULL) {
-		dev_err(&pdev->dev, "Unable to create workqueue\n");
-		ret = -ENOMEM;
-		goto err7;
-	}
-
 	/* Setup Deufult Mode */
 	s3c64xx_spi_hwinit(sdd, pdev->id);
 
 	spin_lock_init(&sdd->lock);
 	init_completion(&sdd->xfer_completion);
-	INIT_WORK(&sdd->work, s3c64xx_spi_work);
 	INIT_LIST_HEAD(&sdd->queue);
 
 	ret = request_irq(irq, s3c64xx_spi_irq, 0, "spi-s3c64xx", sdd);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to request IRQ %d: %d\n",
 			irq, ret);
-		goto err8;
+		goto err7;
 	}
 
 	writel(S3C64XX_SPI_INT_RX_OVERRUN_EN | S3C64XX_SPI_INT_RX_UNDERRUN_EN |
@@ -1158,7 +1098,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 	if (spi_register_master(master)) {
 		dev_err(&pdev->dev, "cannot register SPI master\n");
 		ret = -EBUSY;
-		goto err9;
+		goto err8;
 	}
 
 	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d "
@@ -1172,10 +1112,8 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 
 	return 0;
 
-err9:
-	free_irq(irq, sdd);
 err8:
-	destroy_workqueue(sdd->workqueue);
+	free_irq(irq, sdd);
 err7:
 	clk_disable(sdd->src_clk);
 err6:
@@ -1201,25 +1139,15 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 	struct resource	*mem_res;
-	unsigned long flags;
 
 	pm_runtime_disable(&pdev->dev);
 
-	spin_lock_irqsave(&sdd->lock, flags);
-	sdd->state |= SUSPND;
-	spin_unlock_irqrestore(&sdd->lock, flags);
-
-	while (sdd->state & SPIBUSY)
-		msleep(10);
-
 	spi_unregister_master(master);
 
 	writel(0, sdd->regs + S3C64XX_SPI_INT_EN);
 
 	free_irq(platform_get_irq(pdev, 0), sdd);
 
-	destroy_workqueue(sdd->workqueue);
-
 	clk_disable(sdd->src_clk);
 	clk_put(sdd->src_clk);
 
@@ -1243,14 +1171,8 @@ static int s3c64xx_spi_suspend(struct device *dev)
 {
 	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
-	unsigned long flags;
-
-	spin_lock_irqsave(&sdd->lock, flags);
-	sdd->state |= SUSPND;
-	spin_unlock_irqrestore(&sdd->lock, flags);
 
-	while (sdd->state & SPIBUSY)
-		msleep(10);
+	spi_master_suspend(master);
 
 	/* Disable the clock */
 	clk_disable(sdd->src_clk);
@@ -1267,7 +1189,6 @@ static int s3c64xx_spi_resume(struct device *dev)
 	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
-	unsigned long flags;
 
 	sci->cfg_gpio(pdev);
 
@@ -1277,9 +1198,7 @@ static int s3c64xx_spi_resume(struct device *dev)
 
 	s3c64xx_spi_hwinit(sdd, pdev->id);
 
-	spin_lock_irqsave(&sdd->lock, flags);
-	sdd->state &= ~SUSPND;
-	spin_unlock_irqrestore(&sdd->lock, flags);
+	spi_master_resume(master);
 
 	return 0;
 }
-- 
1.7.9.rc1
