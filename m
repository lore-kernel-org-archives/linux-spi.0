From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/4] ARM: davinci: da850-evm: add SPI flash support
Date: Mon, 25 Feb 2013 16:14:10 +0530
Message-ID: <1361789050-637-5-git-send-email-prakash.pm@ti.com>
References: <1361789050-637-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, "Manjunathappa,
	Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>, hs-ynQEQJNshbs@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1361789050-637-1-git-send-email-prakash.pm-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Enable m25p80 SPI flash support on da850-EVM. Also
add partition information of SPI flash.

Signed-off-by: Manjunathappa, Prakash <prakash.pm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/da850-evm.dts |   40 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 78c8e54..1a28d43 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -46,6 +46,46 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins>;
 		};
+		spi1: spi@1f0e000 {
+			status = "okay";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi1_pins>;
+			flash: m25p80@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "m25p80";
+				spi-max-frequency = <30000000>;
+				reg = <0>;
+				partition@0 {
+					label = "U-Boot-SPL";
+					reg = <0x00000000 0x00010000>;
+					read-only;
+				};
+				partition@1 {
+					label = "U-Boot";
+					reg = <0x00010000 0x00080000>;
+					read-only;
+				};
+				partition@2 {
+					label = "U-Boot-Env";
+					reg = <0x00090000 0x00010000>;
+					read-only;
+				};
+				partition@3 {
+					label = "Kernel";
+					reg = <0x000a0000 0x00280000>;
+				};
+				partition@4 {
+					label = "Filesystem";
+					reg = <0x00220000 0x00400000>;
+				};
+				partition@5 {
+					label = "MAC-Address";
+					reg = <0x00620000 0x00010000>;
+					read-only;
+				};
+			};
+		};
 	};
 	nand_cs3@62000000 {
 		status = "okay";
-- 
1.7.4.1


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
