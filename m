From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv2 1/3] bindings: spi: Add devicetree binding for spi-xilinx
Date: Wed, 9 Mar 2016 14:17:20 +0530
Message-ID: <1457513242-11202-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add a binding document for the spi/spi-xilinx

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-xilinx.txt         |   22 ++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-xilinx.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.txt b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
new file mode 100644
index 0000000..c7b7856
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
@@ -0,0 +1,22 @@
+Xilinx SPI controller Device Tree Bindings
+-------------------------------------------------
+
+Required properties:
+- compatible		: Should be "xlnx,xps-spi-2.00.a" or "xlnx,xps-spi-2.00.b"
+- reg			: Physical base address and size of SPI registers map.
+- interrupts		: Property with a value describing the interrupt
+			  number.
+- interrupt-parent	: Must be core interrupt controller
+
+Optional properties:
+- xlnx,num-ss-bits	: Number of chip selects used.
+
+Example:
+	axi_quad_spi@41e00000 {
+			compatible = "xlnx,xps-spi-2.00.a";
+			interrupt-parent = <&intc>;
+			interrupts = <0 31 1>;
+			reg = <0x41e00000 0x10000>;
+			xlnx,num-ss-bits = <0x1>;
+	};
+
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
