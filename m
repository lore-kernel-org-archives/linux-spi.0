From: "Albert ARIBAUD (3ADEV)" <albert.aribaud-iEu9NFBzPZE@public.gmane.org>
Subject: [PATCH] spi-fsl-dspi: add slave support
Date: Mon, 26 Sep 2016 23:03:50 +0200
Message-ID: <20160926210350.17135-1-albert.aribaud@3adev.fr>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Slave support is selected by adding a 'spi-slave-mode'
property to the DSPI node in the device tree.

EOQF only works for master mode, while TCF works for
both master and slave modes, so switch all variants to
TCF.

No provision is made for switching between master and
slave modes dynamically.

Signed-off-by: Albert ARIBAUD (3ADEV) <albert.aribaud-iEu9NFBzPZE@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |   3 +-
 drivers/spi/spi-fsl-dspi.c                         | 316 ++++++++++-----------
 2 files changed, 156 insertions(+), 163 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
index ff5893d..9f73fe5 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -14,9 +14,10 @@ Required properties:
 - spi-num-chipselects : the number of the chipselect signals.
 - bus-num : the slave chip chipselect signal number.
 
-Optional property:
+Optional properties:
 - big-endian: If present the dspi device's registers are implemented
   in big endian mode.
+- spi-slave-mode: if present, controller runs in slave mode.
 
 Optional SPI slave node properties:
 - fsl,spi-cs-sck-delay: a delay in nanoseconds between activating chip
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 9e9dadb..425b068 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -39,13 +39,12 @@
 #define TRAN_STATE_TX_VOID		0x02
 #define TRAN_STATE_WORD_ODD_NUM	0x04
 
-#define DSPI_FIFO_SIZE			4
-
 #define SPI_MCR		0x00
 #define SPI_MCR_MASTER		(1 << 31)
 #define SPI_MCR_PCSIS		(0x3F << 16)
 #define SPI_MCR_CLR_TXF	(1 << 11)
 #define SPI_MCR_CLR_RXF	(1 << 10)
+#define SPI_MCR_HALT	(1 << 0)
 
 #define SPI_TCR			0x08
 #define SPI_TCR_GET_TCNT(x)	(((x) & 0xffff0000) >> 16)
@@ -66,14 +65,21 @@
 #define SPI_CTAR_SCALE_BITS	0xf
 
 #define SPI_CTAR0_SLAVE	0x0c
+#define SPI_CTAR0_SLAVE_FMSZ(x)	(((x) & 0x00000001f) << 27)
+#define SPI_CTAR0_SLAVE_CPOL(x)	((x) << 26)
+#define SPI_CTAR0_SLAVE_CPHA(x)	((x) << 25)
 
 #define SPI_SR			0x2c
+#define SPI_SR_TXRXS		0x40000000
 #define SPI_SR_EOQF		0x10000000
 #define SPI_SR_TCFQF		0x80000000
+#define SPI_SR_TFFF		0x02000000
+#define SPI_SR_RFDF		0x00020000
 
 #define SPI_RSER		0x30
 #define SPI_RSER_EOQFE		0x10000000
 #define SPI_RSER_TCFQE		0x80000000
+#define SPI_RSER_RFDFE		0x00020000
 
 #define SPI_PUSHR		0x34
 #define SPI_PUSHR_CONT		(1 << 31)
@@ -114,28 +120,19 @@ struct chip_data {
 	u16 void_write_data;
 };
 
-enum dspi_trans_mode {
-	DSPI_EOQ_MODE = 0,
-	DSPI_TCFQ_MODE,
-};
-
 struct fsl_dspi_devtype_data {
-	enum dspi_trans_mode trans_mode;
 	u8 max_clock_factor;
 };
 
 static const struct fsl_dspi_devtype_data vf610_data = {
-	.trans_mode = DSPI_EOQ_MODE,
 	.max_clock_factor = 2,
 };
 
 static const struct fsl_dspi_devtype_data ls1021a_v1_data = {
-	.trans_mode = DSPI_TCFQ_MODE,
 	.max_clock_factor = 8,
 };
 
 static const struct fsl_dspi_devtype_data ls2085a_data = {
-	.trans_mode = DSPI_TCFQ_MODE,
 	.max_clock_factor = 8,
 };
 
