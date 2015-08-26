From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/3] spi: fsl-(e)spi: migrate to using devm_ functions
 to simplify cleanup
Date: Wed, 26 Aug 2015 21:21:50 +0200
Message-ID: <55DE11CE.7090508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Migrate fsl-espi and fsl-spi to using the managed devm_ functions
for resource handling. This simplifies the cleanup.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- changed devm_ioremap to devm_ioremap_resource
- remove fsl_espi_remove as it would be empty afterwards

 drivers/spi/spi-fsl-espi.c | 20 +++++---------------
 drivers/spi/spi-fsl-lib.c  |  4 ----
 drivers/spi/spi-fsl-spi.c  | 21 ++++++++-------------
 3 files changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index d3f05a0..f35eb2c 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -604,11 +604,6 @@ static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
 	return ret;
 }
 
-static void fsl_espi_remove(struct mpc8xxx_spi *mspi)
-{
-	iounmap(mspi->reg_base);
-}
-
 static int fsl_espi_suspend(struct spi_master *master)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi;
@@ -671,9 +666,8 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	master->unprepare_transfer_hardware = fsl_espi_suspend;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
-	mpc8xxx_spi->spi_remove = fsl_espi_remove;
 
-	mpc8xxx_spi->reg_base = ioremap(mem->start, resource_size(mem));
+	mpc8xxx_spi->reg_base = devm_ioremap_resource(dev, mem);
 	if (!mpc8xxx_spi->reg_base) {
 		ret = -ENOMEM;
 		goto err_probe;
@@ -682,10 +676,10 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	reg_base = mpc8xxx_spi->reg_base;
 
 	/* Register for SPI Interrupt */
-	ret = request_irq(mpc8xxx_spi->irq, fsl_espi_irq,
+	ret = devm_request_irq(dev, mpc8xxx_spi->irq, fsl_espi_irq,
 			  0, "fsl_espi", mpc8xxx_spi);
 	if (ret)
-		goto free_irq;
+		goto err_probe;
 
 	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE) {
 		mpc8xxx_spi->rx_shift = 16;
@@ -731,18 +725,14 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 
 	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
 
-	ret = spi_register_master(master);
+	ret = devm_spi_register_master(dev, master);
 	if (ret < 0)
-		goto unreg_master;
+		goto err_probe;
 
 	dev_info(dev, "at 0x%p (irq = %d)\n", reg_base, mpc8xxx_spi->irq);
 
 	return master;
 
-unreg_master:
-	free_irq(mpc8xxx_spi->irq, mpc8xxx_spi);
-free_irq:
-	iounmap(mpc8xxx_spi->reg_base);
 err_probe:
 	spi_master_put(master);
 err:
diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index cb35d2f..e50fd06 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -122,10 +122,6 @@ int mpc8xxx_spi_remove(struct device *dev)
 	master = dev_get_drvdata(dev);
 	mpc8xxx_spi = spi_master_get_devdata(master);
 
-	spi_unregister_master(master);
-
-	free_irq(mpc8xxx_spi->irq, mpc8xxx_spi);
-
 	if (mpc8xxx_spi->spi_remove)
 		mpc8xxx_spi->spi_remove(mpc8xxx_spi);
 
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 60c5907..8bfbe9e 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -561,7 +561,6 @@ static irqreturn_t fsl_spi_irq(s32 irq, void *context_data)
 
 static void fsl_spi_remove(struct mpc8xxx_spi *mspi)
 {
-	iounmap(mspi->reg_base);
 	fsl_spi_cpm_free(mspi);
 }
 
@@ -639,10 +638,10 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
 	if (ret)
 		goto err_cpm_init;
 
-	mpc8xxx_spi->reg_base = ioremap(mem->start, resource_size(mem));
+	mpc8xxx_spi->reg_base = devm_ioremap_resource(dev, mem);
 	if (mpc8xxx_spi->reg_base == NULL) {
 		ret = -ENOMEM;
-		goto err_ioremap;
+		goto err_probe;
 	}
 
 	if (mpc8xxx_spi->type == TYPE_GRLIB)
@@ -661,11 +660,11 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
 					&mpc8xxx_spi->tx_shift, 8, 1);
 
 	/* Register for SPI Interrupt */
-	ret = request_irq(mpc8xxx_spi->irq, fsl_spi_irq,
-			  0, "fsl_spi", mpc8xxx_spi);
+	ret = devm_request_irq(dev, mpc8xxx_spi->irq, fsl_spi_irq,
+			       0, "fsl_spi", mpc8xxx_spi);
 
 	if (ret != 0)
-		goto free_irq;
+		goto err_probe;
 
 	reg_base = mpc8xxx_spi->reg_base;
 
@@ -686,20 +685,16 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
 
 	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
 
-	ret = spi_register_master(master);
+	ret = devm_spi_register_master(dev, master);
 	if (ret < 0)
-		goto unreg_master;
+		goto err_probe;
 
 	dev_info(dev, "at 0x%p (irq = %d), %s mode\n", reg_base,
 		 mpc8xxx_spi->irq, mpc8xxx_spi_strmode(mpc8xxx_spi->flags));
 
 	return master;
 
-unreg_master:
-	free_irq(mpc8xxx_spi->irq, mpc8xxx_spi);
-free_irq:
-	iounmap(mpc8xxx_spi->reg_base);
-err_ioremap:
+err_probe:
 	fsl_spi_cpm_free(mpc8xxx_spi);
 err_cpm_init:
 	spi_master_put(master);
-- 
2.5.0


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
