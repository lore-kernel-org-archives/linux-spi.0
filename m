From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: sh-msiof: Add support for R-Car M3-W
Date: Mon, 21 Nov 2016 18:24:55 +0100
Message-ID: <1479749095-13548-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

MSIOF in R-Car M3-W (r8a7796) is handled fine by the existing driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested with MSIOF2(B) on EXIO connector D of r8a7796/salvator-x, using
spidev, gpio-74x164, and a logic analyzer.

 Documentation/devicetree/bindings/spi/sh-msiof.txt | 1 +
 drivers/spi/spi-sh-msiof.c                         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index aa005c1d10d95756..da6614c6379604bb 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -10,6 +10,7 @@ Required properties:
 			 "renesas,msiof-r8a7792" (R-Car V2H)
 			 "renesas,msiof-r8a7793" (R-Car M2-N)
 			 "renesas,msiof-r8a7794" (R-Car E2)
+			 "renesas,msiof-r8a7796" (R-Car M3-W)
 			 "renesas,msiof-sh73a0" (SH-Mobile AG5)
 - reg                  : A list of offsets and lengths of the register sets for
 			 the device.
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 1de3a772eb7d23a8..0012ad02e5696d35 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -980,6 +980,7 @@ static int sh_msiof_transfer_one(struct spi_master *master,
 	{ .compatible = "renesas,msiof-r8a7792",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7793",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7794",   .data = &r8a779x_data },
+	{ .compatible = "renesas,msiof-r8a7796",   .data = &r8a779x_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_msiof_match);
-- 
1.9.1
