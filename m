From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi/pl022: Explicitly truncate large bitmask
Date: Fri,  1 Aug 2014 17:48:55 +0100
Message-ID: <1406911735-17239-1-git-send-email-broonie@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org,
	Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

When building on 64 bit architectures the use of bitwise negation generates
constants larger than 32 bits which won't fit in u32s used to represent
32 bit register values on the device. Explicitly cast to let the compiler
know that the higher bits are not significant and can be discarded.

Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pl022.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 66d2ae2..1189cfd 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1417,7 +1417,7 @@ static void do_interrupt_dma_transfer(struct pl022 *pl022)
 	 * Default is to enable all interrupts except RX -
 	 * this will be enabled once TX is complete
 	 */
-	u32 irqflags = ENABLE_ALL_INTERRUPTS & ~SSP_IMSC_MASK_RXIM;
+	u32 irqflags = (u32)(ENABLE_ALL_INTERRUPTS & ~SSP_IMSC_MASK_RXIM);
 
 	/* Enable target chip, if not already active */
 	if (!pl022->next_msg_cs_active)
-- 
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
