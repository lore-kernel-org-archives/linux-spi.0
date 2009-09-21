From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3 v2][RESEND] spi: DMA support for
 Designware core on Moorestown platform
Date: Mon, 21 Sep 2009 16:47:41 +0800
Message-ID: <20090921164741.5aa1c405@feng-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
To: <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

>From 792f1d88fb42e0a526f968a16118de1508934d2c Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date: Tue, 4 Aug 2009 16:42:31 +0800
Subject: [PATCH 3/3] spi: DMA support for Designware core on Moorestown platform

Designware core can work with multiple DMA controllers for DMA
operation, and this patch supports it to cowork with the Designware
DMA controller used on Intel Moorestown platform

Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Kconfig        |    4 +
 drivers/spi/dw_spi.c       |  173 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/spi/dw_spi.h |    6 ++
 3 files changed, 179 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 906bca4..e3f98d9 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -233,6 +233,10 @@ config SPI_DESIGNWARE
 	help
 	  general driver for SPI controller core from DesignWare
 
+config SPI_DW_MRST_DMA
+	bool "DMA support for DW SPI controller on Intel Moorestown platform"
+	depends on SPI_DESGINWARE && MRST_DMA
+
 config SPI_DW_PCI
 	tristate "PCI interface driver for DW SPI core"
 	depends on SPI_DESIGNWARE && PCI
diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
index 261c27c..aed7e57 100644
--- a/drivers/spi/dw_spi.c
+++ b/drivers/spi/dw_spi.c
@@ -29,6 +29,10 @@
 #include <linux/debugfs.h>
 #endif
 
+#ifdef CONFIG_SPI_MRST_DMA
+#include <linux/lnw_dma.h>
+#endif
+
 #define START_STATE	((void *)0)
 #define RUNNING_STATE	((void *)1)
 #define DONE_STATE	((void *)2)
@@ -62,6 +66,168 @@ struct chip_data {
 	void (*cs_control)(u32 command);
 };
 
