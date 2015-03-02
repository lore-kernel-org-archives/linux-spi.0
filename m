From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 7/9] spi: dw-mid: move to use core SPI DMA mappings
Date: Mon,  2 Mar 2015 20:16:04 +0200
Message-ID: <1425320166-13788-8-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1425320166-13788-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425320166-13788-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SPI core has a comprehensive function set to map and unmap a message when it's
needed. This patch converts driver to use that advantage.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 52 ++++++++++++++++++++++++++++--------------------
 drivers/spi/spi-dw.c     | 40 +++++++------------------------------
 drivers/spi/spi-dw.h     | 17 ++++++----------
 3 files changed, 43 insertions(+), 66 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index e614190..599dad4 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -69,6 +69,7 @@ static int mid_spi_dma_init(struct dw_spi *dws)
 	rxs->hs_mode = LNW_DMA_HW_HS;
 	rxs->cfg_mode = LNW_DMA_PER_TO_MEM;
 	dws->rxchan->private = rxs;
+	dws->master->dma_rx = dws->rxchan;
 
 	/* 2. Init tx channel */
 	dws->txchan = dma_request_channel(mask, mid_spi_dma_chan_filter, dws);
@@ -78,6 +79,7 @@ static int mid_spi_dma_init(struct dw_spi *dws)
 	txs->hs_mode = LNW_DMA_HW_HS;
 	txs->cfg_mode = LNW_DMA_MEM_TO_PER;
 	dws->txchan->private = txs;
+	dws->master->dma_tx = dws->txchan;
 
 	dws->dma_inited = 1;
 	return 0;
@@ -116,6 +118,17 @@ static irqreturn_t dma_transfer(struct dw_spi *dws)
 	return IRQ_HANDLED;
 }
 
+static bool mid_spi_can_dma(struct spi_master *master, struct spi_device *spi,
+		struct spi_transfer *xfer)
+{
+	struct dw_spi *dws = spi_master_get_devdata(master);
+
+	if (!dws->dma_inited)
+		return false;
+
+	return xfer->len > dws->fifo_len;
+}
+
 static enum dma_slave_buswidth convert_dma_width(u32 dma_width) {
 	if (dma_width == 1)
 		return DMA_SLAVE_BUSWIDTH_1_BYTE;
@@ -139,12 +152,13 @@ static void dw_spi_dma_tx_done(void *arg)
 	spi_finalize_current_transfer(dws->master);
 }
 
-static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws)
+static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
+		struct spi_transfer *xfer)
 {
 	struct dma_slave_config txconf;
 	struct dma_async_tx_descriptor *txdesc;
 
-	if (!dws->tx_dma)
+	if (!xfer->tx_buf)
 		return NULL;
 
 	txconf.direction = DMA_MEM_TO_DEV;
@@ -156,13 +170,9 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws)
 
 	dmaengine_slave_config(dws->txchan, &txconf);
 
-	memset(&dws->tx_sgl, 0, sizeof(dws->tx_sgl));
-	dws->tx_sgl.dma_address = dws->tx_dma;
-	dws->tx_sgl.length = dws->len;
-
 	txdesc = dmaengine_prep_slave_sg(dws->txchan,
-				&dws->tx_sgl,
-				1,
+				xfer->tx_sg.sgl,
+				xfer->tx_sg.nents,
 				DMA_MEM_TO_DEV,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!txdesc)
@@ -188,12 +198,13 @@ static void dw_spi_dma_rx_done(void *arg)
 	spi_finalize_current_transfer(dws->master);
 }
 
-static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws)
+static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
+		struct spi_transfer *xfer)
 {
 	struct dma_slave_config rxconf;
 	struct dma_async_tx_descriptor *rxdesc;
 
-	if (!dws->rx_dma)
+	if (!xfer->rx_buf)
 		return NULL;
 
 	rxconf.direction = DMA_DEV_TO_MEM;
@@ -205,13 +216,9 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws)
 
 	dmaengine_slave_config(dws->rxchan, &rxconf);
 
