From: Bhaktipriya Shridhar <bhaktipriya96-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-bfin-sport: Remove deprecated
 create_singlethread_workqueue
Date: Sat, 2 Jul 2016 14:29:41 +0530
Message-ID: <20160702085941.GA28900@Karyakshetra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The workqueue "workqueue" serves as a driver message queue.
It has a single work item(&drv_data->pump_messages) and hence doesn't
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

Work item has been flushed in bfin_sport_spi_destroy_queue() to ensure
that there are no pending tasks while disconnecting the driver.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-bfin-sport.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-bfin-sport.c b/drivers/spi/spi-bfin-sport.c
index 6c96755..01d0ba9 100644
--- a/drivers/spi/spi-bfin-sport.c
+++ b/drivers/spi/spi-bfin-sport.c
@@ -64,8 +64,6 @@ struct bfin_sport_spi_master_data {
 	/* Pin request list */
 	u16 *pin_req;

-	/* Driver message queue */
-	struct workqueue_struct *workqueue;
 	struct work_struct pump_messages;
 	spinlock_t lock;
 	struct list_head queue;
@@ -300,7 +298,7 @@ bfin_sport_spi_giveback(struct bfin_sport_spi_master_data *drv_data)
 	drv_data->cur_msg = NULL;
 	drv_data->cur_transfer = NULL;
 	drv_data->cur_chip = NULL;
-	queue_work(drv_data->workqueue, &drv_data->pump_messages);
+	schedule_work(&drv_data->pump_messages);
 	spin_unlock_irqrestore(&drv_data->lock, flags);

 	if (!drv_data->cs_change)
@@ -556,7 +554,7 @@ bfin_sport_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 	list_add_tail(&msg->queue, &drv_data->queue);

 	if (drv_data->run && !drv_data->busy)
-		queue_work(drv_data->workqueue, &drv_data->pump_messages);
+		schedule_work(&drv_data->pump_messages);

 	spin_unlock_irqrestore(&drv_data->lock, flags);

@@ -666,12 +664,7 @@ bfin_sport_spi_init_queue(struct bfin_sport_spi_master_data *drv_data)
 	tasklet_init(&drv_data->pump_transfers,
 		     bfin_sport_spi_pump_transfers, (unsigned long)drv_data);

-	/* init messages workqueue */
 	INIT_WORK(&drv_data->pump_messages, bfin_sport_spi_pump_messages);
-	drv_data->workqueue =
-	    create_singlethread_workqueue(dev_name(drv_data->master->dev.parent));
-	if (drv_data->workqueue == NULL)
-		return -EBUSY;

 	return 0;
 }
@@ -694,7 +687,7 @@ bfin_sport_spi_start_queue(struct bfin_sport_spi_master_data *drv_data)
 	drv_data->cur_chip = NULL;
 	spin_unlock_irqrestore(&drv_data->lock, flags);

-	queue_work(drv_data->workqueue, &drv_data->pump_messages);
+	schedule_work(&drv_data->pump_messages);

 	return 0;
 }
@@ -738,7 +731,7 @@ bfin_sport_spi_destroy_queue(struct bfin_sport_spi_master_data *drv_data)
 	if (status)
 		return status;

-	destroy_workqueue(drv_data->workqueue);
+	flush_work(&drv_data->pump_messages);

 	return 0;
 }
--
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
