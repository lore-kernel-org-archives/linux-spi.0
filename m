From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/1] spi: imx: Update device tree binding documentation
Date: Wed, 15 Nov 2017 11:52:32 -0800
Message-ID: <20171115195232.10354-1-tpiepho@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Update documentation for gpio-cs and num-cs to reflect the standard SPI
bindings.

The dma properties are optional.

Include a warning that native CS do not work in a commonly useful manner
with this hardware/driver, and therefor most users probably should use GPIO
based CS lines rather than native.

CC: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
CC: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
CC: Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
index 5bf13960f7f4..e3c48b20b1a6 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
@@ -12,24 +12,30 @@ Required properties:
   - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53 and later Soc
 - reg : Offset and length of the register set for the device
 - interrupts : Should contain CSPI/eCSPI interrupt
-- cs-gpios : Specifies the gpio pins to be used for chipselects.
 - clocks : Clock specifiers for both ipg and per clocks.
 - clock-names : Clock names should include both "ipg" and "per"
 See the clock consumer binding,
 	Documentation/devicetree/bindings/clock/clock-bindings.txt
-- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
-		Documentation/devicetree/bindings/dma/dma.txt
-- dma-names: DMA request names should include "tx" and "rx" if present.
 
-Obsolete properties:
-- fsl,spi-num-chipselects : Contains the number of the chipselect
+Recommended properties:
+- cs-gpios : GPIOs to use as chip selects, see spi-bus.txt.  While the native chip
+select lines can be used, they appear to always generate a pulse between each
+word of a transfer.  Most use cases will require GPIO based chip selects to
+generate a valid transaction.
 
 Optional properties:
+- num-cs :  Number of total chip selects, see spi-bus.txt.
+- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
+Documentation/devicetree/bindings/dma/dma.txt.
+- dma-names: DMA request names, if present, should include "tx" and "rx".
 - fsl,spi-rdy-drctl: Integer, representing the value of DRCTL, the register
 controlling the SPI_READY handling. Note that to enable the DRCTL consideration,
 the SPI_READY mode-flag needs to be set too.
 Valid values are: 0 (disabled), 1 (edge-triggered burst) and 2 (level-triggered burst).
 
+Obsolete properties:
+- fsl,spi-num-chipselects : Contains the number of the chipselect
+
 Example:
 
 ecspi@70010000 {
-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
