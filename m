From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: [PATCH] spi: bcm2835: fill/drain SPI-fifo as much as possible during interrupt
Date: Mon, 23 Mar 2015 15:11:53 +0100
Message-ID: <F89FEE91-D292-4835-9F49-76A69A17BA4F@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Implement the recommendation from the BCM2835 data-sheet
with regards to polling drivers to fill/drain the FIFO as much data as possible
also for the interrupt-driven case (which this driver is making use of).

This means that for long transfers (>64bytes) we need one interrupt
every 64 bytes instead of every 12 bytes, as the FIFO is 16 words (not bytes) wide.

Tested with mcp251x (can bus), fb_st7735 (TFT framebuffer device) 
and enc28j60 (ethernet) drivers.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |   78 ++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 61 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 419a782..1b6dbfc 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -91,25 +91,23 @@ static inline void bcm2835_wr(struct bcm2835_spi *bs, unsigned reg, u32 val)
 	writel(val, bs->regs + reg);
 }
 
-static inline void bcm2835_rd_fifo(struct bcm2835_spi *bs, int len)
+static inline void bcm2835_rd_fifo(struct bcm2835_spi *bs)
 {
 	u8 byte;
 
-	while (len--) {
+	while (bcm2835_rd(bs, BCM2835_SPI_CS) & BCM2835_SPI_CS_RXD) {
 		byte = bcm2835_rd(bs, BCM2835_SPI_FIFO);
 		if (bs->rx_buf)
 			*bs->rx_buf++ = byte;
 	}
 }
 
-static inline void bcm2835_wr_fifo(struct bcm2835_spi *bs, int len)
+static inline void bcm2835_wr_fifo(struct bcm2835_spi *bs)
 {
 	u8 byte;
 
-	if (len > bs->len)
-		len = bs->len;
-
-	while (len--) {
+	while ((bs->len) &&
+	       (bcm2835_rd(bs, BCM2835_SPI_CS) & BCM2835_SPI_CS_TXD)) {
 		byte = bs->tx_buf ? *bs->tx_buf++ : 0;
 		bcm2835_wr(bs, BCM2835_SPI_FIFO, byte);
 		bs->len--;
@@ -122,60 +120,24 @@ static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 
-	/*
-	 * RXR - RX needs Reading. This means 12 (or more) bytes have been
-	 * transmitted and hence 12 (or more) bytes have been received.
-	 *
-	 * The FIFO is 16-bytes deep. We check for this interrupt to keep the
-	 * FIFO full; we have a 4-byte-time buffer for IRQ latency. We check
-	 * this before DONE (TX empty) just in case we delayed processing this
-	 * interrupt for some reason.
-	 *
-	 * We only check for this case if we have more bytes to TX; at the end
-	 * of the transfer, we ignore this pipelining optimization, and let
-	 * bcm2835_spi_finish_transfer() drain the RX FIFO.
-	 */
-	if (bs->len && (cs & BCM2835_SPI_CS_RXR)) {
-		/* Read 12 bytes of data */
-		bcm2835_rd_fifo(bs, 12);
+	/* Read as many bytes as possible from FIFO */
+	bcm2835_rd_fifo(bs);
 
-		/* Write up to 12 bytes */
-		bcm2835_wr_fifo(bs, 12);
+	if (bs->len) { /* there is more data to transmit */
+		bcm2835_wr_fifo(bs);
+	} else { /* Transfer complete */
+		/* Disable SPI interrupts */
+		cs &= ~(BCM2835_SPI_CS_INTR | BCM2835_SPI_CS_INTD);
+		bcm2835_wr(bs, BCM2835_SPI_CS, cs);
 
 		/*
-		 * We must have written something to the TX FIFO due to the
-		 * bs->len check above, so cannot be DONE. Hence, return
-		 * early. Note that DONE could also be set if we serviced an
-		 * RXR interrupt really late.
+		 * Wake up bcm2835_spi_transfer_one(), which will call
+		 * bcm2835_spi_finish_transfer(), to drain the RX FIFO.
 		 */
-		return IRQ_HANDLED;
+		complete(&bs->done);
 	}
 
-	/*
-	 * DONE - TX empty. This occurs when we first enable the transfer
-	 * since we do not pre-fill the TX FIFO. At any other time, given that
-	 * we refill the TX FIFO above based on RXR, and hence ignore DONE if
-	 * RXR is set, DONE really does mean end-of-transfer.
-	 */
-	if (cs & BCM2835_SPI_CS_DONE) {
-		if (bs->len) { /* First interrupt in a transfer */
-			bcm2835_wr_fifo(bs, 16);
-		} else { /* Transfer complete */
-			/* Disable SPI interrupts */
-			cs &= ~(BCM2835_SPI_CS_INTR | BCM2835_SPI_CS_INTD);
-			bcm2835_wr(bs, BCM2835_SPI_CS, cs);
-
-			/*
-			 * Wake up bcm2835_spi_transfer_one(), which will call
-			 * bcm2835_spi_finish_transfer(), to drain the RX FIFO.
-			 */
-			complete(&bs->done);
-		}
-
-		return IRQ_HANDLED;
-	}
-
-	return IRQ_NONE;
+	return IRQ_HANDLED;
 }
 
 static int bcm2835_spi_start_transfer(struct spi_device *spi,
@@ -236,12 +198,6 @@ static int bcm2835_spi_finish_transfer(struct spi_device *spi,
 	struct bcm2835_spi *bs = spi_master_get_devdata(spi->master);
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 
-	/* Drain RX FIFO */
-	while (cs & BCM2835_SPI_CS_RXD) {
-		bcm2835_rd_fifo(bs, 1);
-		cs = bcm2835_rd(bs, BCM2835_SPI_CS);
-	}
-
 	if (tfr->delay_usecs)
 		udelay(tfr->delay_usecs);
 
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
