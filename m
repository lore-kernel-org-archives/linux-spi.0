From: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v8 6/8] ARM: dts: add spi nodes for atmel SoC
Date: Wed, 3 Apr 2013 14:02:18 +0800
Message-ID: <1364968938-24198-1-git-send-email-wenyou.yang@atmel.com>
References: <1364968581-23700-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, JM.Lin-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org
To: <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1364968581-23700-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Signed-off-by: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
[wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org: add spi nodes for sam9260, sam9263, sam9g45 and sam9n12]
[wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org: remove spi property "cs-gpios" to the board dts files]
[wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org: submit the patch]
Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 arch/arm/boot/dts/at91sam9260.dtsi |   18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi |   18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi |   18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi |   18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |   18 ++++++++++++++++++
 5 files changed, 90 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index cb7bcc5..6e31dc8 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -471,6 +471,24 @@
 				status = "disabled";
 			};
 
+			spi0: spi@fffc8000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffc8000 0x200>;
+				interrupts = <12 4 3>;
+				status = "disabled";
+			};
+
+			spi1: spi@fffcc000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffcc000 0x200>;
+				interrupts = <13 4 3>;
+				status = "disabled";
+			};
+
 			adc0: adc@fffe0000 {
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xfffe0000 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 271d4de..6c6d9ae 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -462,6 +462,24 @@
 				reg = <0xfffffd40 0x10>;
 				status = "disabled";
 			};
+
+			spi0: spi@fffa4000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffa4000 0x200>;
+				interrupts = <14 4 3>;
+				status = "disabled";
+			};
+
+			spi1: spi@fffa8000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffa8000 0x200>;
+				interrupts = <15 4 3>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand@40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 6b1d4ca..e085b8a 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -531,6 +531,24 @@
 				reg = <0xfffffd40 0x10>;
 				status = "disabled";
 			};
+
+			spi0: spi@fffa4000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffa4000 0x200>;
+				interrupts = <14 4 3>;
+				status = "disabled";
+			};
+
+			spi1: spi@fffa8000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffa8000 0x200>;
+				interrupts = <15 4 3>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand@40000000 {
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 7750f98..f3f87ef3 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -373,6 +373,24 @@
 				#size-cells = <0>;
 				status = "disabled";
 			};
+
+			spi0: spi@f0000000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xf0000000 0x100>;
+				interrupts = <13 4 3>;
+				status = "disabled";
+			};
+
+			spi1: spi@f0004000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xf0004000 0x100>;
+				interrupts = <14 4 3>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand@40000000 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index a98c0d5..77ce2e1 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -529,6 +529,24 @@
 					trigger-value = <0x6>;
 				};
 			};
+
+			spi0: spi@f0000000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xf0000000 0x100>;
+				interrupts = <13 4 3>;
+				status = "disabled";
+			};
+
+			spi1: spi@f0004000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xf0004000 0x100>;
+				interrupts = <14 4 3>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand@40000000 {
-- 
1.7.9.5


------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
