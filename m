From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v4 07/15] ARM: shmobile: genmai reference dts: Add RSPI nodes
Date: Fri, 24 Jan 2014 13:49:43 +0100
Message-ID: <1390567791-8988-8-git-send-email-geert@linux-m68k.org>
References: <1390567791-8988-1-git-send-email-geert@linux-m68k.org>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>,
	devicetree@vger.kernel.org
To: Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390567791-8988-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Add pinctrl and SPI devices for RSPI on Genmai.

On this board, only rspi4 is in use. Its bus contains a single device
(a wm8978 audio codec), for which no bindings are defined yet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: devicetree@vger.kernel.org
---
v4:
  - No changes
v3:
  - No changes
v2:
  - Use generic "codec" instead of specific "wm8978" node name.

 arch/arm/boot/dts/r7s72100-genmai-reference.dts |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
index 367af5c133e0..c2cc4bd5a470 100644
--- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
@@ -43,7 +43,7 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scif2_pins &ethernet_pins>;
+	pinctrl-0 = <&scif2_pins &ethernet_pins &rspi4_pins>;
 	pinctrl-names = "default";
 
 	scif2_pins: serial2 {
@@ -73,6 +73,12 @@
 				 "ethernet_int_p1_15";
 		renesas,function = "ethernet";
 	};
+
+	rspi4_pins: spi4 {
+		renesas,groups = "rspi4_rspck_p4_0", "rspi4_ssl0_p4_1",
+				 "rspi4_mosi_p4_2", "rspi4_miso_p4_3";
+		renesas,function = "rspi4";
+	};
 };
 
 &i2c2 {
@@ -85,3 +91,13 @@
 		pagesize = <64>;
 	};
 };
+
+&spi4 {
+	status = "okay";
+
+	codec: codec@0 {
+		compatible = "wlf,wm8978";
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+	};
+};
-- 
1.7.9.5
