From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V2] dt: brcm,bcm2835-aux-spi: add binding documentation for new spi-bcm2835aux
Date: Thu, 25 Jun 2015 10:54:32 +0000
Message-ID: <1435229673-2214-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Stefan Wahren <info-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 .../bindings/spi/brcm,bcm2835-aux-spi.txt          |   35 ++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt

Changelog:
  V1 -> V2:	fixed typo
		added cs-gpios

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
new file mode 100644
index 0000000..66f52d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
@@ -0,0 +1,35 @@
+Broadcom BCM2835 auxiliar SPI1/2 controller
+
+The BCM2835 contains two forms of SPI master controller, one known simply as
+SPI0, and the other known as the "Universal SPI Master"; part of the
+auxiliary block. This binding applies to the SPI1/2 controller.
+
+Required properties:
+- compatible: Should be "brcm,bcm2835-aux-spi".
+- reg: Should contain register location and length for the spi block
+       as well as for the common aux block control
+- interrupts: Should contain shared interrupt of the aux block
+- clocks: The clock feeding the SPI controller.
+- cs-gpios: the cs-gpios (native cs is NOT supported)
+
+Example:
+
+spi1@7e215080 {
+	compatible = "brcm,bcm2835-aux-spi";
+	reg = <0x7e215080 0x40>, <0x7e215000 0x08>;
+	interrupts = <1 29>;
+	clocks = <&clk_spi>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpio 18>, <&gpio 17>, <&gpio 16>;
+};
+
+spi2@7e2150c0 {
+	compatible = "brcm,bcm2835-aux-spi";
+	reg = <0x7e2150c0 0x40>, <0x7e215000 0x08>;
+	interrupts = <1 29>;
+	clocks = <&clk_spi>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpio 43>, <&gpio 44>, <&gpio 45>;
+};
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
