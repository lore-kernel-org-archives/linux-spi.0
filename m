From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/devicetrees: Change 'gpios' to 'cs-gpios' on fsl,spi
 nodes
Date: Thu, 28 Nov 2019 12:16:35 +0000 (UTC)
Message-ID: <7556683b57d8ce100855857f03d1cd3d2903d045.1574943062.git.christophe.leroy@c-s.fr>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Since commit 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO
descriptors"), the prefered way to define chipselect GPIOs is using
'cs-gpios' property instead of the legacy 'gpios' property.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 Documentation/devicetree/bindings/spi/fsl-spi.txt | 8 ++++----
 arch/powerpc/boot/dts/mgcoge.dts                  | 2 +-
 arch/powerpc/boot/dts/mpc832x_rdb.dts             | 2 +-
 arch/powerpc/boot/dts/mpc8610_hpcd.dts            | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-spi.txt b/Documentation/devicetree/bindings/spi/fsl-spi.txt
index 411375eac54d..0654380eb751 100644
--- a/Documentation/devicetree/bindings/spi/fsl-spi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-spi.txt
@@ -15,13 +15,13 @@ Required properties:
 - clock-frequency : input clock frequency to non FSL_SOC cores
 
 Optional properties:
-- gpios : specifies the gpio pins to be used for chipselects.
+- cs-gpios : specifies the gpio pins to be used for chipselects.
   The gpios will be referred to as reg = <index> in the SPI child nodes.
   If unspecified, a single SPI device without a chip select can be used.
 - fsl,spisel_boot : for the MPC8306 and MPC8309, specifies that the
   SPISEL_BOOT signal is used as chip select for a slave device. Use
   reg = <number of gpios> in the corresponding child node, i.e. 0 if
-  the gpios property is not present.
+  the cs-gpios property is not present.
 
 Example:
 	spi@4c0 {
@@ -31,8 +31,8 @@ Example:
 		interrupts = <82 0>;
 		interrupt-parent = <700>;
 		mode = "cpu";
-		gpios = <&gpio 18 1	// device reg=<0>
-			 &gpio 19 1>;	// device reg=<1>
+		cs-gpios = <&gpio 18 1		// device reg=<0>
+			    &gpio 19 1>;	// device reg=<1>
 	};
 
 
diff --git a/arch/powerpc/boot/dts/mgcoge.dts b/arch/powerpc/boot/dts/mgcoge.dts
index a2dd5f1da621..7de068991bde 100644
--- a/arch/powerpc/boot/dts/mgcoge.dts
+++ b/arch/powerpc/boot/dts/mgcoge.dts
@@ -224,7 +224,7 @@
 				reg = <0x11a80 0x40 0x89fc 0x2>;
 				interrupts = <2 8>;
 				interrupt-parent = <&PIC>;
-				gpios = < &cpm2_pio_d 19 0>;
+				cs-gpios = < &cpm2_pio_d 19 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				ds3106@1 {
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index b6257186528e..ecebc27a2898 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -249,7 +249,7 @@
 			reg = <0x4c0 0x40>;
 			interrupts = <2>;
 			interrupt-parent = <&qeic>;
-			gpios = <&qe_pio_d 13 0>;
+			cs-gpios = <&qe_pio_d 13 0>;
 			mode = "cpu-qe";
 
 			mmc-slot@0 {
diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 1a8321ac105a..33bbe58c1ad0 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -200,7 +200,7 @@
 			interrupts = <59 2>;
 			interrupt-parent = <&mpic>;
 			mode = "cpu";
-			gpios = <&sdcsr_pio 7 0>;
+			cs-gpios = <&sdcsr_pio 7 0>;
 			sleep = <&pmc 0x00000800 0>;
 
 			mmc-slot@0 {
-- 
2.13.3
