From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH v4 3/5] ARM: davinci: da850: add SPI1 DT node
Date: Wed, 20 Mar 2013 16:16:57 +0530
Message-ID: <1363776419-10563-4-git-send-email-prakash.pm@ti.com>
References: <1363776419-10563-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <grant.likely@secretlab.ca>, <rob.herring@calxeda.com>,
	<rob@landley.net>, <linux@arm.linux.org.uk>, <nsekhar@ti.com>,
	<hs@denx.de>, <devicetree-discuss@lists.ozlabs.org>,
	<linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	"Manjunathappa, Prakash" <prakash.pm@ti.com>
To: <davinci-linux-open-source@linux.davincidsp.com>,
	<spi-devel-general@lists.sourceforge.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1363776419-10563-1-git-send-email-prakash.pm@ti.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Patch adds SPI1 DT node along with pinmux data.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 arch/arm/boot/dts/da850.dtsi |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 3ec1bda..327fb06 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -62,6 +62,14 @@
 					0x10 0x00002200 0x0000ff00
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
@@ -107,6 +115,16 @@
 			reg = <0x21000 0x1000>;
 			status = "disabled";
 		};
+		spi1: spi@1f0e000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "ti,da830-spi";
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

