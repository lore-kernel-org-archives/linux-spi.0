From: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: [PATCH 7/7] spi: spi-ep93xx: use the default master transfer queueing mechanism
Date: Thu, 16 Feb 2017 16:48:51 -0700
Message-ID: <20170216234851.97938-8-hsweeten@visionengravers.com>
References: <20170216234851.97938-1-hsweeten@visionengravers.com>
Cc: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170216234851.97938-1-hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Update this driver to the default implementation of transfer_one_message().

Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
---
 drivers/spi/spi-ep93xx.c | 322 ++++++++++++++++-------------------------------
 1 file changed, 108 insertions(+), 214 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index dd37626..d48d050 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -73,7 +73,6 @@
  * @clk: clock for the controller
  * @mmio: pointer to ioremap()'d registers
  * @sspdr_phys: physical address of the SSPDR register
- * @wait: wait here until given transfer is completed
  * @tx: current byte in transfer to transmit
  * @rx: current byte in transfer to receive
  * @fifo_level: how full is FIFO (%0..%SPI_FIFO_SIZE - %1). Receiving one
@@ -91,7 +90,6 @@ struct ep93xx_spi {
 	struct clk			*clk;
 	void __iomem			*mmio;
 	unsigned long			sspdr_phys;
-	struct completion		wait;
 	size_t				tx;
 	size_t				rx;
 	size_t				fifo_level;
@@ -123,8 +121,7 @@ static int ep93xx_spi_calc_divisors(struct spi_master *master,
 
 	/*
 	 * Make sure that max value is between values supported by the
-	 * controller. Note that minimum value is already checked in
-	 * ep93xx_spi_transfer_one_message().
+	 * controller.
 	 */
 	rate = clamp(rate, master->min_speed_hz, master->max_speed_hz);
 
@@ -149,15 +146,6 @@ static int ep93xx_spi_calc_divisors(struct spi_master *master,
 	return -EINVAL;
 }
 
-static void ep93xx_spi_cs_control(struct spi_device *spi, bool enable)
-{
-	if (spi->mode & SPI_CS_HIGH)
-		enable = !enable;
-
-	if (gpio_is_valid(spi->cs_gpio))
-		gpio_set_value(spi->cs_gpio, !enable);
-}
-
 static int ep93xx_spi_chip_setup(struct spi_master *master,
 				 struct spi_device *spi,
 				 struct spi_transfer *xfer)
@@ -188,34 +176,38 @@ static int ep93xx_spi_chip_setup(struct spi_master *master,
 	return 0;
 }
 
-static void ep93xx_do_write(struct ep93xx_spi *espi, struct spi_transfer *t)
+static void ep93xx_do_write(struct spi_master *master)
 {
+	struct ep93xx_spi *espi = spi_master_get_devdata(master);
+	struct spi_transfer *xfer = master->cur_msg->state;
 	unsigned int val = 0;
 
-	if (t->bits_per_word > 8) {
-		if (t->tx_buf)
-			val = ((u16 *)t->tx_buf)[espi->tx];
+	if (xfer->bits_per_word > 8) {
+		if (xfer->tx_buf)
+			val = ((u16 *)xfer->tx_buf)[espi->tx];
 		espi->tx += 2;
 	} else {
-		if (t->tx_buf)
-			val = ((u8 *)t->tx_buf)[espi->tx];
+		if (xfer->tx_buf)
+			val = ((u8 *)xfer->tx_buf)[espi->tx];
 		espi->tx += 1;
 	}
 	writel(val, espi->mmio + SSPDR);
 }
 
-static void ep93xx_do_read(struct ep93xx_spi *espi, struct spi_transfer *t)
+static void ep93xx_do_read(struct spi_master *master)
 {
+	struct ep93xx_spi *espi = spi_master_get_devdata(master);
+	struct spi_transfer *xfer = master->cur_msg->state;
 	unsigned int val;
 
 	val = readl(espi->mmio + SSPDR);
-	if (t->bits_per_word > 8) {
-		if (t->rx_buf)
-			((u16 *)t->rx_buf)[espi->rx] = val;
+	if (xfer->bits_per_word > 8) {
+		if (xfer->rx_buf)
+			((u16 *)xfer->rx_buf)[espi->rx] = val;
 		espi->rx += 2;
 	} else {
-		if (t->rx_buf)
-			((u8 *)t->rx_buf)[espi->rx] = val;
+		if (xfer->rx_buf)
+			((u8 *)xfer->rx_buf)[espi->rx] = val;
 		espi->rx += 1;
 	}
 }
@@ -234,45 +226,26 @@ static void ep93xx_do_read(struct ep93xx_spi *espi, struct spi_transfer *t)
 static int ep93xx_spi_read_write(struct spi_master *master)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
-	struct spi_transfer *t = master->cur_msg->state;
+	struct spi_transfer *xfer = master->cur_msg->state;
 
 	/* read as long as RX FIFO has frames in it */
 	while ((readl(espi->mmio + SSPSR) & SSPSR_RNE)) {
-		ep93xx_do_read(espi, t);
+		ep93xx_do_read(master);
 		espi->fifo_level--;
 	}
 
 	/* write as long as TX FIFO has room */
-	while (espi->fifo_level < SPI_FIFO_SIZE && espi->tx < t->len) {
-		ep93xx_do_write(espi, t);
+	while (espi->fifo_level < SPI_FIFO_SIZE && espi->tx < xfer->len) {
+		ep93xx_do_write(master);
 		espi->fifo_level++;
 	}
 
-	if (espi->rx == t->len)
+	if (espi->rx == xfer->len)
 		return 0;
 
 	return -EINPROGRESS;
 }
 
-static void ep93xx_spi_pio_transfer(struct spi_master *master)
-{
-	struct ep93xx_spi *espi = spi_master_get_devdata(master);
-
-	/*
-	 * Now everything is set up for the current transfer. We prime the TX
-	 * FIFO, enable interrupts, and wait for the transfer to complete.
-	 */
-	if (ep93xx_spi_read_write(master)) {
-		unsigned int val;
-
-		val = readl(espi->mmio + SSPCR1);
-		val |= (SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
-		writel(val, espi->mmio + SSPCR1);
-
-		wait_for_completion(&espi->wait);
-	}
-}
-
 /**
  * ep93xx_spi_dma_prepare() - prepares a DMA transfer
  * @master: SPI master
@@ -287,7 +260,7 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
 		       enum dma_transfer_direction dir)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
-	struct spi_transfer *t = master->cur_msg->state;
+	struct spi_transfer *xfer = master->cur_msg->state;
 	struct dma_async_tx_descriptor *txd;
 	enum dma_slave_buswidth buswidth;
 	struct dma_slave_config conf;
@@ -295,10 +268,10 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
 	struct sg_table *sgt;
 	struct dma_chan *chan;
 	const void *buf, *pbuf;
-	size_t len = t->len;
+	size_t len = xfer->len;
 	int i, ret, nents;
 
-	if (t->bits_per_word > 8)
+	if (xfer->bits_per_word > 8)
 		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
 	else
 		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
@@ -308,14 +281,14 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
 
 	if (dir == DMA_DEV_TO_MEM) {
 		chan = espi->dma_rx;
-		buf = t->rx_buf;
+		buf = xfer->rx_buf;
 		sgt = &espi->rx_sgt;
 
 		conf.src_addr = espi->sspdr_phys;
 		conf.src_addr_width = buswidth;
 	} else {
 		chan = espi->dma_tx;
-		buf = t->tx_buf;
+		buf = xfer->tx_buf;
 		sgt = &espi->tx_sgt;
 
 		conf.dst_addr = espi->sspdr_phys;
@@ -406,10 +379,15 @@ static void ep93xx_spi_dma_finish(struct spi_master *master,
 
 static void ep93xx_spi_dma_callback(void *callback_param)
 {
-	complete(callback_param);
+	struct spi_master *master = callback_param;
+
+	ep93xx_spi_dma_finish(master, DMA_MEM_TO_DEV);
+	ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
+
+	spi_finalize_current_transfer(master);
 }
 
-static void ep93xx_spi_dma_transfer(struct spi_master *master)
+static int ep93xx_spi_dma_transfer(struct spi_master *master)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct dma_async_tx_descriptor *rxd, *txd;
@@ -417,177 +395,29 @@ static void ep93xx_spi_dma_transfer(struct spi_master *master)
 	rxd = ep93xx_spi_dma_prepare(master, DMA_DEV_TO_MEM);
 	if (IS_ERR(rxd)) {
 		dev_err(&master->dev, "DMA RX failed: %ld\n", PTR_ERR(rxd));
-		master->cur_msg->status = PTR_ERR(rxd);
-		return;
+		return PTR_ERR(rxd);
 	}
 
 	txd = ep93xx_spi_dma_prepare(master, DMA_MEM_TO_DEV);
 	if (IS_ERR(txd)) {
 		ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
 		dev_err(&master->dev, "DMA TX failed: %ld\n", PTR_ERR(txd));
-		master->cur_msg->status = PTR_ERR(txd);
-		return;
+		return PTR_ERR(txd);
 	}
 
 	/* We are ready when RX is done */
 	rxd->callback = ep93xx_spi_dma_callback;
-	rxd->callback_param = &espi->wait;
+	rxd->callback_param = master;
 
-	/* Now submit both descriptors and wait while they finish */
+	/* Now submit both descriptors and start DMA */
 	dmaengine_submit(rxd);
 	dmaengine_submit(txd);
 
 	dma_async_issue_pending(espi->dma_rx);
 	dma_async_issue_pending(espi->dma_tx);
 
-	wait_for_completion(&espi->wait);
-
-	ep93xx_spi_dma_finish(master, DMA_MEM_TO_DEV);
-	ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
-}
-
-/**
- * ep93xx_spi_process_transfer() - processes one SPI transfer
- * @master: SPI master
- * @msg: current message
- * @t: transfer to process
- *
- * This function processes one SPI transfer given in @t. Function waits until
- * transfer is complete (may sleep) and updates @msg->status based on whether
- * transfer was successfully processed or not.
- */
-static void ep93xx_spi_process_transfer(struct spi_master *master,
-					struct spi_message *msg,
-					struct spi_transfer *t)
-{
-	struct ep93xx_spi *espi = spi_master_get_devdata(master);
-	int err;
-
-	msg->state = t;
-
-	err = ep93xx_spi_chip_setup(master, msg->spi, t);
-	if (err) {
-		dev_err(&master->dev,
-			"failed to setup chip for transfer\n");
-		msg->status = err;
-		return;
-	}
-
-	espi->rx = 0;
-	espi->tx = 0;
-
-	/*
-	 * There is no point of setting up DMA for the transfers which will
-	 * fit into the FIFO and can be transferred with a single interrupt.
-	 * So in these cases we will be using PIO and don't bother for DMA.
-	 */
-	if (espi->dma_rx && t->len > SPI_FIFO_SIZE)
-		ep93xx_spi_dma_transfer(master);
-	else
-		ep93xx_spi_pio_transfer(master);
-
-	/*
-	 * In case of error during transmit, we bail out from processing
-	 * the message.
-	 */
-	if (msg->status)
-		return;
-
-	msg->actual_length += t->len;
-
-	/*
-	 * After this transfer is finished, perform any possible
-	 * post-transfer actions requested by the protocol driver.
-	 */
-	if (t->delay_usecs) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(usecs_to_jiffies(t->delay_usecs));
-	}
-	if (t->cs_change) {
-		if (!list_is_last(&t->transfer_list, &msg->transfers)) {
-			/*
-			 * In case protocol driver is asking us to drop the
-			 * chipselect briefly, we let the scheduler to handle
-			 * any "delay" here.
-			 */
-			ep93xx_spi_cs_control(msg->spi, false);
-			cond_resched();
-			ep93xx_spi_cs_control(msg->spi, true);
-		}
-	}
-}
-
-/*
- * ep93xx_spi_process_message() - process one SPI message
- * @master: SPI master
- * @msg: message to process
- *
- * This function processes a single SPI message. We go through all transfers in
- * the message and pass them to ep93xx_spi_process_transfer(). Chipselect is
- * asserted during the whole message (unless per transfer cs_change is set).
- *
- * @msg->status contains %0 in case of success or negative error code in case of
- * failure.
- */
-static void ep93xx_spi_process_message(struct spi_master *master,
-				       struct spi_message *msg)
-{
-	struct ep93xx_spi *espi = spi_master_get_devdata(master);
-	unsigned long timeout;
-	struct spi_transfer *t;
-
-	/*
-	 * Just to be sure: flush any data from RX FIFO.
-	 */
-	timeout = jiffies + msecs_to_jiffies(SPI_TIMEOUT);
-	while (readl(espi->mmio + SSPSR) & SSPSR_RNE) {
-		if (time_after(jiffies, timeout)) {
-			dev_warn(&master->dev,
-				 "timeout while flushing RX FIFO\n");
-			msg->status = -ETIMEDOUT;
-			return;
-		}
-		readl(espi->mmio + SSPDR);
-	}
-
-	/*
-	 * We explicitly handle FIFO level. This way we don't have to check TX
-	 * FIFO status using %SSPSR_TNF bit which may cause RX FIFO overruns.
-	 */
-	espi->fifo_level = 0;
-
-	/*
-	 * Assert the chipselect.
-	 */
-	ep93xx_spi_cs_control(msg->spi, true);
-
-	list_for_each_entry(t, &msg->transfers, transfer_list) {
-		ep93xx_spi_process_transfer(master, msg, t);
-		if (msg->status)
-			break;
-	}
-
-	/*
-	 * Now the whole message is transferred (or failed for some reason). We
-	 * deselect the device and disable the SPI controller.
-	 */
-	ep93xx_spi_cs_control(msg->spi, false);
-}
-
-static int ep93xx_spi_transfer_one_message(struct spi_master *master,
-					   struct spi_message *msg)
-{
-	struct ep93xx_spi *espi = spi_master_get_devdata(master);
-
-	msg->state = NULL;
-	msg->status = 0;
-	msg->actual_length = 0;
-
-	ep93xx_spi_process_message(master, msg);
-
-	spi_finalize_current_message(master);
-
-	return 0;
+	/* signal that we need to wait for completion */
+	return 1;
 }
 
 static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
@@ -630,11 +460,76 @@ static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
 	val &= ~(SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
 	writel(val, espi->mmio + SSPCR1);
 
-	complete(&espi->wait);
+	spi_finalize_current_transfer(master);
 
 	return IRQ_HANDLED;
 }
 
+static int ep93xx_spi_transfer_one(struct spi_master *master,
+				   struct spi_device *spi,
+				   struct spi_transfer *xfer)
+{
+	struct ep93xx_spi *espi = spi_master_get_devdata(master);
+	unsigned int val;
+	int ret;
+
+	ret = ep93xx_spi_chip_setup(master, spi, xfer);
+	if (ret) {
+		dev_err(&master->dev, "failed to setup chip for transfer\n");
+		return ret;
+	}
+
+	master->cur_msg->state = xfer;
+	espi->rx = 0;
+	espi->tx = 0;
+
+	/*
+	 * There is no point of setting up DMA for the transfers which will
+	 * fit into the FIFO and can be transferred with a single interrupt.
+	 * So in these cases we will be using PIO and don't bother for DMA.
+	 */
+	if (espi->dma_rx && xfer->len > SPI_FIFO_SIZE)
+		return ep93xx_spi_dma_transfer(master);
+
+	/* Using PIO so prime the TX FIFO and enable interrupts */
+	ep93xx_spi_read_write(master);
+
+	val = readl(espi->mmio + SSPCR1);
+	val |= (SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
+	writel(val, espi->mmio + SSPCR1);
+
+	/* signal that we need to wait for completion */
+	return 1;
+}
+
+static int ep93xx_spi_prepare_message(struct spi_master *master,
+				      struct spi_message *msg)
+{
+	struct ep93xx_spi *espi = spi_master_get_devdata(master);
+	unsigned long timeout;
+
+	/*
+	 * Just to be sure: flush any data from RX FIFO.
+	 */
+	timeout = jiffies + msecs_to_jiffies(SPI_TIMEOUT);
+	while (readl(espi->mmio + SSPSR) & SSPSR_RNE) {
+		if (time_after(jiffies, timeout)) {
+			dev_warn(&master->dev,
+				 "timeout while flushing RX FIFO\n");
+			return -ETIMEDOUT;
+		}
+		readl(espi->mmio + SSPDR);
+	}
+
+	/*
+	 * We explicitly handle FIFO level. This way we don't have to check TX
+	 * FIFO status using %SSPSR_TNF bit which may cause RX FIFO overruns.
+	 */
+	espi->fifo_level = 0;
+
+	return 0;
+}
+
 static int ep93xx_spi_prepare_hardware(struct spi_master *master)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
@@ -769,7 +664,8 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 
 	master->prepare_transfer_hardware = ep93xx_spi_prepare_hardware;
 	master->unprepare_transfer_hardware = ep93xx_spi_unprepare_hardware;
-	master->transfer_one_message = ep93xx_spi_transfer_one_message;
+	master->prepare_message = ep93xx_spi_prepare_message;
+	master->transfer_one = ep93xx_spi_transfer_one;
 	master->bus_num = pdev->id;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
@@ -810,8 +706,6 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 		goto fail_release_master;
 	}
 
-	init_completion(&espi->wait);
-
 	/*
 	 * Calculate maximum and minimum supported clock rates
 	 * for the controller.
-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
