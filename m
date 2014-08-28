From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] spi: sh-msiof: Add support for new R-Car Gen2 SoCs
Date: Thu, 28 Aug 2014 10:11:03 +0200
Message-ID: <1409213463-5599-1-git-send-email-geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add support for MSIOF in:
  - r8a7792 (R-Car V2H)
  - r8a7793 (R-Car M2-N)
  - r8a7794 (R-Car E2)

r8a7791 is now called "R-Car M2-W".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop RFC
  - Replace an "H2 and M2" by "Gen2"
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 6 +++++-
 drivers/spi/spi-sh-msiof.c                         | 6 ++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index 98e07f1c3dab..d11c3721e7cd 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -6,6 +6,10 @@ Required properties:
 			 "renesas,sh-mobile-msiof" for SH Mobile series.
 			 Examples with soctypes are:
 			 "renesas,msiof-r8a7790" (R-Car H2)
+			 "renesas,msiof-r8a7791" (R-Car M2-W)
+			 "renesas,msiof-r8a7792" (R-Car V2H)
+			 "renesas,msiof-r8a7793" (R-Car M2-N)
+			 "renesas,msiof-r8a7794" (R-Car E2)
 - reg                  : A list of offsets and lengths of the register sets for
 			 the device.
 			 If only one register set is present, it is to be used
@@ -31,7 +35,7 @@ Optional properties, deprecated for soctype-specific bindings:
 - renesas,tx-fifo-size : Overrides the default tx fifo size given in words
 			 (default is 64)
 - renesas,rx-fifo-size : Overrides the default rx fifo size given in words
-			 (default is 64, or 256 on R-Car H2 and M2)
+			 (default is 64, or 256 on R-Car Gen2)
 
 Pinctrl properties might be needed, too.  See
 Documentation/devicetree/bindings/pinctrl/renesas,*.
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 1165d418340f..3f365402fcc0 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -928,6 +928,9 @@ static const struct of_device_id sh_msiof_match[] = {
 	{ .compatible = "renesas,sh-mobile-msiof", .data = &sh_data },
 	{ .compatible = "renesas,msiof-r8a7790",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7791",   .data = &r8a779x_data },
+	{ .compatible = "renesas,msiof-r8a7792",   .data = &r8a779x_data },
+	{ .compatible = "renesas,msiof-r8a7793",   .data = &r8a779x_data },
+	{ .compatible = "renesas,msiof-r8a7794",   .data = &r8a779x_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_msiof_match);
@@ -1219,6 +1222,9 @@ static struct platform_device_id spi_driver_ids[] = {
 	{ "spi_sh_msiof",	(kernel_ulong_t)&sh_data },
 	{ "spi_r8a7790_msiof",	(kernel_ulong_t)&r8a779x_data },
 	{ "spi_r8a7791_msiof",	(kernel_ulong_t)&r8a779x_data },
+	{ "spi_r8a7792_msiof",	(kernel_ulong_t)&r8a779x_data },
+	{ "spi_r8a7793_msiof",	(kernel_ulong_t)&r8a779x_data },
+	{ "spi_r8a7794_msiof",	(kernel_ulong_t)&r8a779x_data },
 	{},
 };
 MODULE_DEVICE_TABLE(platform, spi_driver_ids);
-- 
1.9.1

