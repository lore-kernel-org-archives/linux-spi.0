From: Aurelien BOUIN <a.bouin@gmail.com>
Subject: [PATCH 4/4] dt: fsl-imx-cspi.txt: Add fsl,spi-dma-bits-per-word
Date: Thu, 12 Feb 2015 13:07:28 +0100
Message-ID: <1423742848-15369-4-git-send-email-a.bouin@gmail.com>
References: <1423742848-15369-1-git-send-email-a.bouin@gmail.com>
Cc: festevam@gmail.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Aurelien BOUIN <a.bouin@gmail.com>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423742848-15369-1-git-send-email-a.bouin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch add the possibility to set the number of bits per word transfered by DMA

Signed-off-by: Aurelien BOUIN <a.bouin@gmail.com>

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
index aad527b..76f82de 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
@@ -6,6 +6,7 @@ Required properties:
 - reg : Offset and length of the register set for the device
 - interrupts : Should contain CSPI/eCSPI interrupt
 - fsl,spi-num-chipselects : Contains the number of the chipselect
+- fsl,spi-dma-bits-per-word : Contains the number of bits per word transfered by DMA
 - cs-gpios : Specifies the gpio pins to be used for chipselects.
 - dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
 		Documentation/devicetree/bindings/dma/dma.txt
@@ -20,6 +21,7 @@ ecspi@70010000 {
 	reg = <0x70010000 0x4000>;
 	interrupts = <36>;
 	fsl,spi-num-chipselects = <2>;
+	fsl,spi-dma-bits-per-word = <8>; /* 8 bits per word is the default value, can be 16 or 32 */
 	cs-gpios = <&gpio3 24 0>, /* GPIO3_24 */
 		   <&gpio3 25 0>; /* GPIO3_25 */
 	dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
-- 
1.9.1
