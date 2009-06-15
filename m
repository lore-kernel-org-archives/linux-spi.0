From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] spi: add DMA support for Intel
 Moorestown SPI controller
Date: Mon, 15 Jun 2009 17:41:05 +0800
Message-ID: <20090615174105.29471af1@feng-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org
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

>From 6dbcddf7fefbef8b8828ecb358dc177f37685c46 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date: Mon, 15 Jun 2009 17:00:11 +0800
Subject: [PATCH 2/2] spi: add DMA support for Intel Moorestown SPI controller

The DMA has been only tested with the DMA controller 2 on the
Moorestown platform

Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Kconfig    |    7 ++
 drivers/spi/mrst_spi.c |  208 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 215 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index e1cba00..f7d82ea 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -229,6 +229,13 @@ config SPI_MRST
 	  The controller is a PCI device, and its core is a Synopsis
 	  DesignWare SPI controller.
 
+config SPI_MRST_DMA
+	boolean "Enable DMA for MRST SPI0 controller"
+	default y
+	depends on SPI_MRST && INTEL_LNW_DMAC2
+	help
+	  This has to be enabled after Moorestown DMAC2 driver is enabled
+
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
diff --git a/drivers/spi/mrst_spi.c b/drivers/spi/mrst_spi.c
index 99a1129..11fae26 100644
--- a/drivers/spi/mrst_spi.c
+++ b/drivers/spi/mrst_spi.c
@@ -34,6 +34,10 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/mrst_spi.h>
 
+#ifdef CONFIG_SPI_MRST_DMA
+#include <linux/lnw_dma.h>
+#endif
+
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #endif
@@ -109,6 +113,19 @@ struct driver_data {
 #endif
 
 	int dma_inited;
+
+#ifdef CONFIG_SPI_MRST_DMA
+	struct lnw_dma_slave	dmas_tx;
+	struct lnw_dma_slave	dmas_rx;
+	struct dma_chan		*txchan;
+	struct dma_chan		*rxchan;
+	int txdma_done;
+	int rxdma_done;
+
+	u64 tx_param;
+	u64 rx_param;
+	struct pci_dev *dma_dev;
+#endif
 };
 
 /* slave spi_dev related */
@@ -136,6 +153,128 @@ struct chip_data {
 	void (*cs_control)(u32 command);
 };
 
