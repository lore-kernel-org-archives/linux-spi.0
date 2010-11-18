From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: [PATCH] dw_spi: add DMA support
Date: Thu, 18 Nov 2010 20:31:18 +0000
Message-ID: <20101118203114.27620.77796.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

dw_spi driver in upstream only supports PIO mode, and this patch
will support it to cowork with the Designware DMA controller used
on Intel Moorestown platform

It has been tested with a Option GTM501L 3G modem, to use DMA mode,
DMA controller 2 of Moorestown has to be enabled

Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
[Typo fix and renames to match intel_mid_dma renaming]
Signed-off-by: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
[Clean up]
Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
[Fix timing delay, add cpu_relax]
Signed-off-by: Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---

 drivers/spi/Kconfig        |    4 +
 drivers/spi/Makefile       |    3 -
 drivers/spi/dw_spi.c       |   48 +++++----
 drivers/spi/dw_spi_mid.c   |  246 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/spi/dw_spi_pci.c   |   14 ++-
 include/linux/spi/dw_spi.h |   15 +++
 6 files changed, 305 insertions(+), 25 deletions(-)
 create mode 100644 drivers/spi/dw_spi_mid.c


diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 82e45cf..6e6a638 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -404,6 +404,10 @@ config SPI_DW_PCI
 	tristate "PCI interface driver for DW SPI core"
 	depends on SPI_DESIGNWARE && PCI
 
+config SPI_DW_MID_DMA
+	bool "DMA support for DW SPI controller on Intel Moorestown platform"
+	depends on SPI_DW_PCI && INTEL_MID_DMAC
+
 config SPI_DW_MMIO
 	tristate "Memory-mapped io interface driver for DW SPI core"
 	depends on SPI_DESIGNWARE && HAVE_CLK
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index b427c2e..4949370 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -17,7 +17,8 @@ obj-$(CONFIG_SPI_BUTTERFLY)		+= spi_butterfly.o
 obj-$(CONFIG_SPI_COLDFIRE_QSPI)		+= coldfire_qspi.o
 obj-$(CONFIG_SPI_DAVINCI)		+= davinci_spi.o
 obj-$(CONFIG_SPI_DESIGNWARE)		+= dw_spi.o
-obj-$(CONFIG_SPI_DW_PCI)		+= dw_spi_pci.o
+obj-$(CONFIG_SPI_DW_PCI)		+= dw_spi_midpci.o
+dw_spi_midpci-objs			:= dw_spi_pci.o dw_spi_mid.o
 obj-$(CONFIG_SPI_DW_MMIO)		+= dw_spi_mmio.o
 obj-$(CONFIG_SPI_EP93XX)		+= ep93xx_spi.o
 obj-$(CONFIG_SPI_GPIO)			+= spi_gpio.o
diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
index 9043931..69cc223 100644
--- a/drivers/spi/dw_spi.c
+++ b/drivers/spi/dw_spi.c
@@ -164,20 +164,23 @@ static inline void mrst_spi_debugfs_remove(struct dw_spi *dws)
 
 static void wait_till_not_busy(struct dw_spi *dws)
 {
-	unsigned long end = jiffies + 1 + usecs_to_jiffies(1000);
+	unsigned long end = jiffies + 1 + usecs_to_jiffies(5000);
 
 	while (time_before(jiffies, end)) {
 		if (!(dw_readw(dws, sr) & SR_BUSY))
 			return;
+		cpu_relax();
 	}
 	dev_err(&dws->master->dev,
-		"DW SPI: Status keeps busy for 1000us after a read/write!\n");
+		"DW SPI: Status keeps busy for 5000us after a read/write!\n");
 }
 
 static void flush(struct dw_spi *dws)
 {
-	while (dw_readw(dws, sr) & SR_RF_NOT_EMPT)
+	while (dw_readw(dws, sr) & SR_RF_NOT_EMPT) {
 		dw_readw(dws, dr);
+		cpu_relax();
+	}
 
 	wait_till_not_busy(dws);
 }
@@ -285,8 +288,10 @@ static void *next_transfer(struct dw_spi *dws)
  */
 static int map_dma_buffers(struct dw_spi *dws)
 {
-	if (!dws->cur_msg->is_dma_mapped || !dws->dma_inited
-		|| !dws->cur_chip->enable_dma)
+	if (!dws->cur_msg->is_dma_mapped
+		|| !dws->dma_inited
+		|| !dws->cur_chip->enable_dma
+		|| !dws->dma_ops)
 		return 0;
 
 	if (dws->cur_transfer->tx_dma)
@@ -338,7 +343,7 @@ static void int_error_stop(struct dw_spi *dws, const char *msg)
 	tasklet_schedule(&dws->pump_transfers);
 }
 
