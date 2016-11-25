From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] spi: fsl-espi: eliminate need for linearization when
 reading from hardware
Date: Fri, 25 Nov 2016 23:59:57 +0100
Message-ID: <80a5a858-dc54-ea9d-3c6e-34fdedc516d7@gmail.com>
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

Eliminate need for linearization when reading from the hardware and
write to the transfer buffers directly.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 77 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 189ab36..e93892d 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -102,6 +102,9 @@ struct fsl_espi {
 	struct spi_transfer *tx_t;
 	unsigned int tx_pos;
 	bool tx_done;
+	struct spi_transfer *rx_t;
+	unsigned int rx_pos;
+	bool rx_done;
 
 	bool swab;
 	unsigned int rx_len;
@@ -125,6 +128,11 @@ static inline u32 fsl_espi_read_reg(struct fsl_espi *espi, int offset)
 	return ioread32be(espi->reg_base + offset);
 }
 
+static inline u16 fsl_espi_read_reg16(struct fsl_espi *espi, int offset)
+{
+	return ioread16(espi->reg_base + offset);
+}
+
 static inline u8 fsl_espi_read_reg8(struct fsl_espi *espi, int offset)
 {
 	return ioread8(espi->reg_base + offset);
@@ -328,19 +336,53 @@ static void fsl_espi_fill_tx_fifo(struct fsl_espi *espi, u32 events)
 static void fsl_espi_read_rx_fifo(struct fsl_espi *espi, u32 events)
 {
 	u32 rx_fifo_avail = SPIE_RXCNT(events);
+	unsigned int rx_left;
+	void *rx_buf;
 
-	while (rx_fifo_avail >= min(4U, espi->rx_len) && espi->rx_len)
-		if (espi->rx_len >= 4) {
-			*(u32 *)espi->rx = fsl_espi_read_reg(espi, ESPI_SPIRF);
-			espi->rx += 4;
-			espi->rx_len -= 4;
+start:
+	rx_left = espi->rx_t->len - espi->rx_pos;
+	rx_buf = espi->rx_t->rx_buf;
+	while (rx_fifo_avail >= min(4U, rx_left) && rx_left) {
+		if (rx_left >= 4) {
+			u32 val = fsl_espi_read_reg(espi, ESPI_SPIRF);
+
+			if (rx_buf && espi->swab)
+				*(u32 *)(rx_buf + espi->rx_pos) = swahb32(val);
+			else if (rx_buf)
+				*(u32 *)(rx_buf + espi->rx_pos) = val;
+			espi->rx_pos += 4;
+			rx_left -= 4;
 			rx_fifo_avail -= 4;
+		} else if (rx_left >= 2 && rx_buf && espi->swab) {
+			u16 val = fsl_espi_read_reg16(espi, ESPI_SPIRF);
+
+			*(u16 *)(rx_buf + espi->rx_pos) = swab16(val);
+			espi->rx_pos += 2;
+			rx_left -= 2;
+			rx_fifo_avail -= 2;
 		} else {
-			*(u8 *)espi->rx = fsl_espi_read_reg8(espi, ESPI_SPIRF);
-			espi->rx += 1;
-			espi->rx_len -= 1;
+			u8 val = fsl_espi_read_reg8(espi, ESPI_SPIRF);
+
+			if (rx_buf)
+				*(u8 *)(rx_buf + espi->rx_pos) = val;
+			espi->rx_pos += 1;
+			rx_left -= 1;
 			rx_fifo_avail -= 1;
 		}
+	}
+
+	if (!rx_left) {
+		if (list_is_last(&espi->rx_t->transfer_list,
+		    espi->m_transfers)) {
+			espi->rx_done = true;
+			return;
+		}
+		espi->rx_t = list_next_entry(espi->rx_t, transfer_list);
+		espi->rx_pos = 0;
+		/* continue with next transfer if rx fifo is not empty */
+		if (rx_fifo_avail)
+			goto start;
+	}
 }
 
 static void fsl_espi_setup_transfer(struct spi_device *spi,
@@ -375,6 +417,7 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct fsl_espi *espi = spi_master_get_devdata(spi->master);
+	unsigned int rx_len = t->len;
 	u32 mask, spcom;
 	int ret;
 
@@ -395,6 +438,7 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		spcom |= SPCOM_RXSKIP(espi->rxskip);
 		espi->tx_len = espi->rxskip;
 		espi->rx_len = t->len - espi->rxskip;
+		rx_len = t->len - espi->rxskip;
 		espi->rx = t->rx_buf + espi->rxskip;
 		if (t->rx_nbits == SPI_NBITS_DUAL)
 			spcom |= SPCOM_DO;
@@ -404,7 +448,7 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 	/* enable interrupts */
 	mask = SPIM_DON;
-	if (espi->rx_len > FSL_ESPI_FIFO_SIZE)
+	if (rx_len > FSL_ESPI_FIFO_SIZE)
 		mask |= SPIM_RXT;
 	fsl_espi_write_reg(espi, ESPI_SPIM, mask);
 
@@ -438,6 +482,10 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 				      transfer_list);
 	espi->tx_pos = 0;
 	espi->tx_done = false;
+	espi->rx_t = list_first_entry(&m->transfers, struct spi_transfer,
+				      transfer_list);
+	espi->rx_pos = 0;
+	espi->rx_done = false;
 
 	espi->rxskip = fsl_espi_check_rxskip_mode(m);
 	if (trans->rx_nbits == SPI_NBITS_DUAL && !espi->rxskip) {
@@ -445,6 +493,10 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 		return -EINVAL;
 	}
 
+	/* In RXSKIP mode skip first transfer for reads */
+	if (espi->rxskip)
+		espi->rx_t = list_next_entry(espi->rx_t, transfer_list);
+
 	fsl_espi_copy_to_buf(m, espi);
 	fsl_espi_setup_transfer(spi, trans);
 
@@ -453,9 +505,6 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 	if (trans->delay_usecs)
 		udelay(trans->delay_usecs);
 
-	if (!ret)
-		fsl_espi_copy_from_buf(m, espi);
-
 	return ret;
 }
 
@@ -556,13 +605,13 @@ static void fsl_espi_cleanup(struct spi_device *spi)
 
 static void fsl_espi_cpu_irq(struct fsl_espi *espi, u32 events)
 {
-	if (espi->rx_len)
+	if (!espi->rx_done)
 		fsl_espi_read_rx_fifo(espi, events);
 
 	if (!espi->tx_done)
 		fsl_espi_fill_tx_fifo(espi, events);
 
-	if (!espi->tx_done || espi->rx_len)
+	if (!espi->tx_done || !espi->rx_done)
 		return;
 
 	/* we're done, but check for errors before returning */
-- 
2.10.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
