From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 2/2] dt: brcm,bcm2835-aux-spi: add binding documentation for new spi-bcm2835aux
Date: Mon, 22 Jun 2015 13:40:07 +0000
Message-ID: <1434980408-4086-2-git-send-email-kernel@martin.sperl.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434980408-4086-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 .../bindings/spi/brcm,bcm2835-aux-spi.txt          |   33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
new file mode 100644
index 0000000..23e4138
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
@@ -0,0 +1,33 @@
+Broadcom BCM2835 SPI1/2 controller
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
+- gpio-cs: the gpio-cs (native cs is NOT supported)
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
+};
+
+spi2@7e215080 {
+	compatible = "brcm,bcm2835-aux-spi";
+	reg = <0x7e2150c0 0x40>, <0x7e215000 0x08>;
+	interrupts = <1 29>;
+	clocks = <&clk_spi>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