-static void transfer_complete(struct dw_spi *dws)
+void dw_spi_xfer_done(struct dw_spi *dws)
 {
 	/* Update total byte transfered return count actual bytes read */
 	dws->cur_msg->actual_length += dws->len;
@@ -353,6 +358,7 @@ static void transfer_complete(struct dw_spi *dws)
 	} else
 		tasklet_schedule(&dws->pump_transfers);
 }
+EXPORT_SYMBOL_GPL(dw_spi_xfer_done);
 
 static irqreturn_t interrupt_transfer(struct dw_spi *dws)
 {
@@ -384,7 +390,7 @@ static irqreturn_t interrupt_transfer(struct dw_spi *dws)
 		if (dws->tx_end > dws->tx)
 			spi_umask_intr(dws, SPI_INT_TXEI);
 		else
-			transfer_complete(dws);
+			dw_spi_xfer_done(dws);
 	}
 
 	return IRQ_HANDLED;
@@ -414,11 +420,7 @@ static void poll_transfer(struct dw_spi *dws)
 	while (dws->write(dws))
 		dws->read(dws);
 
-	transfer_complete(dws);
-}
-
-static void dma_transfer(struct dw_spi *dws, int cs_change)
-{
+	dw_spi_xfer_done(dws);
 }
 
 static void pump_transfers(unsigned long data)
@@ -600,7 +602,7 @@ static void pump_transfers(unsigned long data)
 	}
 
 	if (dws->dma_mapped)
-		dma_transfer(dws, cs_change);
+		dws->dma_ops->dma_transfer(dws, cs_change);
 
 	if (chip->poll_mode)
 		poll_transfer(dws);
@@ -896,11 +898,15 @@ int __devinit dw_spi_add_host(struct dw_spi *dws)
 	master->setup = dw_spi_setup;
 	master->transfer = dw_spi_transfer;
 
-	dws->dma_inited = 0;
-
 	/* Basic HW init */
 	spi_hw_init(dws);
 
+	if (dws->dma_ops && dws->dma_ops->dma_init) {
+		ret = dws->dma_ops->dma_init(dws);
+		if (ret)
+			goto err_diable_hw;
+	}
+
 	/* Initial and start queue */
 	ret = init_queue(dws);
 	if (ret) {
@@ -925,6 +931,8 @@ int __devinit dw_spi_add_host(struct dw_spi *dws)
 
 err_queue_alloc:
 	destroy_queue(dws);
+	if (dws->dma_ops && dws->dma_ops->dma_exit)
+		dws->dma_ops->dma_exit(dws);
 err_diable_hw:
 	spi_enable_chip(dws, 0);
 	free_irq(dws->irq, dws);
@@ -933,7 +941,7 @@ err_free_master:
 exit:
 	return ret;
 }
-EXPORT_SYMBOL(dw_spi_add_host);
+EXPORT_SYMBOL_GPL(dw_spi_add_host);
 
 void __devexit dw_spi_remove_host(struct dw_spi *dws)
 {
@@ -949,6 +957,8 @@ void __devexit dw_spi_remove_host(struct dw_spi *dws)
 		dev_err(&dws->master->dev, "dw_spi_remove: workqueue will not "
 			"complete, message memory not freed\n");
 
+	if (dws->dma_ops && dws->dma_ops->dma_exit)
+		dws->dma_ops->dma_exit(dws);
 	spi_enable_chip(dws, 0);
 	/* Disable clk */
 	spi_set_clk(dws, 0);
@@ -957,7 +967,7 @@ void __devexit dw_spi_remove_host(struct dw_spi *dws)
 	/* Disconnect from the SPI framework */
 	spi_unregister_master(dws->master);
 }
-EXPORT_SYMBOL(dw_spi_remove_host);
+EXPORT_SYMBOL_GPL(dw_spi_remove_host);
 
 int dw_spi_suspend_host(struct dw_spi *dws)
 {
@@ -970,7 +980,7 @@ int dw_spi_suspend_host(struct dw_spi *dws)
 	spi_set_clk(dws, 0);
 	return ret;
 }
-EXPORT_SYMBOL(dw_spi_suspend_host);
+EXPORT_SYMBOL_GPL(dw_spi_suspend_host);
 
 int dw_spi_resume_host(struct dw_spi *dws)
 {
@@ -982,7 +992,7 @@ int dw_spi_resume_host(struct dw_spi *dws)
 		dev_err(&dws->master->dev, "fail to start queue (%d)\n", ret);
 	return ret;
 }
