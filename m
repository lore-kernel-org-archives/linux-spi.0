From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 2/3] dt-bindings: spi: document bcm63xx HS SPI devicetree bindings
Date: Wed,  1 Mar 2017 10:08:13 +0100
Message-ID: <20170301090814.7097-2-jonas.gorski@gmail.com>
References: <20170301090814.7097-1-jonas.gorski@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170301090814.7097-1-jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add documentation for the bindings of the high speed SPI controller found
on newer bcm63xx SoCs.

Signed-off-by: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Changes v1 -> v2
* made the pll clock required
* added "High speed" (HS) to the first line

 .../devicetree/bindings/spi/spi-bcm63xx-hsspi.txt  | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt b/Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
new file mode 100644
index 000000000000..37b29ee13860
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
@@ -0,0 +1,33 @@
+Binding for Broadcom BCM6328 High Speed SPI controller
+
+Required properties:
+- compatible: must contain of "brcm,bcm6328-hsspi".
+- reg: Base address and size of the controllers memory area.
+- interrupts: Interrupt for the SPI block.
+- clocks: phandles of the SPI clock and the PLL clock.
+- clock-names: must be "hsspi", "pll".
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
+	spi@10001000 {
+		compatible = "brcm,bcm6328-hsspi";
+		reg = <0x10001000 0x600>;
+
+		interrupts = <29>;
+
+		clocks = <&clkctl 9>, <&hsspi_pll>;
+		clock-names = "hsspi", "pll";
+
+		num-cs = <2>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
