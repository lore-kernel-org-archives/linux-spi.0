From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv2 3/3] bindings: spi: Add clock entries for spi-xilinx
Date: Wed, 9 Mar 2016 14:17:22 +0530
Message-ID: <1457513242-11202-3-git-send-email-shubhraj@xilinx.com>
References: <1457513242-11202-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457513242-11202-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add clock description for spi-xilinx

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-xilinx.txt         |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.txt b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
index c7b7856..9e683bb 100644
--- a/Documentation/devicetree/bindings/spi/spi-xilinx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
@@ -7,13 +7,16 @@ Required properties:
 - interrupts		: Property with a value describing the interrupt
 			  number.
 - interrupt-parent	: Must be core interrupt controller
+- clocks: Input clock specifier. Refer to common clock bindings.
 
 Optional properties:
 - xlnx,num-ss-bits	: Number of chip selects used.
+- clock-names: Input clock name
 
 Example:
 	axi_quad_spi@41e00000 {
 			compatible = "xlnx,xps-spi-2.00.a";
+			clocks = <&clkc 15>;
 			interrupt-parent = <&intc>;
 			interrupts = <0 31 1>;
 			reg = <0x41e00000 0x10000>;
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