-	memset(&dws->rx_sgl, 0, sizeof(dws->rx_sgl));
-	dws->rx_sgl.dma_address = dws->rx_dma;
-	dws->rx_sgl.length = dws->len;
-
 	rxdesc = dmaengine_prep_slave_sg(dws->rxchan,
-				&dws->rx_sgl,
-				1,
+				xfer->rx_sg.sgl,
+				xfer->rx_sg.nents,
 				DMA_DEV_TO_MEM,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!rxdesc)
@@ -223,16 +230,16 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws)
 	return rxdesc;
 }
 
-static int mid_spi_dma_setup(struct dw_spi *dws)
+static int mid_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	u16 dma_ctrl = 0;
 
 	dw_writew(dws, DW_SPI_DMARDLR, 0xf);
 	dw_writew(dws, DW_SPI_DMATDLR, 0x10);
 
-	if (dws->tx_dma)
+	if (xfer->tx_buf)
 		dma_ctrl |= SPI_DMA_TDMAE;
-	if (dws->rx_dma)
+	if (xfer->rx_buf)
 		dma_ctrl |= SPI_DMA_RDMAE;
 	dw_writew(dws, DW_SPI_DMACR, dma_ctrl);
 
@@ -244,15 +251,15 @@ static int mid_spi_dma_setup(struct dw_spi *dws)
 	return 0;
 }
 
-static int mid_spi_dma_transfer(struct dw_spi *dws)
+static int mid_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	struct dma_async_tx_descriptor *txdesc, *rxdesc;
 
 	/* Prepare the TX dma transfer */
-	txdesc = dw_spi_dma_prepare_tx(dws);
+	txdesc = dw_spi_dma_prepare_tx(dws, xfer);
 
 	/* Prepare the RX dma transfer */
-	rxdesc = dw_spi_dma_prepare_rx(dws);
+	rxdesc = dw_spi_dma_prepare_rx(dws, xfer);
 
 	/* rx must be started before tx due to spi instinct */
 	if (rxdesc) {
@@ -286,6 +293,7 @@ static struct dw_spi_dma_ops mid_dma_ops = {
 	.dma_init	= mid_spi_dma_init,
 	.dma_exit	= mid_spi_dma_exit,
 	.dma_setup	= mid_spi_dma_setup,
+	.can_dma	= mid_spi_can_dma,
 	.dma_transfer	= mid_spi_dma_transfer,
 	.dma_stop	= mid_spi_dma_stop,
 };
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index d53cffe..2437bfc 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -217,32 +217,6 @@ static void dw_reader(struct dw_spi *dws)
 	}
 }
 
