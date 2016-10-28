From: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 3/4] spi: sun6i: Add binding for Allwinner H3 SPI controller
Date: Fri, 28 Oct 2016 15:54:11 +0900
Message-ID: <20161028065412.23008-4-woogyom.kim@gmail.com>
References: <20161028065412.23008-1-woogyom.kim@gmail.com>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161028065412.23008-1-woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

H3 SPI has same architecture as A31 except FIFO capacity.
To configure the buffer size separately, compatible property should be
different. Optional DMA specifiers and example are added.

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Signed-off-by: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-sun6i.txt          | 25 ++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-sun6i.txt b/Documentation/devicetree/bindings/spi/spi-sun6i.txt
index 21de73d..2ec99b8 100644
--- a/Documentation/devicetree/bindings/spi/spi-sun6i.txt
+++ b/Documentation/devicetree/bindings/spi/spi-sun6i.txt
@@ -1,7 +1,7 @@
-Allwinner A31 SPI controller
+Allwinner A31/H3 SPI controller
 
 Required properties:
-- compatible: Should be "allwinner,sun6i-a31-spi".
+- compatible: Should be "allwinner,sun6i-a31-spi" or "allwinner,sun8i-h3-spi".
 - reg: Should contain register location and length.
 - interrupts: Should contain interrupt.
 - clocks: phandle to the clocks feeding the SPI controller. Two are
@@ -12,6 +12,11 @@ Required properties:
 - resets: phandle to the reset controller asserting this device in
           reset
 
+Optional properties:
+- dmas: DMA specifiers for rx and tx dma. See the DMA client binding,
+	Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: DMA request names should include "rx" and "tx" if present.
+
 Example:
 
 spi1: spi@01c69000 {
@@ -22,3 +27,19 @@ spi1: spi@01c69000 {
 	clock-names = "ahb", "mod";
 	resets = <&ahb1_rst 21>;
 };
+
+spi0: spi@01c68000 {
+	compatible = "allwinner,sun8i-h3-spi";
+	reg = <0x01c68000 0x1000>;
+	interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
+	clock-names = "ahb", "mod";
+	dmas = <&dma 23>, <&dma 23>;
+	dma-names = "rx", "tx";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+	resets = <&ccu RST_BUS_SPI0>;
+	status = "disabled";
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
