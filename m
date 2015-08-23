From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] spi: fsl-(e)spi: simplify cleanup code
Date: Sun, 23 Aug 2015 14:21:53 +0200
Message-ID: <55D9BAE1.1030306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Now that most cleanup is done automatically the remove functions
can be significantly simplified.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c |  7 +------
 drivers/spi/spi-fsl-lib.c  | 15 ---------------
 drivers/spi/spi-fsl-lib.h  |  3 ---
 drivers/spi/spi-fsl-spi.c  | 18 +++++++-----------
 4 files changed, 8 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index bfd6259..fdd85be 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -604,10 +604,6 @@ static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
 	return ret;
 }
 
-static void fsl_espi_remove(struct mpc8xxx_spi *mspi)
-{
-}
-
 static int fsl_espi_suspend(struct spi_master *master)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi;
@@ -670,7 +666,6 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	master->unprepare_transfer_hardware = fsl_espi_suspend;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
-	mpc8xxx_spi->spi_remove = fsl_espi_remove;
 
 	mpc8xxx_spi->reg_base = devm_ioremap(dev, mem->start,
 					     resource_size(mem));
@@ -805,7 +800,7 @@ err:
 
 static int of_fsl_espi_remove(struct platform_device *dev)
 {
-	return mpc8xxx_spi_remove(&dev->dev);
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index e50fd06..1e43412 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -114,21 +114,6 @@ void mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
 }
 EXPORT_SYMBOL_GPL(mpc8xxx_spi_probe);
 
-int mpc8xxx_spi_remove(struct device *dev)
-{
-	struct mpc8xxx_spi *mpc8xxx_spi;
-	struct spi_master *master;
-
-	master = dev_get_drvdata(dev);
-	mpc8xxx_spi = spi_master_get_devdata(master);
-
-	if (mpc8xxx_spi->spi_remove)
-		mpc8xxx_spi->spi_remove(mpc8xxx_spi);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mpc8xxx_spi_remove);
-
 int of_mpc8xxx_spi_probe(struct platform_device *ofdev)
 {
 	struct device *dev = &ofdev->dev;
diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index 1326a39..84f5dcb 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -54,9 +54,6 @@ struct mpc8xxx_spi {
 	void (*get_rx) (u32 rx_data, struct mpc8xxx_spi *);
 	u32(*get_tx) (struct mpc8xxx_spi *);
 
-	/* hooks for different controller driver */
-	void (*spi_remove) (struct mpc8xxx_spi *mspi);
-
 	unsigned int count;
 	unsigned int irq;
 
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index fbbab60..b487dab 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -559,11 +559,6 @@ static irqreturn_t fsl_spi_irq(s32 irq, void *context_data)
 	return ret;
 }
 
-static void fsl_spi_remove(struct mpc8xxx_spi *mspi)
-{
-	fsl_spi_cpm_free(mspi);
-}
-
 static void fsl_spi_grlib_cs_control(struct spi_device *spi, bool on)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
@@ -630,7 +625,6 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
 	master->transfer_one_message = fsl_spi_do_one_msg;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
-	mpc8xxx_spi->spi_remove = fsl_spi_remove;
 	mpc8xxx_spi->max_bits_per_word = 32;
 	mpc8xxx_spi->type = fsl_spi_get_type(dev);
 
@@ -862,11 +856,8 @@ static int of_fsl_spi_remove(struct platform_device *ofdev)
 {
 	struct spi_master *master = platform_get_drvdata(ofdev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
-	int ret;
 
-	ret = mpc8xxx_spi_remove(&ofdev->dev);
-	if (ret)
-		return ret;
+	fsl_spi_cpm_free(mpc8xxx_spi);
 	if (mpc8xxx_spi->type == TYPE_FSL)
 		of_fsl_spi_free_chipselects(&ofdev->dev);
 	return 0;
@@ -912,7 +903,12 @@ static int plat_mpc8xxx_spi_probe(struct platform_device *pdev)
 
 static int plat_mpc8xxx_spi_remove(struct platform_device *pdev)
 {
-	return mpc8xxx_spi_remove(&pdev->dev);
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
+
+	fsl_spi_cpm_free(mpc8xxx_spi);
+
+	return 0;
 }
 
 MODULE_ALIAS("platform:mpc8xxx_spi");
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
