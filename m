From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 5/5] ARM: davinci: da850-evm: add SPI flash support
Date: Tue, 12 Mar 2013 13:40:27 +0530
Message-ID: <1363075827-31053-6-git-send-email-prakash.pm@ti.com>
References: <1363075827-31053-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, "Manjunathappa,
	Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1363075827-31053-1-git-send-email-prakash.pm-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Enable m25p64 SPI flash support on da850-EVM. Also
add partition information of SPI flash.

Signed-off-by: Manjunathappa, Prakash <prakash.pm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/da850-evm.dts |   40 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index c359872..fe2bbe7 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -41,6 +41,46 @@
 		wdt: wdt@1c21000 {
 			status = "okay";
 		};
+		spi1: spi@1f0e000 {
+			status = "okay";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi1_pins>;
+			flash: m25p80@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "m25p64";
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
+					reg = <0x00320000 0x00400000>;
+				};
+				partition@5 {
+					label = "MAC-Address";
+					reg = <0x007f0000 0x00010000>;
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
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
