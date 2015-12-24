From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH 1/2] spi: sh-msiof: Add rcar fallback compatibility string
Date: Thu, 24 Dec 2015 20:16:46 +0900
Message-ID: <1450955807-22869-2-git-send-email-ykaneko0929@gmail.com>
References: <1450955807-22869-1-git-send-email-ykaneko0929@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Mark Brown <broonie@kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
To: linux-spi@vger.kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450955807-22869-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add fallback compatibility string for R-Car Gen2 and Gen3.
This is in keeping with the fallback scheme being adopted wherever
appropriate for drivers for Renesas SoCs.
In Addition, this patch deletes the compat strings for old SoCs.

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 11 ++++++++---
 drivers/spi/spi-sh-msiof.c                         |  5 +++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index aa005c1..d9d89ee 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -2,8 +2,8 @@ Renesas MSIOF spi controller
 
 Required properties:
 - compatible           : "renesas,msiof-<soctype>" for SoCs,
-			 "renesas,sh-msiof" for SuperH, or
-			 "renesas,sh-mobile-msiof" for SH Mobile series.
+			 "renesas,rcar-gen2-msiof" for R-Car Gen2 series, or
+			 "renesas,rcar-gen3-msiof" for R-Car Gen3 series.
 			 Examples with soctypes are:
 			 "renesas,msiof-r8a7790" (R-Car H2)
 			 "renesas,msiof-r8a7791" (R-Car M2-W)
@@ -11,6 +11,11 @@ Required properties:
 			 "renesas,msiof-r8a7793" (R-Car M2-N)
 			 "renesas,msiof-r8a7794" (R-Car E2)
 			 "renesas,msiof-sh73a0" (SH-Mobile AG5)
+
+			 When compatible with the generic version, nodes must
+			 list the SoC-specific version corresponding to the
+			 platform first followed by the generic version.
+
 - reg                  : A list of offsets and lengths of the register sets for
 			 the device.
 			 If only one register set is present, it is to be used
@@ -60,7 +65,7 @@ Documentation/devicetree/bindings/pinctrl/renesas,*.
 Example:
 
 	msiof0: spi@e6e20000 {
-		compatible = "renesas,msiof-r8a7791";
+		compatible = "renesas,msiof-r8a7791", "renesas,rcar-gen2-msiof";
 		reg = <0 0xe6e20000 0 0x0064>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index a7934ab..283fb31 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1,6 +1,7 @@
 /*
  * SuperH MSIOF SPI Master Interface
  *
+ * Copyright (C) 2014-2015 Renesas Electronics Corporation
  * Copyright (c) 2009 Magnus Damm
  * Copyright (C) 2014 Glider bvba
  *
@@ -971,8 +972,8 @@ static const struct sh_msiof_chipdata r8a779x_data = {
 };
 
 static const struct of_device_id sh_msiof_match[] = {
-	{ .compatible = "renesas,sh-msiof",        .data = &sh_data },
-	{ .compatible = "renesas,sh-mobile-msiof", .data = &sh_data },
+	{ .compatible = "renesas,rcar-gen2-msiof", .data = &r8a779x_data },
+	{ .compatible = "renesas,rcar-gen3-msiof", .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7790",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7791",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7792",   .data = &r8a779x_data },
-- 
1.9.1

