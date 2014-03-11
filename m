From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 resend] spi: hs-spi: Improve bindings
Date: Tue, 11 Mar 2014 10:40:51 +0100
Message-ID: <1394530851-20244-1-git-send-email-geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

  - Add future-proof "renesas,hspi-<soctype>" compatible values,
  - Add missing "interrupt-parent", "#address-cells", and "#size-cells"
    properties,
  - Add reference to pinctrl documentation,
  - Add example bindings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
Mark: Can you please ack and take this, so Simon can apply the patches that
      use these bindings? Thx!

v3:
  - Split in two patches: bindings and dtsi updates
v2:
  - Add Tested-by
  - List full example compatible properties with soctypes instead of just
    the soctypes, so checkpatch can validate DTSes.

 Documentation/devicetree/bindings/spi/sh-hspi.txt |   28 ++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-hspi.txt b/Documentation/devicetree/bindings/spi/sh-hspi.txt
index 30b57b1c8a13..319bad4af875 100644
--- a/Documentation/devicetree/bindings/spi/sh-hspi.txt
+++ b/Documentation/devicetree/bindings/spi/sh-hspi.txt
@@ -1,7 +1,29 @@
 Renesas HSPI.
 
 Required properties:
-- compatible : 	"renesas,hspi"
-- reg : Offset and length of the register set for the device
-- interrupts : interrupt line used by HSPI
+- compatible       : "renesas,hspi-<soctype>", "renesas,hspi" as fallback.
+		     Examples with soctypes are:
+		       - "renesas,hspi-r8a7778" (R-Car M1)
+		       - "renesas,hspi-r8a7779" (R-Car H1)
+- reg              : Offset and length of the register set for the device
+- interrupt-parent : The phandle for the interrupt controller that
+		     services interrupts for this device
+- interrupts       : Interrupt specifier
+- #address-cells   : Must be <1>
+- #size-cells      : Must be <0>
+
+Pinctrl properties might be needed, too.  See
+Documentation/devicetree/bindings/pinctrl/renesas,*.
+
+Example:
+
+	hspi0: spi@fffc7000 {
+		compatible = "renesas,hspi-r8a7778", "renesas,hspi";
+		reg = <0xfffc7000 0x18>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
 
-- 
1.7.9.5

