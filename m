From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 08/10] spi: dw-mid: move to use core SPI DMA mappings
Date: Thu, 18 Sep 2014 20:08:58 +0300
Message-ID: <1411060140-2801-9-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1411060140-2801-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411060140-2801-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SPI core has a comprehensive function set to map and unmap a message when it's
needed. This patch converts driver to use that advantage.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 31 +++++++++++++++++++------------
 drivers/spi/spi-dw.c     | 28 +++++-----------------------
 drivers/spi/spi-dw.h     |  6 ++----
 3 files changed, 26 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index a62413d..fad7425 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -66,6 +66,7 @@ static int mid_spi_dma_init(struct dw_spi *dws)
 	rxs->hs_mode = LNW_DMA_HW_HS;
 	rxs->cfg_mode = LNW_DMA_PER_TO_MEM;
 	dws->rxchan->private = rxs;
+	dws->master->dma_rx = dws->rxchan;
 
 	/* 2. Init tx channel */
 	dws->txchan = dma_request_channel(mask, mid_spi_dma_chan_filter, dws);
@@ -75,6 +76,7 @@ static int mid_spi_dma_init(struct dw_spi *dws)
 	txs->hs_mode = LNW_DMA_HW_HS;
 	txs->cfg_mode = LNW_DMA_MEM_TO_PER;
 	dws->txchan->private = txs;
+	dws->master->dma_tx = dws->txchan;
 
 	dws->dma_inited = 1;
 	return 0;
@@ -97,6 +99,17 @@ static void mid_spi_dma_exit(struct dw_spi *dws)
 	dma_release_channel(dws->rxchan);
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
 /*
  * dws->dma_chan_done is cleared before the dma transfer starts,
  * callback for rx/tx channel will each increment it by 1.
@@ -113,6 +126,7 @@ static void dw_spi_dma_done(void *arg)
 
 static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 {
+	struct spi_transfer *xfer = dws->cur_transfer;
 	struct dma_async_tx_descriptor *txdesc = NULL, *rxdesc = NULL;
 	struct dma_chan *txchan, *rxchan;
 	struct dma_slave_config txconf, rxconf;
@@ -144,13 +158,9 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 	txchan->device->device_control(txchan, DMA_SLAVE_CONFIG,
 				       (unsigned long) &txconf);
 
-	memset(&dws->tx_sgl, 0, sizeof(dws->tx_sgl));
-	dws->tx_sgl.dma_address = dws->tx_dma;
-	dws->tx_sgl.length = dws->len;
-
 	txdesc = dmaengine_prep_slave_sg(txchan,
-				&dws->tx_sgl,
-				1,
+				xfer->tx_sg.sgl,
+				xfer->tx_sg.nents,
 				DMA_MEM_TO_DEV,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	txdesc->callback = dw_spi_dma_done;
@@ -167,13 +177,9 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 	rxchan->device->device_control(rxchan, DMA_SLAVE_CONFIG,
 				       (unsigned long) &rxconf);
 
-	memset(&dws->rx_sgl, 0, sizeof(dws->rx_sgl));
-	dws->rx_sgl.dma_address = dws->rx_dma;
-	dws->rx_sgl.length = dws->len;
-
 	rxdesc = dmaengine_prep_slave_sg(rxchan,
-				&dws->rx_sgl,
-				1,
+				xfer->rx_sg.sgl,
+				xfer->rx_sg.nents,
 				DMA_DEV_TO_MEM,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	rxdesc->callback = dw_spi_dma_done;
@@ -192,6 +198,7 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 static struct dw_spi_dma_ops mid_dma_ops = {
 	.dma_init	= mid_spi_dma_init,
 	.dma_exit	= mid_spi_dma_exit,
+	.can_dma	= mid_spi_can_dma,
 	.dma_transfer	= mid_spi_dma_transfer,
 };
 #endif
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 11c7613..3379946 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -226,28 +226,6 @@ static void *next_transfer(struct dw_spi *dws)
 	return DONE_STATE;
 }
 
-/*
- * Note: first step is the protocol driver prepares
- * a dma-capable memory, and this func just need translate
- * the virt addr to physical
- */
-static int map_dma_buffers(struct dw_spi *dws)
-{
-	if (!dws->cur_msg->is_dma_mapped
-		|| !dws->dma_inited
-		|| !dws->cur_chip->enable_dma
-		|| !dws->dma_ops)
-		return 0;
-
-	if (dws->cur_transfer->tx_dma)
-		dws->tx_dma = dws->cur_transfer->tx_dma;
-
-	if (dws->cur_transfer->rx_dma)
-		dws->rx_dma = dws->cur_transfer->rx_dma;
-
-	return 1;
-}
-
 /* Caller already set message->status; dma and pio irqs are blocked */
 static void giveback(struct dw_spi *dws)
 {
@@ -364,6 +342,7 @@ static void poll_transfer(struct dw_spi *dws)
 static void pump_transfers(unsigned long data)
 {
 	struct dw_spi *dws = (struct dw_spi *)data;
+	struct spi_master *master = dws->master;
 	struct spi_message *message = NULL;
 	struct spi_transfer *transfer = NULL;
 	struct spi_transfer *previous = NULL;
@@ -464,7 +443,8 @@ static void pump_transfers(unsigned long data)
 	}
 
 	/* Check if current transfer is a DMA transaction */
-	dws->dma_mapped = map_dma_buffers(dws);
+	if (master->can_dma && master->can_dma(master, spi, transfer))
+		dws->dma_mapped = master->cur_msg_mapped;
 
 	/*
 	 * Interrupt mode
@@ -685,6 +665,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		if (ret) {
 			dev_warn(&master->dev, "DMA init failed\n");
 			dws->dma_inited = 0;
+		} else {
+			master->can_dma = dws->dma_ops->can_dma;
 		}
 	}
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 83a103a..436678f4 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -91,6 +91,8 @@ struct dw_spi;
 struct dw_spi_dma_ops {
 	int (*dma_init)(struct dw_spi *dws);
 	void (*dma_exit)(struct dw_spi *dws);
+	bool (*can_dma)(struct spi_master *master, struct spi_device *spi,
+			struct spi_transfer *xfer);
 	int (*dma_transfer)(struct dw_spi *dws, int cs_change);
 };
 
@@ -125,8 +127,6 @@ struct dw_spi {
 	int			dma_mapped;
 	dma_addr_t		rx_dma;
 	dma_addr_t		tx_dma;
-	size_t			rx_map_len;
-	size_t			tx_map_len;
 	u8			n_bytes;	/* current is a 1/2 bytes op */
 	u8			max_bits_per_word;	/* maxim is 16b */
 	u32			dma_width;
@@ -136,9 +136,7 @@ struct dw_spi {
 	/* Dma info */
 	int			dma_inited;
 	struct dma_chan		*txchan;
-	struct scatterlist	tx_sgl;
 	struct dma_chan		*rxchan;
-	struct scatterlist	rx_sgl;
 	int			dma_chan_done;
 	struct device		*dma_dev;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
