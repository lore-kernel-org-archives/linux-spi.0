From: Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v2 1/3] spi: spi-fsl-dspi: Enable TCF interrupt mode support
Date: Wed, 13 May 2015 18:11:51 +0800
Message-ID: <1431511911-19376-1-git-send-email-haikun.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

DSPI module has two optional interrupts when complete data transfer.
One is EOQ interrupt, the other one is TCF interrupt.
EOQ indicates a queue of data frame has been transmitted.
TCF indicates a frame has been transmitted.
This patch enable support TCF mode.
User can configure expected mode in dts node.

Signed-off-by: Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---

Changes in v2:
- Remove global variable g_actual_length
- Add "dspi->dataflags &= ~TRAN_STATE_WORD_ODD_NUM" 
  if dataflags has TRAN_STATE_WORD_ODD_NUM in IRQ handler
- Move single byte chacking inside while loop in function dspi_eoq_write 

Changes in v1: None
 drivers/spi/spi-fsl-dspi.c | 191 +++++++++++++++++++++++++++------------------
 1 file changed, 117 insertions(+), 74 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 5fe54cd..75c5796 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -67,9 +67,11 @@
 
 #define SPI_SR			0x2c
 #define SPI_SR_EOQF		0x10000000
+#define SPI_SR_TCFQF		0x80000000
 
 #define SPI_RSER		0x30
 #define SPI_RSER_EOQFE		0x10000000
+#define SPI_RSER_TCFQE		0x80000000
 
 #define SPI_PUSHR		0x34
 #define SPI_PUSHR_CONT		(1 << 31)
@@ -108,6 +110,11 @@ struct chip_data {
 	u16 void_write_data;
 };
 
