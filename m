From: Bhaktipriya Shridhar <bhaktipriya96-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-sh: Remove deprecated create_singlethread_workqueue
Date: Sat, 16 Jul 2016 13:35:02 +0530
Message-ID: <20160716080502.GA4700@Karyakshetra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The workqueue has a single workitem(&ss->ws) and hence doesn't require
ordering. Also, it is not being used on a memory reclaim path. Hence, the
singlethreaded workqueue has been replaced with the use of system_wq.

System workqueues have been able to handle high level of concurrency
for a long time now and hence it's not required to have a singlethreaded
workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
created with create_singlethread_workqueue(), system_wq allows multiple
work items to overlap executions even on the same CPU; however, a
per-cpu workqueue doesn't have any CPU locality or global ordering
guarantee unless the target CPU is explicitly specified and thus the
increase of local concurrency shouldn't make any difference.

Work item has been flushed in spi_sh_remove() to ensure that
there are no pending tasks while disconnecting the driver.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-sh.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index 5025011..2bf53f0 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -82,7 +82,6 @@ struct spi_sh_data {
 	int irq;
 	struct spi_master *master;
 	struct list_head queue;
-	struct workqueue_struct *workqueue;
 	struct work_struct ws;
 	unsigned long cr1;
 	wait_queue_head_t wait;
@@ -380,7 +379,7 @@ static int spi_sh_transfer(struct spi_device *spi, struct spi_message *mesg)
 	spi_sh_clear_bit(ss, SPI_SH_SSA, SPI_SH_CR1);

 	list_add_tail(&mesg->queue, &ss->queue);
-	queue_work(ss->workqueue, &ss->ws);
+	schedule_work(&ss->ws);

 	spin_unlock_irqrestore(&ss->lock, flags);

@@ -425,7 +424,7 @@ static int spi_sh_remove(struct platform_device *pdev)
 	struct spi_sh_data *ss = platform_get_drvdata(pdev);

 	spi_unregister_master(ss->master);
-	destroy_workqueue(ss->workqueue);
+	flush_work(&ss->ws);
 	free_irq(ss->irq, ss);

 	return 0;
@@ -484,18 +483,11 @@ static int spi_sh_probe(struct platform_device *pdev)
 	spin_lock_init(&ss->lock);
 	INIT_WORK(&ss->ws, spi_sh_work);
 	init_waitqueue_head(&ss->wait);
-	ss->workqueue = create_singlethread_workqueue(
-					dev_name(master->dev.parent));
-	if (ss->workqueue == NULL) {
-		dev_err(&pdev->dev, "create workqueue error\n");
-		ret = -EBUSY;
-		goto error1;
-	}

 	ret = request_irq(irq, spi_sh_irq, 0, "spi_sh", ss);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "request_irq error\n");
-		goto error2;
+		goto error1;
 	}

 	master->num_chipselect = 2;
@@ -514,8 +506,6 @@ static int spi_sh_probe(struct platform_device *pdev)

  error3:
 	free_irq(irq, ss);
- error2:
-	destroy_workqueue(ss->workqueue);
  error1:
 	spi_master_put(master);

--
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
