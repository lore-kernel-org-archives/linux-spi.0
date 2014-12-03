From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] spi: fsl-(e)spi: migrate to generic master queueing
Date: Wed, 03 Dec 2014 07:56:17 +0100
Message-ID: <547EB411.1080109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Migrates the fsl-(e)spi driver to use the generic master queuing.
Avoids the "master is unqueued, this is deprecated" warning.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 13 +++++-----
 drivers/spi/spi-fsl-lib.c  | 59 +---------------------------------------------
 drivers/spi/spi-fsl-lib.h  | 10 +-------
 drivers/spi/spi-fsl-spi.c  | 14 +++++------
 4 files changed, 14 insertions(+), 82 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index cff2ebd..e5702c9 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -411,7 +411,8 @@ static void fsl_espi_rw_trans(struct spi_message *m,
 	kfree(local_buf);
 }
 
-static void fsl_espi_do_one_msg(struct spi_message *m)
+static int fsl_espi_do_one_msg(struct spi_master *master,
+			       struct spi_message *m)
 {
 	struct spi_transfer *t;
 	u8 *rx_buf = NULL;
@@ -441,8 +442,8 @@ static void fsl_espi_do_one_msg(struct spi_message *m)
 
 	m->actual_length = espi_trans.actual_length;
 	m->status = espi_trans.status;
-	if (m->complete)
-		m->complete(m->context);
+	spi_finalize_current_message(master);
+	return 0;
 }
 
 static int fsl_espi_setup(struct spi_device *spi)
@@ -607,16 +608,14 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 
 	dev_set_drvdata(dev, master);
 
-	ret = mpc8xxx_spi_probe(dev, mem, irq);
-	if (ret)
-		goto err_probe;
+	mpc8xxx_spi_probe(dev, mem, irq);
 
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
 	master->setup = fsl_espi_setup;
 	master->cleanup = fsl_espi_cleanup;
+	master->transfer_one_message = fsl_espi_do_one_msg;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
-	mpc8xxx_spi->spi_do_one_msg = fsl_espi_do_one_msg;
 	mpc8xxx_spi->spi_remove = fsl_espi_remove;
 
 	mpc8xxx_spi->reg_base = ioremap(mem->start, resource_size(mem));
diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index 5ddb5b0..446b737 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -61,44 +61,6 @@ struct mpc8xxx_spi_probe_info *to_of_pinfo(struct fsl_spi_platform_data *pdata)
 	return container_of(pdata, struct mpc8xxx_spi_probe_info, pdata);
 }
 
-static void mpc8xxx_spi_work(struct work_struct *work)
-{
-	struct mpc8xxx_spi *mpc8xxx_spi = container_of(work, struct mpc8xxx_spi,
-						       work);
-
-	spin_lock_irq(&mpc8xxx_spi->lock);
-	while (!list_empty(&mpc8xxx_spi->queue)) {
-		struct spi_message *m = container_of(mpc8xxx_spi->queue.next,
-						   struct spi_message, queue);
-
-		list_del_init(&m->queue);
-		spin_unlock_irq(&mpc8xxx_spi->lock);
-
-		if (mpc8xxx_spi->spi_do_one_msg)
-			mpc8xxx_spi->spi_do_one_msg(m);
-
-		spin_lock_irq(&mpc8xxx_spi->lock);
-	}
-	spin_unlock_irq(&mpc8xxx_spi->lock);
-}
-
-int mpc8xxx_spi_transfer(struct spi_device *spi,
-				struct spi_message *m)
-{
-	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
-	unsigned long flags;
-
-	m->actual_length = 0;
-	m->status = -EINPROGRESS;
-
-	spin_lock_irqsave(&mpc8xxx_spi->lock, flags);
-	list_add_tail(&m->queue, &mpc8xxx_spi->queue);
-	queue_work(mpc8xxx_spi->workqueue, &mpc8xxx_spi->work);
-	spin_unlock_irqrestore(&mpc8xxx_spi->lock, flags);
-
-	return 0;
-}
-
 const char *mpc8xxx_spi_strmode(unsigned int flags)
 {
 	if (flags & SPI_QE_CPU_MODE) {
@@ -114,13 +76,12 @@ const char *mpc8xxx_spi_strmode(unsigned int flags)
 	return "CPU";
 }
 
-int mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
+void mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
 			unsigned int irq)
 {
 	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
 	struct spi_master *master;
 	struct mpc8xxx_spi *mpc8xxx_spi;
-	int ret = 0;
 
 	master = dev_get_drvdata(dev);
 
@@ -128,7 +89,6 @@ int mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH
 			| SPI_LSB_FIRST | SPI_LOOP;
 
-	master->transfer = mpc8xxx_spi_transfer;
 	master->dev.of_node = dev->of_node;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
@@ -147,22 +107,7 @@ int mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
 	master->bus_num = pdata->bus_num;
 	master->num_chipselect = pdata->max_chipselect;
 
-	spin_lock_init(&mpc8xxx_spi->lock);
 	init_completion(&mpc8xxx_spi->done);
-	INIT_WORK(&mpc8xxx_spi->work, mpc8xxx_spi_work);
-	INIT_LIST_HEAD(&mpc8xxx_spi->queue);
-
-	mpc8xxx_spi->workqueue = create_singlethread_workqueue(
-		dev_name(master->dev.parent));
-	if (mpc8xxx_spi->workqueue == NULL) {
-		ret = -EBUSY;
-		goto err;
-	}
-
-	return 0;
-
-err:
-	return ret;
 }
 
 int mpc8xxx_spi_remove(struct device *dev)
