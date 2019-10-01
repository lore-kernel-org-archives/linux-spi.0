From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: snps,dw-apb-ssi: Add optional clock domain information" to the spi tree
Date: Tue,  1 Oct 2019 12:41:07 +0100 (BST)
Message-ID: <20191001114107.ACF3F2742A10@ypsilon.sirena.org.uk>
References: <1568793876-9009-3-git-send-email-gareth.williams.jx@renesas.com>
Cc: devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Rob Herring <robh+dt@kernel.org>
To: Gareth Williams <gareth.williams.jx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1568793876-9009-3-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   dt-bindings: snps,dw-apb-ssi: Add optional clock domain information

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

>From 47cf13bc763c891c6192184c5e5aa8c1b331b2ff Mon Sep 17 00:00:00 2001
From: Gareth Williams <gareth.williams.jx@renesas.com>
Date: Wed, 18 Sep 2019 09:04:34 +0100
Subject: [PATCH] dt-bindings: snps,dw-apb-ssi: Add optional clock domain
 information

Note in the bindings documentation that pclk should be renamed if a clock
domain is used to enable the optional bus clock.

Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
Link: https://lore.kernel.org/r/1568793876-9009-3-git-send-email-gareth.williams.jx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index f54c8c36395e..3ed08ee9feba 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -16,7 +16,8 @@ Required properties:
 Optional properties:
 - clock-names : Contains the names of the clocks:
     "ssi_clk", for the core clock used to generate the external SPI clock.
-    "pclk", the interface clock, required for register access.
+    "pclk", the interface clock, required for register access. If a clock domain
+     used to enable this clock then it should be named "pclk_clkdomain".
 - cs-gpios : Specifies the gpio pins to be used for chipselects.
 - num-cs : The number of chipselects. If omitted, this will default to 4.
 - reg-io-width : The I/O register width (in bytes) implemented by this
-- 
2.20.1
