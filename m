From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/4] ARM: davinci: da850: add SPI1 DT node
Date: Mon, 25 Feb 2013 16:14:08 +0530
Message-ID: <1361789050-637-3-git-send-email-prakash.pm@ti.com>
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

Patch adds SPI1 DT node along with pinmux data.

Signed-off-by: Manjunathappa, Prakash <prakash.pm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/da850.dtsi |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index ebe7386..e921c82 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -76,6 +76,14 @@
 					0x28 0x00222222  0x00ffffff
 				>;
 			};
+			spi1_pins: pinmux_spi_pins {
+				pinctrl-single,bits = <
+					/* SIMO, SOMI, ENA,
+					 * CLK, CS[0], CS[1]
+					 */
+					0x14 0x00111111 0x00ffffff
+				>;
+			};
 		};
 		serial0: serial@1c42000 {
 			compatible = "ns16550a";
@@ -126,6 +134,16 @@
 			interrupts = <16>;
 			status = "disabled";
 		};
+		spi1: spi@1f0e000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "ti,da8xx-spi";
+			reg = <0x30e000 0x1000>;
+			num-cs = <4>;
+			ti,davinci-spi-intr-line = <1>;
+			interrupts = <56>;
+			status = "disabled";
+		};
 	};
 	nand_cs3@62000000 {
 		compatible = "ti,davinci-nand";
-- 
1.7.4.1


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
