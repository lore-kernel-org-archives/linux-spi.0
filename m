From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH 6/6] [RFC] arm: shmobile: genmai reference: Add RSPI nodes
Date: Tue, 24 Dec 2013 12:56:50 +0100
Message-ID: <1387886210-3634-7-git-send-email-geert+renesas@linux-m68k.org>
References: <1387886210-3634-1-git-send-email-geert+renesas@linux-m68k.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387886210-3634-1-git-send-email-geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add pinctrl and SPI devices for RSPI on Genmai.

On this board, only rspi4 is in use. It's bus contains a single device
(a wm8978 audio codec), for which no bindings are defined yet.

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 arch/arm/boot/dts/r7s72100-genmai-reference.dts |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
index 114510f8bf09..6d99630627e4 100644
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
+	codec: wm8978@0 {
+		compatible = "wlf,wm8978";
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+	};
+};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
