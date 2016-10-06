From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: replace of_get_property with of_property_read_u32" to the spi tree
Date: Thu, 06 Oct 2016 18:03:31 +0200
Message-ID: <E1bsB8t-0001sz-9A@finisterre>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: replace of_get_property with of_property_read_u32

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

>From 72997f9d801392510f4654c3a67b2b37978dfbcd Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sat, 1 Oct 2016 21:07:52 +0200
Subject: [PATCH] spi: fsl-espi: replace of_get_property with
 of_property_read_u32

of_property_read_u32 is better here than generic of_get_property:
- implicit endianness conversion if needed
- implicit checking of size of property

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 7451585a080e..1f97cce615d3 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -545,9 +545,8 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	struct spi_master *master;
 	struct mpc8xxx_spi *mpc8xxx_spi;
 	struct device_node *nc;
-	const __be32 *prop;
-	u32 regval, csmode;
-	int i, len, ret;
+	u32 regval, csmode, cs, prop;
+	int ret;
 
 	master = spi_alloc_master(dev, sizeof(struct mpc8xxx_spi));
 	if (!master)
@@ -599,29 +598,29 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	/* Init eSPI CS mode register */
 	for_each_available_child_of_node(master->dev.of_node, nc) {
 		/* get chip select */
-		prop = of_get_property(nc, "reg", &len);
-		if (!prop || len < sizeof(*prop))
-			continue;
-		i = be32_to_cpup(prop);
-		if (i < 0 || i >= pdata->max_chipselect)
+		ret = of_property_read_u32(nc, "reg", &cs);
+		if (ret || cs >= pdata->max_chipselect)
 			continue;
 
 		csmode = CSMODE_INIT_VAL;
+
 		/* check if CSBEF is set in device tree */
-		prop = of_get_property(nc, "fsl,csbef", &len);
-		if (prop && len >= sizeof(*prop)) {
+		ret = of_property_read_u32(nc, "fsl,csbef", &prop);
+		if (!ret) {
 			csmode &= ~(CSMODE_BEF(0xf));
-			csmode |= CSMODE_BEF(be32_to_cpup(prop));
+			csmode |= CSMODE_BEF(prop);
 		}
+
 		/* check if CSAFT is set in device tree */
-		prop = of_get_property(nc, "fsl,csaft", &len);
-		if (prop && len >= sizeof(*prop)) {
+		ret = of_property_read_u32(nc, "fsl,csaft", &prop);
+		if (!ret) {
 			csmode &= ~(CSMODE_AFT(0xf));
-			csmode |= CSMODE_AFT(be32_to_cpup(prop));
+			csmode |= CSMODE_AFT(prop);
 		}
-		fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODEx(i), csmode);
 
-		dev_info(dev, "cs=%d, init_csmode=0x%x\n", i, csmode);
+		fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODEx(cs), csmode);
+
+		dev_info(dev, "cs=%u, init_csmode=0x%x\n", cs, csmode);
 	}
 
 	/* Enable SPI interface */
@@ -660,16 +659,16 @@ static int of_fsl_espi_get_chipselects(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
-	const u32 *prop;
-	int len;
+	u32 num_cs;
+	int ret;
 
-	prop = of_get_property(np, "fsl,espi-num-chipselects", &len);
-	if (!prop || len < sizeof(*prop)) {
+	ret = of_property_read_u32(np, "fsl,espi-num-chipselects", &num_cs);
+	if (ret) {
 		dev_err(dev, "No 'fsl,espi-num-chipselects' property\n");
 		return -EINVAL;
 	}
 
-	pdata->max_chipselect = *prop;
+	pdata->max_chipselect = num_cs;
 	pdata->cs_control = NULL;
 
 	return 0;
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
