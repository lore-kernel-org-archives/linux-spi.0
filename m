From: Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v2 6/6] DTS: add SPI flash(s25fl128p01)
	support on p4080ds and mpc8536ds board
Date: Mon, 2 Aug 2010 15:52:04 +0800
Message-ID: <1280735524-17547-7-git-send-email-Mingkai.hu@freescale.com>
References: <1280735524-17547-1-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-2-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-3-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-4-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-5-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-6-git-send-email-Mingkai.hu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: kumar.gala-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tie-fei.zang-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1280735524-17547-6-git-send-email-Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---

v2:
 - Remove the whitespace inconsitencies

 arch/powerpc/boot/dts/mpc8536ds.dts |   52 +++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/p4080ds.dts   |   11 +++-----
 2 files changed, 56 insertions(+), 7 deletions(-)

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
index 6b29eab..48437ad 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -236,22 +236,19 @@
 		};
 
 		spi@110000 {
-			cell-index = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "fsl,espi";
+			compatible = "fsl,mpc8536-espi";
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



------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