-EXPORT_SYMBOL(dw_spi_resume_host);
+EXPORT_SYMBOL_GPL(dw_spi_resume_host);
 
 MODULE_AUTHOR("Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
 MODULE_DESCRIPTION("Driver for DesignWare SPI controller core");
diff --git a/drivers/spi/dw_spi_mid.c b/drivers/spi/dw_spi_mid.c
new file mode 100644
index 0000000..465e1cd
--- /dev/null
+++ b/drivers/spi/dw_spi_mid.c
@@ -0,0 +1,246 @@
+/*
+ * dw_spi_mid.c - special handling for DW core on Intel MID platform
+ *
+ * Copyright (c) 2009, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/dw_spi.h>
+
+#ifdef CONFIG_SPI_DW_MID_DMA
+#include <linux/intel_mid_dma.h>
+#include <linux/pci.h>
+
+struct mid_dma {
+	struct intel_mid_dma_slave	dmas_tx;
+	struct intel_mid_dma_slave	dmas_rx;
+};
+
+static bool mid_spi_dma_chan_filter(struct dma_chan *chan, void *param)
+{
+	struct dw_spi *dws = (struct dw_spi *)param;
+	bool ret = false;
+
+	if (!dws->dmac)
+		goto out;
+
+	if (chan->device->dev == &dws->dmac->dev)
+		ret = true;
+
+out:
+	return ret;
+}
+
+static int mid_spi_dma_init(struct dw_spi *dws)
+{
+	struct mid_dma *dw_dma = dws->dma_priv;
+	struct intel_mid_dma_slave *rxs, *txs;
+	struct dma_slave_config *ds;
+	dma_cap_mask_t mask;
+
+	dws->txchan = NULL;
+	dws->rxchan = NULL;
+
+	/*get pci device for DMA*/
+	dws->dmac = pci_get_device(PCI_VENDOR_ID_INTEL, 0x813, NULL);
+
+	/* 1. Init rx channel */
+	rxs = &dw_dma->dmas_rx;
+	ds = &rxs->dma_slave;
+	ds->direction = DMA_FROM_DEVICE;
+	rxs->hs_mode = LNW_DMA_HW_HS;
+	rxs->cfg_mode = LNW_DMA_PER_TO_MEM;
+	ds->src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	ds->dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	ds->src_maxburst = 16;
+	ds->dst_maxburst = 16;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	dws->rxchan = dma_request_channel(mask, mid_spi_dma_chan_filter, dws);
+	if (!dws->rxchan)
+		goto err_exit;
+	dws->rxchan->private = rxs;
+
+	/* 2. Init tx channel */
+	txs = &dw_dma->dmas_tx;
+	ds = &txs->dma_slave;
+
+	ds->direction = DMA_TO_DEVICE;
+	txs->hs_mode = LNW_DMA_HW_HS;
+	txs->cfg_mode = LNW_DMA_MEM_TO_PER;
+	ds->src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	ds->dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	ds->src_maxburst = 16;
+	ds->dst_maxburst = 16;
+
+	dma_cap_set(DMA_SLAVE, mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+
+	dws->txchan = dma_request_channel(mask, mid_spi_dma_chan_filter, dws);
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
+	return 0;
+
+free_rxchan:
+	dma_release_channel(dws->rxchan);
+err_exit:
+	return -1;
+
+}
+
+static void mid_spi_dma_exit(struct dw_spi *dws)
+{
+	dma_release_channel(dws->txchan);
+	dma_release_channel(dws->rxchan);
+}
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
+	dw_spi_xfer_done(dws);
+}
+
+static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
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
+
+	return 0;
+}
+
+static struct dw_spi_dma_ops mid_dma_ops = {
+	.dma_init	= mid_spi_dma_init,
+	.dma_exit	= mid_spi_dma_exit,
+	.dma_transfer	= mid_spi_dma_transfer,
+};
+#endif
+
+/* Some specific info for SPI0 controller on Moorestown */
+/* HW info for MRST CLk Control Unit, one 32b reg */
+#define MRST_SPI_CLK_BASE	100000000	/* 100m */
+#define MRST_CLK_SPI0_REG	0xff11d86c
+#define CLK_SPI_BDIV_OFFSET	0
+#define CLK_SPI_BDIV_MASK	0x00000007
+#define CLK_SPI_CDIV_OFFSET	9
+#define CLK_SPI_CDIV_MASK	0x00000e00
+#define CLK_SPI_CDIV_100M	0x0
+#define CLK_SPI_CDIV_50M	0x1
+#define CLK_SPI_CDIV_33M	0x2
+#define CLK_SPI_CDIV_25M	0x3
+#define CLK_SPI_DISABLE_OFFSET	8
+
+int dw_spi_mid_init(struct dw_spi *dws)
+{
+	u32 *clk_reg, clk_cdiv;
+
+	clk_reg = ioremap_nocache(MRST_CLK_SPI0_REG, 16);
+	if (!clk_reg)
+		return -ENOMEM;
+
+	/* get SPI controller operating freq info */
+	clk_cdiv  = ((*clk_reg) & CLK_SPI_CDIV_MASK) >> CLK_SPI_CDIV_OFFSET;
+	dws->max_freq = MRST_SPI_CLK_BASE / (clk_cdiv + 1);
+	iounmap(clk_reg);
+
+	dws->num_cs = 16;
+	dws->fifo_len = 40;	/* FIFO has 40 words buffer */
+
+#ifdef CONFIG_SPI_DW_MID_DMA
+	dws->dma_priv = kzalloc(sizeof(struct mid_dma), GFP_KERNEL);
+	if (!dws->dma_priv)
+		return -ENOMEM;
+	dws->dma_ops = &mid_dma_ops;
+#endif
+	return 0;
+}
+
diff --git a/drivers/spi/dw_spi_pci.c b/drivers/spi/dw_spi_pci.c
index 1f52755..076d1f8 100644
--- a/drivers/spi/dw_spi_pci.c
+++ b/drivers/spi/dw_spi_pci.c
@@ -1,5 +1,5 @@
 /*
- * mrst_spi_pci.c - PCI interface driver for DW SPI Core
+ * dw_spi_pci.c - PCI interface driver for DW SPI Core
  *
  * Copyright (c) 2009, Intel Corporation.
  *
@@ -26,8 +26,8 @@
 #define DRIVER_NAME "dw_spi_pci"
 
 struct dw_spi_pci {
-	struct pci_dev		*pdev;
-	struct dw_spi		dws;
+	struct pci_dev	*pdev;
+	struct dw_spi	dws;
 };
 
 static int __devinit spi_pci_probe(struct pci_dev *pdev,
@@ -72,9 +72,13 @@ static int __devinit spi_pci_probe(struct pci_dev *pdev,
 	dws->parent_dev = &pdev->dev;
 	dws->bus_num = 0;
 	dws->num_cs = 4;
-	dws->max_freq = 25000000;	/* for Moorestwon */
 	dws->irq = pdev->irq;
