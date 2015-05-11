From: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Subject: [PATCH] spi: pl022: Specify 'num-cs' property as required in devicetree binding
Date: Mon, 11 May 2015 12:20:18 -0300
Message-ID: <1431357618-6829-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Since commit 39a6ac11df65 ("spi/pl022: Devicetree support w/o platform data")
the 'num-cs' parameter cannot be passed through platform data when probing
with devicetree. Instead, it's a required devicetree property.

Fix the binding documentation so the property is properly specified.

Fixes: 39a6ac11df65 ("spi/pl022: Devicetree support w/o platform data")
Signed-off-by: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi_pl022.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi_pl022.txt b/Documentation/devicetree/bindings/spi/spi_pl022.txt
index 22ed679..4d1673c 100644
--- a/Documentation/devicetree/bindings/spi/spi_pl022.txt
+++ b/Documentation/devicetree/bindings/spi/spi_pl022.txt
@@ -4,9 +4,9 @@ Required properties:
 - compatible : "arm,pl022", "arm,primecell"
 - reg : Offset and length of the register set for the device
 - interrupts : Should contain SPI controller interrupt
+- num-cs : total number of chipselects
 
 Optional properties:
-- num-cs : total number of chipselects
 - cs-gpios : should specify GPIOs used for chipselects.
   The gpios will be referred to as reg = <index> in the SPI child nodes.
   If unspecified, a single SPI device without a chip select can be used.
-- 
2.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