+#ifdef CONFIG_SPI_MRST_DMA
+static void dw_spi_dma_init(struct dw_spi *dws)
+{
+	struct lnw_dma_slave *rxs, *txs;
+	dma_cap_mask_t mask;
+
+	dws->txchan = NULL;
+	dws->rxchan = NULL;
+
+	/* 1. Init rx channel */
+	rxs = &dws->dmas_rx;
+
+	rxs->dirn = DMA_FROM_DEVICE;
+	rxs->hs_mode = LNW_DMA_HW_HS;
+	rxs->cfg_mode = LNW_DMA_PER_TO_MEM;
+	rxs->src_width = LNW_DMA_WIDTH_16BIT;
+	rxs->dst_width = LNW_DMA_WIDTH_32BIT;
+	rxs->src_msize = LNW_DMA_MSIZE_16;
+	rxs->dst_msize = LNW_DMA_MSIZE_16;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	dws->rxchan = dma_request_channel(mask, NULL, NULL);
+	if (!dws->rxchan)
+		goto err_exit;
+	dws->rxchan->private = rxs;
+
+	/* 2. Init tx channel */
+	txs = &dws->dmas_tx;
+
+	txs->dirn = DMA_TO_DEVICE;
+	txs->hs_mode = LNW_DMA_HW_HS;
+	txs->cfg_mode = LNW_DMA_MEM_TO_PER;
+	txs->src_width = LNW_DMA_WIDTH_32BIT;
+	txs->dst_width = LNW_DMA_WIDTH_16BIT;
+	txs->src_msize = LNW_DMA_MSIZE_16;
+	txs->dst_msize = LNW_DMA_MSIZE_16;
+
+	dma_cap_set(DMA_SLAVE, mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+
+	dws->txchan = dma_request_channel(mask, NULL, NULL);
+	if (!dws->txchan)
+		goto free_rxchan;
+	dws->txchan->private = txs;
+
+	/* Set the dma done bit to 1 */
+	dws->dma_inited = 1;
+	dws->txdma_done = 1;
+	dws->rxdma_done = 1;
+
+	dws->tx_param = ((u64)(unsigned long)dws << 32)
+				| (unsigned long)(&dws->txdma_done);
+	dws->rx_param = ((u64)(unsigned long)dws << 32)
+				| (unsigned long)(&dws->rxdma_done);
+	return;
+
+free_rxchan:
+	dma_release_channel(dws->rxchan);
+err_exit:
+	return;
+}
+
+static void dw_spi_dma_exit(struct dw_spi *dws)
+{
+	dma_release_channel(dws->txchan);
+	dma_release_channel(dws->rxchan);
+}
+
+
+static inline void unmap_dma_buffers(struct dw_spi *dws);
+static void transfer_complete(struct dw_spi *dws);
+
+static void dw_spi_dma_done(void *arg)
+{
+	u64 *param = arg;
+	struct dw_spi *dws;
+	int *done;
+
+	dws = (struct dw_spi *)(unsigned long)(*param >> 32);
+	done = (int *)(unsigned long)(*param & 0xffffffff);
+
+	*done = 1;
+	/* wait till both tx/rx channels are done */
+	if (!dws->txdma_done || !dws->rxdma_done)
+		return;
+
+	transfer_complete(dws);
+}
+
+static void dma_transfer(struct dw_spi *dws, int cs_change)
+{
+	struct dma_async_tx_descriptor *txdesc = NULL, *rxdesc = NULL;
+	struct dma_chan *txchan, *rxchan;
+	enum dma_ctrl_flags flag;
+	u16 dma_ctrl = 0;
+
+	/* 1. setup DMA related registers */
+	if (cs_change) {
+		spi_enable_chip(dws, 0);
+		dw_writew(dws, dmardlr, 0xf);
+		dw_writew(dws, dmatdlr, 0x10);
+		if (dws->tx_dma)
+			dma_ctrl |= 0x2;
+		if (dws->rx_dma)
+			dma_ctrl |= 0x1;
+		dw_writew(dws, dmacr, dma_ctrl);
+		spi_enable_chip(dws, 1);
+	}
+
+	if (dws->tx_dma)
+		dws->txdma_done = 0;
+	if (dws->rx_dma)
+		dws->rxdma_done = 0;
+
+	/* 2. start the TX dma transfer */
+	txchan = dws->txchan;
+	rxchan = dws->rxchan;
+
+	flag = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
+	if (dws->tx_dma) {
+		txdesc = txchan->device->device_prep_dma_memcpy(txchan,
+				dws->dma_addr, dws->tx_dma,
+				dws->len, flag);
+		txdesc->callback = dw_spi_dma_done;
+		txdesc->callback_param = &dws->tx_param;
+	}
+
+	/* 3. start the RX dma transfer */
+	if (dws->rx_dma) {
+		rxdesc = rxchan->device->device_prep_dma_memcpy(rxchan,
+				dws->rx_dma, dws->dma_addr,
+				dws->len, flag);
+		rxdesc->callback = dw_spi_dma_done;
+		rxdesc->callback_param = &dws->rx_param;
+	}
+
+	/* rx must be started before tx due to spi instinct */
+	if (rxdesc)
+		rxdesc->tx_submit(rxdesc);
+	if (txdesc)
+		txdesc->tx_submit(txdesc);
+}
+#else
+static inline void dw_spi_dma_init(struct dw_spi *dws)
+{
+	return;
+}
+
+static inline void dw_spi_dma_exit(struct dw_spi *dws)
+{
+	return;
+}
+
+static void dma_transfer(struct dw_spi *dws, int cs_change)
+{
+	return;
+}
+#endif /* CONFIG_SPI_MRST_DMA */
+
 #ifdef CONFIG_DEBUG_FS
 static int spi_show_regs_open(struct inode *inode, struct file *file)
 {
@@ -413,10 +579,6 @@ static void poll_transfer(struct dw_spi *dws)
 	transfer_complete(dws);
 }
 
-static void dma_transfer(struct dw_spi *dws, int cs_change)
-{
-}
-
 static void pump_transfers(unsigned long data)
 {
 	struct dw_spi *dws = (struct dw_spi *)data;
@@ -853,6 +1015,7 @@ int __devinit dw_spi_add_host(struct dw_spi *dws)
 	master->transfer = dw_spi_transfer;
 
 	dws->dma_inited = 0;
+	dw_spi_dma_init(dws);
 
 	/* Basic HW init */
 	spi_hw_init(dws);
@@ -881,6 +1044,7 @@ int __devinit dw_spi_add_host(struct dw_spi *dws)
 
 err_queue_alloc:
 	destroy_queue(dws);
+	dw_spi_dma_exit(dws);
 err_diable_hw:
 	spi_enable_chip(dws, 0);
 	free_irq(dws->irq, dws);
@@ -904,6 +1068,7 @@ void __devexit dw_spi_remove_host(struct dw_spi *dws)
 		dev_err(&dws->master->dev, "dw_spi_remove: workqueue will not "
 			"complete, message memory not freed\n");
 
+	dw_spi_dma_exit(dws);
 	spi_enable_chip(dws, 0);
 	/* Disable clk */
 	spi_set_clk(dws, 0);
diff --git a/include/linux/spi/dw_spi.h b/include/linux/spi/dw_spi.h
index 51b3e77..4881a18 100644
--- a/include/linux/spi/dw_spi.h
+++ b/include/linux/spi/dw_spi.h
@@ -1,6 +1,7 @@
 #ifndef DW_SPI_HEADER_H
 #define DW_SPI_HEADER_H
 #include <linux/io.h>
+#include <linux/lnw_dma.h>
 
 /* Bit fields in CTRLR0 */
 #define SPI_DFS_OFFSET			0
@@ -141,6 +142,11 @@ struct dw_spi {
 	struct device		*dma_dev;
 	dma_addr_t		dma_addr;
 
+#ifdef CONFIG_SPI_MRST_DMA
+	struct lnw_dma_slave	dmas_tx;
+	struct lnw_dma_slave	dmas_rx;
+#endif
+
 	/* Bus interface info */
 	void			*priv;
 #ifdef CONFIG_DEBUG_FS
-- 
1.5.6.3

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
