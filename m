From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] spi: sh-msiof: Remove "renesas,msiof-sh7724" from bindings
Date: Tue, 11 Mar 2014 10:43:26 +0100
Message-ID: <1394531006-20341-1-git-send-email-geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

It's not implemented in the driver, so it's a bad example.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v2:
  - Add Acked-by

 Documentation/devicetree/bindings/spi/sh-msiof.txt |    1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index 1f0cb33763a1..f24baf3b6cc1 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -5,7 +5,6 @@ Required properties:
 			 "renesas,sh-msiof" for SuperH, or
 			 "renesas,sh-mobile-msiof" for SH Mobile series.
 			 Examples with soctypes are:
-			 "renesas,msiof-sh7724" (SH)
 			 "renesas,msiof-r8a7790" (R-Car H2)
 			 "renesas,msiof-r8a7791" (R-Car M2)
 - reg                  : Offset and length of the register set for the device
-- 
1.7.9.5

