From: Bhaktipriya Shridhar <bhaktipriya96-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] spi: spi-topcliff-pch: Remove deprecated create_singlethread_workqueue
Date: Sun, 10 Jul 2016 19:42:13 +0530
Message-ID: <1468159933-28099-1-git-send-email-bhaktipriya96@gmail.com>
References: <201607022003.aKXFDba1%fengguang.wu@intel.com>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Bhaktipriya Shridhar <bhaktipriya96-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201607022003.aKXFDba1%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The workqueue "wk" serves as a queue for carrying out execution
of requests. It has a single work item(&drv_data->work) and hence doesn't
require ordering. Also, it is not being used on a memory reclaim path.
Hence, the singlethreaded workqueue has been replaced with the use of
system_wq.

System workqueues have been able to handle high level of concurrency
for a long time now and hence it's not required to have a singlethreaded
workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
created with create_singlethread_workqueue(), system_wq allows multiple
work items to overlap executions even on the same CPU; however, a
per-cpu workqueue doesn't have any CPU locality or global ordering
guarantee unless the target CPU is explicitly specified and thus the
increase of local concurrency shouldn't make any difference.

Work item has been flushed in pch_spi_free_resources() to ensure that
there are no pending tasks while disconnecting the driver.

Also dropped the label 'err_return' since it's not being used anymore.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Changes in v2:
	-Fixed build warning by removing unused label 'err_return'

 drivers/spi/spi-topcliff-pch.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 93dfcee..c54ee66 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -133,8 +133,6 @@ struct pch_spi_dma_ctrl {
  * @io_remap_addr:		The remapped PCI base address
  * @master:			Pointer to the SPI master structure
  * @work:			Reference to work queue handler
- * @wk:				Workqueue for carrying out execution of the
- *				requests
  * @wait:			Wait queue for waking up upon receiving an
  *				interrupt.
  * @transfer_complete:		Status of SPI Transfer
@@ -169,7 +167,6 @@ struct pch_spi_data {
 	unsigned long io_base_addr;
 	struct spi_master *master;
 	struct work_struct work;
-	struct workqueue_struct *wk;
 	wait_queue_head_t wait;
 	u8 transfer_complete;
 	u8 bcurrent_msg_processing;
@@ -517,8 +514,7 @@ static int pch_spi_transfer(struct spi_device *pspi, struct spi_message *pmsg)

 	dev_dbg(&pspi->dev, "%s - Invoked list_add_tail\n", __func__);

-	/* schedule work queue to run */
-	queue_work(data->wk, &data->work);
+	schedule_work(&data->work);
 	dev_dbg(&pspi->dev, "%s - Invoked queue work\n", __func__);

 	retval = 0;
@@ -674,7 +670,7 @@ static void pch_spi_nomore_transfer(struct pch_spi_data *data)
 		 *more messages)
 		 */
 		dev_dbg(&data->master->dev, "%s:Invoke queue_work\n", __func__);
-		queue_work(data->wk, &data->work);
+		schedule_work(&data->work);
 	} else if (data->board_dat->suspend_sts ||
 		   data->status == STATUS_EXITING) {
 		dev_dbg(&data->master->dev,
@@ -1266,14 +1262,7 @@ static void pch_spi_free_resources(struct pch_spi_board_data *board_dat,
 {
 	dev_dbg(&board_dat->pdev->dev, "%s ENTRY\n", __func__);

-	/* free workqueue */
-	if (data->wk != NULL) {
-		destroy_workqueue(data->wk);
-		data->wk = NULL;
-		dev_dbg(&board_dat->pdev->dev,
-			"%s destroy_workqueue invoked successfully\n",
-			__func__);
-	}
+	flush_work(&data->work);
 }

 static int pch_spi_get_resources(struct pch_spi_board_data *board_dat,
@@ -1283,14 +1272,6 @@ static int pch_spi_get_resources(struct pch_spi_board_data *board_dat,

 	dev_dbg(&board_dat->pdev->dev, "%s ENTRY\n", __func__);

-	/* create workqueue */
-	data->wk = create_singlethread_workqueue(KBUILD_MODNAME);
-	if (!data->wk) {
-		dev_err(&board_dat->pdev->dev,
-			"%s create_singlet hread_workqueue failed\n", __func__);
-		retval = -EBUSY;
-		goto err_return;
-	}

 	/* reset PCH SPI h/w */
 	pch_spi_reset(data->master);
@@ -1299,7 +1280,6 @@ static int pch_spi_get_resources(struct pch_spi_board_data *board_dat,

 	dev_dbg(&board_dat->pdev->dev, "%s data->irq_reg_sts=true\n", __func__);

-err_return:
 	if (retval != 0) {
 		dev_err(&board_dat->pdev->dev,
 			"%s FAIL:invoking pch_spi_free_resources\n", __func__);
--
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
