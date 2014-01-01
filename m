From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH 2/2] spi: clps711x: dts: Add bindings documentation for the CLPS711X SPI
Date: Wed,  1 Jan 2014 10:10:09 +0400
Message-ID: <1388556609-11040-1-git-send-email-shc_work@mail.ru>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch adds the devicetree documentation for the
Cirrus Logic CLPS711X SPI.

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-clps711x.txt       | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-clps711x.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-clps711x.txt b/Documentation/devicetree/bindings/spi/spi-clps711x.txt
new file mode 100644
index 0000000..aa16903
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-clps711x.txt
@@ -0,0 +1,22 @@
+* ARM CLPS711X Serial Peripheral Interface (SPI)
+
+Required properties:
+- compatible: Should be "cirrus,clps711x-spi".
+- reg: Offset and length of the register set for the device.
+- interrupts: Should contain SPI interrupt.
+- clocks: Phandle to SPI clock.
+- syscon: Phandle to SYSCON node used for SPI control (SYSCON3).
+- cs-gpios: Specifies the GPIO pins to be used for chipselects.
+
+Example:
+	spi: spi@80000500 {
+		compatible = "cirrus,clps711x-spi";
+		reg = <0x80000500 0x4>;
+		interrupts = <15>;
+		clocks = <&clks 10>;
+		syscon = <&syscon3>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cs-gpios = <&portb 4 GPIO_ACTIVE_LOW>,
+			   <&portb 5 GPIO_ACTIVE_LOW>;
+	};
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
