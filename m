From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH 4/4] SPI: imx: Update DT binding documentation
Date: Wed,  8 Jun 2016 20:02:09 +0300
Message-ID: <1465405329-5153-4-git-send-email-shc_work@mail.ru>
References: <1465405329-5153-1-git-send-email-shc_work@mail.ru>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465405329-5153-1-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Mark "fsl,spi-num-chipselects" property as obsolete.

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
index 523341a..8bc95e2 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
@@ -11,7 +11,6 @@ Required properties:
   - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.MX51
 - reg : Offset and length of the register set for the device
 - interrupts : Should contain CSPI/eCSPI interrupt
-- fsl,spi-num-chipselects : Contains the number of the chipselect
 - cs-gpios : Specifies the gpio pins to be used for chipselects.
 - clocks : Clock specifiers for both ipg and per clocks.
 - clock-names : Clock names should include both "ipg" and "per"
@@ -21,6 +20,9 @@ See the clock consumer binding,
 		Documentation/devicetree/bindings/dma/dma.txt
 - dma-names: DMA request names should include "tx" and "rx" if present.
 
+Obsolete properties:
+- fsl,spi-num-chipselects : Contains the number of the chipselect
+
 Example:
 
 ecspi@70010000 {
@@ -29,7 +31,6 @@ ecspi@70010000 {
 	compatible = "fsl,imx51-ecspi";
 	reg = <0x70010000 0x4000>;
 	interrupts = <36>;
-	fsl,spi-num-chipselects = <2>;
 	cs-gpios = <&gpio3 24 0>, /* GPIO3_24 */
 		   <&gpio3 25 0>; /* GPIO3_25 */
 	dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
-- 
2.4.9

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
