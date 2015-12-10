From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH v2] spi-fsl-dspi: Fix CTAR Register access
Date: Thu, 10 Dec 2015 11:25:30 +0530
Message-ID: <1449726930-7378-1-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <stefan@agner.ch>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
To: <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

DSPI instances in Vybrid have a different amount of chip selects
and CTARs (Clock and transfer Attributes Register). In case of
DSPI1 we only have 2 CTAR registers and 4 CS. In present driver
implementation CTAR offset is derived from CS instance which will
lead to out of bound access if chip select instance is greater than
CTAR register instance, hence use single CTAR0 register for all CS
instances. Since we write the CTAR register anyway before each access,
there is no value in using the additional CTAR registers. Also one
should not program a value in CTAS for a CTAR register that is not
present, hence configure CTAS to use CTAR0.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 drivers/spi/spi-fsl-dspi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 59a1143..39412c9 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -167,7 +167,7 @@ static inline int is_double_byte_mode(struct fsl_dspi *dspi)
 {
 	unsigned int val;
 
-	regmap_read(dspi->regmap, SPI_CTAR(dspi->cs), &val);
+	regmap_read(dspi->regmap, SPI_CTAR(0), &val);
 
 	return ((val & SPI_FRAME_BITS_MASK) == SPI_FRAME_BITS(8)) ? 0 : 1;
 }
@@ -257,7 +257,7 @@ static u32 dspi_data_to_pushr(struct fsl_dspi *dspi, int tx_word)
 
 	return	SPI_PUSHR_TXDATA(d16) |
 		SPI_PUSHR_PCS(dspi->cs) |
-		SPI_PUSHR_CTAS(dspi->cs) |
+		SPI_PUSHR_CTAS(0) |
 		SPI_PUSHR_CONT;
 }
 
@@ -290,7 +290,7 @@ static int dspi_eoq_write(struct fsl_dspi *dspi)
 		 */
 		if (tx_word && (dspi->len == 1)) {
 			dspi->dataflags |= TRAN_STATE_WORD_ODD_NUM;
-			regmap_update_bits(dspi->regmap, SPI_CTAR(dspi->cs),
+			regmap_update_bits(dspi->regmap, SPI_CTAR(0),
 					SPI_FRAME_BITS_MASK, SPI_FRAME_BITS(8));
 			tx_word = 0;
 		}
@@ -339,7 +339,7 @@ static int dspi_tcfq_write(struct fsl_dspi *dspi)
 
 	if (tx_word && (dspi->len == 1)) {
 		dspi->dataflags |= TRAN_STATE_WORD_ODD_NUM;
-		regmap_update_bits(dspi->regmap, SPI_CTAR(dspi->cs),
+		regmap_update_bits(dspi->regmap, SPI_CTAR(0),
 				SPI_FRAME_BITS_MASK, SPI_FRAME_BITS(8));
 		tx_word = 0;
 	}
@@ -407,7 +407,7 @@ static int dspi_transfer_one_message(struct spi_master *master,
 		regmap_update_bits(dspi->regmap, SPI_MCR,
 				SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
 				SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
-		regmap_write(dspi->regmap, SPI_CTAR(dspi->cs),
+		regmap_write(dspi->regmap, SPI_CTAR(0),
 				dspi->cur_chip->ctar_val);
 
 		trans_mode = dspi->devtype_data->trans_mode;
@@ -566,7 +566,7 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 		if (!dspi->len) {
 			if (dspi->dataflags & TRAN_STATE_WORD_ODD_NUM) {
 				regmap_update_bits(dspi->regmap,
-						   SPI_CTAR(dspi->cs),
+						   SPI_CTAR(0),
 						   SPI_FRAME_BITS_MASK,
 						   SPI_FRAME_BITS(16));
 				dspi->dataflags &= ~TRAN_STATE_WORD_ODD_NUM;
-- 
2.6.2
