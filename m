From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Subject: [PATCH 5/8] spi: rspi: Add support for no TX only mode
Date: Tue, 24 Dec 2013 12:40:45 +0100
Message-ID: <1387885248-28425-6-git-send-email-geert+renesas@linux-m68k.org>
References: <1387885248-28425-1-git-send-email-geert+renesas@linux-m68k.org>
Cc: linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: linux-spi@vger.kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1387885248-28425-1-git-send-email-geert+renesas@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add support for RSPI variants lacking TX only mode, based on the SDK
reference code. This is needed for RZ/A1H.

The TX only mode flag is passed using platform data, defaulting to true for
legacy RSPI. QSPI nevers has TX only mode.

If TX only mode is not available, we have to wait for the receive interrupt
bit to become set, and perform a dummy read, in the transmit path.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/spi/spi-rspi.c   |   50 ++++++++++++++++++++++++++++++++++++++++------
 include/linux/spi/rspi.h |    1 +
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 00788091fc16..92aaa1eac5a9 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -191,6 +191,7 @@ struct rspi_data {
 
 	unsigned dma_width_16bit:1;
 	unsigned dma_callbacked:1;
+	unsigned txmode:1;
 };
 
 static void rspi_write8(const struct rspi_data *rspi, u8 data, u16 offset)
@@ -251,6 +252,20 @@ struct spi_ops {
 /*
  * functions for RSPI
  */
+static void rspi_set_txmode(const struct rspi_data *rspi)
+{
+	if (rspi->txmode)
+		rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) | SPCR_TXMD,
+			    RSPI_SPCR);
+}
+
+static void rspi_clear_txmode(const struct rspi_data *rspi)
+{
+	if (rspi->txmode)
+		rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) & ~SPCR_TXMD,
+			    RSPI_SPCR);
+}
+
 static int rspi_parse_platform_data(struct rspi_data *rspi,
 				    const struct rspi_plat_data *rspi_pd)
 {
@@ -275,6 +290,11 @@ static int rspi_parse_platform_data(struct rspi_data *rspi,
 		rspi->spdcr = 0;
 	}
 
+	if (rspi_pd)
+		rspi->txmode = rspi_pd->txmode;
+	else
+		rspi->txmode = 1;	/* legacy RSPI defaults to true */
+
 	return 0;
 }
 
@@ -321,6 +341,9 @@ static int qspi_parse_platform_data(struct rspi_data *rspi,
 	rspi->data_width = 8;
 	rspi->spdcr = 0;
 
+	/* No TX only mode */
+	rspi->txmode = 0;
+
 	return 0;
 }
 
@@ -414,8 +437,7 @@ static int rspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
 	int remain = t->len;
 	const u8 *data = t->tx_buf;
 	while (remain > 0) {
-		rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) | SPCR_TXMD,
-			    RSPI_SPCR);
+		rspi_set_txmode(rspi);
 
 		if (rspi_wait_for_interrupt(rspi, SPSR_SPTEF, SPCR_SPTIE) < 0) {
 			dev_err(&rspi->master->dev,
@@ -423,6 +445,15 @@ static int rspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
 			return -ETIMEDOUT;
 		}
 
+		if (!rspi->txmode && remain != t->len) {
+			if (rspi_wait_for_interrupt(rspi, SPSR_SPRF,
+						    SPCR_SPRIE) < 0) {
+				dev_err(&rspi->master->dev,
+					"%s: receive timeout\n", __func__);
+				return -ETIMEDOUT;
+			}
+			rspi_read_data(rspi);	/* dummy read */
+		}
 		rspi_write_data(rspi, *data);
 		data++;
 		remain--;
@@ -431,6 +462,14 @@ static int rspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
 	/* Waiting for the last transmition */
 	rspi_wait_for_interrupt(rspi, SPSR_SPTEF, SPCR_SPTIE);
 
+	if (!rspi->txmode) {
+		if (rspi_wait_for_interrupt(rspi, SPSR_SPRF, SPCR_SPRIE) < 0) {
+			dev_err(&rspi->master->dev,
+				"%s: receive timeout\n", __func__);
+			return -ETIMEDOUT;
+		}
+		rspi_read_data(rspi);	/* dummy read */
+	}
 	return 0;
 }
 
@@ -562,7 +601,7 @@ static int rspi_send_dma(struct rspi_data *rspi, struct spi_transfer *t)
 	for (i = 0; i < rspi->numirq; i++)
 		disable_irq(rspi->irq[i]);
 
-	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) | SPCR_TXMD, RSPI_SPCR);
+	rspi_set_txmode(rspi);
 	rspi_enable_irq(rspi, SPCR_SPTIE);
 	rspi->dma_callbacked = 0;
 
@@ -613,8 +652,7 @@ static int rspi_receive_pio(struct rspi_data *rspi, struct spi_message *mesg,
 
 	data = t->rx_buf;
 	while (remain > 0) {
-		rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) & ~SPCR_TXMD,
-			    RSPI_SPCR);
+		rspi_clear_txmode(rspi);
 
 		if (rspi_wait_for_interrupt(rspi, SPSR_SPTEF, SPCR_SPTIE) < 0) {
 			dev_err(&rspi->master->dev,
@@ -748,7 +786,7 @@ static int rspi_receive_dma(struct rspi_data *rspi, struct spi_transfer *t)
 	for (i = 0; i < rspi->numirq; i++)
 		disable_irq(rspi->irq[i]);
 
-	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) & ~SPCR_TXMD, RSPI_SPCR);
+	rspi_clear_txmode(rspi);
 	rspi_enable_irq(rspi, SPCR_SPTIE | SPCR_SPRIE);
 	rspi->dma_callbacked = 0;
 
diff --git a/include/linux/spi/rspi.h b/include/linux/spi/rspi.h
index 7316dd9c7ba9..0f5f612f0092 100644
--- a/include/linux/spi/rspi.h
+++ b/include/linux/spi/rspi.h
@@ -28,6 +28,7 @@ struct rspi_plat_data {
 	unsigned int dma_rx_id;
 
 	unsigned dma_width_16bit:1;	/* DMAC read/write width = 16-bit */
+	unsigned txmode:1;		/* TX only mode */
 
 	u16 num_chipselect;
 };
-- 
1.7.9.5

