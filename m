From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi-fsl-dspi: Fix CTAR Register access" to the spi tree
Date: Sat, 12 Dec 2015 23:08:11 +0000
Message-ID: <E1a7tGt-0002tt-8n@finisterre>
References: <1449726930-7378-1-git-send-email-bhuvanchandra.dv@toradex.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
	Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449726930-7378-1-git-send-email-bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi-fsl-dspi: Fix CTAR Register access

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ef22d1604c622d24ded69f40d40c3c6d83f71156 Mon Sep 17 00:00:00 2001
From: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Date: Thu, 10 Dec 2015 11:25:30 +0530
Subject: [PATCH] spi-fsl-dspi: Fix CTAR Register access

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
Acked-by: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
