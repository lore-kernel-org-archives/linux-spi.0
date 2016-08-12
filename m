From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/PROTO 1/9 common] spi: sh-msiof: Add support for R-Car H3
Date: Fri, 12 Aug 2016 18:38:37 +0200
Message-ID: <1471019925-29083-2-git-send-email-geert+renesas@glider.be>
References: <1471019925-29083-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-clk@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: linux-renesas-soc@vger.kernel.org
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1471019925-29083-1-git-send-email-geert+renesas@glider.be>
Sender: linux-clk-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add support for MSIOF in r8a7795 (R-Car H3).

Not-Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Not intended for upstream merge.

R-Car H3 ES1.0 has a hardware bug preventing MSIOF from being used with
real SPI devices. However, this does not affect the generation of clock
signals on the SPI bus.
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 1 +
 drivers/spi/spi-sh-msiof.c                         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index aa005c1d10d95756..e4ba96cb45ffff31 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -10,6 +10,7 @@ Required properties:
 			 "renesas,msiof-r8a7792" (R-Car V2H)
 			 "renesas,msiof-r8a7793" (R-Car M2-N)
 			 "renesas,msiof-r8a7794" (R-Car E2)
+			 "renesas,msiof-r8a7795" (R-Car H3)
 			 "renesas,msiof-sh73a0" (SH-Mobile AG5)
 - reg                  : A list of offsets and lengths of the register sets for
 			 the device.
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 6852552a32ef7457..ffa5efdf266a8276 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -996,6 +996,7 @@ static const struct of_device_id sh_msiof_match[] = {
 	{ .compatible = "renesas,msiof-r8a7792",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7793",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7794",   .data = &r8a779x_data },
+	{ .compatible = "renesas,msiof-r8a7795",   .data = &r8a779x_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_msiof_match);
-- 
1.9.1

