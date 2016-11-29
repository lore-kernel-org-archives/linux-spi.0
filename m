From: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 3/5] dt-bindings: spi: Add documentation for the Armada 3700 SPI Controller
Date: Tue, 29 Nov 2016 15:39:37 +0100
Message-ID: <20161129143939.3191-4-romain.perier@free-electrons.com>
References: <20161129143939.3191-1-romain.perier@free-electrons.com>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
        Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161129143939.3191-1-romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This adds the devicetree bindings documentation for the SPI controller
present in the Marvell Armada 3700 SoCs.

Signed-off-by: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-armada-3700.txt    | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-armada-3700.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-armada-3700.txt b/Documentation/devicetree/bindings/spi/spi-armada-3700.txt
new file mode 100644
index 0000000..1564aa8
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-armada-3700.txt
@@ -0,0 +1,25 @@
+* Marvell Armada 3700 SPI Controller
+
+Required Properties:
+
+- compatible: should be "marvell,armada-3700-spi"
+- reg: physical base address of the controller and length of memory mapped
+       region.
+- interrupts: The interrupt number. The interrupt specifier format depends on
+	      the interrupt controller and of its driver.
+- clocks: Must contain the clock source, usually from the North Bridge clocks.
+- num-cs: The number of chip selects that is supported by this SPI Controller
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+
+Example:
+
+	spi0: spi@10600 {
+		compatible = "marvell,armada-3700-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x10600 0x5d>;
+		clocks = <&nb_perih_clk 7>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+		num-cs = <4>;
+	};
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
