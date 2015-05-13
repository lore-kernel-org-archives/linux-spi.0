From: Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v1 2/3] spi: spi-fsl-dspi: Change the way of increasing spi_message->actual_length
Date: Wed, 13 May 2015 18:12:01 +0800
Message-ID: <1431511921-19548-1-git-send-email-haikun.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In current driver, we increase actual_length in the following way:
message->actual_length += dspi_xxx_transfer()
It has two defects.
First, transmitting maybe in process when the function call finished and
we don't know the transmitting result in this moment.
Secondly, the last sentence in function before returning is accessing the
SPI register and trigger the data transmitting. If we enable interrupt,
interrupt may be generated before function return and we also have the same
sentence "message->actual_length += dspi_xxx_transfer()"
in the IRQ handler.
And usually dspi_xxx_transfer will trigger a new IRQ.
The original dspi_xxx_transfer call may return when no new IRQ generate.
This may mess the variable spi_message->actual_length.
Now we increase the variable in the IRQ handler and only when we get the
TCF or EOQ interrupt
And we get the transmitted data length from the SPI transfer counter
instead of the function return value.

Signed-off-by: Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 89 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 62 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 75c5796..f6e2ef9 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -47,6 +47,7 @@
 #define SPI_MCR_CLR_RXF	(1 << 10)
 
 #define SPI_TCR			0x08
+#define SPI_TCR_GET_TCNT(x)	(((x) & 0xffff0000) >> 16)
 
 #define SPI_CTAR(x)		(0x0c + (((x) & 0x3) * 4))
 #define SPI_CTAR_FMSZ(x)	(((x) & 0x0000000f) << 27)
@@ -104,6 +105,7 @@
 #define SPI_CS_ASSERT		0x02
 #define SPI_CS_DROP		0x04
 
+#define SPI_TCR_TCNT_MAX	0x10000
 struct chip_data {
 	u32 mcr_val;
 	u32 ctar_val;
@@ -139,6 +141,8 @@ struct fsl_dspi {
 
 	wait_queue_head_t	waitq;
 	u32			waitflags;
+
+	u32			spi_tcnt;
 };
 
 static inline int is_double_byte_mode(struct fsl_dspi *dspi)
@@ -258,7 +262,6 @@ static int dspi_eoq_write(struct fsl_dspi *dspi)
 	int tx_count = 0;
 	int tx_word;
 	u32 dspi_pushr = 0;
-	int first = 1;
 
 	tx_word = is_double_byte_mode(dspi);
 
@@ -284,11 +287,6 @@ static int dspi_eoq_write(struct fsl_dspi *dspi)
 		} else if (tx_word && (dspi->len == 1))
 			dspi_pushr |= SPI_PUSHR_EOQ;
 
-		if (first) {
-			first = 0;
-			dspi_pushr |= SPI_PUSHR_CTCNT; /* clear counter */
-		}
-
 		regmap_write(dspi->regmap, SPI_PUSHR, dspi_pushr);
 
 		tx_count++;
@@ -355,6 +353,10 @@ static int dspi_transfer_one_message(struct spi_master *master,
 	struct spi_device *spi = message->spi;
 	struct spi_transfer *transfer;
 	int status = 0;
+	u32 spi_tcr;
+
+	regmap_read(dspi->regmap, SPI_TCR, &spi_tcr);
+	dspi->spi_tcnt = SPI_TCR_GET_TCNT(spi_tcr);
 
 	message->actual_length = 0;
 
@@ -394,10 +396,10 @@ static int dspi_transfer_one_message(struct spi_master *master,
 
 		if (dspi->trans_mode == DSPI_EOQ_MODE) {
 			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_EOQFE);
-			message->actual_length += dspi_eoq_write(dspi);
+			dspi_eoq_write(dspi);
 		} else if (dspi->trans_mode == DSPI_TCFQ_MODE) {
 			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_TCFQE);
-			message->actual_length += dspi_tcfq_write(dspi);
+			dspi_tcfq_write(dspi);
 		}
 
 		if (wait_event_interruptible(dspi->waitq, dspi->waitflags))
