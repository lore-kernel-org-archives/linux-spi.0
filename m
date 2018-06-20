From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: [PATCH 02/12] spi: spi-fsl-dspi: Drop unneeded use of dataflags bits
Date: Wed, 20 Jun 2018 09:34:32 +0200
Message-ID: <20180620073442.20913-3-esben.haabendal@gmail.com>
References: <20180620073442.20913-1-esben.haabendal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620073442.20913-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Esben Haabendal <eha@deif.com>

Checking directly against pointer value should be at least as fast as doing
bitmasking and compare, so let's keep it simple.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>
---
 drivers/spi/spi-fsl-dspi.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 3ca9b9608801..3bf135bf8b93 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -38,8 +38,6 @@
 
 #define DRIVER_NAME "fsl-dspi"
 
-#define TRAN_STATE_RX_VOID		0x01
-#define TRAN_STATE_TX_VOID		0x02
 #define TRAN_STATE_WORD_ODD_NUM	0x04
 
 #define DSPI_FIFO_SIZE			4
@@ -232,7 +230,7 @@ static void dspi_rx_dma_callback(void *arg)
 
 	rx_word = is_double_byte_mode(dspi);
 
-	if (!(dspi->dataflags & TRAN_STATE_RX_VOID)) {
+	if (dspi->rx) {
 		for (i = 0; i < dma->curr_xfer_len; i++) {
 			d = dspi->dma->rx_dma_buf[i];
 			rx_word ? (*(u16 *)dspi->rx = d) :
@@ -538,12 +536,13 @@ static u32 dspi_data_to_pushr(struct fsl_dspi *dspi, int tx_word)
 {
 	u16 d16;
 
-	if (!(dspi->dataflags & TRAN_STATE_TX_VOID))
+	if (dspi->tx) {
 		d16 = tx_word ? *(u16 *)dspi->tx : *(u8 *)dspi->tx;
-	else
+		dspi->tx += tx_word + 1;
+	} else {
 		d16 = dspi->void_write_data;
+	}
 
-	dspi->tx += tx_word + 1;
 	dspi->len -= tx_word + 1;
 
 	return	SPI_PUSHR_TXDATA(d16) |
@@ -560,10 +559,10 @@ static void dspi_data_from_popr(struct fsl_dspi *dspi, int rx_word)
 	regmap_read(dspi->regmap, SPI_POPR, &val);
 	d = SPI_POPR_RXDATA(val);
 
-	if (!(dspi->dataflags & TRAN_STATE_RX_VOID))
+	if (dspi->rx) {
 		rx_word ? (*(u16 *)dspi->rx = d) : (*(u8 *)dspi->rx = d);
-
-	dspi->rx += rx_word + 1;
+		dspi->rx += rx_word + 1;
+	}
 }
 
 static int dspi_eoq_write(struct fsl_dspi *dspi)
@@ -687,12 +686,6 @@ static int dspi_transfer_one_message(struct spi_master *master,
 		dspi->rx_end = dspi->rx + transfer->len;
 		dspi->len = transfer->len;
 
-		if (!dspi->rx)
-			dspi->dataflags |= TRAN_STATE_RX_VOID;
-
-		if (!dspi->tx)
-			dspi->dataflags |= TRAN_STATE_TX_VOID;
-
 		regmap_write(dspi->regmap, SPI_MCR, dspi->cur_chip->mcr_val);
 		regmap_update_bits(dspi->regmap, SPI_MCR,
 				SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
-- 
2.17.1
