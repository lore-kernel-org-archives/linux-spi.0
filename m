From: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: [PATCH 5/7] spi: spi-ep93xx: pass the spi_master pointer around
Date: Thu, 16 Feb 2017 16:48:49 -0700
Message-ID: <20170216234851.97938-6-hsweeten@visionengravers.com>
References: <20170216234851.97938-1-hsweeten@visionengravers.com>
Cc: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170216234851.97938-1-hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Change the parameters for some of the functions so that the spi_master
pointer is passed around instead of the private data ep93xx_spi pointer.

This allows removing the 'pdev' member of the private data and will
help with some later cleanup.

Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
---
 drivers/spi/spi-ep93xx.c | 90 ++++++++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index e8f454b..f276dde 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -70,7 +70,6 @@
 
 /**
  * struct ep93xx_spi - EP93xx SPI controller structure
- * @pdev: pointer to platform device
  * @clk: clock for the controller
  * @mmio: pointer to ioremap()'d registers
  * @sspdr_phys: physical address of the SSPDR register
@@ -90,7 +89,6 @@
  *            the client
  */
 struct ep93xx_spi {
-	const struct platform_device	*pdev;
 	struct clk			*clk;
 	void __iomem			*mmio;
 	unsigned long			sspdr_phys;
@@ -113,15 +111,15 @@ struct ep93xx_spi {
 
 /**
  * ep93xx_spi_calc_divisors() - calculates SPI clock divisors
- * @espi: ep93xx SPI controller struct
+ * @master: SPI master
  * @rate: desired SPI output clock rate
  * @div_cpsr: pointer to return the cpsr (pre-scaler) divider
  * @div_scr: pointer to return the scr divider
  */
-static int ep93xx_spi_calc_divisors(const struct ep93xx_spi *espi,
+static int ep93xx_spi_calc_divisors(struct spi_master *master,
 				    u32 rate, u8 *div_cpsr, u8 *div_scr)
 {
-	struct spi_master *master = platform_get_drvdata(espi->pdev);
+	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	unsigned long spi_clk_rate = clk_get_rate(espi->clk);
 	int cpsr, scr;
 
@@ -162,17 +160,18 @@ static void ep93xx_spi_cs_control(struct spi_device *spi, bool enable)
 		gpio_set_value(spi->cs_gpio, !enable);
 }
 
-static int ep93xx_spi_chip_setup(const struct ep93xx_spi *espi,
+static int ep93xx_spi_chip_setup(struct spi_master *master,
 				 struct spi_device *spi,
 				 struct spi_transfer *xfer)
 {
+	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	u8 dss = bits_per_word_to_dss(xfer->bits_per_word);
 	u8 div_cpsr = 0;
 	u8 div_scr = 0;
 	u16 cr0;
 	int err;
 
-	err = ep93xx_spi_calc_divisors(espi, xfer->speed_hz,
+	err = ep93xx_spi_calc_divisors(master, xfer->speed_hz,
 				       &div_cpsr, &div_scr);
 	if (err)
 		return err;
@@ -181,9 +180,9 @@ static int ep93xx_spi_chip_setup(const struct ep93xx_spi *espi,
 	cr0 |= (spi->mode & (SPI_CPHA | SPI_CPOL)) << SSPCR0_MODE_SHIFT;
 	cr0 |= dss;
 
-	dev_dbg(&espi->pdev->dev, "setup: mode %d, cpsr %d, scr %d, dss %d\n",
+	dev_dbg(&master->dev, "setup: mode %d, cpsr %d, scr %d, dss %d\n",
 		spi->mode, div_cpsr, div_scr, dss);
-	dev_dbg(&espi->pdev->dev, "setup: cr0 %#x\n", cr0);
+	dev_dbg(&master->dev, "setup: cr0 %#x\n", cr0);
 
 	writel(div_cpsr, espi->mmio + SSPCPSR);
 	writel(cr0, espi->mmio + SSPCR0);
@@ -234,8 +233,9 @@ static void ep93xx_do_read(struct ep93xx_spi *espi, struct spi_transfer *t)
  * When this function is finished, RX FIFO should be empty and TX FIFO should be
  * full.
  */
-static int ep93xx_spi_read_write(struct ep93xx_spi *espi)
+static int ep93xx_spi_read_write(struct spi_master *master)
 {
+	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct spi_message *msg = espi->current_msg;
 	struct spi_transfer *t = msg->state;
 
@@ -257,13 +257,15 @@ static int ep93xx_spi_read_write(struct ep93xx_spi *espi)
 	return -EINPROGRESS;
 }
 
-static void ep93xx_spi_pio_transfer(struct ep93xx_spi *espi)
+static void ep93xx_spi_pio_transfer(struct spi_master *master)
 {
+	struct ep93xx_spi *espi = spi_master_get_devdata(master);
+
 	/*
 	 * Now everything is set up for the current transfer. We prime the TX
 	 * FIFO, enable interrupts, and wait for the transfer to complete.
 	 */
-	if (ep93xx_spi_read_write(espi)) {
+	if (ep93xx_spi_read_write(master)) {
 		unsigned int val;
 
 		val = readl(espi->mmio + SSPCR1);
@@ -276,7 +278,7 @@ static void ep93xx_spi_pio_transfer(struct ep93xx_spi *espi)
 
 /**
  * ep93xx_spi_dma_prepare() - prepares a DMA transfer
- * @espi: ep93xx SPI controller struct
+ * @master: SPI master
  * @dir: DMA transfer direction
  *
  * Function configures the DMA, maps the buffer and prepares the DMA
@@ -284,8 +286,10 @@ static void ep93xx_spi_pio_transfer(struct ep93xx_spi *espi)
  * in case of failure.
  */
 static struct dma_async_tx_descriptor *
-ep93xx_spi_dma_prepare(struct ep93xx_spi *espi, enum dma_transfer_direction dir)
+ep93xx_spi_dma_prepare(struct spi_master *master,
+		       enum dma_transfer_direction dir)
 {
+	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct spi_transfer *t = espi->current_msg->state;
 	struct dma_async_tx_descriptor *txd;
 	enum dma_slave_buswidth buswidth;
@@ -361,7 +365,7 @@ ep93xx_spi_dma_prepare(struct ep93xx_spi *espi, enum dma_transfer_direction dir)
 	}
 
 	if (WARN_ON(len)) {
-		dev_warn(&espi->pdev->dev, "len = %zu expected 0!\n", len);
+		dev_warn(&master->dev, "len = %zu expected 0!\n", len);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -379,15 +383,16 @@ ep93xx_spi_dma_prepare(struct ep93xx_spi *espi, enum dma_transfer_direction dir)
 
 /**
  * ep93xx_spi_dma_finish() - finishes with a DMA transfer
- * @espi: ep93xx SPI controller struct
+ * @master: SPI master
  * @dir: DMA transfer direction
  *
  * Function finishes with the DMA transfer. After this, the DMA buffer is
  * unmapped.
  */
-static void ep93xx_spi_dma_finish(struct ep93xx_spi *espi,
+static void ep93xx_spi_dma_finish(struct spi_master *master,
 				  enum dma_transfer_direction dir)
 {
+	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct dma_chan *chan;
 	struct sg_table *sgt;
 
@@ -407,22 +412,23 @@ static void ep93xx_spi_dma_callback(void *callback_param)
 	complete(callback_param);
 }
 
-static void ep93xx_spi_dma_transfer(struct ep93xx_spi *espi)
+static void ep93xx_spi_dma_transfer(struct spi_master *master)
 {
+	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct spi_message *msg = espi->current_msg;
 	struct dma_async_tx_descriptor *rxd, *txd;
 
-	rxd = ep93xx_spi_dma_prepare(espi, DMA_DEV_TO_MEM);
+	rxd = ep93xx_spi_dma_prepare(master, DMA_DEV_TO_MEM);
 	if (IS_ERR(rxd)) {
-		dev_err(&espi->pdev->dev, "DMA RX failed: %ld\n", PTR_ERR(rxd));
+		dev_err(&master->dev, "DMA RX failed: %ld\n", PTR_ERR(rxd));
 		msg->status = PTR_ERR(rxd);
 		return;
 	}
 
-	txd = ep93xx_spi_dma_prepare(espi, DMA_MEM_TO_DEV);
+	txd = ep93xx_spi_dma_prepare(master, DMA_MEM_TO_DEV);
 	if (IS_ERR(txd)) {
-		ep93xx_spi_dma_finish(espi, DMA_DEV_TO_MEM);
-		dev_err(&espi->pdev->dev, "DMA TX failed: %ld\n", PTR_ERR(txd));
+		ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
+		dev_err(&master->dev, "DMA TX failed: %ld\n", PTR_ERR(txd));
 		msg->status = PTR_ERR(txd);
 		return;
 	}
@@ -440,13 +446,13 @@ static void ep93xx_spi_dma_transfer(struct ep93xx_spi *espi)
 
 	wait_for_completion(&espi->wait);
 
-	ep93xx_spi_dma_finish(espi, DMA_MEM_TO_DEV);
-	ep93xx_spi_dma_finish(espi, DMA_DEV_TO_MEM);
+	ep93xx_spi_dma_finish(master, DMA_MEM_TO_DEV);
+	ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
 }
 
 /**
  * ep93xx_spi_process_transfer() - processes one SPI transfer
- * @espi: ep93xx SPI controller struct
+ * @master: SPI master
  * @msg: current message
  * @t: transfer to process
  *
@@ -454,17 +460,18 @@ static void ep93xx_spi_dma_transfer(struct ep93xx_spi *espi)
  * transfer is complete (may sleep) and updates @msg->status based on whether
  * transfer was successfully processed or not.
  */
-static void ep93xx_spi_process_transfer(struct ep93xx_spi *espi,
+static void ep93xx_spi_process_transfer(struct spi_master *master,
 					struct spi_message *msg,
 					struct spi_transfer *t)
 {
+	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	int err;
 
 	msg->state = t;
 
-	err = ep93xx_spi_chip_setup(espi, msg->spi, t);
+	err = ep93xx_spi_chip_setup(master, msg->spi, t);
 	if (err) {
-		dev_err(&espi->pdev->dev,
+		dev_err(&master->dev,
 			"failed to setup chip for transfer\n");
 		msg->status = err;
 		return;
@@ -479,9 +486,9 @@ static void ep93xx_spi_process_transfer(struct ep93xx_spi *espi,
 	 * So in these cases we will be using PIO and don't bother for DMA.
 	 */
 	if (espi->dma_rx && t->len > SPI_FIFO_SIZE)
-		ep93xx_spi_dma_transfer(espi);
+		ep93xx_spi_dma_transfer(master);
 	else
-		ep93xx_spi_pio_transfer(espi);
+		ep93xx_spi_pio_transfer(master);
 
 	/*
 	 * In case of error during transmit, we bail out from processing
@@ -516,7 +523,7 @@ static void ep93xx_spi_process_transfer(struct ep93xx_spi *espi,
 
 /*
  * ep93xx_spi_process_message() - process one SPI message
- * @espi: ep93xx SPI controller struct
+ * @master: SPI master
  * @msg: message to process
  *
  * This function processes a single SPI message. We go through all transfers in
@@ -526,9 +533,10 @@ static void ep93xx_spi_process_transfer(struct ep93xx_spi *espi,
  * @msg->status contains %0 in case of success or negative error code in case of
  * failure.
  */
-static void ep93xx_spi_process_message(struct ep93xx_spi *espi,
+static void ep93xx_spi_process_message(struct spi_master *master,
 				       struct spi_message *msg)
 {
+	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	unsigned long timeout;
 	struct spi_transfer *t;
 
@@ -538,7 +546,7 @@ static void ep93xx_spi_process_message(struct ep93xx_spi *espi,
 	timeout = jiffies + msecs_to_jiffies(SPI_TIMEOUT);
 	while (readl(espi->mmio + SSPSR) & SSPSR_RNE) {
 		if (time_after(jiffies, timeout)) {
-			dev_warn(&espi->pdev->dev,
+			dev_warn(&master->dev,
 				 "timeout while flushing RX FIFO\n");
 			msg->status = -ETIMEDOUT;
 			return;
@@ -558,7 +566,7 @@ static void ep93xx_spi_process_message(struct ep93xx_spi *espi,
 	ep93xx_spi_cs_control(msg->spi, true);
 
 	list_for_each_entry(t, &msg->transfers, transfer_list) {
-		ep93xx_spi_process_transfer(espi, msg, t);
+		ep93xx_spi_process_transfer(master, msg, t);
 		if (msg->status)
 			break;
 	}
@@ -580,7 +588,7 @@ static int ep93xx_spi_transfer_one_message(struct spi_master *master,
 	msg->actual_length = 0;
 
 	espi->current_msg = msg;
-	ep93xx_spi_process_message(espi, msg);
+	ep93xx_spi_process_message(master, msg);
 	espi->current_msg = NULL;
 
 	spi_finalize_current_message(master);
@@ -590,7 +598,8 @@ static int ep93xx_spi_transfer_one_message(struct spi_master *master,
 
 static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
 {
-	struct ep93xx_spi *espi = dev_id;
+	struct spi_master *master = dev_id;
+	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	unsigned int val;
 
 	/*
@@ -600,7 +609,7 @@ static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
 	if (readl(espi->mmio + SSPIIR) & SSPIIR_RORIS) {
 		/* clear the overrun interrupt */
 		writel(0, espi->mmio + SSPICR);
-		dev_warn(&espi->pdev->dev,
+		dev_warn(&master->dev,
 			 "receive overrun, aborting the message\n");
 		espi->current_msg->status = -EIO;
 	} else {
@@ -608,7 +617,7 @@ static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
 		 * Interrupt is either RX (RIS) or TX (TIS). For both cases we
 		 * simply execute next data transfer.
 		 */
-		if (ep93xx_spi_read_write(espi)) {
+		if (ep93xx_spi_read_write(master)) {
 			/*
 			 * In normal case, there still is some processing left
 			 * for current transfer. Let's wait for the next
@@ -815,7 +824,6 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	 */
 	master->max_speed_hz = clk_get_rate(espi->clk) / 2;
 	master->min_speed_hz = clk_get_rate(espi->clk) / (254 * 256);
-	espi->pdev = pdev;
 
 	espi->sspdr_phys = res->start + SSPDR;
 
@@ -826,7 +834,7 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	}
 
 	error = devm_request_irq(&pdev->dev, irq, ep93xx_spi_interrupt,
-				0, "ep93xx-spi", espi);
+				0, "ep93xx-spi", master);
 	if (error) {
 		dev_err(&pdev->dev, "failed to request irq\n");
 		goto fail_release_master;
-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
