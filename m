From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sh-msiof: Add r8a774a1 support" to the spi tree
Date: Tue, 28 Aug 2018 21:56:35 +0100 (BST)
Message-ID: <20180828205635.E7107440095@finisterre.ee.mobilebroadband>
References: <1534517914-15406-1-git-send-email-fabrizio.castro@bp.renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534517914-15406-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sh-msiof: Add r8a774a1 support

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

>From 864822235f1897219409ec1f0af076fcc9057c57 Mon Sep 17 00:00:00 2001
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Date: Fri, 17 Aug 2018 15:58:34 +0100
Subject: [PATCH] spi: sh-msiof: Add r8a774a1 support

Document RZ/G2M (R8A774A1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index bfbc2035fb6b..8f7bb6aaff2e 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -3,6 +3,7 @@ Renesas MSIOF spi controller
 Required properties:
 - compatible           : "renesas,msiof-r8a7743" (RZ/G1M)
 			 "renesas,msiof-r8a7745" (RZ/G1E)
+			 "renesas,msiof-r8a774a1" (RZ/G2M)
 			 "renesas,msiof-r8a7790" (R-Car H2)
 			 "renesas,msiof-r8a7791" (R-Car M2-W)
 			 "renesas,msiof-r8a7792" (R-Car V2H)
@@ -14,7 +15,7 @@ Required properties:
 			 "renesas,msiof-sh73a0" (SH-Mobile AG5)
 			 "renesas,sh-mobile-msiof" (generic SH-Mobile compatibile device)
 			 "renesas,rcar-gen2-msiof" (generic R-Car Gen2 and RZ/G1 compatible device)
-			 "renesas,rcar-gen3-msiof" (generic R-Car Gen3 compatible device)
+			 "renesas,rcar-gen3-msiof" (generic R-Car Gen3 and RZ/G2 compatible device)
 			 "renesas,sh-msiof"      (deprecated)
 
 			 When compatible with the generic version, nodes
-- 
2.18.0