-	dws->fifo_len = 40;		/* FIFO has 40 words buffer */
+
+	if (pdev->device == 0x0800) {
+		ret = dw_spi_mid_init(dws);
+		if (ret)
+			goto err_unmap;
+	}
 
 	ret = dw_spi_add_host(dws);
 	if (ret)
diff --git a/include/linux/spi/dw_spi.h b/include/linux/spi/dw_spi.h
index c91302f..b2ecf9f 100644
--- a/include/linux/spi/dw_spi.h
+++ b/include/linux/spi/dw_spi.h
@@ -1,5 +1,6 @@
 #ifndef DW_SPI_HEADER_H
 #define DW_SPI_HEADER_H
+
 #include <linux/io.h>
 
 /* Bit fields in CTRLR0 */
@@ -82,6 +83,13 @@ struct dw_spi_reg {
 				though only low 16 bits matters */
 } __packed;
 
+struct dw_spi;
+struct dw_spi_dma_ops {
+	int (*dma_init)(struct dw_spi *dws);
+	void (*dma_exit)(struct dw_spi *dws);
+	int (*dma_transfer)(struct dw_spi *dws, int cs_change);
+};
+
 struct dw_spi {
 	struct spi_master	*master;
 	struct spi_device	*cur_dev;
@@ -143,6 +151,9 @@ struct dw_spi {
 	u64			rx_param;
 	struct device		*dma_dev;
 	dma_addr_t		dma_addr;
+	struct dw_spi_dma_ops	*dma_ops;
+	void			*dma_priv; /* platform relate info */
+	struct pci_dev		*dmac;
 
 	/* Bus interface info */
 	void			*priv;
@@ -216,4 +227,8 @@ extern int dw_spi_add_host(struct dw_spi *dws);
 extern void dw_spi_remove_host(struct dw_spi *dws);
 extern int dw_spi_suspend_host(struct dw_spi *dws);
 extern int dw_spi_resume_host(struct dw_spi *dws);
+extern void dw_spi_xfer_done(struct dw_spi *dws);
+
+/* platform related setup */
+extern int dw_spi_mid_init(struct dw_spi *dws); /* Intel MID platforms */
 #endif /* DW_SPI_HEADER_H */


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
