From: Ranjit Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [LINUX RFC v3 1/2] devicetree: Add DT bindings documentation for Zynq Ultrascale+ MPSoC GQSPI controller
Date: Wed, 10 Jun 2015 16:08:20 +0530
Message-ID: <1433932701-5834-1-git-send-email-ranjit.waghmode@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <ran27jit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"Ranjit Waghmode" <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	<broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add bindings documentation for GQSPI controller driver used by
Zynq Ultrascale+ MPSoC

Signed-off-by: Ranjit Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
Changes in v3:
- Did split in register addressing as per Sorens request

Changes in v2:
No changes in v2
---
 .../devicetree/bindings/spi/spi-zynqmp-qspi.txt    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
new file mode 100644
index 0000000..c8f50e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
@@ -0,0 +1,26 @@
+Xilinx Zynq UltraScale+ MPSoC GQSPI controller Device Tree Bindings
+-------------------------------------------------------------------
+
+Required properties:
+- compatible		: Should be "xlnx,zynqmp-qspi-1.0".
+- reg			: Physical base address and size of GQSPI registers map.
+- interrupts		: Property with a value describing the interrupt
+			  number.
+- interrupt-parent	: Must be core interrupt controller.
+- clock-names		: List of input clock names - "ref_clk", "pclk"
+			  (See clock bindings for details).
+- clocks		: Clock phandles (see clock bindings for details).
+
+Optional properties:
+- num-cs		: Number of chip selects used.
+
+Example:
+	qspi: spi@ff0f0000 {
+		compatible = "xlnx,zynqmp-qspi-1.0";
+		clock-names = "ref_clk", "pclk";
+		clocks = <&misc_clk &misc_clk>;
+		interrupts = <0 15 4>;
+		interrupt-parent = <&gic>;
+		num-cs = <1>;
+		reg = <0x0 0xff0f0000 0x1000>,<0x0 0xc0000000 0x8000000>;
+	};
--
2.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
