From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] dt-bindings: spi: document bcm63xx SPI devicetree bindings
Date: Tue, 21 Feb 2017 11:58:21 +0100
Message-ID: <20170221105822.10437-1-jonas.gorski@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add documentation for the bindings of the low speed SPI controller found
on most bcm63xx SoCs.

Signed-off-by: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-bcm63xx.txt        | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-bcm63xx.txt b/Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
new file mode 100644
index 000000000000..1c16f6692613
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
@@ -0,0 +1,33 @@
+Binding for Broadcom BCM6348/BCM6358 SPI controller
+
+Required properties:
+- compatible: must contain one of "brcm,bcm6348-spi", "brcm,bcm6358-spi".
+- reg: Base address and size of the controllers memory area.
+- interrupts: Interrupt for the SPI block.
+- clocks: phandle of the SPI clock.
+- clock-names: has to be "spi".
+- #address-cells: <1>, as required by generic SPI binding.
+- #size-cells: <0>, also as required by generic SPI binding.
+
+Optional properties:
+- num-cs: some controllers have less than 8 cs signals. Defaults to 8
+  if absent.
+
+Child nodes as per the generic SPI binding.
+
+Example:
+
+	spi@10000800 {
+		compatible = "brcm,bcm6368-spi", "brcm,bcm6358-spi";
+		reg = <0x10000800 0x70c>;
+
+		interrupts = <1>;
+
+		clocks = <&clkctl 9>;
+		clock-names = "spi";
+
+		num-cs = <5>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
