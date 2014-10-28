From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 2/2] spi: dw-mid: split rx and tx callbacks when DMA
Date: Tue, 28 Oct 2014 18:25:02 +0200
Message-ID: <1414513502-595-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1414513502-595-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414513502-595-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Currently driver wouldn't work properly if user asked for simplex transfer. The
patch separates DMA rx and tx callbacks and finishes transfer correctly in any
case.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 53 +++++++++++++++++++++++++++++++++++-------------
 drivers/spi/spi-dw.h     |  2 +-
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index c8319ab..7281316 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -26,6 +26,9 @@
 #include <linux/intel_mid_dma.h>
 #include <linux/pci.h>
 
+#define RX_BUSY		0
+#define TX_BUSY		1
+
 struct mid_dma {
 	struct intel_mid_dma_slave	dmas_tx;
 	struct intel_mid_dma_slave	dmas_rx;
@@ -98,15 +101,14 @@ static void mid_spi_dma_exit(struct dw_spi *dws)
 }
 
 /*
- * dws->dma_chan_done is cleared before the dma transfer starts,
- * callback for rx/tx channel will each increment it by 1.
- * Reaching 2 means the whole spi transaction is done.
+ * dws->dma_chan_busy is set before the dma transfer starts, callback for tx
+ * channel will clear a corresponding bit.
  */
-static void dw_spi_dma_done(void *arg)
+static void dw_spi_dma_tx_done(void *arg)
 {
 	struct dw_spi *dws = arg;
 
-	if (++dws->dma_chan_done != 2)
+	if (test_and_clear_bit(TX_BUSY, &dws->dma_chan_busy) & BIT(RX_BUSY))
 		return;
 	dw_spi_xfer_done(dws);
 }
@@ -116,6 +118,9 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws)
 	struct dma_slave_config txconf;
 	struct dma_async_tx_descriptor *txdesc;
 
+	if (!dws->tx_dma)
+		return NULL;
+
 	txconf.direction = DMA_MEM_TO_DEV;
 	txconf.dst_addr = dws->dma_addr;
 	txconf.dst_maxburst = LNW_DMA_MSIZE_16;
@@ -134,17 +139,33 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws)
 				1,
 				DMA_MEM_TO_DEV,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	txdesc->callback = dw_spi_dma_done;
+	txdesc->callback = dw_spi_dma_tx_done;
 	txdesc->callback_param = dws;
 
 	return txdesc;
 }
 
+/*
+ * dws->dma_chan_busy is set before the dma transfer starts, callback for rx
+ * channel will clear a corresponding bit.
+ */
+static void dw_spi_dma_rx_done(void *arg)
+{
+	struct dw_spi *dws = arg;
+
+	if (test_and_clear_bit(RX_BUSY, &dws->dma_chan_busy) & BIT(TX_BUSY))
+		return;
+	dw_spi_xfer_done(dws);
+}
+
 static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws)
 {
 	struct dma_slave_config rxconf;
 	struct dma_async_tx_descriptor *rxdesc;
 
+	if (!dws->rx_dma)
+		return NULL;
+
 	rxconf.direction = DMA_DEV_TO_MEM;
 	rxconf.src_addr = dws->dma_addr;
 	rxconf.src_maxburst = LNW_DMA_MSIZE_16;
@@ -163,7 +184,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws)
 				1,
 				DMA_DEV_TO_MEM,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	rxdesc->callback = dw_spi_dma_done;
+	rxdesc->callback = dw_spi_dma_rx_done;
 	rxdesc->callback_param = dws;
 
 	return rxdesc;
@@ -195,8 +216,6 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 	if (cs_change)
 		dw_spi_dma_setup(dws);
 
-	dws->dma_chan_done = 0;
-
 	/* 2. Prepare the TX dma transfer */
 	txdesc = dw_spi_dma_prepare_tx(dws);
 
@@ -204,11 +223,17 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 	rxdesc = dw_spi_dma_prepare_rx(dws);
 
 	/* rx must be started before tx due to spi instinct */
-	dmaengine_submit(rxdesc);
-	dma_async_issue_pending(dws->rxchan);
-
-	dmaengine_submit(txdesc);
-	dma_async_issue_pending(dws->txchan);
+	if (rxdesc) {
+		set_bit(RX_BUSY, &dws->dma_chan_busy);
+		dmaengine_submit(rxdesc);
+		dma_async_issue_pending(dws->rxchan);
+	}
+
+	if (txdesc) {
+		set_bit(TX_BUSY, &dws->dma_chan_busy);
+		dmaengine_submit(txdesc);
+		dma_async_issue_pending(dws->txchan);
+	}
 
 	return 0;
 }
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 83a103a..3d32be6 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -139,7 +139,7 @@ struct dw_spi {
 	struct scatterlist	tx_sgl;
 	struct dma_chan		*rxchan;
 	struct scatterlist	rx_sgl;
-	int			dma_chan_done;
+	unsigned long		dma_chan_busy;
 	struct device		*dma_dev;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
 	struct dw_spi_dma_ops	*dma_ops;
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
