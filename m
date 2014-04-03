From: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/2] devicetree: Add devicetree bindings documentation for Cadence SPI
Date: Thu,  3 Apr 2014 16:40:31 +0530
Message-ID: <1396523431-14519-2-git-send-email-harinik@xilinx.com>
References: <1396523431-14519-1-git-send-email-harinik@xilinx.com>
Cc: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1396523431-14519-1-git-send-email-harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add spi-cadence bindings documentation.

Signed-off-by: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---

v2 changes:
- Separate patch for bindings.
- Add xilinx compatible string; Make compatible string first in the node.
- Use property name num-cs. Make this property optional.

---
 .../devicetree/bindings/spi/spi-cadence.txt        |   27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-cadence.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.txt b/Documentation/devicetree/bindings/spi/spi-cadence.txt
new file mode 100644
index 0000000..ccb7599
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-cadence.txt
@@ -0,0 +1,27 @@
+Cadence SPI controller Device Tree Bindings
+-------------------------------------------
+
+Required properties:
+- compatible		: Should be "cdns,spi-r1p6" or "xlnx,zynq-spi-r1p6".
+- reg			: Physical base address and size of SPI registers map.
+- interrupts		: Property with a value describing the interrupt
+			  number.
+- interrupt-parent	: Must be core interrupt controller
+- clock-names		: List of input clock names - "ref_clk", "pclk"
+			  (See clock bindings for details).
+- clocks		: Clock phandles (see clock bindings for details).
+
+Optional properties:
+- num-cs		: Number of chip selects used.
+
+Example:
+
+	spi@e0007000 {
+		compatible = "xlnx,zynq-spi-r1p6";
+		clock-names = "ref_clk", "pclk";
+		clocks = <&clkc 26>, <&clkc 35>;
+		interrupt-parent = <&intc>;
+		interrupts = <0 49 4>;
+		num-cs = /bits/ 16 <4>;
+		reg = <0xe0007000 0x1000>;
+	} ;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
