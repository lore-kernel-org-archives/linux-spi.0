From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH] spi: core: Improve tx/rx_nbits check comments
Date: Sun, 12 Jan 2014 14:00:29 +0100
Message-ID: <1389531629-6026-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

  - Rephrase the comments about tx/rx_nbits validity checks,
  - Remove the stale comment about SPI_3WIRE (the code it refers to was
    removed in commit 368ca4e0c75612c0a4d6bbcef7efb944604340c2 ("spi:
    Eliminate 3WIRE spi_transfer check")).

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/spi/spi.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index eaaad9d7fa84..ccb8a00ee83d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1667,9 +1667,8 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 		if (xfer->rx_buf && !xfer->rx_nbits)
 			xfer->rx_nbits = SPI_NBITS_SINGLE;
 		/* check transfer tx/rx_nbits:
-		 * 1. keep the value is not out of single, dual and quad
-		 * 2. keep tx/rx_nbits is contained by mode in spi_device
-		 * 3. if SPI_3WIRE, tx/rx_nbits should be in single
+		 * 1. check the value matches one of single, dual and quad
+		 * 2. check tx/rx_nbits match the mode in spi_device
 		 */
 		if (xfer->tx_buf) {
 			if (xfer->tx_nbits != SPI_NBITS_SINGLE &&
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
