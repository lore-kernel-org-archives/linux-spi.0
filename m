From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sh-msiof: Document hardware limitations related to chip selects" to the spi tree
Date: Thu, 14 Dec 2017 11:49:38 +0000
Message-ID: <E1ePS1C-0005U3-Tn@debutante>
References: <1513191913-10612-5-git-send-email-geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513191913-10612-5-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sh-msiof: Document hardware limitations related to chip selects

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From c99182f73cce7926c623b5c1c0ff0b7954ac8d81 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 13 Dec 2017 20:05:13 +0100
Subject: [PATCH] spi: sh-msiof: Document hardware limitations related to chip
 selects

Guide users to maintain the proper balance between native and GPIO chip
selects.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index bc8c16a6cfc8..80710f0f0448 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -41,6 +41,16 @@ Optional properties:
 			   0: MSIOF_SYNC
 			   1: MSIOF_SS1
 			   2: MSIOF_SS2
+			 Hardware limitations related to chip selects:
+			   - Native chip selects are always deasserted in
+			     between transfers that are part of the same
+			     message.  Use cs-gpios to work around this.
+			   - All slaves using native chip selects must use the
+			     same spi-cs-high configuration.  Use cs-gpios to
+			     work around this.
+			   - When using GPIO chip selects, at least one native
+			     chip select must be left unused, as it will be
+			     driven anyway.
 - dmas                 : Must contain a list of two references to DMA
 			 specifiers, one for transmission, and one for
 			 reception.
-- 
2.15.1
