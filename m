From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv4 2/2] bindings: spi: Add clock entries for spi-xilinx
Date: Sat, 12 Mar 2016 13:30:37 +0530
Message-ID: <1457769637-5627-2-git-send-email-shubhraj@xilinx.com>
References: <1457769637-5627-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457769637-5627-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add clock description for spi-xilinx

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
v3
Add a clock name
v4
Correct the name 
 .../devicetree/bindings/spi/spi-xilinx.txt         |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.txt b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
index c7b7856..07ec09a 100644
--- a/Documentation/devicetree/bindings/spi/spi-xilinx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
@@ -7,6 +7,9 @@ Required properties:
 - interrupts		: Property with a value describing the interrupt
 			  number.
 - interrupt-parent	: Must be core interrupt controller
+- clocks: Input clock specifier. Refer to common clock bindings.
+- clock-names: tuple listing input clock names.
+	Required elements: "s_axi_aclk"
 
 Optional properties:
 - xlnx,num-ss-bits	: Number of chip selects used.
@@ -14,6 +17,8 @@ Optional properties:
 Example:
 	axi_quad_spi@41e00000 {
 			compatible = "xlnx,xps-spi-2.00.a";
+			clocks = <&clkc 15>;
+			clock-names = "spi_fclk";
 			interrupt-parent = <&intc>;
 			interrupts = <0 31 1>;
 			reg = <0x41e00000 0x10000>;
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
