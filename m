From: Mingkai Hu <Mingkai.hu@freescale.com>
Subject: [PATCH v4 4/5] powerpc/of: add eSPI controller dts bindings and DTS
	modification
Date: Tue, 12 Oct 2010 18:18:33 +0800
Message-ID: <1286878714-13090-5-git-send-email-Mingkai.hu@freescale.com>
References: <1286878714-13090-1-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-2-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-3-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-4-git-send-email-Mingkai.hu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b@pacbell.net, kumar.gala@freescale.com,
	Mingkai Hu <Mingkai.hu@freescale.com>
To: <linuxppc-dev@ozlabs.org>, <spi-devel-general@lists.sourceforge.net>,
	<linux-mtd@lists.infradead.org>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1286878714-13090-4-git-send-email-Mingkai.hu@freescale.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

Also modifiy the document of cell-index in SPI controller. Add the
SPI flash(s25fl128p01) support on p4080ds and mpc8536ds board.

Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
---
v4:
 - Updated to latest kernel base(Linux 2.6.36-rc7).

 Documentation/powerpc/dts-bindings/fsl/spi.txt |   24 ++++++++++-
 arch/powerpc/boot/dts/mpc8536ds.dts            |   52 ++++++++++++++++++++++++
 arch/powerpc/boot/dts/p4080ds.dts              |   11 ++---
 3 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/spi.txt b/Documentation/powerpc/dts-bindings/fsl/spi.txt
index 80510c0..777abd7 100644
--- a/Documentation/powerpc/dts-bindings/fsl/spi.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/spi.txt
@@ -1,7 +1,9 @@
 * SPI (Serial Peripheral Interface)
 
 Required properties:
-- cell-index : SPI controller index.
+- cell-index : QE SPI subblock index.
+		0: QE subblock SPI1
+		1: QE subblock SPI2
 - compatible : should be "fsl,spi".
 - mode : the SPI operation mode, it can be "cpu" or "cpu-qe".
 - reg : Offset and length of the register set for the device
@@ -29,3 +31,23 @@ Example:
 		gpios = <&gpio 18 1	// device reg=<0>
 			 &gpio 19 1>;	// device reg=<1>
 	};
+
+
+* eSPI (Enhanced Serial Peripheral Interface)
+
+Required properties:
+- compatible : should be "fsl,mpc8536-espi".
+- reg : Offset and length of the register set for the device.
+- interrupts : should contain eSPI interrupt, the device has one interrupt.
+- fsl,espi-num-chipselects : the number of the chipselect signals.
+
+Example:
+	spi@110000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,mpc8536-espi";
+		reg = <0x110000 0x1000>;
+		interrupts = <53 0x2>;
+		interrupt-parent = <&mpic>;
+		fsl,espi-num-chipselects = <4>;
+	};
diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
index 815cebb..a75c10e 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -108,6 +108,58 @@
 			};
 		};
 
+		spi@7000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc8536-espi";
+			reg = <0x7000 0x1000>;
+			interrupts = <59 0x2>;
+			interrupt-parent = <&mpic>;
+			fsl,espi-num-chipselects = <4>;
+
+			flash@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "spansion,s25sl12801";
+				reg = <0>;
+				spi-max-frequency = <40000000>;
+				partition@u-boot {
+					label = "u-boot";
+					reg = <0x00000000 0x00100000>;
+					read-only;
+				};
+				partition@kernel {
+					label = "kernel";
+					reg = <0x00100000 0x00500000>;
+					read-only;
+				};
+				partition@dtb {
+					label = "dtb";
+					reg = <0x00600000 0x00100000>;
+					read-only;
+				};
+				partition@fs {
+					label = "file system";
+					reg = <0x00700000 0x00900000>;
+				};
+			};
+			flash@1 {
+				compatible = "spansion,s25sl12801";
+				reg = <1>;
+				spi-max-frequency = <40000000>;
+			};
+			flash@2 {
+				compatible = "spansion,s25sl12801";
+				reg = <2>;
+				spi-max-frequency = <40000000>;
+			};
+			flash@3 {
+				compatible = "spansion,s25sl12801";
+				reg = <3>;
+				spi-max-frequency = <40000000>;
+			};
+		};
+
 		dma@21300 {
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index 2f0de24..5b7fc29 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -236,22 +236,19 @@
 		};
 
 		spi@110000 {
-			cell-index = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "fsl,espi";
+			compatible = "fsl,p4080-espi", "fsl,mpc8536-espi";
 			reg = <0x110000 0x1000>;
 			interrupts = <53 0x2>;
 			interrupt-parent = <&mpic>;
-			espi,num-ss-bits = <4>;
-			mode = "cpu";
+			fsl,espi-num-chipselects = <4>;
 
-			fsl_m25p80@0 {
+			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "fsl,espi-flash";
+				compatible = "spansion,s25sl12801";
 				reg = <0>;
-				linux,modalias = "fsl_m25p80";
 				spi-max-frequency = <40000000>; /* input clock */
 				partition@u-boot {
 					label = "u-boot";
-- 
1.6.4
