From: Bhaktipriya Shridhar <bhaktipriya96-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-txx9: Remove deprecated
 create_singlethread_workqueue
Date: Sat, 2 Jul 2016 14:20:55 +0530
Message-ID: <20160702085054.GA28059@Karyakshetra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The workqueue "workqueue" has a single work item(&c->work) and hence
doesn't require ordering. Also, it is not being used on a memory reclaim
path.Hence, the singlethreaded workqueue has been replaced with the use of
system_wq.

System workqueues have been able to handle high level of concurrency
for a long time now and hence it's not required to have a singlethreaded
workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
created with create_singlethread_workqueue(), system_wq allows multiple
work items to overlap executions even on the same CPU; however, a
per-cpu workqueue doesn't have any CPU locality or global ordering
guarantee unless the target CPU is explicitly specified and thus the
increase of local concurrency shouldn't make any difference.

Work item has been flushed in txx9spi_remove() to ensure that
nothing is pending while disconnecting the driver.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-txx9.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index d69f8f8..7492ea3 100644
--- a/drivers/spi/spi-txx9.c
+++ b/drivers/spi/spi-txx9.c
@@ -72,7 +72,6 @@


 struct txx9spi {
-	struct workqueue_struct	*workqueue;
 	struct work_struct work;
 	spinlock_t lock;	/* protect 'queue' */
 	struct list_head queue;
@@ -315,7 +314,7 @@ static int txx9spi_transfer(struct spi_device *spi, struct spi_message *m)

 	spin_lock_irqsave(&c->lock, flags);
 	list_add_tail(&m->queue, &c->queue);
-	queue_work(c->workqueue, &c->work);
+	schedule_work(&c->work);
 	spin_unlock_irqrestore(&c->lock, flags);

 	return 0;
@@ -374,10 +373,6 @@ static int txx9spi_probe(struct platform_device *dev)
 	if (ret)
 		goto exit;

-	c->workqueue = create_singlethread_workqueue(
-				dev_name(master->dev.parent));
-	if (!c->workqueue)
-		goto exit_busy;
 	c->last_chipselect = -1;

 	dev_info(&dev->dev, "at %#llx, irq %d, %dMHz\n",
@@ -400,8 +395,6 @@ static int txx9spi_probe(struct platform_device *dev)
 exit_busy:
 	ret = -EBUSY;
 exit:
-	if (c->workqueue)
-		destroy_workqueue(c->workqueue);
 	clk_disable(c->clk);
 	spi_master_put(master);
 	return ret;
@@ -412,7 +405,7 @@ static int txx9spi_remove(struct platform_device *dev)
 	struct spi_master *master = platform_get_drvdata(dev);
 	struct txx9spi *c = spi_master_get_devdata(master);

-	destroy_workqueue(c->workqueue);
+	flush_work(&c->work);
 	clk_disable(c->clk);
 	return 0;
 }
--
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
