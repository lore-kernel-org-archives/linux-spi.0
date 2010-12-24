From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [Patch v2 3/3] spi/dw_spi: add DMA support
Date: Fri, 24 Dec 2010 13:59:11 +0800
Message-ID: <1293170351-7426-3-git-send-email-feng.tang@intel.com>
References: <1293170351-7426-1-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org,
	alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1293170351-7426-1-git-send-email-feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

dw_spi driver in upstream only supports PIO mode, and this patch
will support it to cowork with the Designware dma controller used
on Intel Moorestown platform, at the same time it provides a general
framework to support dw_spi core to cowork with dma controllers on
other platforms

It has been tested with a Option GTM501L 3G modem and Infenion 60x60
modem. To use DMA mode, DMA controller 2 of Moorestown has to be enabled

Also change the dma interface suggested by Linus Walleij.

Acked-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
[Typo fix and renames to match intel_mid_dma renaming]
Signed-off-by: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/Kconfig        |    4 +
 drivers/spi/Makefile       |    3 +-
 drivers/spi/dw_spi.c       |   33 ++++---
 drivers/spi/dw_spi_mid.c   |  224 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/spi/dw_spi_pci.c   |   20 +++-
 include/linux/spi/dw_spi.h |   24 ++++-
 6 files changed, 284 insertions(+), 24 deletions(-)
 create mode 100644 drivers/spi/dw_spi_mid.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 78f9fd0..d53c830 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -396,6 +396,10 @@ config SPI_DW_PCI
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
index 8bc1a5a..5e6e812 100644
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
index b50bf5b..497ecb3 100644
--- a/drivers/spi/dw_spi.c
+++ b/drivers/spi/dw_spi.c
@@ -288,8 +288,10 @@ static void *next_transfer(struct dw_spi *dws)
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
@@ -341,7 +343,7 @@ static void int_error_stop(struct dw_spi *dws, const char *msg)
 	tasklet_schedule(&dws->pump_transfers);
 }
 
-static void transfer_complete(struct dw_spi *dws)
+void dw_spi_xfer_done(struct dw_spi *dws)
 {
 	/* Update total byte transfered return count actual bytes read */
 	dws->cur_msg->actual_length += dws->len;
@@ -356,6 +358,7 @@ static void transfer_complete(struct dw_spi *dws)
 	} else
 		tasklet_schedule(&dws->pump_transfers);
 }
+EXPORT_SYMBOL_GPL(dw_spi_xfer_done);
 
 static irqreturn_t interrupt_transfer(struct dw_spi *dws)
 {
@@ -387,7 +390,7 @@ static irqreturn_t interrupt_transfer(struct dw_spi *dws)
 		if (dws->tx_end > dws->tx)
 			spi_umask_intr(dws, SPI_INT_TXEI);
 		else
-			transfer_complete(dws);
+			dw_spi_xfer_done(dws);
 	}
 
 	return IRQ_HANDLED;
@@ -422,11 +425,7 @@ static void poll_transfer(struct dw_spi *dws)
 	 */
 	dws->read(dws);
 
-	transfer_complete(dws);
-}
-
-static void dma_transfer(struct dw_spi *dws, int cs_change)
-{
+	dw_spi_xfer_done(dws);
 }
 
 static void pump_transfers(unsigned long data)
@@ -608,7 +607,7 @@ static void pump_transfers(unsigned long data)
 	}
 
 	if (dws->dma_mapped)
-		dma_transfer(dws, cs_change);
+		dws->dma_ops->dma_transfer(dws, cs_change);
 
 	if (chip->poll_mode)
 		poll_transfer(dws);
@@ -904,11 +903,17 @@ int __devinit dw_spi_add_host(struct dw_spi *dws)
 	master->setup = dw_spi_setup;
 	master->transfer = dw_spi_transfer;
 
-	dws->dma_inited = 0;
-
 	/* Basic HW init */
 	spi_hw_init(dws);
 
