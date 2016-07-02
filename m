From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH] spi: spi-bfin5xx: Remove deprecated
 create_singlethread_workqueue
Date: Sat, 2 Jul 2016 14:12:00 +0530
Message-ID: <20160702084200.GA27584@Karyakshetra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tejun Heo <tj@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

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

Work item has been flushed in bfin_spi_destroy_queue() to ensure that there
are no pending tasks while disconnecting the driver.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/spi/spi-bfin5xx.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-bfin5xx.c b/drivers/spi/spi-bfin5xx.c
index 1e91325..249c7a3 100644
--- a/drivers/spi/spi-bfin5xx.c
+++ b/drivers/spi/spi-bfin5xx.c
@@ -67,8 +67,6 @@ struct bfin_spi_master_data {
 	/* BFIN hookup */
 	struct bfin5xx_spi_master *master_info;

-	/* Driver message queue */
-	struct workqueue_struct *workqueue;
 	struct work_struct pump_messages;
 	spinlock_t lock;
 	struct list_head queue;
@@ -359,7 +357,7 @@ static void bfin_spi_giveback(struct bfin_spi_master_data *drv_data)
 	drv_data->cur_msg = NULL;
 	drv_data->cur_transfer = NULL;
 	drv_data->cur_chip = NULL;
-	queue_work(drv_data->workqueue, &drv_data->pump_messages);
+	schedule_work(&drv_data->pump_messages);
 	spin_unlock_irqrestore(&drv_data->lock, flags);

 	msg->state = NULL;
@@ -946,7 +944,7 @@ static int bfin_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 	list_add_tail(&msg->queue, &drv_data->queue);

 	if (drv_data->running && !drv_data->busy)
-		queue_work(drv_data->workqueue, &drv_data->pump_messages);
+		schedule_work(&drv_data->pump_messages);

 	spin_unlock_irqrestore(&drv_data->lock, flags);

@@ -1177,12 +1175,7 @@ static int bfin_spi_init_queue(struct bfin_spi_master_data *drv_data)
 	tasklet_init(&drv_data->pump_transfers,
 		     bfin_spi_pump_transfers, (unsigned long)drv_data);

-	/* init messages workqueue */
 	INIT_WORK(&drv_data->pump_messages, bfin_spi_pump_messages);
-	drv_data->workqueue = create_singlethread_workqueue(
-				dev_name(drv_data->master->dev.parent));
-	if (drv_data->workqueue == NULL)
-		return -EBUSY;

 	return 0;
 }
@@ -1204,7 +1197,7 @@ static int bfin_spi_start_queue(struct bfin_spi_master_data *drv_data)
 	drv_data->cur_chip = NULL;
 	spin_unlock_irqrestore(&drv_data->lock, flags);

-	queue_work(drv_data->workqueue, &drv_data->pump_messages);
+	schedule_work(&drv_data->pump_messages);

 	return 0;
 }
@@ -1246,7 +1239,7 @@ static int bfin_spi_destroy_queue(struct bfin_spi_master_data *drv_data)
 	if (status != 0)
 		return status;

-	destroy_workqueue(drv_data->workqueue);
+	flush_work(&drv_data->pump_messages);

 	return 0;
 }
--
2.1.4
