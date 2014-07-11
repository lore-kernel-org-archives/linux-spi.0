From: Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/1] spi: samsung: Update binding documentation
Date: Fri, 11 Jul 2014 14:41:03 +0530
Message-ID: <1405069863-17723-1-git-send-email-sachin.kamat@samsung.com>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, spk.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Samsung SPI driver uses generic DMA bindings. Update the documentation
accordingly.

Signed-off-by: Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-samsung.txt        |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index fe6f9037b561..7f2d88d3fbe7 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -17,14 +17,11 @@ Required SoC Specific Properties:
 - interrupts: The interrupt number to the cpu. The interrupt specifier format
   depends on the interrupt controller.
 
-[PRELIMINARY: the dma channel allocation will change once there are
-official DMA bindings]
+- dmas : Two or more DMA channel specifiers following the convention outlined
+  in bindings/dma/dma.txt
 
-- tx-dma-channel: The dma channel specifier for tx operations. The format of
-  the dma specifier depends on the dma controller.
-
-- rx-dma-channel: The dma channel specifier for rx operations. The format of
-  the dma specifier depends on the dma controller.
+- dma-names: Names for the dma channels. There must be at least one channel
+  named "tx" for transmit and named "rx" for receive.
 
 Required Board Specific Properties:
 
@@ -73,8 +70,11 @@ Example:
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x12d20000 0x100>;
 		interrupts = <0 66 0>;
-		tx-dma-channel = <&pdma0 5>;
-		rx-dma-channel = <&pdma0 4>;
+		dmas = <&pdma0 5
+			&pdma0 4>;
+		dma-names = "tx", "rx";
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 - Board Specific Portion:
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