@@ -173,8 +118,6 @@ int mpc8xxx_spi_remove(struct device *dev)
 	master = dev_get_drvdata(dev);
 	mpc8xxx_spi = spi_master_get_devdata(master);
 
-	flush_workqueue(mpc8xxx_spi->workqueue);
-	destroy_workqueue(mpc8xxx_spi->workqueue);
 	spi_unregister_master(master);
 
 	free_irq(mpc8xxx_spi->irq, mpc8xxx_spi);
diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index 2fcbfd0..b4ed04e 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -55,7 +55,6 @@ struct mpc8xxx_spi {
 	u32(*get_tx) (struct mpc8xxx_spi *);
 
 	/* hooks for different controller driver */
-	void (*spi_do_one_msg) (struct spi_message *m);
 	void (*spi_remove) (struct mpc8xxx_spi *mspi);
 
 	unsigned int count;
@@ -78,12 +77,6 @@ struct mpc8xxx_spi {
 			   int bits_per_word, int msb_first);
 #endif
 
-	struct workqueue_struct *workqueue;
-	struct work_struct work;
-
-	struct list_head queue;
-	spinlock_t lock;
-
 	struct completion done;
 };
 
@@ -123,9 +116,8 @@ extern struct mpc8xxx_spi_probe_info *to_of_pinfo(
 		struct fsl_spi_platform_data *pdata);
 extern int mpc8xxx_spi_bufs(struct mpc8xxx_spi *mspi,
 		struct spi_transfer *t, unsigned int len);
-extern int mpc8xxx_spi_transfer(struct spi_device *spi, struct spi_message *m);
 extern const char *mpc8xxx_spi_strmode(unsigned int flags);
-extern int mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
+extern void mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
 		unsigned int irq);
 extern int mpc8xxx_spi_remove(struct device *dev);
 extern int of_mpc8xxx_spi_probe(struct platform_device *ofdev);
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 048f457..e24a9bf 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -353,7 +353,8 @@ static int fsl_spi_bufs(struct spi_device *spi, struct spi_transfer *t,
 	return mpc8xxx_spi->count;
 }
 
-static void fsl_spi_do_one_msg(struct spi_message *m)
+static int fsl_spi_do_one_msg(struct spi_master *master,
+			      struct spi_message *m)
 {
 	struct spi_device *spi = m->spi;
 	struct spi_transfer *t, *first;
@@ -408,8 +409,7 @@ static void fsl_spi_do_one_msg(struct spi_message *m)
 	}
 
 	m->status = status;
-	if (m->complete)
-		m->complete(m->context);
+	spi_finalize_current_message(master);
 
 	if (status || !cs_change) {
 		ndelay(nsecs);
@@ -417,6 +417,7 @@ static void fsl_spi_do_one_msg(struct spi_message *m)
 	}
 
 	fsl_spi_setup_transfer(spi, NULL);
+	return 0;
 }
 
 static int fsl_spi_setup(struct spi_device *spi)
@@ -624,15 +625,13 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
 
 	dev_set_drvdata(dev, master);
 
-	ret = mpc8xxx_spi_probe(dev, mem, irq);
-	if (ret)
-		goto err_probe;
+	mpc8xxx_spi_probe(dev, mem, irq);
 
 	master->setup = fsl_spi_setup;
 	master->cleanup = fsl_spi_cleanup;
+	master->transfer_one_message = fsl_spi_do_one_msg;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
-	mpc8xxx_spi->spi_do_one_msg = fsl_spi_do_one_msg;
 	mpc8xxx_spi->spi_remove = fsl_spi_remove;
 	mpc8xxx_spi->max_bits_per_word = 32;
 	mpc8xxx_spi->type = fsl_spi_get_type(dev);
@@ -704,7 +703,6 @@ free_irq:
 err_ioremap:
 	fsl_spi_cpm_free(mpc8xxx_spi);
 err_cpm_init:
-err_probe:
 	spi_master_put(master);
 err:
 	return ERR_PTR(ret);
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
