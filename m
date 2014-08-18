From: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] spi: fsl-dspi: Convert to use regmap framework's endianness method.
Date: Mon, 18 Aug 2014 15:48:20 +0800
Message-ID: <1408348100-28819-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---

This is depended on the following patches, which has been applied into
Regmap-Tree:
https://lkml.org/lkml/2014/7/15/6
https://lkml.org/lkml/2014/7/15/5
https://lkml.org/lkml/2014/7/15/7




 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 7 ++++++-
 drivers/spi/spi-fsl-dspi.c                             | 3 ---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
index 5376de4..cbbe16e 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -10,7 +10,12 @@ Required properties:
 - pinctrl-names: must contain a "default" entry.
 - spi-num-chipselects : the number of the chipselect signals.
 - bus-num : the slave chip chipselect signal number.
-- big-endian : if DSPI modudle is big endian, the bool will be set in node.
+
+Optional property:
+- big-endian: If present the dspi device's registers are implemented
+  in big endian mode, otherwise in native mode(same with CPU), for more
+  detail please see: Documentation/devicetree/bindings/regmap/regmap.txt.
+
 Example:
 
 dspi0@4002c000 {
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 5021ddf..ebc4d1f 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -493,9 +493,6 @@ static int dspi_probe(struct platform_device *pdev)
 	}
 
 	dspi_regmap_config.lock_arg = dspi;
-	dspi_regmap_config.val_format_endian =
-		of_property_read_bool(np, "big-endian")
-			? REGMAP_ENDIAN_BIG : REGMAP_ENDIAN_DEFAULT;
 	dspi->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "dspi", base,
 						&dspi_regmap_config);
 	if (IS_ERR(dspi->regmap)) {
-- 
1.8.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