@@ -488,29 +490,62 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 {
 	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
 	struct spi_message *msg = dspi->cur_msg;
+	u32 spi_sr, spi_tcr;
+	u32 spi_tcnt, tcnt_diff;
+	int tx_word;
 
-	if (dspi->trans_mode == DSPI_EOQ_MODE) {
-		regmap_write(dspi->regmap, SPI_SR, SPI_SR_EOQF);
-		dspi_eoq_read(dspi);
-	} else if (dspi->trans_mode == DSPI_TCFQ_MODE) {
-		regmap_write(dspi->regmap, SPI_SR, SPI_SR_TCFQF);
-		dspi_tcfq_read(dspi);
-	}
+	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
 
-	if (!dspi->len) {
-		if (dspi->dataflags & TRAN_STATE_WORD_ODD_NUM) {
-			regmap_update_bits(dspi->regmap, SPI_CTAR(dspi->cs),
-			SPI_FRAME_BITS_MASK, SPI_FRAME_BITS(16));
-			dspi->dataflags &= ~TRAN_STATE_WORD_ODD_NUM;
+	if (spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)) {
+		tx_word = is_double_byte_mode(dspi);
+
+		regmap_read(dspi->regmap, SPI_TCR, &spi_tcr);
+		spi_tcnt = SPI_TCR_GET_TCNT(spi_tcr);
+
+		/*
+		 * The width of SPI Transfer Counter in SPI_TCR is 16bits,
+		 * so the max couner is 65535. When the counter reach 65535,
+		 * it will wrap around, counter reset to zero.
+		 * spi_tcnt my be less than dspi->spi_tcnt, it means the
+		 * counter already wrapped around.
+		 * SPI Transfer Counter is a counter of transmitted frames.
+		 * The size of frame maybe two bytes.
+		 */
+		tcnt_diff = ((spi_tcnt + SPI_TCR_TCNT_MAX) - dspi->spi_tcnt)
+			% SPI_TCR_TCNT_MAX;
+		tcnt_diff *= (tx_word + 1);
+		if (dspi->dataflags & TRAN_STATE_WORD_ODD_NUM)
+			tcnt_diff--;
+
+		msg->actual_length += tcnt_diff;
+
+		dspi->spi_tcnt = spi_tcnt;
+
+		if (dspi->trans_mode == DSPI_EOQ_MODE) {
+			regmap_write(dspi->regmap, SPI_SR, SPI_SR_EOQF);
+			dspi_eoq_read(dspi);
+		} else if (dspi->trans_mode == DSPI_TCFQ_MODE) {
+			regmap_write(dspi->regmap, SPI_SR, SPI_SR_TCFQF);
+			dspi_tcfq_read(dspi);
 		}
 
-		dspi->waitflags = 1;
-		wake_up_interruptible(&dspi->waitq);
-	} else {
-		if (dspi->trans_mode == DSPI_EOQ_MODE)
-			msg->actual_length += dspi_eoq_write(dspi);
-		else if (dspi->trans_mode == DSPI_TCFQ_MODE)
-			msg->actual_length += dspi_tcfq_write(dspi);
+		if (!dspi->len) {
+			if (dspi->dataflags & TRAN_STATE_WORD_ODD_NUM) {
+				regmap_update_bits(dspi->regmap,
+						   SPI_CTAR(dspi->cs),
+						   SPI_FRAME_BITS_MASK,
+						   SPI_FRAME_BITS(16));
+				dspi->dataflags &= ~TRAN_STATE_WORD_ODD_NUM;
+			}
+
+			dspi->waitflags = 1;
+			wake_up_interruptible(&dspi->waitq);
+		} else {
+			if (dspi->trans_mode == DSPI_EOQ_MODE)
+				dspi_eoq_write(dspi);
+			else if (dspi->trans_mode == DSPI_TCFQ_MODE)
+				dspi_tcfq_write(dspi);
+		}
 	}
 	return IRQ_HANDLED;
 }
-- 
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
