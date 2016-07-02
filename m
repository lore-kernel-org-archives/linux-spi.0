From: Bhaktipriya Shridhar <bhaktipriya96-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-mpc52xx-psc: Remove deprecated
 create_singlethread_workqueue
Date: Sat, 2 Jul 2016 14:27:06 +0530
Message-ID: <20160702085706.GA28703@Karyakshetra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The workqueue "workqueue" has a single work item(&mps->work)
doesn't require ordering. Also, it is not being used on a memory reclaim
path. Hence, the singlethreaded workqueue has been replaced with the use
of system_wq.

System workqueues have been able to handle high level of concurrency
for a long time now and hence it's not required to have a singlethreaded
workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
created with create_singlethread_workqueue(), system_wq allows multiple
work items to overlap executions even on the same CPU; however, a
per-cpu workqueue doesn't have any CPU locality or global ordering
guarantee unless the target CPU is explicitly specified and thus the
increase of local concurrency shouldn't make any difference.

Work item has been flushed in mpc52xx_psc_spi_of_remove() to ensure that
nothing is pending while disconnecting the driver.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-mpc52xx-psc.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 72d11eb..42a8b85 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -42,7 +42,6 @@ struct mpc52xx_psc_spi {
 	u8 bits_per_word;
 	u8 busy;

-	struct workqueue_struct *workqueue;
 	struct work_struct work;

 	struct list_head queue;
@@ -299,7 +298,7 @@ static int mpc52xx_psc_spi_transfer(struct spi_device *spi,

 	spin_lock_irqsave(&mps->lock, flags);
 	list_add_tail(&m->queue, &mps->queue);
-	queue_work(mps->workqueue, &mps->work);
+	schedule_work(&mps->work);
 	spin_unlock_irqrestore(&mps->lock, flags);

 	return 0;
@@ -425,21 +424,12 @@ static int mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	INIT_WORK(&mps->work, mpc52xx_psc_spi_work);
 	INIT_LIST_HEAD(&mps->queue);

-	mps->workqueue = create_singlethread_workqueue(
-		dev_name(master->dev.parent));
-	if (mps->workqueue == NULL) {
-		ret = -EBUSY;
-		goto free_irq;
-	}
-
 	ret = spi_register_master(master);
 	if (ret < 0)
-		goto unreg_master;
+		goto free_irq;

 	return ret;

-unreg_master:
-	destroy_workqueue(mps->workqueue);
 free_irq:
 	free_irq(mps->irq, mps);
 free_master:
@@ -484,8 +474,7 @@ static int mpc52xx_psc_spi_of_remove(struct platform_device *op)
 	struct spi_master *master = spi_master_get(platform_get_drvdata(op));
 	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(master);

-	flush_workqueue(mps->workqueue);
-	destroy_workqueue(mps->workqueue);
+	flush_work(&mps->work);
 	spi_unregister_master(master);
 	free_irq(mps->irq, mps);
 	if (mps->psc)
--
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
