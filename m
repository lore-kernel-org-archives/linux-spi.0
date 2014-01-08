From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH RFT] spi: oc-tiny: Simplify tiny_spi_txrx_bufs
 implementation when irq is not used
Date: Wed, 08 Jan 2014 16:00:04 +0800
Message-ID: <1389168004.28019.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Currently we have similar code for (txp && rxp), (txp && !rxp), (!rxp & txp),
and (!txp && !rxp) cases. This patch refactors the code a bit to avoid
duplicate similar code.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
Hi Thomas,
I don't have this hardware, so please test this path if you think it is ok.
I think there is no functional change with this patch.

Thanks,
Axel
 drivers/spi/spi-oc-tiny.c | 62 +++++++++--------------------------------------
 1 file changed, 11 insertions(+), 51 deletions(-)

diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index 91c6685..f7c896e 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -153,62 +153,22 @@ static int tiny_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 		}
 
 		wait_for_completion(&hw->done);
-	} else if (txp && rxp) {
-		/* we need to tighten the transfer loop */
-		writeb(*txp++, hw->base + TINY_SPI_TXDATA);
-		if (t->len > 1) {
-			writeb(*txp++, hw->base + TINY_SPI_TXDATA);
-			for (i = 2; i < t->len; i++) {
-				u8 rx, tx = *txp++;
-				tiny_spi_wait_txr(hw);
-				rx = readb(hw->base + TINY_SPI_TXDATA);
-				writeb(tx, hw->base + TINY_SPI_TXDATA);
-				*rxp++ = rx;
-			}
-			tiny_spi_wait_txr(hw);
-			*rxp++ = readb(hw->base + TINY_SPI_TXDATA);
-		}
-		tiny_spi_wait_txe(hw);
-		*rxp++ = readb(hw->base + TINY_SPI_RXDATA);
-	} else if (rxp) {
-		writeb(0, hw->base + TINY_SPI_TXDATA);
-		if (t->len > 1) {
-			writeb(0,
-			       hw->base + TINY_SPI_TXDATA);
-			for (i = 2; i < t->len; i++) {
-				u8 rx;
-				tiny_spi_wait_txr(hw);
-				rx = readb(hw->base + TINY_SPI_TXDATA);
-				writeb(0, hw->base + TINY_SPI_TXDATA);
-				*rxp++ = rx;
-			}
-			tiny_spi_wait_txr(hw);
-			*rxp++ = readb(hw->base + TINY_SPI_TXDATA);
-		}
-		tiny_spi_wait_txe(hw);
-		*rxp++ = readb(hw->base + TINY_SPI_RXDATA);
-	} else if (txp) {
-		writeb(*txp++, hw->base + TINY_SPI_TXDATA);
-		if (t->len > 1) {
-			writeb(*txp++, hw->base + TINY_SPI_TXDATA);
-			for (i = 2; i < t->len; i++) {
-				u8 tx = *txp++;
-				tiny_spi_wait_txr(hw);
-				writeb(tx, hw->base + TINY_SPI_TXDATA);
-			}
-		}
-		tiny_spi_wait_txe(hw);
 	} else {
-		writeb(0, hw->base + TINY_SPI_TXDATA);
-		if (t->len > 1) {
-			writeb(0, hw->base + TINY_SPI_TXDATA);
-			for (i = 2; i < t->len; i++) {
+		/* we need to tighten the transfer loop */
+		writeb(txp ? *txp++ : 0, hw->base + TINY_SPI_TXDATA);
+		for (i = 1; i < t->len; i++) {
+			writeb(txp ? *txp++ : 0, hw->base + TINY_SPI_TXDATA);
+
+			if (rxp || (i != t->len - 1))
 				tiny_spi_wait_txr(hw);
-				writeb(0, hw->base + TINY_SPI_TXDATA);
-			}
+			if (rxp)
+				*rxp++ = readb(hw->base + TINY_SPI_TXDATA);
 		}
 		tiny_spi_wait_txe(hw);
+		if (rxp)
+			*rxp++ = readb(hw->base + TINY_SPI_RXDATA);
 	}
+
 	return t->len;
 }
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
