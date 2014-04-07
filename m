From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: efm32: Update binding document to make
 "efm32,location" property optional
Date: Mon, 07 Apr 2014 15:11:46 +0800
Message-ID: <1396854706.27810.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If "efm32,location" property is not provided, keeping what is already
configured in the hardware, so its either the reset default 0 or whatever
the bootloader did.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/efm32-spi.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/efm32-spi.txt b/Documentation/devicetree/bindings/spi/efm32-spi.txt
index 8f081c9..130cd17 100644
--- a/Documentation/devicetree/bindings/spi/efm32-spi.txt
+++ b/Documentation/devicetree/bindings/spi/efm32-spi.txt
@@ -8,7 +8,13 @@ Required properties:
 - interrupts: pair specifying rx and tx irq
 - clocks: phandle to the spi clock
 - cs-gpios: see spi-bus.txt
-- efm32,location: Value to write to the ROUTE register's LOCATION bitfield to configure the pinmux for the device, see datasheet for values.
+
+Recommended properties :
+- efm32,location: Value to write to the ROUTE register's LOCATION bitfield to
+                  configure the pinmux for the device, see datasheet for values.
+                  If "efm32,location" property is not provided, keeping what is
+                  already configured in the hardware, so its either the reset
+                  default 0 or whatever the bootloader did.
 
 Example:
 
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
