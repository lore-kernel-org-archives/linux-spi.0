From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] spi: spi-fsl-dspi: Make bus-num property optional
Date: Thu,  5 Mar 2020 12:55:46 +0100
Message-ID: <20200305115546.31814-1-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The SPI bus number is completely optional to Linux, so make the
corresponding device tree property optional as well.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 2 +-
 drivers/spi/spi-fsl-dspi.c                             | 8 ++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
index 162e024b95a0..5c7817c8341c 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -14,11 +14,11 @@ Required properties:
 - pinctrl-0: pin control group to be used for this controller.
 - pinctrl-names: must contain a "default" entry.
 - spi-num-chipselects : the number of the chipselect signals.
-- bus-num : the slave chip chipselect signal number.
 
 Optional property:
 - big-endian: If present the dspi device's registers are implemented
   in big endian mode.
+- bus-num : the slave chip chipselect signal number.
 
 Optional SPI slave node properties:
 - fsl,spi-cs-sck-delay: a delay in nanoseconds between activating chip
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 6ec2dcb8c57a..8187dd4a3ec4 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1038,7 +1038,7 @@ static int dspi_probe(struct platform_device *pdev)
 	const struct regmap_config *regmap_config;
 	struct fsl_dspi_platform_data *pdata;
 	struct spi_controller *ctlr;
-	int ret, cs_num, bus_num;
+	int ret, cs_num, bus_num = -1;
 	struct fsl_dspi *dspi;
 	struct resource *res;
 	void __iomem *base;
@@ -1074,11 +1074,7 @@ static int dspi_probe(struct platform_device *pdev)
 		}
 		ctlr->num_chipselect = cs_num;
 
-		ret = of_property_read_u32(np, "bus-num", &bus_num);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "can't get bus-num\n");
-			goto out_ctlr_put;
-		}
+		of_property_read_u32(np, "bus-num", &bus_num);
 		ctlr->bus_num = bus_num;
 
 		if (of_property_read_bool(np, "spi-slave"))
-- 
2.25.1
