From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi/s3c64xx: Split wait_for_xfer() into PIO and DMA versions
Date: Fri, 24 Jan 2014 20:06:14 +0000
Message-ID: <1390593974-28837-1-git-send-email-broonie@kernel.org>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

There is no meaningful code sharing between the PIO and DMA variants
(just the timeout calculation) so in order to make the code easier to
work with split the two cases.

Looking at the code it is not clear how the PIO version works for large
transmits, greater than FIFO size is only handled for RX.

Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c | 166 +++++++++++++++++++++++++---------------------
 1 file changed, 89 insertions(+), 77 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 19113538f5c6..b9ba7a3e7741 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -677,101 +677,110 @@ static u32 s3c64xx_spi_wait_for_timeout(struct s3c64xx_spi_driver_data *sdd,
 	return RX_FIFO_LVL(status, sdd);
 }
 
-static int wait_for_xfer(struct s3c64xx_spi_driver_data *sdd,
-				struct spi_transfer *xfer, int dma_mode)
+static int wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
+			struct spi_transfer *xfer)
 {
 	void __iomem *regs = sdd->regs;
 	unsigned long val;
+	u32 status;
 	int ms;
 
 	/* millisecs to xfer 'len' bytes @ 'cur_speed' */
 	ms = xfer->len * 8 * 1000 / sdd->cur_speed;
 	ms += 10; /* some tolerance */
 
-	if (dma_mode) {
-		val = msecs_to_jiffies(ms) + 10;
-		val = wait_for_completion_timeout(&sdd->xfer_completion, val);
-	} else {
-		u32 status;
-		val = msecs_to_loops(ms);
-		do {
+	val = msecs_to_jiffies(ms) + 10;
+	val = wait_for_completion_timeout(&sdd->xfer_completion, val);
+
+	/*
+	 * If the previous xfer was completed within timeout, then
+	 * proceed further else return -EIO.
+	 * DmaTx returns after simply writing data in the FIFO,
+	 * w/o waiting for real transmission on the bus to finish.
+	 * DmaRx returns only after Dma read data from FIFO which
+	 * needs bus transmission to finish, so we don't worry if
+	 * Xfer involved Rx(with or without Tx).
+	 */
+	if (val && !xfer->rx_buf) {
+		val = msecs_to_loops(10);
+		status = readl(regs + S3C64XX_SPI_STATUS);
+		while ((TX_FIFO_LVL(status, sdd)
+			|| !S3C64XX_SPI_ST_TX_DONE(status, sdd))
+		       && --val) {
+			cpu_relax();
 			status = readl(regs + S3C64XX_SPI_STATUS);
-		} while (RX_FIFO_LVL(status, sdd) < xfer->len && --val);
+		}
+
 	}
 
-	if (dma_mode) {
-		u32 status;
-
-		/*
-		 * If the previous xfer was completed within timeout, then
-		 * proceed further else return -EIO.
-		 * DmaTx returns after simply writing data in the FIFO,
-		 * w/o waiting for real transmission on the bus to finish.
-		 * DmaRx returns only after Dma read data from FIFO which
-		 * needs bus transmission to finish, so we don't worry if
-		 * Xfer involved Rx(with or without Tx).
-		 */
-		if (val && !xfer->rx_buf) {
-			val = msecs_to_loops(10);
-			status = readl(regs + S3C64XX_SPI_STATUS);
-			while ((TX_FIFO_LVL(status, sdd)
-				|| !S3C64XX_SPI_ST_TX_DONE(status, sdd))
-					&& --val) {
-				cpu_relax();
-				status = readl(regs + S3C64XX_SPI_STATUS);
-			}
+	/* If timed out while checking rx/tx status return error */
+	if (!val)
+		return -EIO;
 
-		}
+	return 0;
+}
 
-		/* If timed out while checking rx/tx status return error */
-		if (!val)
-			return -EIO;
-	} else {
-		int loops;
-		u32 cpy_len;
-		u8 *buf;
-
-		/* If it was only Tx */
-		if (!xfer->rx_buf) {
-			sdd->state &= ~TXBUSY;
-			return 0;
-		}
+static int wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
+			struct spi_transfer *xfer)
+{
+	void __iomem *regs = sdd->regs;
+	unsigned long val;
+	u32 status;
+	int loops;
+	u32 cpy_len;
+	u8 *buf;
+	int ms;
 
-		/*
-		 * If the receive length is bigger than the controller fifo
-		 * size, calculate the loops and read the fifo as many times.
-		 * loops = length / max fifo size (calculated by using the
-		 * fifo mask).
-		 * For any size less than the fifo size the below code is
-		 * executed atleast once.
-		 */
-		loops = xfer->len / ((FIFO_LVL_MASK(sdd) >> 1) + 1);
-		buf = xfer->rx_buf;
-		do {
-			/* wait for data to be received in the fifo */
-			cpy_len = s3c64xx_spi_wait_for_timeout(sdd,
-						(loops ? ms : 0));
+	/* millisecs to xfer 'len' bytes @ 'cur_speed' */
+	ms = xfer->len * 8 * 1000 / sdd->cur_speed;
+	ms += 10; /* some tolerance */
 
-			switch (sdd->cur_bpw) {
-			case 32:
-				ioread32_rep(regs + S3C64XX_SPI_RX_DATA,
-					buf, cpy_len / 4);
-				break;
-			case 16:
-				ioread16_rep(regs + S3C64XX_SPI_RX_DATA,
-					buf, cpy_len / 2);
-				break;
-			default:
-				ioread8_rep(regs + S3C64XX_SPI_RX_DATA,
-					buf, cpy_len);
-				break;
-			}
+	val = msecs_to_loops(ms);
+	do {
+		status = readl(regs + S3C64XX_SPI_STATUS);
+	} while (RX_FIFO_LVL(status, sdd) < xfer->len && --val);
 
-			buf = buf + cpy_len;
-		} while (loops--);
-		sdd->state &= ~RXBUSY;
+
+	/* If it was only Tx */
+	if (!xfer->rx_buf) {
+		sdd->state &= ~TXBUSY;
+		return 0;
 	}
 
+	/*
+	 * If the receive length is bigger than the controller fifo
+	 * size, calculate the loops and read the fifo as many times.
+	 * loops = length / max fifo size (calculated by using the
+	 * fifo mask).
+	 * For any size less than the fifo size the below code is
+	 * executed atleast once.
+	 */
+	loops = xfer->len / ((FIFO_LVL_MASK(sdd) >> 1) + 1);
+	buf = xfer->rx_buf;
+	do {
+		/* wait for data to be received in the fifo */
+		cpy_len = s3c64xx_spi_wait_for_timeout(sdd,
+						       (loops ? ms : 0));
+
+		switch (sdd->cur_bpw) {
+		case 32:
+			ioread32_rep(regs + S3C64XX_SPI_RX_DATA,
+				     buf, cpy_len / 4);
+			break;
+		case 16:
+			ioread16_rep(regs + S3C64XX_SPI_RX_DATA,
+				     buf, cpy_len / 2);
+			break;
+		default:
+			ioread8_rep(regs + S3C64XX_SPI_RX_DATA,
+				    buf, cpy_len);
+			break;
+		}
+
+		buf = buf + cpy_len;
+	} while (loops--);
+	sdd->state &= ~RXBUSY;
+
 	return 0;
 }
 
@@ -928,7 +937,10 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 
 	spin_unlock_irqrestore(&sdd->lock, flags);
 
-	status = wait_for_xfer(sdd, xfer, use_dma);
+	if (use_dma)
+		status = wait_for_dma(sdd, xfer);
+	else
+		status = wait_for_pio(sdd, xfer);
 
 	if (status) {
 		dev_err(&spi->dev, "I/O Error: rx-%d tx-%d res:rx-%c tx-%c len-%d\n",
-- 
1.8.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