+enum dspi_trans_mode {
+	DSPI_EOQ_MODE = 0,
+	DSPI_TCFQ_MODE,
+};
+
 struct fsl_dspi {
 	struct spi_master	*master;
 	struct platform_device	*pdev;
@@ -128,6 +135,7 @@ struct fsl_dspi {
 	u8			cs;
 	u16			void_write_data;
 	u32			cs_change;
+	enum dspi_trans_mode	trans_mode;
 
 	wait_queue_head_t	waitq;
 	u32			waitflags;
@@ -213,63 +221,61 @@ static void ns_delay_scale(char *psc, char *sc, int delay_ns,
 	}
 }
 
-static int dspi_transfer_write(struct fsl_dspi *dspi)
+static u32 dspi_data_to_pushr(struct fsl_dspi *dspi, int tx_word)
 {
-	int tx_count = 0;
-	int tx_word;
 	u16 d16;
-	u8  d8;
-	u32 dspi_pushr = 0;
-	int first = 1;
 
-	tx_word = is_double_byte_mode(dspi);
+	if (!(dspi->dataflags & TRAN_STATE_TX_VOID))
+		d16 = tx_word ? *(u16 *)dspi->tx : *(u8 *)dspi->tx;
+	else
+		d16 = dspi->void_write_data;
 
-	/* If we are in word mode, but only have a single byte to transfer
-	 * then switch to byte mode temporarily.  Will switch back at the
-	 * end of the transfer.
-	 */
-	if (tx_word && (dspi->len == 1)) {
-		dspi->dataflags |= TRAN_STATE_WORD_ODD_NUM;
-		regmap_update_bits(dspi->regmap, SPI_CTAR(dspi->cs),
-				SPI_FRAME_BITS_MASK, SPI_FRAME_BITS(8));
-		tx_word = 0;
-	}
+	dspi->tx += tx_word + 1;
+	dspi->len -= tx_word + 1;
 
-	while (dspi->len && (tx_count < DSPI_FIFO_SIZE)) {
-		if (tx_word) {
-			if (dspi->len == 1)
-				break;
+	return	SPI_PUSHR_TXDATA(d16) |
+		SPI_PUSHR_PCS(dspi->cs) |
+		SPI_PUSHR_CTAS(dspi->cs) |
+		SPI_PUSHR_CONT;
+}
 
-			if (!(dspi->dataflags & TRAN_STATE_TX_VOID)) {
-				d16 = *(u16 *)dspi->tx;
-				dspi->tx += 2;
-			} else {
-				d16 = dspi->void_write_data;
-			}
+static void dspi_data_from_popr(struct fsl_dspi *dspi, int rx_word)
+{
+	u16 d;
+	unsigned int val;
 
-			dspi_pushr = SPI_PUSHR_TXDATA(d16) |
-				SPI_PUSHR_PCS(dspi->cs) |
-				SPI_PUSHR_CTAS(dspi->cs) |
-				SPI_PUSHR_CONT;
+	regmap_read(dspi->regmap, SPI_POPR, &val);
+	d = SPI_POPR_RXDATA(val);
 
-			dspi->len -= 2;
-		} else {
-			if (!(dspi->dataflags & TRAN_STATE_TX_VOID)) {
+	if (!(dspi->dataflags & TRAN_STATE_RX_VOID))
+		rx_word ? (*(u16 *)dspi->rx = d) : (*(u8 *)dspi->rx = d);
 
-				d8 = *(u8 *)dspi->tx;
-				dspi->tx++;
-			} else {
-				d8 = (u8)dspi->void_write_data;
-			}
+	dspi->rx += rx_word + 1;
+}
 
-			dspi_pushr = SPI_PUSHR_TXDATA(d8) |
-				SPI_PUSHR_PCS(dspi->cs) |
-				SPI_PUSHR_CTAS(dspi->cs) |
-				SPI_PUSHR_CONT;
+static int dspi_eoq_write(struct fsl_dspi *dspi)
+{
+	int tx_count = 0;
+	int tx_word;
+	u32 dspi_pushr = 0;
+	int first = 1;
+
+	tx_word = is_double_byte_mode(dspi);
 
-			dspi->len--;
+	while (dspi->len && (tx_count < DSPI_FIFO_SIZE)) {
+		/* If we are in word mode, only have a single byte to transfer
+		 * switch to byte mode temporarily.  Will switch back at the
+		 * end of the transfer.
+		 */
+		if (tx_word && (dspi->len == 1)) {
+			dspi->dataflags |= TRAN_STATE_WORD_ODD_NUM;
+			regmap_update_bits(dspi->regmap, SPI_CTAR(dspi->cs),
+					SPI_FRAME_BITS_MASK, SPI_FRAME_BITS(8));
+			tx_word = 0;
 		}
 
+		dspi_pushr = dspi_data_to_pushr(dspi, tx_word);
+
 		if (dspi->len == 0 || tx_count == DSPI_FIFO_SIZE - 1) {
 			/* last transfer in the transfer */
 			dspi_pushr |= SPI_PUSHR_EOQ;
@@ -291,40 +297,55 @@ static int dspi_transfer_write(struct fsl_dspi *dspi)
 	return tx_count * (tx_word + 1);
 }
 
-static int dspi_transfer_read(struct fsl_dspi *dspi)
+static int dspi_eoq_read(struct fsl_dspi *dspi)
 {
 	int rx_count = 0;
 	int rx_word = is_double_byte_mode(dspi);
-	u16 d;
 
 	while ((dspi->rx < dspi->rx_end)
 			&& (rx_count < DSPI_FIFO_SIZE)) {
-		if (rx_word) {
-			unsigned int val;
+		if (rx_word && (dspi->rx_end - dspi->rx) == 1)
+			rx_word = 0;
 
-			if ((dspi->rx_end - dspi->rx) == 1)
-				break;
+		dspi_data_from_popr(dspi, rx_word);
+		rx_count++;
+	}
 
-			regmap_read(dspi->regmap, SPI_POPR, &val);
-			d = SPI_POPR_RXDATA(val);
+	return rx_count;
+}
 
-			if (!(dspi->dataflags & TRAN_STATE_RX_VOID))
-				*(u16 *)dspi->rx = d;
-			dspi->rx += 2;
+static int dspi_tcfq_write(struct fsl_dspi *dspi)
+{
+	int tx_word;
+	u32 dspi_pushr = 0;
 
-		} else {
-			unsigned int val;
+	tx_word = is_double_byte_mode(dspi);
 
-			regmap_read(dspi->regmap, SPI_POPR, &val);
-			d = SPI_POPR_RXDATA(val);
-			if (!(dspi->dataflags & TRAN_STATE_RX_VOID))
-				*(u8 *)dspi->rx = d;
-			dspi->rx++;
-		}
-		rx_count++;
+	if (tx_word && (dspi->len == 1)) {
+		dspi->dataflags |= TRAN_STATE_WORD_ODD_NUM;
+		regmap_update_bits(dspi->regmap, SPI_CTAR(dspi->cs),
+				SPI_FRAME_BITS_MASK, SPI_FRAME_BITS(8));
+		tx_word = 0;
 	}
 
-	return rx_count;
+	dspi_pushr = dspi_data_to_pushr(dspi, tx_word);
+
+	if ((dspi->cs_change) && (!dspi->len))
+		dspi_pushr &= ~SPI_PUSHR_CONT;
+
+	regmap_write(dspi->regmap, SPI_PUSHR, dspi_pushr);
+
+	return tx_word + 1;
+}
+
+static void dspi_tcfq_read(struct fsl_dspi *dspi)
+{
+	int rx_word = is_double_byte_mode(dspi);
+
+	if (rx_word && (dspi->rx_end - dspi->rx) == 1)
+		rx_word = 0;
+
+	dspi_data_from_popr(dspi, rx_word);
 }
 
 static int dspi_transfer_one_message(struct spi_master *master,
@@ -334,6 +355,7 @@ static int dspi_transfer_one_message(struct spi_master *master,
 	struct spi_device *spi = message->spi;
 	struct spi_transfer *transfer;
 	int status = 0;
+
 	message->actual_length = 0;
 
 	list_for_each_entry(transfer, &message->transfers, transfer_list) {
@@ -370,8 +392,13 @@ static int dspi_transfer_one_message(struct spi_master *master,
 			regmap_write(dspi->regmap, SPI_CTAR(dspi->cs),
 					dspi->cur_chip->ctar_val);
 
-		regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_EOQFE);
-		message->actual_length += dspi_transfer_write(dspi);
+		if (dspi->trans_mode == DSPI_EOQ_MODE) {
+			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_EOQFE);
+			message->actual_length += dspi_eoq_write(dspi);
+		} else if (dspi->trans_mode == DSPI_TCFQ_MODE) {
+			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_TCFQE);
+			message->actual_length += dspi_tcfq_write(dspi);
+		}
 
 		if (wait_event_interruptible(dspi->waitq, dspi->waitflags))
 			dev_err(&dspi->pdev->dev, "wait transfer complete fail!\n");
@@ -460,22 +487,31 @@ static void dspi_cleanup(struct spi_device *spi)
 static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 {
 	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
-
 	struct spi_message *msg = dspi->cur_msg;
 
-	regmap_write(dspi->regmap, SPI_SR, SPI_SR_EOQF);
-	dspi_transfer_read(dspi);
+	if (dspi->trans_mode == DSPI_EOQ_MODE) {
+		regmap_write(dspi->regmap, SPI_SR, SPI_SR_EOQF);
+		dspi_eoq_read(dspi);
+	} else if (dspi->trans_mode == DSPI_TCFQ_MODE) {
+		regmap_write(dspi->regmap, SPI_SR, SPI_SR_TCFQF);
+		dspi_tcfq_read(dspi);
+	}
 
 	if (!dspi->len) {
-		if (dspi->dataflags & TRAN_STATE_WORD_ODD_NUM)
+		if (dspi->dataflags & TRAN_STATE_WORD_ODD_NUM) {
 			regmap_update_bits(dspi->regmap, SPI_CTAR(dspi->cs),
 			SPI_FRAME_BITS_MASK, SPI_FRAME_BITS(16));
+			dspi->dataflags &= ~TRAN_STATE_WORD_ODD_NUM;
+		}
 
 		dspi->waitflags = 1;
 		wake_up_interruptible(&dspi->waitq);
-	} else
-		msg->actual_length += dspi_transfer_write(dspi);
-
+	} else {
+		if (dspi->trans_mode == DSPI_EOQ_MODE)
+			msg->actual_length += dspi_eoq_write(dspi);
+		else if (dspi->trans_mode == DSPI_TCFQ_MODE)
+			msg->actual_length += dspi_tcfq_write(dspi);
+	}
 	return IRQ_HANDLED;
 }
 
@@ -559,6 +595,13 @@ static int dspi_probe(struct platform_device *pdev)
 	}
 	master->bus_num = bus_num;
 
+	if (of_property_read_bool(np, "eoq-mode"))
+		dspi->trans_mode = DSPI_EOQ_MODE;
+	else if (of_property_read_bool(np, "tcfq-mode"))
+		dspi->trans_mode = DSPI_TCFQ_MODE;
+	else
+		dspi->trans_mode = DSPI_TCFQ_MODE;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base)) {
-- 
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