+#ifdef CONFIG_SPI_MRST_DMA
+static bool chan_filter(struct dma_chan *chan, void *param)
+{
+	struct driver_data *drv_data = param;
+	bool ret = false;
+
+	if (chan->device->dev == &drv_data->dma_dev->dev)
+		ret = true;
+	return ret;
+}
+
+static void mrst_spi_dma_init(struct driver_data *drv_data)
+{
+	struct lnw_dma_slave *rxs, *txs;
+	dma_cap_mask_t mask;
+	struct pci_dev *dmac2;
+
+	drv_data->txchan = NULL;
+	drv_data->rxchan = NULL;
+
+	/* mrst spi0 controller only work with mrst dma contrller 2 */
+	dmac2 = pci_get_device(PCI_VENDOR_ID_INTEL, 0x0813, NULL);
+	if (!dmac2) {
+		printk(KERN_WARNING
+			"MRST SPI0: can't find DMAC2, dma init failed\n");
+		return;
+	} else
+		drv_data->dma_dev = dmac2;
+
+	/* 1. init rx channel */
+	rxs = &drv_data->dmas_rx;
+
+	rxs->dirn = DMA_FROM_DEVICE;
+	rxs->hs_mode = LNW_DMA_HW_HS;
+	rxs->cfg_mode = LNW_DMA_PER_TO_MEM;
+	rxs->src_width = LNW_DMA_WIDTH_16BIT;
+	rxs->dst_width = LNW_DMA_WIDTH_32BIT;
+	rxs->src_msize = LNW_DMA_MSIZE_16;
+	rxs->dst_msize = LNW_DMA_MSIZE_16;
+
+	rxs->rx_reg = (dma_addr_t)(drv_data->paddr + 0x60);
+	rxs->tx_reg = (dma_addr_t)0;
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	drv_data->rxchan = dma_request_channel(mask, chan_filter,
+						drv_data);
+	if (!drv_data->rxchan)
+		goto err_exit;
+	drv_data->rxchan->private = rxs;
+
+	/* 2. init tx channel */
+	txs = &drv_data->dmas_tx;
+
+	txs->dirn = DMA_TO_DEVICE;
+	txs->hs_mode = LNW_DMA_HW_HS;
+	txs->cfg_mode = LNW_DMA_MEM_TO_PER;
+	txs->src_width = LNW_DMA_WIDTH_32BIT;
+	txs->dst_width = LNW_DMA_WIDTH_16BIT;
+	txs->src_msize = LNW_DMA_MSIZE_16;
+	txs->dst_msize = LNW_DMA_MSIZE_16;
+
+	txs->tx_reg = (dma_addr_t)(drv_data->paddr + 0x60);
+	txs->rx_reg = (dma_addr_t)0;
+	dma_cap_set(DMA_SLAVE, mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+
+	drv_data->txchan = dma_request_channel(mask, chan_filter,
+						drv_data);
+	if (!drv_data->txchan)
+		goto free_rxchan;
+	drv_data->txchan->private = txs;
+
+	/* set the dma done bit to 1 */
+	drv_data->dma_inited = 1;
+	drv_data->txdma_done = 1;
+	drv_data->rxdma_done = 1;
+
+	drv_data->tx_param = ((u64)(u32)drv_data << 32)
+				| (u32)(&drv_data->txdma_done);
+	drv_data->rx_param = ((u64)(u32)drv_data << 32)
+				| (u32)(&drv_data->rxdma_done);
+	return;
+
+free_rxchan:
+	dma_release_channel(drv_data->rxchan);
+err_exit:
+	pci_dev_put(dmac2);
+	return;
+}
+
+static void mrst_spi_dma_exit(struct driver_data *drv_data)
+{
+	dma_release_channel(drv_data->txchan);
+	dma_release_channel(drv_data->rxchan);
+	pci_dev_put(drv_data->dma_dev);
+}
+
+
+static inline void unmap_dma_buffers(struct driver_data *drv_data);
+static void transfer_complete(struct driver_data *drv_data);
+
+static void mrst_spi_dma_done(void *arg)
+{
+	u64 *param = arg;
+	struct driver_data *drv_data;
+	int *done;
+
+	drv_data = (struct driver_data *)(u32)(*param >> 32);
+	done = (int *)(u32)(*param & 0xffffffff);
+
+	*done = 1;
+	/* wait till both tx/rx channels are done */
+	if (!drv_data->txdma_done || !drv_data->rxdma_done)
+		return;
+
+	transfer_complete(drv_data);
+}
+#endif
+
+
 #ifdef CONFIG_DEBUG_FS
 static int spi_show_regs_open(struct inode *inode, struct file *file)
 {
@@ -419,7 +558,66 @@ static void giveback(struct driver_data *drv_data)
 
 static void dma_transfer(struct driver_data *drv_data, int cs_change)
 {
+#ifdef CONFIG_SPI_MRST_DMA
+	void *reg = drv_data->vaddr;
+	struct dma_async_tx_descriptor *txdesc = NULL, *rxdesc = NULL;
+	struct dma_chan *txchan, *rxchan;
+	enum dma_ctrl_flags flag;
+	u16 dmacr = 0;
+
+	/* 1. setup DMA related registers */
+	if (cs_change) {
+		mrst_spi_enable(reg, 0);
+
+		write_dmardlr(0xf, reg);
+		write_dmatdlr(0x10, reg);
+
+		if (drv_data->tx_dma)
+			dmacr |= 0x2;
+		if (drv_data->rx_dma)
+			dmacr |= 0x1;
+
+		write_dmacr(dmacr, reg);
+		mrst_spi_enable(reg, 1);
+	}
+
+	if (drv_data->tx_dma)
+		drv_data->txdma_done = 0;
 
+	if (drv_data->rx_dma)
+		drv_data->rxdma_done = 0;
+
+	/* 2. start the TX dma transfer */
+	txchan = drv_data->txchan;
+	rxchan = drv_data->rxchan;
+
+	flag = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
+
+	if (drv_data->tx_dma) {
+		txdesc = txchan->device->device_prep_dma_memcpy(txchan,
+				drv_data->dmas_tx.tx_reg, drv_data->tx_dma,
+				drv_data->len, flag);
+
+		txdesc->callback = mrst_spi_dma_done;
+		txdesc->callback_param = &drv_data->tx_param;
+	}
+
+	/* 3. start the RX dma transfer */
+	if (drv_data->rx_dma) {
+		rxdesc = rxchan->device->device_prep_dma_memcpy(rxchan,
+				drv_data->rx_dma, drv_data->dmas_rx.rx_reg,
+				drv_data->len, flag);
+
+		rxdesc->callback = mrst_spi_dma_done;
+		rxdesc->callback_param = &drv_data->rx_param;
+	}
+
+	/* rx must be started before tx due to spi instinct */
+	if (rxdesc)
+		rxdesc->tx_submit(rxdesc);
+	if (txdesc)
+		txdesc->tx_submit(txdesc);
+#endif
 }
 
 static void int_error_stop(struct driver_data *drv_data, const char *msg)
@@ -1012,6 +1210,9 @@ static int __devinit mrst_spi_probe(struct pci_dev *pdev,
 	master->transfer = mrst_spi_transfer;
 
 	drv_data->dma_inited = 0;
+#ifdef CONFIG_SPI_MRST_DMA
+	mrst_spi_dma_init(drv_data);
+#endif
 
 	/* basic HW init */
 	spi_hw_init(drv_data);
@@ -1042,6 +1243,9 @@ static int __devinit mrst_spi_probe(struct pci_dev *pdev,
 
 err_queue_alloc:
 	destroy_queue(drv_data);
+#ifdef CONFIG_SPI_MRST_DMA
+	mrst_spi_dma_exit(drv_data);
+#endif
 err_diable_hw:
 	mrst_spi_enable(drv_data->vaddr, 0);
 	free_irq(drv_data->irq, drv_data);
@@ -1072,6 +1276,10 @@ static void __devexit mrst_spi_remove(struct pci_dev *pdev)
 		dev_err(&pdev->dev, "mrst_spi_remove: workqueue will not "
 			"complete, message memory not freed\n");
 
+#ifdef CONFIG_SPI_MRST_DMA
+	mrst_spi_dma_exit(drv_data);
+#endif
+
 	reg = drv_data->vaddr;
 	mrst_spi_enable(reg, 0);
 	spi_disable_clk(reg);
-- 
1.5.6.3

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
