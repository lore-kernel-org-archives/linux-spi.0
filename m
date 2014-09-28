From: gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org
Subject: [PATCH v3] spi: orion: support armada extended baud rates
Date: Sun, 28 Sep 2014 23:24:04 +1000
Message-ID: <1411910644-7174-1-git-send-email-gerg@uclinux.org>
Cc: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>

The Armada SoC family implementation of this SPI hardware module has
extended the configuration register to allow for a wider range of SPI
clock rates. Specifically the Serial Baud Rate Pre-selection bits in the
SPI Interface Configuration Register now also use bits 6 and 7 as well.

Modify the baud rate calculation to handle these differences for the
Armada case. Potentially a baud rate can be setup using a number of
different pre-scalar and scalar combinations. This code tries all
possible pre-scalar divisors (8 in total) to try and find the most
accurate set.

This change introduces (and documents) a new device tree compatible
device name "armada-370-spi" to support this.

Signed-off-by: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Tested-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Reviewed-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
Changes in v2:
Introduced a new devicetree compatible name for armada SPI support.

Changes in v3:
Changed compatible devicetree name to armada-370-spi.
Split change to armada-370-xp.dtsi out into separate patch

 .../devicetree/bindings/spi/spi-orion.txt          |   2 +-
 drivers/spi/spi-orion.c                            | 116 +++++++++++++++++----
 2 files changed, 95 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-orion.txt b/Documentation/devicetree/bindings/spi/spi-orion.txt
index a3ff50f..50c3a3d 100644
--- a/Documentation/devicetree/bindings/spi/spi-orion.txt
+++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
@@ -1,7 +1,7 @@
 Marvell Orion SPI device
 
 Required properties:
-- compatible : should be "marvell,orion-spi".
+- compatible : should be "marvell,orion-spi" or "marvell,armada-370-spi".
 - reg : offset and length of the register set for the device
 - cell-index : Which of multiple SPI controllers is this.
 Optional properties:
diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index c4675fa..acf8e48 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/clk.h>
 #include <linux/sizes.h>
 #include <asm/unaligned.h>
@@ -40,13 +41,27 @@
 #define ORION_SPI_MODE_CPHA		(1 << 12)
 #define ORION_SPI_IF_8_16_BIT_MODE	(1 << 5)
 #define ORION_SPI_CLK_PRESCALE_MASK	0x1F
+#define ARMADA_SPI_CLK_PRESCALE_MASK	0xDF
 #define ORION_SPI_MODE_MASK		(ORION_SPI_MODE_CPOL | \
 					 ORION_SPI_MODE_CPHA)
 
+enum orion_spi_type {
+	ORION_SPI,
+	ARMADA_SPI,
+};
+
+struct orion_spi_dev {
+	enum orion_spi_type	typ;
+	unsigned int		min_divisor;
+	unsigned int		max_divisor;
+	u32			prescale_mask;
+};
+
 struct orion_spi {
 	struct spi_master	*master;
 	void __iomem		*base;
 	struct clk              *clk;
+	const struct orion_spi_dev *devdata;
 };
 
 static inline void __iomem *spi_reg(struct orion_spi *orion_spi, u32 reg)
@@ -83,30 +98,66 @@ static int orion_spi_baudrate_set(struct spi_device *spi, unsigned int speed)
 	u32 prescale;
 	u32 reg;
 	struct orion_spi *orion_spi;
+	const struct orion_spi_dev *devdata;
 
 	orion_spi = spi_master_get_devdata(spi->master);
+	devdata = orion_spi->devdata;
 
 	tclk_hz = clk_get_rate(orion_spi->clk);
 
