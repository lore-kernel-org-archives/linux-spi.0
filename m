From: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCHv2 2/2] spi: imx: document use of native chip-selects in devicetree
Date: Tue, 21 Mar 2017 22:43:25 +1000
Message-ID: <1490100205-31309-3-git-send-email-gerg@linux-m68k.org>
References: <1490100205-31309-1-git-send-email-gerg@linux-m68k.org>
Cc: shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org,
        Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490100205-31309-1-git-send-email-gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Document the "<0>" notation for specifying use of a native chip-select
in the "cs-gpios" tag of an SPI device in devicetree. This isn't unique
to the spi-imx driver, but this clearly spells out that you can use it
with this driver.

Signed-off-by: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

v2: added documentation to patch set

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
index 8bc95e2..cfc60cb 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
@@ -12,6 +12,7 @@ Required properties:
 - reg : Offset and length of the register set for the device
 - interrupts : Should contain CSPI/eCSPI interrupt
 - cs-gpios : Specifies the gpio pins to be used for chipselects.
+	Specify use of native chipselects with "<0>" in place of a gpio.
 - clocks : Clock specifiers for both ipg and per clocks.
 - clock-names : Clock names should include both "ipg" and "per"
 See the clock consumer binding,
@@ -32,7 +33,8 @@ ecspi@70010000 {
 	reg = <0x70010000 0x4000>;
 	interrupts = <36>;
 	cs-gpios = <&gpio3 24 0>, /* GPIO3_24 */
-		   <&gpio3 25 0>; /* GPIO3_25 */
+		   <&gpio3 25 0>, /* GPIO3_25 */
+		   <0>;           /* Native chip select */
 	dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
 	dma-names = "rx", "tx";
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