+	if (dws->dma_ops && dws->dma_ops->dma_init) {
+		ret = dws->dma_ops->dma_init(dws);
+		if (ret) {
+			dev_warn(&master->dev, "DMA init failed\n");
+			dws->dma_inited = 0;
+		}
+	}
+
 	/* Initial and start queue */
 	ret = init_queue(dws);
 	if (ret) {
@@ -933,6 +938,8 @@ int __devinit dw_spi_add_host(struct dw_spi *dws)
 
 err_queue_alloc:
 	destroy_queue(dws);
+	if (dws->dma_ops && dws->dma_ops->dma_exit)
+		dws->dma_ops->dma_exit(dws);
 err_diable_hw:
 	spi_enable_chip(dws, 0);
 	free_irq(dws->irq, dws);
@@ -957,6 +964,8 @@ void __devexit dw_spi_remove_host(struct dw_spi *dws)
 		dev_err(&dws->master->dev, "dw_spi_remove: workqueue will not "
 			"complete, message memory not freed\n");
 
+	if (dws->dma_ops && dws->dma_ops->dma_exit)
+		dws->dma_ops->dma_exit(dws);
 	spi_enable_chip(dws, 0);
 	/* Disable clk */
 	spi_set_clk(dws, 0);
diff --git a/drivers/spi/dw_spi_mid.c b/drivers/spi/dw_spi_mid.c
new file mode 100644
index 0000000..8a49a13
--- /dev/null
+++ b/drivers/spi/dw_spi_mid.c
@@ -0,0 +1,224 @@
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
+	struct dw_spi *dws = param;
+
+	return dws->dmac && (&dws->dmac->dev == chan->device->dev);
+}
+
+static int mid_spi_dma_init(struct dw_spi *dws)
+{
+	struct mid_dma *dw_dma = dws->dma_priv;
+	struct intel_mid_dma_slave *rxs, *txs;
+	dma_cap_mask_t mask;
+
+	/*
+	 * Get pci device for DMA controller, currently it could only
+	 * be the DMA controller of either Moorestown or Medfield
+	 */
+	dws->dmac = pci_get_device(PCI_VENDOR_ID_INTEL, 0x0813, NULL);
+	if (!dws->dmac)
+		dws->dmac = pci_get_device(PCI_VENDOR_ID_INTEL, 0x0827, NULL);
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	/* 1. Init rx channel */
+	dws->rxchan = dma_request_channel(mask, mid_spi_dma_chan_filter, dws);
+	if (!dws->rxchan)
+		goto err_exit;
+	rxs = &dw_dma->dmas_rx;
+	rxs->hs_mode = LNW_DMA_HW_HS;
+	rxs->cfg_mode = LNW_DMA_PER_TO_MEM;
+	dws->rxchan->private = rxs;
+
+	/* 2. Init tx channel */
+	dws->txchan = dma_request_channel(mask, mid_spi_dma_chan_filter, dws);
+	if (!dws->txchan)
+		goto free_rxchan;
+	txs = &dw_dma->dmas_tx;
+	txs->hs_mode = LNW_DMA_HW_HS;
+	txs->cfg_mode = LNW_DMA_MEM_TO_PER;
+	dws->txchan->private = txs;
+
+	dws->dma_inited = 1;
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
+/*
+ * dws->dma_chan_done is cleared before the dma transfer starts,
+ * callback for rx/tx channel will each increment it by 1.
+ * Reaching 2 means the whole spi transaction is done.
+ */
+static void dw_spi_dma_done(void *arg)
+{
+	struct dw_spi *dws = arg;
+
+	if (++dws->dma_chan_done != 2)
+		return;
+	dw_spi_xfer_done(dws);
+}
+
+static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
+{
+	struct dma_async_tx_descriptor *txdesc = NULL, *rxdesc = NULL;
+	struct dma_chan *txchan, *rxchan;
+	struct dma_slave_config txconf, rxconf;
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
+	dws->dma_chan_done = 0;
+	txchan = dws->txchan;
+	rxchan = dws->rxchan;
+
+	/* 2. Prepare the TX dma transfer */
+	txconf.direction = DMA_TO_DEVICE;
+	txconf.dst_addr = dws->dma_addr;
+	txconf.dst_maxburst = LNW_DMA_MSIZE_16;
+	txconf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	txconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+
+	txchan->device->device_control(txchan, DMA_SLAVE_CONFIG,
+				       (unsigned long) &txconf);
+
+	memset(&dws->tx_sgl, 0, sizeof(dws->tx_sgl));
+	dws->tx_sgl.dma_address = dws->tx_dma;
+	dws->tx_sgl.length = dws->len;
+
+	txdesc = txchan->device->device_prep_slave_sg(txchan,
+				&dws->tx_sgl,
+				1,
+				DMA_TO_DEVICE,
+				DMA_PREP_INTERRUPT | DMA_COMPL_SKIP_DEST_UNMAP);
+	txdesc->callback = dw_spi_dma_done;
+	txdesc->callback_param = dws;
+
+	/* 3. Prepare the RX dma transfer */
+	rxconf.direction = DMA_FROM_DEVICE;
+	rxconf.src_addr = dws->dma_addr;
+	rxconf.src_maxburst = LNW_DMA_MSIZE_16;
+	rxconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	rxconf.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+
+	rxchan->device->device_control(rxchan, DMA_SLAVE_CONFIG,
+				       (unsigned long) &rxconf);
+
+	memset(&dws->rx_sgl, 0, sizeof(dws->rx_sgl));
+	dws->rx_sgl.dma_address = dws->rx_dma;
+	dws->rx_sgl.length = dws->len;
+
+	rxdesc = rxchan->device->device_prep_slave_sg(rxchan,
+				&dws->rx_sgl,
+				1,
+				DMA_FROM_DEVICE,
+				DMA_PREP_INTERRUPT | DMA_COMPL_SKIP_DEST_UNMAP);
+	rxdesc->callback = dw_spi_dma_done;
+	rxdesc->callback_param = dws;
+
+	/* rx must be started before tx due to spi instinct */
+	rxdesc->tx_submit(rxdesc);
+	txdesc->tx_submit(txdesc);
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
+
+/* HW info for MRST CLk Control Unit, one 32b reg */
+#define MRST_SPI_CLK_BASE	100000000	/* 100m */
+#define MRST_CLK_SPI0_REG	0xff11d86c
+#define CLK_SPI_BDIV_OFFSET	0
+#define CLK_SPI_BDIV_MASK	0x00000007
+#define CLK_SPI_CDIV_OFFSET	9
+#define CLK_SPI_CDIV_MASK	0x00000e00
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
+	clk_cdiv  = (readl(clk_reg) & CLK_SPI_CDIV_MASK) >> CLK_SPI_CDIV_OFFSET;
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
index 1f52755..49ec3aa 100644
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
@@ -72,9 +72,17 @@ static int __devinit spi_pci_probe(struct pci_dev *pdev,
 	dws->parent_dev = &pdev->dev;
 	dws->bus_num = 0;
 	dws->num_cs = 4;
-	dws->max_freq = 25000000;	/* for Moorestwon */
 	dws->irq = pdev->irq;
-	dws->fifo_len = 40;		/* FIFO has 40 words buffer */
+
+	/*
+	 * Specific handling for Intel MID paltforms, like dma setup,
+	 * clock rate, FIFO depth.
+	 */
+	if (pdev->device == 0x0800) {
+		ret = dw_spi_mid_init(dws);
+		if (ret)
+			goto err_unmap;
+	}
 
 	ret = dw_spi_add_host(dws);
 	if (ret)
@@ -140,7 +148,7 @@ static int spi_resume(struct pci_dev *pdev)
 #endif
 
 static const struct pci_device_id pci_ids[] __devinitdata = {
-	/* Intel Moorestown platform SPI controller 0 */
+	/* Intel MID platform SPI controller 0 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0800) },
 	{},
 };
diff --git a/include/linux/spi/dw_spi.h b/include/linux/spi/dw_spi.h
index c91302f..6cd10f6 100644
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
@@ -136,13 +144,15 @@ struct dw_spi {
 	/* Dma info */
 	int			dma_inited;
 	struct dma_chan		*txchan;
+	struct scatterlist	tx_sgl;
 	struct dma_chan		*rxchan;
-	int			txdma_done;
-	int			rxdma_done;
-	u64			tx_param;
-	u64			rx_param;
+	struct scatterlist	rx_sgl;
+	int			dma_chan_done;
 	struct device		*dma_dev;
-	dma_addr_t		dma_addr;
+	dma_addr_t		dma_addr; /* phy address of the Data register */
+	struct dw_spi_dma_ops	*dma_ops;
+	void			*dma_priv; /* platform relate info */
+	struct pci_dev		*dmac;
 
 	/* Bus interface info */
 	void			*priv;
@@ -216,4 +226,8 @@ extern int dw_spi_add_host(struct dw_spi *dws);
 extern void dw_spi_remove_host(struct dw_spi *dws);
 extern int dw_spi_suspend_host(struct dw_spi *dws);
 extern int dw_spi_resume_host(struct dw_spi *dws);
+extern void dw_spi_xfer_done(struct dw_spi *dws);
+
+/* platform related setup */
+extern int dw_spi_mid_init(struct dw_spi *dws); /* Intel MID platforms */
 #endif /* DW_SPI_HEADER_H */
-- 
1.7.0.4


------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