-	/*
-	 * the supported rates are: 4,6,8...30
-	 * round up as we look for equal or less speed
-	 */
-	rate = DIV_ROUND_UP(tclk_hz, speed);
-	rate = roundup(rate, 2);
+	if (devdata->typ == ARMADA_SPI) {
+		unsigned int clk, spr, sppr, sppr2, err;
+		unsigned int best_spr, best_sppr, best_err;
+
+		best_err = speed;
+		best_spr = 0;
+		best_sppr = 0;
+
+		/* Iterate over the valid range looking for best fit */
+		for (sppr = 0; sppr < 8; sppr++) {
+			sppr2 = 0x1 << sppr;
+
+			spr = tclk_hz / sppr2;
+			spr = DIV_ROUND_UP(spr, speed);
+			if ((spr == 0) || (spr > 15))
+				continue;
 
-	/* check if requested speed is too small */
-	if (rate > 30)
-		return -EINVAL;
+			clk = tclk_hz / (spr * sppr2);
+			err = speed - clk;
 
-	if (rate < 4)
-		rate = 4;
+			if (err < best_err) {
+				best_spr = spr;
+				best_sppr = sppr;
+				best_err = err;
+			}
+		}
+
+		if ((best_sppr == 0) && (best_spr == 0))
+			return -EINVAL;
+
+		prescale = ((best_sppr & 0x6) << 5) |
+			((best_sppr & 0x1) << 4) | best_spr;
+	} else {
+		/*
+		 * the supported rates are: 4,6,8...30
+		 * round up as we look for equal or less speed
+		 */
+		rate = DIV_ROUND_UP(tclk_hz, speed);
+		rate = roundup(rate, 2);
+
+		/* check if requested speed is too small */
+		if (rate > 30)
+			return -EINVAL;
 
-	/* Convert the rate to SPI clock divisor value.	*/
-	prescale = 0x10 + rate/2;
+		if (rate < 4)
+			rate = 4;
+
+		/* Convert the rate to SPI clock divisor value.	*/
+		prescale = 0x10 + rate/2;
+	}
 
 	reg = readl(spi_reg(orion_spi, ORION_SPI_IF_CONFIG_REG));
-	reg = ((reg & ~ORION_SPI_CLK_PRESCALE_MASK) | prescale);
+	reg = ((reg & ~devdata->prescale_mask) | prescale);
 	writel(reg, spi_reg(orion_spi, ORION_SPI_IF_CONFIG_REG));
 
 	return 0;
@@ -342,8 +393,31 @@ static int orion_spi_reset(struct orion_spi *orion_spi)
 	return 0;
 }
 
+static const struct orion_spi_dev orion_spi_dev_data = {
+	.typ = ORION_SPI,
+	.min_divisor = 4,
+	.max_divisor = 30,
+	.prescale_mask = ORION_SPI_CLK_PRESCALE_MASK,
+};
+
+static const struct orion_spi_dev armada_spi_dev_data = {
+	.typ = ARMADA_SPI,
+	.min_divisor = 1,
+	.max_divisor = 1920,
+	.prescale_mask = ARMADA_SPI_CLK_PRESCALE_MASK,
+};
+
+static const struct of_device_id orion_spi_of_match_table[] = {
+	{ .compatible = "marvell,orion-spi", .data = &orion_spi_dev_data, },
+	{ .compatible = "marvell,armada-370-spi", .data = &armada_spi_dev_data, },
+	{}
+};
+MODULE_DEVICE_TABLE(of, orion_spi_of_match_table);
+
 static int orion_spi_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id;
+	const struct orion_spi_dev *devdata;
 	struct spi_master *master;
 	struct orion_spi *spi;
 	struct resource *r;
@@ -378,6 +452,10 @@ static int orion_spi_probe(struct platform_device *pdev)
 	spi = spi_master_get_devdata(master);
 	spi->master = master;
 
+	of_id = of_match_device(orion_spi_of_match_table, &pdev->dev);
+	devdata = of_id->data;
+	spi->devdata = devdata;
+
 	spi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(spi->clk)) {
 		status = PTR_ERR(spi->clk);
@@ -389,8 +467,8 @@ static int orion_spi_probe(struct platform_device *pdev)
 		goto out;
 
 	tclk_hz = clk_get_rate(spi->clk);
-	master->max_speed_hz = DIV_ROUND_UP(tclk_hz, 4);
-	master->min_speed_hz = DIV_ROUND_UP(tclk_hz, 30);
+	master->max_speed_hz = DIV_ROUND_UP(tclk_hz, devdata->min_divisor);
+	master->min_speed_hz = DIV_ROUND_UP(tclk_hz, devdata->max_divisor);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	spi->base = devm_ioremap_resource(&pdev->dev, r);
@@ -469,12 +547,6 @@ static const struct dev_pm_ops orion_spi_pm_ops = {
 			   NULL)
 };
 
-static const struct of_device_id orion_spi_of_match_table[] = {
-	{ .compatible = "marvell,orion-spi", },
-	{}
-};
-MODULE_DEVICE_TABLE(of, orion_spi_of_match_table);
-
 static struct platform_driver orion_spi_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
