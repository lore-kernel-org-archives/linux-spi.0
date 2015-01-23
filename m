From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 11/18] spi/xilinx: Remove rx_fn and tx_fn pointer
Date: Fri, 23 Jan 2015 17:08:43 +0100
Message-ID: <1422029330-10971-12-git-send-email-ricardo.ribalda@gmail.com>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422029330-10971-1-git-send-email-ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Simplify the code by removing the tx and and rx function pointers and
substitute them by a single function.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-xilinx.c | 69 +++++++++++++-----------------------------------
 1 file changed, 18 insertions(+), 51 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 29edf1b..6b6c658 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -92,8 +92,6 @@ struct xilinx_spi {
 	u32 cs_inactive;	/* Level of the CS pins when inactive*/
 	unsigned int (*read_fn)(void __iomem *);
 	void (*write_fn)(u32, void __iomem *);
-	void (*tx_fn)(struct xilinx_spi *);
-	void (*rx_fn)(struct xilinx_spi *);
 };
 
 static void xspi_write32(u32 val, void __iomem *addr)
@@ -116,49 +114,32 @@ static unsigned int xspi_read32_be(void __iomem *addr)
 	return ioread32be(addr);
 }
 
-static void xspi_tx8(struct xilinx_spi *xspi)
-{
-	xspi->write_fn(*xspi->tx_ptr, xspi->regs + XSPI_TXD_OFFSET);
-	xspi->tx_ptr++;
-}
-
-static void xspi_tx16(struct xilinx_spi *xspi)
-{
-	xspi->write_fn(*(u16 *)(xspi->tx_ptr), xspi->regs + XSPI_TXD_OFFSET);
-	xspi->tx_ptr += 2;
-}
-
-static void xspi_tx32(struct xilinx_spi *xspi)
+static void xilinx_spi_tx(struct xilinx_spi *xspi)
 {
 	xspi->write_fn(*(u32 *)(xspi->tx_ptr), xspi->regs + XSPI_TXD_OFFSET);
-	xspi->tx_ptr += 4;
+	xspi->tx_ptr += xspi->bits_per_word/8;
 }
 
-static void xspi_rx8(struct xilinx_spi *xspi)
+static void xilinx_spi_rx(struct xilinx_spi *xspi)
 {
 	u32 data = xspi->read_fn(xspi->regs + XSPI_RXD_OFFSET);
-	if (xspi->rx_ptr) {
-		*xspi->rx_ptr = data & 0xff;
-		xspi->rx_ptr++;
-	}
-}
 
-static void xspi_rx16(struct xilinx_spi *xspi)
-{
-	u32 data = xspi->read_fn(xspi->regs + XSPI_RXD_OFFSET);
-	if (xspi->rx_ptr) {
-		*(u16 *)(xspi->rx_ptr) = data & 0xffff;
-		xspi->rx_ptr += 2;
-	}
-}
+	if (!xspi->rx_ptr)
+		return;
 
-static void xspi_rx32(struct xilinx_spi *xspi)
-{
-	u32 data = xspi->read_fn(xspi->regs + XSPI_RXD_OFFSET);
-	if (xspi->rx_ptr) {
+	switch (xspi->bits_per_word) {
+	case 8:
+		*(u8 *)(xspi->rx_ptr) = data;
+		break;
+	case 16:
+		*(u16 *)(xspi->rx_ptr) = data;
+		break;
+	case 32:
 		*(u32 *)(xspi->rx_ptr) = data;
-		xspi->rx_ptr += 4;
+		break;
 	}
+
+	xspi->rx_ptr += xspi->bits_per_word/8;
 }
 
 static void xspi_init_hw(struct xilinx_spi *xspi)
@@ -250,7 +231,7 @@ static void xilinx_spi_fill_tx_fifo(struct xilinx_spi *xspi, int n_words)
 
 	while (n_words--)
 		if (xspi->tx_ptr)
-			xspi->tx_fn(xspi);
+			xilinx_spi_tx(xspi);
 		else
 			xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
 	return;
@@ -301,7 +282,7 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 		/* Read out all the data from the Rx FIFO */
 		while (n_words--)
-			xspi->rx_fn(xspi);
+			xilinx_spi_rx(xspi);
 	}
 
 	return t->len - xspi->remaining_bytes;
@@ -423,20 +404,6 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 
 	master->bits_per_word_mask = SPI_BPW_MASK(bits_per_word);
 	xspi->bits_per_word = bits_per_word;
-	if (xspi->bits_per_word == 8) {
-		xspi->tx_fn = xspi_tx8;
-		xspi->rx_fn = xspi_rx8;
-	} else if (xspi->bits_per_word == 16) {
-		xspi->tx_fn = xspi_tx16;
-		xspi->rx_fn = xspi_rx16;
-	} else if (xspi->bits_per_word == 32) {
-		xspi->tx_fn = xspi_tx32;
-		xspi->rx_fn = xspi_rx32;
-	} else {
-		ret = -EINVAL;
-		goto put_master;
-	}
-
 	xspi->buffer_size = xilinx_spi_find_buffer_size(xspi);
 
 	xspi->irq = platform_get_irq(pdev, 0);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
