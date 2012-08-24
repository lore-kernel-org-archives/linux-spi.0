From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH 2/2] ARM: mxs: Update DENX M28 machine and dts file
Date: Fri, 24 Aug 2012 05:25:42 +0200
Message-ID: <1345778742-20994-2-git-send-email-marex@denx.de>
References: <1345778742-20994-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1345778742-20994-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Update the mach-mxs machine by removing the enet_clkout(). The new
revision of the board doesn't need that. Also, update the DTS file
with all the new drivers pulled in the mainline recently, that is,
SPI, LRADC, USB. Also, remove bogus AUART3.

Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/imx28-m28evk.dts |   98 +++++++++++++++++++++++++++++++++---
 arch/arm/mach-mxs/mach-mxs.c       |    1 -
 2 files changed, 92 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index 183a3fd..e418b75 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -23,6 +23,8 @@
 	apb@80000000 {
 		apbh@80000000 {
 			gpmi-nand@8000c000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg>;
 				status = "okay";
@@ -62,9 +64,28 @@
 					     &mmc0_sck_cfg>;
 				bus-width = <8>;
 				wp-gpios = <&gpio3 10 1>;
+				vmmc-supply = <&reg_vddio_sd0>;
 				status = "okay";
 			};
 
+			ssp2: ssp@80014000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx28-spi";
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi2_pins_a>;
+				status = "okay";
+
+				flash: m25p80@0 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "m25p80";
+					spi-max-frequency = <40000000>;
+					m25p,fast-read;
+					reg = <0>;
+				};
+			};
+
 			pinctrl@80018000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
@@ -72,8 +93,11 @@
 				hog_pins_a: hog-gpios@0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
+						0x31c3 /* MX28_PAD_PWM3__GPIO_3_28 */
 						0x30a3 /* MX28_PAD_AUART2_CTS__GPIO_3_10 */
 						0x30b3 /* MX28_PAD_AUART2_RTS__GPIO_3_11 */
+						0x30c3 /* MX28_PAD_AUART3_RX__GPIO_3_12 */
+						0x30d3 /* MX28_PAD_AUART3_TX__GPIO_3_13 */
 					>;
 					fsl,drive-strength = <0>;
 					fsl,voltage = <1>;
@@ -90,6 +114,22 @@
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
 				};
+
+				usb0_pins_a: usb0@0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x2152>;
+					fsl,drive-strength = <2>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				usb1_pins_a: usb1@0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x2142>;
+					fsl,drive-strength = <2>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
 			};
 
 			lcdif@80030000 {
@@ -99,6 +139,10 @@
 				status = "okay";
 			};
 
+			lradc@80050000 {
+				status = "okay";
+			};
+
 			can0: can@80032000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&can0_pins_a>;
@@ -129,6 +173,7 @@
 			i2c0: i2c@80058000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&i2c0_pins_a>;
+				clock-frequency = <400000>;
 				status = "okay";
 
 				sgtl5000: codec@0a {
@@ -157,26 +202,41 @@
 				status = "okay";
 			};
 
-			auart0: serial@8006a000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&auart0_2pins_a>;
+			usbphy0: usbphy@8007c000 {
 				status = "okay";
 			};
 
-			auart3: serial@80070000 {
+			usbphy1: usbphy@8007e000 {
+				status = "okay";
+			};
+
+			auart0: serial@8006a000 {
 				pinctrl-names = "default";
-				pinctrl-0 = <&auart3_pins_a>;
+				pinctrl-0 = <&auart0_2pins_a>;
 				status = "okay";
 			};
 		};
 	};
 
 	ahb@80080000 {
+		usb0: usb@80080000 {
+			vbus-supply = <&reg_usb0_vbus>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&usb0_pins_a>;
+			status = "okay";
+		};
+
+		usb1: usb@80090000 {
+			vbus-supply = <&reg_usb1_vbus>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&usb1_pins_a>;
+			status = "okay";
+		};
+
 		mac0: ethernet@800f0000 {
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
-			phy-reset-gpios = <&gpio3 11 0>;
 			status = "okay";
 		};
 
@@ -198,6 +258,32 @@
 			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
 		};
+
+		reg_vddio_sd0: vddio-sd0 {
+			compatible = "regulator-fixed";
+			regulator-name = "vddio-sd0";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 28 0>;
+		};
+
+		reg_usb0_vbus: usb0_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb0_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 12 0>;
+			enable-active-low;
+		};
+
+		reg_usb1_vbus: usb1_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 13 0>;
+			enable-active-low;
+		};
 	};
 
 	sound {
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 8dabfe8..5ac45a1 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -241,7 +241,6 @@ static void __init imx28_evk_init(void)
 
 static void __init m28evk_init(void)
 {
-	enable_clk_enet_out();
 	update_fec_mac_prop(OUI_DENX);
 
 	mxsfb_pdata.mode_list = m28evk_video_modes;
-- 
1.7.10.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
