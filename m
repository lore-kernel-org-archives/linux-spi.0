From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 2/7] spi: dw-mid: split dma_setup() from dma_transfer()
Date: Mon,  9 Mar 2015 16:48:46 +0200
Message-ID: <1425912531-23457-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1425912531-23457-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425912531-23457-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch splits DMA preparatory code to dma_setup() callback. The change also
converts transfer_one() to program DMA whenever the transfer is DMA mapped. The
change is a follow up of the converion to use SPI core transfer_one_message().
Since the DMA mapped transfers can be interleaved with PIO ones the DMA related
configuration should respect that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 17 ++++++-----------
 drivers/spi/spi-dw.c     | 23 +++++++++++++----------
 drivers/spi/spi-dw.h     |  4 ++--
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 25c8fa7..4b4d266 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -207,12 +207,10 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws)
 	return rxdesc;
 }
 
-static void dw_spi_dma_setup(struct dw_spi *dws)
+static int mid_spi_dma_setup(struct dw_spi *dws)
 {
 	u16 dma_ctrl = 0;
 
-	spi_enable_chip(dws, 0);
-
 	dw_writew(dws, DW_SPI_DMARDLR, 0xf);
 	dw_writew(dws, DW_SPI_DMATDLR, 0x10);
 
@@ -222,21 +220,17 @@ static void dw_spi_dma_setup(struct dw_spi *dws)
 		dma_ctrl |= SPI_DMA_RDMAE;
 	dw_writew(dws, DW_SPI_DMACR, dma_ctrl);
 
-	spi_enable_chip(dws, 1);
+	return 0;
 }
 
-static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
+static int mid_spi_dma_transfer(struct dw_spi *dws)
 {
 	struct dma_async_tx_descriptor *txdesc, *rxdesc;
 
-	/* 1. setup DMA related registers */
-	if (cs_change)
-		dw_spi_dma_setup(dws);
-
-	/* 2. Prepare the TX dma transfer */
+	/* Prepare the TX dma transfer */
 	txdesc = dw_spi_dma_prepare_tx(dws);
 
-	/* 3. Prepare the RX dma transfer */
+	/* Prepare the RX dma transfer */
 	rxdesc = dw_spi_dma_prepare_rx(dws);
 
 	/* rx must be started before tx due to spi instinct */
@@ -258,6 +252,7 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 static struct dw_spi_dma_ops mid_dma_ops = {
 	.dma_init	= mid_spi_dma_init,
 	.dma_exit	= mid_spi_dma_exit,
+	.dma_setup	= mid_spi_dma_setup,
 	.dma_transfer	= mid_spi_dma_transfer,
 };
 #endif
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index f3e4092..c7c2fcc 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -316,11 +316,11 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	struct dw_spi *dws = spi_master_get_devdata(master);
 	struct chip_data *chip = spi_get_ctldata(spi);
 	u8 imask = 0;
-	u8 cs_change = 0;
 	u16 txlevel = 0;
 	u16 clk_div = 0;
 	u32 speed = 0;
 	u32 cr0 = 0;
+	int ret;
 
 	dws->n_bytes = chip->n_bytes;
 	dws->dma_width = chip->dma_width;
@@ -332,8 +332,6 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	dws->rx = transfer->rx_buf;
 	dws->rx_end = dws->rx + transfer->len;
 	dws->len = transfer->len;
-	if (chip != dws->prev_chip)
-		cs_change = 1;
 
 	spi_enable_chip(dws, 0);
 
@@ -397,7 +395,13 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	 * Interrupt mode
 	 * we only need set the TXEI IRQ, as TX/RX always happen syncronizely
 	 */
-	if (!dws->dma_mapped && !chip->poll_mode) {
+	if (dws->dma_mapped) {
+		ret = dws->dma_ops->dma_setup(dws);
+		if (ret < 0) {
+			spi_enable_chip(dws, 1);
+			return ret;
+		}
+	} else if (!chip->poll_mode) {
 		txlevel = min_t(u16, dws->fifo_len / 2, dws->len / dws->n_bytes);
 		dw_writew(dws, DW_SPI_TXFLTR, txlevel);
 
@@ -411,11 +415,11 @@ static int dw_spi_transfer_one(struct spi_master *master,
 
 	spi_enable_chip(dws, 1);
 
-	if (cs_change)
-		dws->prev_chip = chip;
-
-	if (dws->dma_mapped)
-		dws->dma_ops->dma_transfer(dws, cs_change);
+	if (dws->dma_mapped) {
+		ret = dws->dma_ops->dma_transfer(dws);
+		if (ret < 0)
+			return ret;
+	}
 
 	if (chip->poll_mode)
 		return poll_transfer(dws);
@@ -546,7 +550,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 
 	dws->master = master;
 	dws->type = SSI_MOTO_SPI;
-	dws->prev_chip = NULL;
 	dws->dma_inited = 0;
 	dws->dma_addr = (dma_addr_t)(dws->paddr + 0x60);
 	snprintf(dws->name, sizeof(dws->name), "dw_spi%d", dws->bus_num);
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 855bfdd..7351692 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -91,7 +91,8 @@ struct dw_spi;
 struct dw_spi_dma_ops {
 	int (*dma_init)(struct dw_spi *dws);
 	void (*dma_exit)(struct dw_spi *dws);
-	int (*dma_transfer)(struct dw_spi *dws, int cs_change);
+	int (*dma_setup)(struct dw_spi *dws);
+	int (*dma_transfer)(struct dw_spi *dws);
 };
 
 struct dw_spi {
@@ -109,7 +110,6 @@ struct dw_spi {
 	u16			num_cs;		/* supported slave numbers */
 
 	/* Current message transfer state info */
-	struct chip_data	*prev_chip;
 	size_t			len;
 	void			*tx;
 	void			*tx_end;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
