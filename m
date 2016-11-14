From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: factor out fsl_espi_init_regs" to the spi tree
Date: Mon, 14 Nov 2016 13:54:27 +0000
Message-ID: <E1c6HiN-0003Jb-Nj@finisterre>
References: <4e79541e-d512-8b66-9692-13d20722c9c0@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4e79541e-d512-8b66-9692-13d20722c9c0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: factor out fsl_espi_init_regs

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 456c742be68eca1c8c55f4e0384f0418a55a31c5 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sun, 13 Nov 2016 14:40:18 +0100
Subject: [PATCH] spi: fsl-espi: factor out fsl_espi_init_regs

The register initialization is the same in fsl_espi_probe and in
of_fsl_espi_resume. Therefore factor it out into fsl_espi_init_regs.

It was actually a bug that CSMODE_BEF and CSMODE_AFT were not set
in of_fsl_espi_resume. Seems like nobody ever used values other
than zero for these parameters.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 110 +++++++++++++++++++++------------------------
 1 file changed, 50 insertions(+), 60 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 5d84694b7323..7a903434c881 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -576,13 +576,58 @@ static size_t fsl_espi_max_message_size(struct spi_device *spi)
 	return SPCOM_TRANLEN_MAX;
 }
 
+static void fsl_espi_init_regs(struct device *dev, bool initial)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct mpc8xxx_spi *mspi = spi_master_get_devdata(master);
+	struct device_node *nc;
+	u32 csmode, cs, prop;
+	int ret;
+
+	/* SPI controller initializations */
+	fsl_espi_write_reg(mspi, ESPI_SPMODE, 0);
+	fsl_espi_write_reg(mspi, ESPI_SPIM, 0);
+	fsl_espi_write_reg(mspi, ESPI_SPCOM, 0);
+	fsl_espi_write_reg(mspi, ESPI_SPIE, 0xffffffff);
+
+	/* Init eSPI CS mode register */
+	for_each_available_child_of_node(master->dev.of_node, nc) {
+		/* get chip select */
+		ret = of_property_read_u32(nc, "reg", &cs);
+		if (ret || cs >= master->num_chipselect)
+			continue;
+
+		csmode = CSMODE_INIT_VAL;
+
+		/* check if CSBEF is set in device tree */
+		ret = of_property_read_u32(nc, "fsl,csbef", &prop);
+		if (!ret) {
+			csmode &= ~(CSMODE_BEF(0xf));
+			csmode |= CSMODE_BEF(prop);
+		}
+
+		/* check if CSAFT is set in device tree */
+		ret = of_property_read_u32(nc, "fsl,csaft", &prop);
+		if (!ret) {
+			csmode &= ~(CSMODE_AFT(0xf));
+			csmode |= CSMODE_AFT(prop);
+		}
+
+		fsl_espi_write_reg(mspi, ESPI_SPMODEx(cs), csmode);
+
+		if (initial)
+			dev_info(dev, "cs=%u, init_csmode=0x%x\n", cs, csmode);
+	}
+
+	/* Enable SPI interface */
+	fsl_espi_write_reg(mspi, ESPI_SPMODE, SPMODE_INIT_VAL | SPMODE_ENABLE);
+}
+
 static int fsl_espi_probe(struct device *dev, struct resource *mem,
 			  unsigned int irq, unsigned int num_cs)
 {
 	struct spi_master *master;
 	struct mpc8xxx_spi *mpc8xxx_spi;
-	struct device_node *nc;
-	u32 regval, csmode, cs, prop;
 	int ret;
 
 	master = spi_alloc_master(dev, sizeof(struct mpc8xxx_spi));
@@ -634,44 +679,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	if (ret)
 		goto err_probe;
 
-	/* SPI controller initializations */
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODE, 0);
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIM, 0);
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPCOM, 0);
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIE, 0xffffffff);
-
-	/* Init eSPI CS mode register */
-	for_each_available_child_of_node(master->dev.of_node, nc) {
-		/* get chip select */
-		ret = of_property_read_u32(nc, "reg", &cs);
-		if (ret || cs >= num_cs)
-			continue;
-
-		csmode = CSMODE_INIT_VAL;
-
-		/* check if CSBEF is set in device tree */
-		ret = of_property_read_u32(nc, "fsl,csbef", &prop);
-		if (!ret) {
-			csmode &= ~(CSMODE_BEF(0xf));
-			csmode |= CSMODE_BEF(prop);
-		}
-
-		/* check if CSAFT is set in device tree */
-		ret = of_property_read_u32(nc, "fsl,csaft", &prop);
-		if (!ret) {
-			csmode &= ~(CSMODE_AFT(0xf));
-			csmode |= CSMODE_AFT(prop);
-		}
-
-		fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODEx(cs), csmode);
-
-		dev_info(dev, "cs=%u, init_csmode=0x%x\n", cs, csmode);
-	}
-
-	/* Enable SPI interface */
-	regval = SPMODE_INIT_VAL | SPMODE_ENABLE;
-
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODE, regval);
+	fsl_espi_init_regs(dev, true);
 
 	pm_runtime_set_autosuspend_delay(dev, AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(dev);
@@ -771,27 +779,9 @@ static int of_fsl_espi_suspend(struct device *dev)
 static int of_fsl_espi_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
-	struct mpc8xxx_spi *mpc8xxx_spi;
-	u32 regval;
-	int i, ret;
-
-	mpc8xxx_spi = spi_master_get_devdata(master);
-
-	/* SPI controller initializations */
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODE, 0);
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIM, 0);
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPCOM, 0);
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIE, 0xffffffff);
-
-	/* Init eSPI CS mode register */
-	for (i = 0; i < master->num_chipselect; i++)
-		fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODEx(i),
-				      CSMODE_INIT_VAL);
-
-	/* Enable SPI interface */
-	regval = SPMODE_INIT_VAL | SPMODE_ENABLE;
+	int ret;
 
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODE, regval);
+	fsl_espi_init_regs(dev, false);
 
 	ret = pm_runtime_force_resume(dev);
 	if (ret < 0)
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
