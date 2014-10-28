From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/2] spi: dw-mid: refactor to use helpers
Date: Tue, 28 Oct 2014 18:25:01 +0200
Message-ID: <1414513502-595-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1414513502-595-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414513502-595-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch splits few helpers, namely dw_spi_dma_prepare_rx(),
dw_spi_dma_prepare_tx(), and dw_spi_dma_setup() which will be useful for the
consequent improvements.

There is no functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 69 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 46c6d58..c8319ab 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -111,28 +111,11 @@ static void dw_spi_dma_done(void *arg)
 	dw_spi_xfer_done(dws);
 }
 
-static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
+static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws)
 {
-	struct dma_async_tx_descriptor *txdesc, *rxdesc;
-	struct dma_slave_config txconf, rxconf;
-	u16 dma_ctrl = 0;
-
-	/* 1. setup DMA related registers */
-	if (cs_change) {
-		spi_enable_chip(dws, 0);
-		dw_writew(dws, DW_SPI_DMARDLR, 0xf);
-		dw_writew(dws, DW_SPI_DMATDLR, 0x10);
-		if (dws->tx_dma)
-			dma_ctrl |= SPI_DMA_TDMAE;
-		if (dws->rx_dma)
-			dma_ctrl |= SPI_DMA_RDMAE;
-		dw_writew(dws, DW_SPI_DMACR, dma_ctrl);
-		spi_enable_chip(dws, 1);
-	}
+	struct dma_slave_config txconf;
+	struct dma_async_tx_descriptor *txdesc;
 
-	dws->dma_chan_done = 0;
-
-	/* 2. Prepare the TX dma transfer */
 	txconf.direction = DMA_MEM_TO_DEV;
 	txconf.dst_addr = dws->dma_addr;
 	txconf.dst_maxburst = LNW_DMA_MSIZE_16;
@@ -154,7 +137,14 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 	txdesc->callback = dw_spi_dma_done;
 	txdesc->callback_param = dws;
 
-	/* 3. Prepare the RX dma transfer */
+	return txdesc;
+}
+
+static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws)
+{
+	struct dma_slave_config rxconf;
+	struct dma_async_tx_descriptor *rxdesc;
+
 	rxconf.direction = DMA_DEV_TO_MEM;
 	rxconf.src_addr = dws->dma_addr;
 	rxconf.src_maxburst = LNW_DMA_MSIZE_16;
@@ -176,6 +166,43 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 	rxdesc->callback = dw_spi_dma_done;
 	rxdesc->callback_param = dws;
 
+	return rxdesc;
+}
+
+static void dw_spi_dma_setup(struct dw_spi *dws)
+{
+	u16 dma_ctrl = 0;
+
+	spi_enable_chip(dws, 0);
+
+	dw_writew(dws, DW_SPI_DMARDLR, 0xf);
+	dw_writew(dws, DW_SPI_DMATDLR, 0x10);
+
+	if (dws->tx_dma)
+		dma_ctrl |= SPI_DMA_TDMAE;
+	if (dws->rx_dma)
+		dma_ctrl |= SPI_DMA_RDMAE;
+	dw_writew(dws, DW_SPI_DMACR, dma_ctrl);
+
+	spi_enable_chip(dws, 1);
+}
+
+static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
+{
+	struct dma_async_tx_descriptor *txdesc, *rxdesc;
+
+	/* 1. setup DMA related registers */
+	if (cs_change)
+		dw_spi_dma_setup(dws);
+
+	dws->dma_chan_done = 0;
+
+	/* 2. Prepare the TX dma transfer */
+	txdesc = dw_spi_dma_prepare_tx(dws);
+
+	/* 3. Prepare the RX dma transfer */
+	rxdesc = dw_spi_dma_prepare_rx(dws);
+
 	/* rx must be started before tx due to spi instinct */
 	dmaengine_submit(rxdesc);
 	dma_async_issue_pending(dws->rxchan);
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
