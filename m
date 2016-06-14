From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "SPI: imx: Update DT binding documentation" to the spi tree
Date: Tue, 14 Jun 2016 10:19:11 +0100
Message-ID: <E1bCkV5-00060K-IY@finisterre>
References: <1465405329-5153-4-git-send-email-shc_work@mail.ru>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465405329-5153-4-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   SPI: imx: Update DT binding documentation

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a5561add24d6ce5e95c76b8ea1aea6ea2e553eab Mon Sep 17 00:00:00 2001
From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Date: Wed, 8 Jun 2016 20:02:09 +0300
Subject: [PATCH] SPI: imx: Update DT binding documentation

Mark "fsl,spi-num-chipselects" property as obsolete.

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
index 523341a0e113..8bc95e2fc47f 100644
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
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
