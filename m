From: Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH spi for-5.4 3/5] spi: spi-fsl-dspi: Use poll mode in case the platform IRQ is missing
Date: Sun, 18 Aug 2019 21:25:58 +0300
Message-ID: <20190818182600.3047-4-olteanv@gmail.com>
References: <20190818182600.3047-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, netdev@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
To: broonie@kernel.org, h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190818182600.3047-1-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On platforms like LS1021A which use TCFQ mode, an interrupt needs to be
processed after each byte is TXed/RXed. I tried to make the DSPI
implementation on this SoC operate in other, more efficient modes (EOQ,
DMA) but it looks like it simply isn't possible.

Therefore allow the driver to operate in poll mode, to ease a bit of
this absurd amount of IRQ load generated in TCFQ mode. Doing so reduces
both the net time it takes to transmit a SPI message, as well as the
inter-frame jitter that occurs while doing so.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 81 ++++++++++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 238bbe172b79..4daf8c3d07b7 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -647,15 +647,11 @@ static void dspi_eoq_read(struct fsl_dspi *dspi)
 		dspi_push_rx(dspi, fifo_read(dspi));
 }
 
-static irqreturn_t dspi_interrupt(int irq, void *dev_id)
+static int dspi_rxtx(struct fsl_dspi *dspi)
 {
-	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
 	struct spi_message *msg = dspi->cur_msg;
-	u32 spi_sr, spi_tcr;
 	u16 spi_tcnt;
-
-	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
-	regmap_write(dspi->regmap, SPI_SR, spi_sr);
+	u32 spi_tcr;
 
 	/* Get transfer counter (in number of SPI transfers). It was
 	 * reset to 0 when transfer(s) were started.
@@ -670,17 +666,52 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	else
 		dspi_tcfq_read(dspi);
 
-	if (!dspi->len) {
-		dspi->waitflags = 1;
-		wake_up_interruptible(&dspi->waitq);
-		return IRQ_HANDLED;
-	}
+	if (!dspi->len)
+		/* Success! */
+		return 0;
 
 	if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
 		dspi_eoq_write(dspi);
 	else
 		dspi_tcfq_write(dspi);
 
+	return -EINPROGRESS;
+}
+
+static int dspi_poll(struct fsl_dspi *dspi)
+{
+	int tries = 1000;
+	u32 spi_sr;
+
+	do {
+		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+		regmap_write(dspi->regmap, SPI_SR, spi_sr);
+
+		if (spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF))
+			break;
+	} while (--tries);
+
+	if (!tries)
+		return -ETIMEDOUT;
+
+	return dspi_rxtx(dspi);
+}
+
+static irqreturn_t dspi_interrupt(int irq, void *dev_id)
+{
+	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
+	u32 spi_sr;
+
+	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+	regmap_write(dspi->regmap, SPI_SR, spi_sr);
+
+	dspi_rxtx(dspi);
+
+	if (!dspi->len) {
+		dspi->waitflags = 1;
+		wake_up_interruptible(&dspi->waitq);
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -768,13 +799,18 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			goto out;
 		}
 
-		if (trans_mode != DSPI_DMA_MODE) {
-			if (wait_event_interruptible(dspi->waitq,
-						     dspi->waitflags))
-				dev_err(&dspi->pdev->dev,
-					"wait transfer complete fail!\n");
+		if (!dspi->irq) {
+			do {
+				status = dspi_poll(dspi);
+			} while (status == -EINPROGRESS);
+		} else if (trans_mode != DSPI_DMA_MODE) {
+			status = wait_event_interruptible(dspi->waitq,
+							  dspi->waitflags);
 			dspi->waitflags = 0;
 		}
+		if (status)
+			dev_err(&dspi->pdev->dev,
+				"Waiting for transfer to complete failed!\n");
 
 		if (transfer->delay_usecs)
 			udelay(transfer->delay_usecs);
@@ -1074,10 +1110,13 @@ static int dspi_probe(struct platform_device *pdev)
 		goto out_ctlr_put;
 
 	dspi_init(dspi);
+
 	dspi->irq = platform_get_irq(pdev, 0);
-	if (dspi->irq < 0) {
-		ret = dspi->irq;
-		goto out_clk_put;
+	if (dspi->irq <= 0) {
+		dev_info(&pdev->dev,
+			 "can't get platform irq, using poll mode\n");
+		dspi->irq = 0;
+		goto poll_mode;
 	}
 
 	ret = devm_request_irq(&pdev->dev, dspi->irq, dspi_interrupt,
@@ -1087,6 +1126,9 @@ static int dspi_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
+	init_waitqueue_head(&dspi->waitq);
+
+poll_mode:
 	if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
 		ret = dspi_request_dma(dspi, res->start);
 		if (ret < 0) {
@@ -1098,7 +1140,6 @@ static int dspi_probe(struct platform_device *pdev)
 	ctlr->max_speed_hz =
 		clk_get_rate(dspi->clk) / dspi->devtype_data->max_clock_factor;
 
-	init_waitqueue_head(&dspi->waitq);
 	platform_set_drvdata(pdev, ctlr);
 
 	ret = spi_register_controller(ctlr);
-- 
2.17.1