-/*
- * Note: first step is the protocol driver prepares
- * a dma-capable memory, and this func just need translate
- * the virt addr to physical
- */
-static int map_dma_buffers(struct spi_master *master,
-		struct spi_device *spi, struct spi_transfer *transfer)
-{
-	struct dw_spi *dws = spi_master_get_devdata(master);
-	struct chip_data *chip = spi_get_ctldata(spi);
-
-	if (!master->cur_msg->is_dma_mapped
-		|| !dws->dma_inited
-		|| !chip->enable_dma
-		|| !dws->dma_ops)
-		return 0;
-
-	if (transfer->tx_dma)
-		dws->tx_dma = transfer->tx_dma;
-
-	if (transfer->rx_dma)
-		dws->rx_dma = transfer->rx_dma;
-
-	return 1;
-}
-
 static void int_error_stop(struct dw_spi *dws, const char *msg)
 {
 	spi_reset_chip(dws);
@@ -322,11 +296,10 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	u32 cr0 = 0;
 	int ret;
 
+	dws->dma_mapped = 0;
 	dws->n_bytes = chip->n_bytes;
 	dws->dma_width = chip->dma_width;
 
-	dws->rx_dma = transfer->rx_dma;
-	dws->tx_dma = transfer->tx_dma;
 	dws->tx = (void *)transfer->tx_buf;
 	dws->tx_end = dws->tx + transfer->len;
 	dws->rx = transfer->rx_buf;
@@ -386,7 +359,8 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	dw_writew(dws, DW_SPI_CTRL0, cr0);
 
 	/* Check if current transfer is a DMA transaction */
-	dws->dma_mapped = map_dma_buffers(master, spi, transfer);
+	if (master->can_dma && master->can_dma(master, spi, transfer))
+		dws->dma_mapped = master->cur_msg_mapped;
 
 	/* For poll mode just disable all interrupts */
 	spi_mask_intr(dws, 0xff);
@@ -396,7 +370,7 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	 * we only need set the TXEI IRQ, as TX/RX always happen syncronizely
 	 */
 	if (dws->dma_mapped) {
-		ret = dws->dma_ops->dma_setup(dws);
+		ret = dws->dma_ops->dma_setup(dws, transfer);
 		if (ret < 0) {
 			spi_enable_chip(dws, 1);
 			return ret;
@@ -416,7 +390,7 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	spi_enable_chip(dws, 1);
 
 	if (dws->dma_mapped) {
-		ret = dws->dma_ops->dma_transfer(dws);
+		ret = dws->dma_ops->dma_transfer(dws, transfer);
 		if (ret < 0)
 			return ret;
 	}
@@ -470,8 +444,6 @@ static int dw_spi_setup(struct spi_device *spi)
 
 		chip->rx_threshold = 0;
 		chip->tx_threshold = 0;
-
-		chip->enable_dma = chip_info->enable_dma;
 	}
 
 	if (spi->bits_per_word == 8) {
@@ -584,6 +556,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		if (ret) {
 			dev_warn(dev, "DMA init failed\n");
 			dws->dma_inited = 0;
+		} else {
+			master->can_dma = dws->dma_ops->can_dma;
 		}
 	}
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 7f130bd..f298df5 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -91,8 +91,10 @@ struct dw_spi;
 struct dw_spi_dma_ops {
 	int (*dma_init)(struct dw_spi *dws);
 	void (*dma_exit)(struct dw_spi *dws);
-	int (*dma_setup)(struct dw_spi *dws);
-	int (*dma_transfer)(struct dw_spi *dws);
+	int (*dma_setup)(struct dw_spi *dws, struct spi_transfer *xfer);
+	bool (*can_dma)(struct spi_master *master, struct spi_device *spi,
+			struct spi_transfer *xfer);
+	int (*dma_transfer)(struct dw_spi *dws, struct spi_transfer *xfer);
 	void (*dma_stop)(struct dw_spi *dws);
 };
 
@@ -117,20 +119,14 @@ struct dw_spi {
 	void			*rx;
 	void			*rx_end;
 	int			dma_mapped;
-	dma_addr_t		rx_dma;
-	dma_addr_t		tx_dma;
-	size_t			rx_map_len;
-	size_t			tx_map_len;
 	u8			n_bytes;	/* current is a 1/2 bytes op */
 	u32			dma_width;
 	irqreturn_t		(*transfer_handler)(struct dw_spi *dws);
 
-	/* Dma info */
+	/* DMA info */
 	int			dma_inited;
 	struct dma_chan		*txchan;
-	struct scatterlist	tx_sgl;
 	struct dma_chan		*rxchan;
-	struct scatterlist	rx_sgl;
 	unsigned long		dma_chan_busy;
 	struct device		*dma_dev;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
@@ -206,14 +202,13 @@ static inline void spi_reset_chip(struct dw_spi *dws)
 
 /*
  * Each SPI slave device to work with dw_api controller should
- * has such a structure claiming its working mode (PIO/DMA etc),
+ * has such a structure claiming its working mode (poll or PIO/DMA),
  * which can be save in the "controller_data" member of the
  * struct spi_device.
  */
 struct dw_spi_chip {
 	u8 poll_mode;	/* 1 for controller polling mode */
 	u8 type;	/* SPI/SSP/MicroWire */
-	u8 enable_dma;
 	void (*cs_control)(u32 command);
 };
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