@@ -150,9 +147,10 @@ struct fsl_dspi {
 	struct spi_transfer	*cur_transfer;
 	struct spi_message	*cur_msg;
 	struct chip_data	*cur_chip;
-	size_t			len;
+	size_t			tx_len;
 	void			*tx;
 	void			*tx_end;
+	size_t			rx_len;
 	void			*rx;
 	void			*rx_end;
 	char			dataflags;
@@ -251,18 +249,21 @@ static u32 dspi_data_to_pushr(struct fsl_dspi *dspi, int tx_word)
 {
 	u16 d16;
 
-	if (!(dspi->dataflags & TRAN_STATE_TX_VOID))
+	if ( (dspi->tx_len) && !(dspi->dataflags & TRAN_STATE_TX_VOID) ) {
 		d16 = tx_word ? *(u16 *)dspi->tx : *(u8 *)dspi->tx;
+		dspi->tx += tx_word + 1;
+		dspi->tx_len -= tx_word + 1;
+	}
 	else
 		d16 = dspi->void_write_data;
 
-	dspi->tx += tx_word + 1;
-	dspi->len -= tx_word + 1;
-
-	return	SPI_PUSHR_TXDATA(d16) |
-		SPI_PUSHR_PCS(dspi->cs) |
-		SPI_PUSHR_CTAS(0) |
-		SPI_PUSHR_CONT;
+	if (dspi->cur_chip->mcr_val & SPI_MCR_MASTER)
+		return	SPI_PUSHR_TXDATA(d16) |
+			SPI_PUSHR_PCS(dspi->cs) |
+			SPI_PUSHR_CTAS(0) |
+			SPI_PUSHR_CONT;
+	else
+		return	SPI_PUSHR_TXDATA(d16);
 }
 
 static void dspi_data_from_popr(struct fsl_dspi *dspi, int rx_word)
@@ -273,99 +274,78 @@ static void dspi_data_from_popr(struct fsl_dspi *dspi, int rx_word)
 	regmap_read(dspi->regmap, SPI_POPR, &val);
 	d = SPI_POPR_RXDATA(val);
 
-	if (!(dspi->dataflags & TRAN_STATE_RX_VOID))
+	if ((dspi->rx_len) && !(dspi->dataflags & TRAN_STATE_RX_VOID)) {
 		rx_word ? (*(u16 *)dspi->rx = d) : (*(u8 *)dspi->rx = d);
+		dspi->rx += rx_word + 1;
+		dspi->rx_len -= rx_word + 1;
+	}
 
-	dspi->rx += rx_word + 1;
 }
 
