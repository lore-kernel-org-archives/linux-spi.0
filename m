From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH 10/10] ARM: mx28: Add SPI pinmux into imx28.dtsi
Date: Fri,  6 Jul 2012 08:17:29 +0200
Message-ID: <1341555449-17507-10-git-send-email-marex@denx.de>
References: <1341555449-17507-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>,
	Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1341555449-17507-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>
CC: Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
CC: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
Cc: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
---
 arch/arm/boot/dts/imx28.dtsi |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 01625e2..da5ce86 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -339,6 +339,45 @@
 					fsl,voltage = <1>;
 					fsl,pull-up = <1>;
 				};
+
+				spi0_pins_a: spi0@0 {
+					reg = <0>;
+					fsl,pinmux-ids =
+						<0x2000 0x2010 0x2020 0x2030
+						0x2040 0x2050 0x2060 0x2070
+						0x2080 0x2090 0x20a0>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
+				spi1_pins_a: spi1@0 {
+					reg = <0>;
+					fsl,pinmux-ids =
+						<0x20c0 0x20d0 0x20e0 0x20f0>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
+				spi2_pins_a: spi2@0 {
+					reg = <0>;
+					fsl,pinmux-ids =
+						<0x2100 0x2110 0x2120
+						0x2130 0x2140 0x2150>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
+				spi3_pins_a: spi3@0 {
+					reg = <0>;
+					fsl,pinmux-ids =
+						<0x2180 0x2190 0x21a0 0x21b0>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
 			};
 
 			digctl@8001c000 {
-- 
1.7.10


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
