From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] spi: fsl-espi: eliminate need for linearization when
 writing to hardware
Date: Fri, 25 Nov 2016 23:59:24 +0100
Message-ID: <fe019347-2d40-7e0a-4ee4-cadaa8930d5f@gmail.com>
References: <2424ba57-be1a-d32d-0c14-1662c2d02409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2424ba57-be1a-d32d-0c14-1662c2d02409-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Eliminate need for linearization when writing to the hardware and
read from the transfer buffers directly.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 79 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 4222578..189ab36 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -98,6 +98,11 @@ struct fsl_espi {
 	const void *tx;
 	void *rx;
 
+	struct list_head *m_transfers;
+	struct spi_transfer *tx_t;
+	unsigned int tx_pos;
+	bool tx_done;
+
 	bool swab;
 	unsigned int rx_len;
 	unsigned int tx_len;
@@ -131,6 +136,12 @@ static inline void fsl_espi_write_reg(struct fsl_espi *espi, int offset,
 	iowrite32be(val, espi->reg_base + offset);
 }
 
+static inline void fsl_espi_write_reg16(struct fsl_espi *espi, int offset,
+					u16 val)
+{
+	iowrite16(val, espi->reg_base + offset);
+}
+
 static inline void fsl_espi_write_reg8(struct fsl_espi *espi, int offset,
 				       u8 val)
 {
@@ -260,22 +271,58 @@ static unsigned int fsl_espi_check_rxskip_mode(struct spi_message *m)
 static void fsl_espi_fill_tx_fifo(struct fsl_espi *espi, u32 events)
 {
 	u32 tx_fifo_avail;
+	unsigned int tx_left;
+	const void *tx_buf;
 
 	/* if events is zero transfer has not started and tx fifo is empty */
 	tx_fifo_avail = events ? SPIE_TXCNT(events) :  FSL_ESPI_FIFO_SIZE;
-
-	while (tx_fifo_avail >= min(4U, espi->tx_len) && espi->tx_len)
-		if (espi->tx_len >= 4) {
-			fsl_espi_write_reg(espi, ESPI_SPITF, *(u32 *)espi->tx);
-			espi->tx += 4;
-			espi->tx_len -= 4;
+start:
+	tx_left = espi->tx_t->len - espi->tx_pos;
+	tx_buf = espi->tx_t->tx_buf;
+	while (tx_fifo_avail >= min(4U, tx_left) && tx_left) {
+		if (tx_left >= 4) {
+			if (!tx_buf)
+				fsl_espi_write_reg(espi, ESPI_SPITF, 0);
+			else if (espi->swab)
+				fsl_espi_write_reg(espi, ESPI_SPITF,
+					swahb32p(tx_buf + espi->tx_pos));
+			else
+				fsl_espi_write_reg(espi, ESPI_SPITF,
+					*(u32 *)(tx_buf + espi->tx_pos));
+			espi->tx_pos += 4;
+			tx_left -= 4;
 			tx_fifo_avail -= 4;
+		} else if (tx_left >= 2 && tx_buf && espi->swab) {
+			fsl_espi_write_reg16(espi, ESPI_SPITF,
+					swab16p(tx_buf + espi->tx_pos));
+			espi->tx_pos += 2;
+			tx_left -= 2;
+			tx_fifo_avail -= 2;
 		} else {
-			fsl_espi_write_reg8(espi, ESPI_SPITF, *(u8 *)espi->tx);
-			espi->tx += 1;
-			espi->tx_len -= 1;
+			if (!tx_buf)
+				fsl_espi_write_reg8(espi, ESPI_SPITF, 0);
+			else
+				fsl_espi_write_reg8(espi, ESPI_SPITF,
+					*(u8 *)(tx_buf + espi->tx_pos));
+			espi->tx_pos += 1;
+			tx_left -= 1;
 			tx_fifo_avail -= 1;
 		}
+	}
+
+	if (!tx_left) {
+		/* Last transfer finished, in rxskip mode only one is needed */
+		if (list_is_last(&espi->tx_t->transfer_list,
+		    espi->m_transfers) || espi->rxskip) {
+			espi->tx_done = true;
+			return;
+		}
+		espi->tx_t = list_next_entry(espi->tx_t, transfer_list);
+		espi->tx_pos = 0;
+		/* continue with next transfer if tx fifo is not full */
+		if (tx_fifo_avail)
+			goto start;
+	}
 }
 
 static void fsl_espi_read_rx_fifo(struct fsl_espi *espi, u32 events)
@@ -369,9 +416,7 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	/* Won't hang up forever, SPI bus sometimes got lost interrupts... */
 	ret = wait_for_completion_timeout(&espi->done, 2 * HZ);
 	if (ret == 0)
-		dev_err(espi->dev,
-			"Transaction hanging up (left %u tx bytes, %u rx bytes)\n",
-			espi->tx_len, espi->rx_len);
+		dev_err(espi->dev, "Transfer timed out!\n");
 
 	/* disable rx ints */
 	fsl_espi_write_reg(espi, ESPI_SPIM, 0);
@@ -388,6 +433,12 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 	/* In case of LSB-first and bits_per_word > 8 byte-swap all words */
 	espi->swab = spi->mode & SPI_LSB_FIRST && trans->bits_per_word > 8;
 
+	espi->m_transfers = &m->transfers;
+	espi->tx_t = list_first_entry(&m->transfers, struct spi_transfer,
+				      transfer_list);
+	espi->tx_pos = 0;
+	espi->tx_done = false;
+
 	espi->rxskip = fsl_espi_check_rxskip_mode(m);
 	if (trans->rx_nbits == SPI_NBITS_DUAL && !espi->rxskip) {
 		dev_err(espi->dev, "Dual output mode requires RXSKIP mode!\n");
@@ -508,10 +559,10 @@ static void fsl_espi_cpu_irq(struct fsl_espi *espi, u32 events)
 	if (espi->rx_len)
 		fsl_espi_read_rx_fifo(espi, events);
 
-	if (espi->tx_len)
+	if (!espi->tx_done)
 		fsl_espi_fill_tx_fifo(espi, events);
 
-	if (espi->tx_len || espi->rx_len)
+	if (!espi->tx_done || espi->rx_len)
 		return;
 
 	/* we're done, but check for errors before returning */
-- 
2.10.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
