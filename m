From: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: [PATCH 6/7] spi: spi-ep93xx: remove private data 'current_msg'
Date: Thu, 16 Feb 2017 16:48:50 -0700
Message-ID: <20170216234851.97938-7-hsweeten@visionengravers.com>
References: <20170216234851.97938-1-hsweeten@visionengravers.com>
Cc: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170216234851.97938-1-hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The currently in-flight message can be found from the spi master.
Use that instead and remove the private data pointer.

Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
---
 drivers/spi/spi-ep93xx.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index f276dde..dd37626 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -74,7 +74,6 @@
  * @mmio: pointer to ioremap()'d registers
  * @sspdr_phys: physical address of the SSPDR register
  * @wait: wait here until given transfer is completed
- * @current_msg: message that is currently processed (or %NULL if none)
  * @tx: current byte in transfer to transmit
  * @rx: current byte in transfer to receive
  * @fifo_level: how full is FIFO (%0..%SPI_FIFO_SIZE - %1). Receiving one
@@ -93,7 +92,6 @@ struct ep93xx_spi {
 	void __iomem			*mmio;
 	unsigned long			sspdr_phys;
 	struct completion		wait;
-	struct spi_message		*current_msg;
 	size_t				tx;
 	size_t				rx;
 	size_t				fifo_level;
@@ -236,8 +234,7 @@ static void ep93xx_do_read(struct ep93xx_spi *espi, struct spi_transfer *t)
 static int ep93xx_spi_read_write(struct spi_master *master)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
-	struct spi_message *msg = espi->current_msg;
-	struct spi_transfer *t = msg->state;
+	struct spi_transfer *t = master->cur_msg->state;
 
 	/* read as long as RX FIFO has frames in it */
 	while ((readl(espi->mmio + SSPSR) & SSPSR_RNE)) {
@@ -290,7 +287,7 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
 		       enum dma_transfer_direction dir)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
-	struct spi_transfer *t = espi->current_msg->state;
+	struct spi_transfer *t = master->cur_msg->state;
 	struct dma_async_tx_descriptor *txd;
 	enum dma_slave_buswidth buswidth;
 	struct dma_slave_config conf;
@@ -415,13 +412,12 @@ static void ep93xx_spi_dma_callback(void *callback_param)
 static void ep93xx_spi_dma_transfer(struct spi_master *master)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
-	struct spi_message *msg = espi->current_msg;
 	struct dma_async_tx_descriptor *rxd, *txd;
 
 	rxd = ep93xx_spi_dma_prepare(master, DMA_DEV_TO_MEM);
 	if (IS_ERR(rxd)) {
 		dev_err(&master->dev, "DMA RX failed: %ld\n", PTR_ERR(rxd));
-		msg->status = PTR_ERR(rxd);
+		master->cur_msg->status = PTR_ERR(rxd);
 		return;
 	}
 
@@ -429,7 +425,7 @@ static void ep93xx_spi_dma_transfer(struct spi_master *master)
 	if (IS_ERR(txd)) {
 		ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
 		dev_err(&master->dev, "DMA TX failed: %ld\n", PTR_ERR(txd));
-		msg->status = PTR_ERR(txd);
+		master->cur_msg->status = PTR_ERR(txd);
 		return;
 	}
 
@@ -587,9 +583,7 @@ static int ep93xx_spi_transfer_one_message(struct spi_master *master,
 	msg->status = 0;
 	msg->actual_length = 0;
 
-	espi->current_msg = msg;
 	ep93xx_spi_process_message(master, msg);
-	espi->current_msg = NULL;
 
 	spi_finalize_current_message(master);
 
@@ -611,7 +605,7 @@ static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
 		writel(0, espi->mmio + SSPICR);
 		dev_warn(&master->dev,
 			 "receive overrun, aborting the message\n");
-		espi->current_msg->status = -EIO;
+		master->cur_msg->status = -EIO;
 	} else {
 		/*
 		 * Interrupt is either RX (RIS) or TX (TIS). For both cases we
-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
