From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sh-msiof: Add support for R-Car M3-W" to the spi tree
Date: Mon, 21 Nov 2016 19:20:42 +0000
Message-ID: <E1c8u8w-00080T-Qa@debutante>
References: <1479749095-13548-1-git-send-email-geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1479749095-13548-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sh-msiof: Add support for R-Car M3-W

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

>From eb51cffa743de5c78cfbf44f576b0f1eccc784f4 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 21 Nov 2016 18:24:55 +0100
Subject: [PATCH] spi: sh-msiof: Add support for R-Car M3-W

MSIOF in R-Car M3-W (r8a7796) is handled fine by the existing driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 1 +
 drivers/spi/spi-sh-msiof.c                         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index aa005c1d10d9..da6614c63796 100644
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
index 1de3a772eb7d..0012ad02e569 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -980,6 +980,7 @@ static const struct of_device_id sh_msiof_match[] = {
 	{ .compatible = "renesas,msiof-r8a7792",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7793",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7794",   .data = &r8a779x_data },
+	{ .compatible = "renesas,msiof-r8a7796",   .data = &r8a779x_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_msiof_match);
-- 
2.10.2
