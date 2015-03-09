From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 6/7] spi: dw-mid: convert to use dw_dmac instead of intel_mid_dma
Date: Mon,  9 Mar 2015 16:48:50 +0200
Message-ID: <1425912531-23457-7-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1425912531-23457-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425912531-23457-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

intel_mid_dma seems to be unmaintained for a long time. Moreover, the IP block
of DMA itself is the same in both dw_dmac and intel_mid_dma. This patch moves
spi-dw-midpci to use dw_dmac driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/Kconfig      |  2 +-
 drivers/spi/spi-dw-mid.c | 45 +++++++++++++++++++--------------------------
 drivers/spi/spi-dw.h     |  4 ++--
 3 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ab8dfbe..9131079 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -632,7 +632,7 @@ config SPI_DW_PCI
 
 config SPI_DW_MID_DMA
 	bool "DMA support for DW SPI controller on Intel MID platform"
-	depends on SPI_DW_PCI && INTEL_MID_DMAC
+	depends on SPI_DW_PCI && DW_DMAC_PCI
 
 config SPI_DW_MMIO
 	tristate "Memory-mapped io interface driver for DW SPI core"
diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 599dad4..d4109f6 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -23,29 +23,31 @@
 #include "spi-dw.h"
 
 #ifdef CONFIG_SPI_DW_MID_DMA
-#include <linux/intel_mid_dma.h>
 #include <linux/pci.h>
+#include <linux/platform_data/dma-dw.h>
 
 #define RX_BUSY		0
 #define TX_BUSY		1
 
-struct mid_dma {
-	struct intel_mid_dma_slave	dmas_tx;
-	struct intel_mid_dma_slave	dmas_rx;
-};
+static struct dw_dma_slave mid_dma_tx = { .dst_id = 1 };
+static struct dw_dma_slave mid_dma_rx = { .src_id = 0 };
 
 static bool mid_spi_dma_chan_filter(struct dma_chan *chan, void *param)
 {
-	struct dw_spi *dws = param;
+	struct dw_dma_slave *s = param;
+
+	if (s->dma_dev != chan->device->dev)
+		return false;
 
-	return dws->dma_dev == chan->device->dev;
+	chan->private = s;
+	return true;
 }
 
 static int mid_spi_dma_init(struct dw_spi *dws)
 {
-	struct mid_dma *dw_dma = dws->dma_priv;
 	struct pci_dev *dma_dev;
-	struct intel_mid_dma_slave *rxs, *txs;
+	struct dw_dma_slave *tx = dws->dma_tx;
+	struct dw_dma_slave *rx = dws->dma_rx;
 	dma_cap_mask_t mask;
 
 	/*
@@ -56,29 +58,21 @@ static int mid_spi_dma_init(struct dw_spi *dws)
 	if (!dma_dev)
 		return -ENODEV;
 
-	dws->dma_dev = &dma_dev->dev;
-
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
 	/* 1. Init rx channel */
-	dws->rxchan = dma_request_channel(mask, mid_spi_dma_chan_filter, dws);
+	rx->dma_dev = &dma_dev->dev;
+	dws->rxchan = dma_request_channel(mask, mid_spi_dma_chan_filter, rx);
 	if (!dws->rxchan)
 		goto err_exit;
-	rxs = &dw_dma->dmas_rx;
-	rxs->hs_mode = LNW_DMA_HW_HS;
-	rxs->cfg_mode = LNW_DMA_PER_TO_MEM;
-	dws->rxchan->private = rxs;
 	dws->master->dma_rx = dws->rxchan;
 
 	/* 2. Init tx channel */
-	dws->txchan = dma_request_channel(mask, mid_spi_dma_chan_filter, dws);
+	tx->dma_dev = &dma_dev->dev;
+	dws->txchan = dma_request_channel(mask, mid_spi_dma_chan_filter, tx);
 	if (!dws->txchan)
 		goto free_rxchan;
-	txs = &dw_dma->dmas_tx;
-	txs->hs_mode = LNW_DMA_HW_HS;
-	txs->cfg_mode = LNW_DMA_MEM_TO_PER;
-	dws->txchan->private = txs;
 	dws->master->dma_tx = dws->txchan;
 
 	dws->dma_inited = 1;
@@ -163,7 +157,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
 
 	txconf.direction = DMA_MEM_TO_DEV;
 	txconf.dst_addr = dws->dma_addr;
-	txconf.dst_maxburst = LNW_DMA_MSIZE_16;
+	txconf.dst_maxburst = 16;
 	txconf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	txconf.dst_addr_width = convert_dma_width(dws->dma_width);
 	txconf.device_fc = false;
@@ -209,7 +203,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
 
 	rxconf.direction = DMA_DEV_TO_MEM;
 	rxconf.src_addr = dws->dma_addr;
-	rxconf.src_maxburst = LNW_DMA_MSIZE_16;
+	rxconf.src_maxburst = 16;
 	rxconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	rxconf.src_addr_width = convert_dma_width(dws->dma_width);
 	rxconf.device_fc = false;
@@ -328,9 +322,8 @@ int dw_spi_mid_init(struct dw_spi *dws)
 	iounmap(clk_reg);
 
 #ifdef CONFIG_SPI_DW_MID_DMA
-	dws->dma_priv = kzalloc(sizeof(struct mid_dma), GFP_KERNEL);
-	if (!dws->dma_priv)
-		return -ENOMEM;
+	dws->dma_tx = &mid_dma_tx;
+	dws->dma_rx = &mid_dma_rx;
 	dws->dma_ops = &mid_dma_ops;
 #endif
 	return 0;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index f298df5..41f77e2 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -128,10 +128,10 @@ struct dw_spi {
 	struct dma_chan		*txchan;
 	struct dma_chan		*rxchan;
 	unsigned long		dma_chan_busy;
-	struct device		*dma_dev;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
 	struct dw_spi_dma_ops	*dma_ops;
-	void			*dma_priv; /* platform relate info */
+	void			*dma_tx;
+	void			*dma_rx;
 
 	/* Bus interface info */
 	void			*priv;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
