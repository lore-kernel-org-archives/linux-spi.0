From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sh-msiof: Add R-Car Gen 2 and 3 fallback bindings" to the spi tree
Date: Wed, 14 Dec 2016 18:03:40 +0000
Message-ID: <E1cHDu0-0007CT-Mr@debutante>
References: <1481536175-17238-1-git-send-email-horms+renesas@verge.net.au>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1481536175-17238-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sh-msiof: Add R-Car Gen 2 and 3 fallback bindings

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

>From 4286db8456f4fa0c6af2b6b9abc5991a7e7da69c Mon Sep 17 00:00:00 2001
From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 12 Dec 2016 10:49:35 +0100
Subject: [PATCH] spi: sh-msiof: Add R-Car Gen 2 and 3 fallback bindings

In the case of Renesas R-Car hardware we know that there are generations of
SoCs, e.g. Gen 2 and Gen 3. But beyond that it's not clear what the
relationship between IP blocks might be. For example, I believe that
r8a7790 is older than r8a7791 but that doesn't imply that the latter is a
descendant of the former or vice versa.

We can, however, by examining the documentation and behaviour of the
hardware at run-time observe that the current driver implementation appears
to be compatible with the IP blocks on SoCs within a given generation.

For the above reasons and convenience when enabling new SoCs a
per-generation fallback compatibility string scheme is being adopted for
drivers for Renesas SoCs.

Also:
* Deprecate renesas,sh-msiof. It seems poorly named as it is only
  compatible with SH-Mobile. It also appears unused in mainline.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 19 +++++++++++++------
 drivers/spi/spi-sh-msiof.c                         |  4 +++-
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index da6614c63796..dc975064fa27 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -1,17 +1,23 @@
 Renesas MSIOF spi controller
 
 Required properties:
-- compatible           : "renesas,msiof-<soctype>" for SoCs,
-			 "renesas,sh-msiof" for SuperH, or
-			 "renesas,sh-mobile-msiof" for SH Mobile series.
-			 Examples with soctypes are:
-			 "renesas,msiof-r8a7790" (R-Car H2)
+- compatible           : "renesas,msiof-r8a7790" (R-Car H2)
 			 "renesas,msiof-r8a7791" (R-Car M2-W)
 			 "renesas,msiof-r8a7792" (R-Car V2H)
 			 "renesas,msiof-r8a7793" (R-Car M2-N)
 			 "renesas,msiof-r8a7794" (R-Car E2)
 			 "renesas,msiof-r8a7796" (R-Car M3-W)
 			 "renesas,msiof-sh73a0" (SH-Mobile AG5)
+			 "renesas,sh-mobile-msiof" (generic SH-Mobile compatibile device)
+			 "renesas,rcar-gen2-msiof" (generic R-Car Gen2 compatible device)
+			 "renesas,rcar-gen3-msiof" (generic R-Car Gen3 compatible device)
+			 "renesas,sh-msiof"      (deprecated)
+
+			 When compatible with the generic version, nodes
+			 must list the SoC-specific version corresponding
+			 to the platform first followed by the generic
+			 version.
+
 - reg                  : A list of offsets and lengths of the register sets for
 			 the device.
 			 If only one register set is present, it is to be used
@@ -61,7 +67,8 @@ Documentation/devicetree/bindings/pinctrl/renesas,*.
 Example:
 
 	msiof0: spi@e6e20000 {
-		compatible = "renesas,msiof-r8a7791";
+		compatible = "renesas,msiof-r8a7791",
+			     "renesas,rcar-gen2-msiof";
 		reg = <0 0xe6e20000 0 0x0064>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 0012ad02e569..471ca211b76c 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -973,14 +973,16 @@ static const struct sh_msiof_chipdata r8a779x_data = {
 };
 
 static const struct of_device_id sh_msiof_match[] = {
-	{ .compatible = "renesas,sh-msiof",        .data = &sh_data },
 	{ .compatible = "renesas,sh-mobile-msiof", .data = &sh_data },
 	{ .compatible = "renesas,msiof-r8a7790",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7791",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7792",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7793",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7794",   .data = &r8a779x_data },
+	{ .compatible = "renesas,rcar-gen2-msiof", .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7796",   .data = &r8a779x_data },
+	{ .compatible = "renesas,rcar-gen3-msiof", .data = &r8a779x_data },
+	{ .compatible = "renesas,sh-msiof",        .data = &sh_data }, // Deprecated
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_msiof_match);
-- 
2.11.0
