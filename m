From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH v2 2/2] spi: add DT binding for clps711x SPI
Date: Thu,  7 Jul 2016 11:49:46 +0200
Message-ID: <20160707094952.4111577-2-arnd@arndb.de>
References: <20160707094952.4111577-1-arnd@arndb.de>
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160707094952.4111577-1-arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This documents the binding used by Alexander Shiyan's DT support for
the clps711x SPI controller.

I've left the file name to match the ARM platform port name "clps711x"
for consistency with the other bindings, even though the compatible
string refers to the later ep7309 chip.

Linux no longer supports the old clps711x and ep72xx product lines,
but we still use the name. The entire family is now discontinued
by the manufacturer.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-clps711x.txt       | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-clps711x.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-clps711x.txt b/Documentation/devicetree/bindings/spi/spi-clps711x.txt
new file mode 100644
index 000000000000..4c3ec13f423f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-clps711x.txt
@@ -0,0 +1,33 @@
+Serial Peripheral Interface on Cirrus Logic CL-PS71xx, EP72xx, EP73xx
+
+Required properties
+- #address-cells: must be <1>
+- #size-cells: must be <0>
+- compatible: should include "cirrus,ep7209-spi"
+- reg: Address and length of one register range
+- interrupts: one interrupt line
+- clocks: One entry, refers to the SPI bus clock
+- cs-gpios: Specifies the gpio pins to be used for chipselects.
+	    See: Documentation/devicetree/bindings/spi/spi-bus.txt
+
+An additional register is present in the system controller,
+which is assumed to be in the same device tree, with and marked
+as compatible with "cirrus,ep7209-syscon3".
+
+Example:
+
+spi@80000500 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "cirrus,ep7209-spi";
+	reg = <0x80000500 0x4>;
+	interrupts = <15>;
+	clocks = <&clks CLPS711X_CLK_SPI>;
+	status = "disabled";
+};
+
+syscon3: syscon@80002200 {
+	compatible = "cirrus,ep7209-syscon3", "syscon";
+	reg = <0x80002200 0x40>;
+};
+
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
