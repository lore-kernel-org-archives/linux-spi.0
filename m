From: Naga Sureshkumar Relli <naga.sureshkumar.relli-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 3/3] spi: xilinx: Update devicetree bindings for spi-xilinx
Date: Mon, 30 May 2016 15:17:07 +0530
Message-ID: <1464601627-5246-1-git-send-email-nagasure@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Naga Sureshkumar Relli" <nagasure-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	<punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Update bindings for spi-xilinx.
as per spi-bus.txt rename num-ss-bits to num-cs.
and add fifo-size and bits-per-word properties.

Signed-off-by: Naga Sureshkumar Relli <nagasure-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
changes for v2
 - none
---
 Documentation/devicetree/bindings/spi/spi-xilinx.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.txt b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
index c7b7856..539bbe9 100644
--- a/Documentation/devicetree/bindings/spi/spi-xilinx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
@@ -7,9 +7,11 @@ Required properties:
 - interrupts		: Property with a value describing the interrupt
 			  number.
 - interrupt-parent	: Must be core interrupt controller
+- fifo-size		: Depth of TX/RX Fifos
 
 Optional properties:
-- xlnx,num-ss-bits	: Number of chip selects used.
+- num-cs		: Number of chip selects used.
+- bits-per-word		: Number of bits per word.
 
 Example:
 	axi_quad_spi@41e00000 {
@@ -17,6 +19,8 @@ Example:
 			interrupt-parent = <&intc>;
 			interrupts = <0 31 1>;
 			reg = <0x41e00000 0x10000>;
-			xlnx,num-ss-bits = <0x1>;
+			num-cs = <0x1>;
+			fifo-size = <256>;
+			bits-per-word = <8>;
 	};
 
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
