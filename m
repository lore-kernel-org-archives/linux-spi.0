From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH] spi: sh-msiof: Add r8a774a1 support
Date: Fri, 17 Aug 2018 15:58:34 +0100
Message-ID: <1534517914-15406-1-git-send-email-fabrizio.castro@bp.renesas.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Document RZ/G2M (R8A774A1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
This patch applies on top of next-20180817

 Documentation/devicetree/bindings/spi/sh-msiof.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index bfbc203..8f7bb6a 100644
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
2.7.4
