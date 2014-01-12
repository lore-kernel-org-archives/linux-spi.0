From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH 9/9] ARM: shmobile: koelsch: Add QSPI nodes
Date: Sun, 12 Jan 2014 12:13:42 +0100
Message-ID: <1389525222-3482-10-git-send-email-geert@linux-m68k.org>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389525222-3482-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Add pinctrl and SPI devices for QSPI on Koelsch.
Add Spansion s25fl512s SPI FLASH and MTD partitions.

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts |   36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index d5e42b396ef7..885b61e09638 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -123,6 +123,11 @@
 		renesas,groups = "scif1_data_d";
 		renesas,function = "scif1";
 	};
+
+	qspi_pins: spi {
+		renesas,groups = "qspi_ctrl", "qspi_data4";
+		renesas,function = "qspi";
+	};
 };
 
 &scif0 {
@@ -138,3 +143,34 @@
 
 	status = "okay";
 };
+
+&spi {
+	pinctrl-0 = <&qspi_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	flash: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl512s";
+		reg = <0>;
+		spi-max-frequency = <30000000>;
+		m25p,fast-read;
+
+		partition@0 {
+			label = "loader";
+			reg = <0x00000000 0x00080000>;
+			read-only;
+		};
+		partition@80000 {
+			label = "bootenv";
+			reg = <0x00080000 0x00080000>;
+			read-only;
+		};
+		partition@100000 {
+			label = "data";
+			reg = <0x00100000 0x03f00000>;
+		};
+	};
+};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
