From: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] devicetree: Add devicetree bindings documentation for Zynq Quad SPI
Date: Thu, 3 Apr 2014 22:33:06 +0530
Message-ID: <ee057d8c-50d9-4d4b-ac86-d7c5fc44b1b0@TX2EHSMHS034.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <kpc528-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <kalluripunnaiahchoudary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add bindings documentation for Zynq Quad SPI driver.

Signed-off-by: Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-zynq-qspi.txt      |   26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt b/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
new file mode 100644
index 0000000..88e00f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
@@ -0,0 +1,26 @@
+Xilinx Zynq QSPI controller Device Tree Bindings
+-------------------------------------------------
+
+Required properties:
+- compatible		: Should be "xlnx,zynq-qspi-1.0".
+- reg			: Physical base address and size of QSPI registers map.
+- interrupts		: Property with a value describing the interrupt
+			  number.
+- interrupt-parent	: Must be core interrupt controller
+- clock-names		: List of input clock names - "ref_clk", "aper_clk"
+			  (See clock bindings for details).
+- clocks		: Clock phandles (see clock bindings for details).
+
+Optional properties:
+- num-cs		: Number of chip selects used.
+
+Example:
+	qspi@e000d000 {
+		compatible = "xlnx,zynq-qspi-1.0";
+		clock-names = "ref_clk", "aper_clk";
+		clocks = <&clkc 10>, <&clkc 43>;
+		interrupt-parent = <&ps7_scugic_0>;
+		interrupts = <0 19 4>;
+		num-cs = /bits/ 16 <1>;
+		reg = <0xe000d000 0x1000>;
+	};
-- 
1.7.9.5


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
