From: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] spi-fsl-dspi: Fix CTAR Register access
Date: Wed, 9 Dec 2015 11:51:39 +0530
Message-ID: <1449642099-13045-1-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <stefan-XLVq0VzYD2Y@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

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

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 01fa95b..b21c3c0 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -138,7 +138,7 @@ static inline int is_double_byte_mode(struct fsl_dspi *dspi)
 {
 	unsigned int val;
 
-	regmap_read(dspi->regmap, SPI_CTAR(dspi->cs), &val);
+	regmap_read(dspi->regmap, SPI_CTAR(0), &val);
 
 	return ((val & SPI_FRAME_BITS_MASK) == SPI_FRAME_BITS(8)) ? 0 : 1;
 }
@@ -231,7 +231,7 @@ static int dspi_transfer_write(struct fsl_dspi *dspi)
 	 */
 	if (tx_word && (dspi->len == 1)) {
 		dspi->dataflags |= TRAN_STATE_WORD_ODD_NUM;
-		regmap_update_bits(dspi->regmap, SPI_CTAR(dspi->cs),
+		regmap_update_bits(dspi->regmap, SPI_CTAR(0),
 				SPI_FRAME_BITS_MASK, SPI_FRAME_BITS(8));
 		tx_word = 0;
 	}
@@ -250,7 +250,7 @@ static int dspi_transfer_write(struct fsl_dspi *dspi)
 
 			dspi_pushr = SPI_PUSHR_TXDATA(d16) |
 				SPI_PUSHR_PCS(dspi->cs) |
-				SPI_PUSHR_CTAS(dspi->cs) |
+				SPI_PUSHR_CTAS(0) |
 				SPI_PUSHR_CONT;
 
 			dspi->len -= 2;
@@ -265,7 +265,7 @@ static int dspi_transfer_write(struct fsl_dspi *dspi)
 
 			dspi_pushr = SPI_PUSHR_TXDATA(d8) |
 				SPI_PUSHR_PCS(dspi->cs) |
-				SPI_PUSHR_CTAS(dspi->cs) |
+				SPI_PUSHR_CTAS(0) |
 				SPI_PUSHR_CONT;
 
 			dspi->len--;
@@ -365,10 +365,10 @@ static int dspi_transfer_one_message(struct spi_master *master,
 		regmap_update_bits(dspi->regmap, SPI_MCR,
 				SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
 				SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
-		regmap_write(dspi->regmap, SPI_CTAR(dspi->cs),
+		regmap_write(dspi->regmap, SPI_CTAR(0),
 				dspi->cur_chip->ctar_val);
 		if (transfer->speed_hz)
-			regmap_write(dspi->regmap, SPI_CTAR(dspi->cs),
+			regmap_write(dspi->regmap, SPI_CTAR(0),
 					dspi->cur_chip->ctar_val);
 
 		regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_EOQFE);
@@ -469,7 +469,7 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 
 	if (!dspi->len) {
 		if (dspi->dataflags & TRAN_STATE_WORD_ODD_NUM)
-			regmap_update_bits(dspi->regmap, SPI_CTAR(dspi->cs),
+			regmap_update_bits(dspi->regmap, SPI_CTAR(0),
 			SPI_FRAME_BITS_MASK, SPI_FRAME_BITS(16));
 
 		dspi->waitflags = 1;
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
