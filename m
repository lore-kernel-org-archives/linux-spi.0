From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH 2/2] spi: sh-msiof: Add compatible string for r8a7795
Date: Thu, 24 Dec 2015 20:16:47 +0900
Message-ID: <1450955807-22869-3-git-send-email-ykaneko0929@gmail.com>
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

From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>

Simply documents new compatibility string.
As a previous patch adds a generic R-Car Gen3 compatibility string
there appears to be no need for a driver updates.

Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index d9d89ee..81c1389 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -11,6 +11,7 @@ Required properties:
 			 "renesas,msiof-r8a7793" (R-Car M2-N)
 			 "renesas,msiof-r8a7794" (R-Car E2)
 			 "renesas,msiof-sh73a0" (SH-Mobile AG5)
+			 "renesas,msiof-r8a7795" (R-Car H3)
 
 			 When compatible with the generic version, nodes must
 			 list the SoC-specific version corresponding to the
-- 
1.9.1