-static int dspi_eoq_write(struct fsl_dspi *dspi)
+static int dspi_write(struct fsl_dspi *dspi)
 {
-	int tx_count = 0;
 	int tx_word;
 	u32 dspi_pushr = 0;
+	int tx_count = 0;
+	u32 spi_mcr, spi_sr;
 
 	tx_word = is_double_byte_mode(dspi);
 
-	while (dspi->len && (tx_count < DSPI_FIFO_SIZE)) {
-		/* If we are in word mode, only have a single byte to transfer
-		 * switch to byte mode temporarily.  Will switch back at the
-		 * end of the transfer.
-		 */
-		if (tx_word && (dspi->len == 1)) {
-			dspi->dataflags |= TRAN_STATE_WORD_ODD_NUM;
-			regmap_update_bits(dspi->regmap, SPI_CTAR(0),
-					SPI_FRAME_BITS_MASK, SPI_FRAME_BITS(8));
-			tx_word = 0;
-		}
+	if (tx_word && (dspi->tx_len == 1)) {
+		dspi->dataflags |= TRAN_STATE_WORD_ODD_NUM;
+		regmap_update_bits(dspi->regmap, SPI_CTAR(0),
+				SPI_FRAME_BITS_MASK, SPI_FRAME_BITS(8));
+		tx_word = 0;
+	}
+
+	regmap_read(dspi->regmap, SPI_MCR, &spi_mcr);
+	while (dspi->tx_len) {
 
 		dspi_pushr = dspi_data_to_pushr(dspi, tx_word);
 
-		if (dspi->len == 0 || tx_count == DSPI_FIFO_SIZE - 1) {
-			/* last transfer in the transfer */
-			dspi_pushr |= SPI_PUSHR_EOQ;
-			if ((dspi->cs_change) && (!dspi->len))
-				dspi_pushr &= ~SPI_PUSHR_CONT;
-		} else if (tx_word && (dspi->len == 1))
-			dspi_pushr |= SPI_PUSHR_EOQ;
+		if (spi_mcr & SPI_MCR_MASTER) {
+			if (!dspi->tx_len) {
+				dspi_pushr |= SPI_PUSHR_EOQ;
+				if (dspi->cs_change)
+					dspi_pushr &= ~SPI_PUSHR_CONT;
+			}
+			regmap_write(dspi->regmap, SPI_PUSHR, dspi_pushr);
+		}
+		else
+			regmap_write(dspi->regmap, SPI_PUSHR_SLAVE, dspi_pushr);
 
-		regmap_write(dspi->regmap, SPI_PUSHR, dspi_pushr);
+		regmap_write(dspi->regmap, SPI_SR, SPI_SR_TFFF);
+		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+		if (!(spi_sr & SPI_SR_TFFF))
+			break;
 
 		tx_count++;
 	}
 
-	return tx_count * (tx_word + 1);
+	return tx_count * (tx_word+1);
 }
 
-static int dspi_eoq_read(struct fsl_dspi *dspi)
+static int dspi_read(struct fsl_dspi *dspi)
 {
 	int rx_count = 0;
 	int rx_word = is_double_byte_mode(dspi);
+	u32 spi_sr;
 
-	while ((dspi->rx < dspi->rx_end)
-			&& (rx_count < DSPI_FIFO_SIZE)) {
-		if (rx_word && (dspi->rx_end - dspi->rx) == 1)
-			rx_word = 0;
-
-		dspi_data_from_popr(dspi, rx_word);
-		rx_count++;
-	}
+	if (rx_word && (dspi->rx_end - dspi->rx) == 1)
+		rx_word = 0;
 
-	return rx_count;
-}
+	while (dspi->rx_len) {
 
-static int dspi_tcfq_write(struct fsl_dspi *dspi)
-{
-	int tx_word;
-	u32 dspi_pushr = 0;
+		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+		if (!(spi_sr & SPI_SR_RFDF))
+			break;
 
-	tx_word = is_double_byte_mode(dspi);
+		dspi_data_from_popr(dspi, rx_word);
 
-	if (tx_word && (dspi->len == 1)) {
-		dspi->dataflags |= TRAN_STATE_WORD_ODD_NUM;
-		regmap_update_bits(dspi->regmap, SPI_CTAR(0),
-				SPI_FRAME_BITS_MASK, SPI_FRAME_BITS(8));
-		tx_word = 0;
+		rx_count++;
 	}
 
-	dspi_pushr = dspi_data_to_pushr(dspi, tx_word);
-
-	if ((dspi->cs_change) && (!dspi->len))
-		dspi_pushr &= ~SPI_PUSHR_CONT;
-
-	regmap_write(dspi->regmap, SPI_PUSHR, dspi_pushr);
-
-	return tx_word + 1;
-}
-
-static void dspi_tcfq_read(struct fsl_dspi *dspi)
-{
-	int rx_word = is_double_byte_mode(dspi);
-
-	if (rx_word && (dspi->rx_end - dspi->rx) == 1)
-		rx_word = 0;
-
-	dspi_data_from_popr(dspi, rx_word);
+	return rx_count * (rx_word+1);
 }
 
 static int dspi_transfer_one_message(struct spi_master *master,
@@ -375,8 +355,8 @@ static int dspi_transfer_one_message(struct spi_master *master,
 	struct spi_device *spi = message->spi;
 	struct spi_transfer *transfer;
 	int status = 0;
-	enum dspi_trans_mode trans_mode;
 	u32 spi_tcr;
+	u32 spi_sr;
 
 	regmap_read(dspi->regmap, SPI_TCR, &spi_tcr);
 	dspi->spi_tcnt = SPI_TCR_GET_TCNT(spi_tcr);
@@ -396,50 +376,68 @@ static int dspi_transfer_one_message(struct spi_master *master,
 
 		dspi->dataflags = 0;
 		dspi->tx = (void *)transfer->tx_buf;
+		dspi->tx_len = transfer->len;
 		dspi->tx_end = dspi->tx + transfer->len;
 		dspi->rx = transfer->rx_buf;
+		dspi->rx_len = transfer->len;
 		dspi->rx_end = dspi->rx + transfer->len;
-		dspi->len = transfer->len;
 
 		if (!dspi->rx)
 			dspi->dataflags |= TRAN_STATE_RX_VOID;
 
 		if (!dspi->tx)
 			dspi->dataflags |= TRAN_STATE_TX_VOID;
-
-		regmap_write(dspi->regmap, SPI_MCR, dspi->cur_chip->mcr_val);
+		/* stop module */
+		regmap_write(dspi->regmap, SPI_MCR,
+			dspi->cur_chip->mcr_val | SPI_MCR_HALT);
+		do
+			regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+		while (spi_sr & SPI_SR_TXRXS);
+
+		/* clear fifos */
 		regmap_update_bits(dspi->regmap, SPI_MCR,
 				SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
 				SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
-		regmap_write(dspi->regmap, SPI_CTAR(0),
-				dspi->cur_chip->ctar_val);
-
-		trans_mode = dspi->devtype_data->trans_mode;
-		switch (trans_mode) {
-		case DSPI_EOQ_MODE:
-			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_EOQFE);
-			dspi_eoq_write(dspi);
-			break;
-		case DSPI_TCFQ_MODE:
-			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_TCFQE);
-			dspi_tcfq_write(dspi);
-			break;
-		default:
-			dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
-				trans_mode);
-			status = -EINVAL;
-			goto out;
-		}
 
-		if (wait_event_interruptible(dspi->waitq, dspi->waitflags))
+		/* configure SPI */
+		if (dspi->cur_chip->mcr_val & SPI_MCR_MASTER)
+			regmap_write(dspi->regmap, SPI_CTAR(dspi->cs),
+			     dspi->cur_chip->ctar_val);
+		else
+			regmap_write(dspi->regmap, SPI_CTAR0_SLAVE,
+			     dspi->cur_chip->ctar_val);
+
+		/* enable IRQs */
+		regmap_write(dspi->regmap, SPI_RSER,
+			     SPI_RSER_TCFQE | SPI_RSER_RFDFE);
+		/* prime 'frame pump' */
+		dspi_write(dspi);
+		/* start module */
+		regmap_update_bits(dspi->regmap, SPI_MCR, SPI_MCR_HALT, 0);
+
+		/* wait for the 'pump' to empty */
+		if (wait_event_interruptible(dspi->waitq, dspi->waitflags)) {
 			dev_err(&dspi->pdev->dev, "wait transfer complete fail!\n");
+			status = -EIO;
+		}
 		dspi->waitflags = 0;
 
-		if (transfer->delay_usecs)
-			udelay(transfer->delay_usecs);
+		/* stop module */
+		regmap_write(dspi->regmap, SPI_MCR,
+			dspi->cur_chip->mcr_val | SPI_MCR_HALT);
+		do
+			regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+		while (spi_sr & SPI_SR_TXRXS);
+
+		/* disable IRQs */
+		regmap_update_bits(dspi->regmap, SPI_RSER,
+				   SPI_RSER_TCFQE | SPI_RSER_RFDFE,
+				   0);
+		/* wait if required */
+		if ((transfer->delay_usecs) && (status >= 0))
+				udelay(transfer->delay_usecs);
 	}
 
-out:
 	message->status = status;
 	spi_finalize_current_message(master);
 
@@ -476,8 +474,9 @@ static int dspi_setup(struct spi_device *spi)
 	of_property_read_u32(spi->dev.of_node, "fsl,spi-sck-cs-delay",
 			&sck_cs_delay);
 
-	chip->mcr_val = SPI_MCR_MASTER | SPI_MCR_PCSIS |
-		SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF;
+	chip->mcr_val = SPI_MCR_PCSIS | SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF;
+	if (!of_property_read_bool(spi->dev.of_node, "spi-slave-mode"))
+		chip->mcr_val |= SPI_MCR_MASTER;
 
 	chip->void_write_data = 0;
 
@@ -490,16 +489,22 @@ static int dspi_setup(struct spi_device *spi)
 	/* Set After SCK delay scale values */
 	ns_delay_scale(&pasc, &asc, sck_cs_delay, clkrate);
 
-	chip->ctar_val =  SPI_CTAR_FMSZ(fmsz)
-		| SPI_CTAR_CPOL(spi->mode & SPI_CPOL ? 1 : 0)
-		| SPI_CTAR_CPHA(spi->mode & SPI_CPHA ? 1 : 0)
-		| SPI_CTAR_LSBFE(spi->mode & SPI_LSB_FIRST ? 1 : 0)
-		| SPI_CTAR_PCSSCK(pcssck)
-		| SPI_CTAR_CSSCK(cssck)
-		| SPI_CTAR_PASC(pasc)
-		| SPI_CTAR_ASC(asc)
-		| SPI_CTAR_PBR(pbr)
-		| SPI_CTAR_BR(br);
+	if (chip->mcr_val & SPI_MCR_MASTER)
+		chip->ctar_val =  SPI_CTAR_FMSZ(fmsz)
+			| SPI_CTAR_CPOL(spi->mode & SPI_CPOL ? 1 : 0)
+			| SPI_CTAR_CPHA(spi->mode & SPI_CPHA ? 1 : 0)
+			| SPI_CTAR_LSBFE(spi->mode & SPI_LSB_FIRST ? 1 : 0)
+			| SPI_CTAR_PCSSCK(pcssck)
+			| SPI_CTAR_CSSCK(cssck)
+			| SPI_CTAR_PASC(pasc)
+			| SPI_CTAR_ASC(asc)
+			| SPI_CTAR_PBR(pbr)
+			| SPI_CTAR_BR(br);
+	else
+		chip->ctar_val =  SPI_CTAR0_SLAVE_FMSZ(fmsz)
+			| SPI_CTAR0_SLAVE_CPOL(spi->mode & SPI_CPOL ? 1 : 0)
+			| SPI_CTAR0_SLAVE_CPHA(spi->mode & SPI_CPHA ? 1 : 0)
+			;
 
 	spi_set_ctldata(spi, chip);
 
@@ -520,16 +525,21 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 {
 	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
 	struct spi_message *msg = dspi->cur_msg;
-	enum dspi_trans_mode trans_mode;
 	u32 spi_sr, spi_tcr;
 	u32 spi_tcnt, tcnt_diff;
 	int tx_word;
 
 	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
-	regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
+	/* a transfer happened. Read incoming data and write next one */
+	dspi_write(dspi);
+	dspi_read(dspi);
+
+	/* If a frame was shifted out, update the counter */
+	if (spi_sr & SPI_SR_TCFQF) {
+
+		regmap_write(dspi->regmap, SPI_SR, SPI_SR_TCFQF);
 
-	if (spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)) {
 		tx_word = is_double_byte_mode(dspi);
 
 		regmap_read(dspi->regmap, SPI_TCR, &spi_tcr);
@@ -552,22 +562,15 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 		msg->actual_length += tcnt_diff;
 
 		dspi->spi_tcnt = spi_tcnt;
+	}
 
-		trans_mode = dspi->devtype_data->trans_mode;
-		switch (trans_mode) {
-		case DSPI_EOQ_MODE:
-			dspi_eoq_read(dspi);
-			break;
-		case DSPI_TCFQ_MODE:
-			dspi_tcfq_read(dspi);
-			break;
-		default:
-			dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
-				trans_mode);
-				return IRQ_HANDLED;
-		}
+	/* If EOQ or all was sent and received then wake up */
+	if ((spi_sr & SPI_SR_EOQF) || ((!dspi->tx_len) && (!dspi->rx_len))) {
 
-		if (!dspi->len) {
+		regmap_write(dspi->regmap, SPI_SR, SPI_SR_EOQF);
+
+		if ((!dspi->tx_len) && (!dspi->rx_len)) {
+			/* reset 'half-word' state if set */
 			if (dspi->dataflags & TRAN_STATE_WORD_ODD_NUM) {
 				regmap_update_bits(dspi->regmap,
 						   SPI_CTAR(0),
@@ -575,22 +578,9 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 						   SPI_FRAME_BITS(16));
 				dspi->dataflags &= ~TRAN_STATE_WORD_ODD_NUM;
 			}
-
+			/* wake driver up */
 			dspi->waitflags = 1;
 			wake_up_interruptible(&dspi->waitq);
-		} else {
-			switch (trans_mode) {
-			case DSPI_EOQ_MODE:
-				dspi_eoq_write(dspi);
-				break;
-			case DSPI_TCFQ_MODE:
-				dspi_tcfq_write(dspi);
-				break;
-			default:
-				dev_err(&dspi->pdev->dev,
-					"unsupported trans_mode %u\n",
-					trans_mode);
-			}
 		}
 	}
 
@@ -598,9 +588,9 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 }
 
 static const struct of_device_id fsl_dspi_dt_ids[] = {
+	{ .compatible = "fsl,vf610-dspi-slave", .data = (void *)&vf610_data, },
 	{ .compatible = "fsl,vf610-dspi", .data = (void *)&vf610_data, },
-	{ .compatible = "fsl,ls1021a-v1.0-dspi",
-		.data = (void *)&ls1021a_v1_data, },
+	{ .compatible = "fsl,ls1021a-v1.0-dspi", .data = (void *)&ls1021a_v1_data, },
 	{ .compatible = "fsl,ls2085a-dspi", .data = (void *)&ls2085a_data, },
 	{ /* sentinel */ }
 };
@@ -679,13 +669,6 @@ static int dspi_probe(struct platform_device *pdev)
 	}
 	master->num_chipselect = cs_num;
 
-	ret = of_property_read_u32(np, "bus-num", &bus_num);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "can't get bus-num\n");
-		goto out_master_put;
-	}
-	master->bus_num = bus_num;
-
 	dspi->devtype_data = (struct fsl_dspi_devtype_data *)of_id->data;
 	if (!dspi->devtype_data) {
 		dev_err(&pdev->dev, "can't get devtype_data\n");
@@ -693,6 +676,13 @@ static int dspi_probe(struct platform_device *pdev)
 		goto out_master_put;
 	}
 
+	ret = of_property_read_u32(np, "bus-num", &bus_num);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "can't get bus-num\n");
+		goto out_master_put;
+	}
+	master->bus_num = bus_num;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base)) {
@@ -742,6 +732,8 @@ static int dspi_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
+	dev_info(&pdev->dev, "registered DSPI controller\n");
+
 	return ret;
 
 out_clk_put:
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
