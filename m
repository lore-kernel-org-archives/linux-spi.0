From: Jane Wan <Jane.Wan-X7+3OicCfH32eFz/2MeuCQ@public.gmane.org>
Subject: [PATCH] Configure FSL eSPI CSBEF and CSAFT
Date: Wed, 16 Apr 2014 13:09:39 -0700
Message-ID: <1397678979-7655-1-git-send-email-Jane.Wan@gainspeed.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jane Wan <Jane.Wan-X7+3OicCfH32eFz/2MeuCQ@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>,
	<b48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, <sr-ynQEQJNshbs@public.gmane.org>,
	<insop.song-X7+3OicCfH32eFz/2MeuCQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Make FSL eSPI CSnBEF and CSnAFT fields in ESPI_SPMODEn registers
(n=0,1,2,3) configurable through device tree.

CSnBEF is the chip select setup time.  It's the delay in bits from the
activation of chip select pin to the first clock for data frame.

CSnAFT is the chip select hold time.  It's the delay in bits from the
last clock for data frame to the deactivation of chip select pin.

The FSL eSPI driver hardcodes CSnBEF and CSnAFT to 0.  Need to set
them to a different value for some device.

Signed-off-by: Jane Wan <Jane.Wan-X7+3OicCfH32eFz/2MeuCQ@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/fsl-spi.txt |    6 ++++
 drivers/spi/spi-fsl-espi.c                        |   34 ++++++++++++++++++---
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-spi.txt b/Documentation/devicetree/bindings/spi/fsl-spi.txt
index b032dd7..2c7fd41 100644
--- a/Documentation/devicetree/bindings/spi/fsl-spi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-spi.txt
@@ -42,6 +42,10 @@ Required properties:
 - interrupts : should contain eSPI interrupt, the device has one interrupt.
 - fsl,espi-num-chipselects : the number of the chipselect signals.
 
+Optional properties:
+- fsl,csbef: chip select assertion time in bits before frame starts
+- fsl,csaft: chip select negation time in bits after frame ends
+
 Example:
 	spi@110000 {
 		#address-cells = <1>;
@@ -51,4 +55,6 @@ Example:
 		interrupts = <53 0x2>;
 		interrupt-parent = <&mpic>;
 		fsl,espi-num-chipselects = <4>;
+		fsl,csbef = <1>;
+		fsl,csaft = <1>;
 	};
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 428dc7a..7ff9463 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -590,8 +590,10 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	struct spi_master *master;
 	struct mpc8xxx_spi *mpc8xxx_spi;
 	struct fsl_espi_reg *reg_base;
-	u32 regval;
-	int i, ret = 0;
+	struct device_node *nc;
+	const __be32 *prop;
+	u32 regval, csmode;
+	int i, len, ret = 0;
 
 	master = spi_alloc_master(dev, sizeof(struct mpc8xxx_spi));
 	if (!master) {
@@ -638,8 +640,32 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	mpc8xxx_spi_write_reg(&reg_base->event, 0xffffffff);
 
 	/* Init eSPI CS mode register */
-	for (i = 0; i < pdata->max_chipselect; i++)
-		mpc8xxx_spi_write_reg(&reg_base->csmode[i], CSMODE_INIT_VAL);
+	for_each_available_child_of_node(master->dev.of_node, nc) {
+		/* get chip select */
+		prop = of_get_property(nc, "reg", &len);
+		if (!prop || len < sizeof(*prop))
+			continue;
+		i = be32_to_cpup(prop);
+		if (i < 0 || i >= pdata->max_chipselect)
+			continue;
+
+		csmode = CSMODE_INIT_VAL;
+		/* check if CSBEF is set in device tree */
+		prop = of_get_property(nc, "fsl,csbef", &len);
+		if (prop && len >= sizeof(*prop)) {
+			csmode &= ~(CSMODE_BEF(0xf));
+			csmode |= CSMODE_BEF(be32_to_cpup(prop));
+		}
+		/* check if CSAFT is set in device tree */
+		prop = of_get_property(nc, "fsl,csaft", &len);
+		if (prop && len >= sizeof(*prop)) {
+			csmode &= ~(CSMODE_AFT(0xf));
+			csmode |= CSMODE_AFT(be32_to_cpup(prop));
+		}
+		mpc8xxx_spi_write_reg(&reg_base->csmode[i], csmode);
+
+		dev_info(dev, "cs=%d, init_csmode=0x%x\n", i, csmode);
+	}
 
 	/* Enable SPI interface */
 	regval = pdata->initial_spmode | SPMODE_INIT_VAL | SPMODE_ENABLE;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
