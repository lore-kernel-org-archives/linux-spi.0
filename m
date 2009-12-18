From: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] SPI slave driver for Intel's Moorestown
	platform
Date: Fri, 18 Dec 2009 13:07:59 -0800
Message-ID: <1261170479.10785.7.camel@ubuntu-vmware>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi mailing list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

>From c34b29d41b6669b81b49065b62dd9d0c0b30e7f4 Mon Sep 17 00:00:00 2001
From: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date: Thu, 17 Dec 2009 10:43:49 -0800
Subject: [PATCH] SPI slave driver for Intel's Moorestown platform


Signed-off-by: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Kconfig          |    7 +
 drivers/spi/Makefile         |    1 +
 drivers/spi/mrst_spi_slave.c | 1136 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1144 insertions(+), 0 deletions(-)
 create mode 100644 drivers/spi/mrst_spi_slave.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d1124b3..3807346 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -290,6 +290,13 @@ comment "SPI SLAVE Controller Drivers"
 
 # (slave support would go here)
 
+config SPI_MRST_SLAVE
+	tristate "SPI slave controller driver for Intel Moorestown platform "
+	depends on SPI_SLAVE
+	help
+	  This is the SPI slave controller driver for Intel Moorestown
+	  platform.
+
 endif # SPI_SLAVE
 
 endif # SPI
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 21a1182..0471e38 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_SPI_TLE62X0)	+= tle62x0.o
 # 	... add above this line ...
 
 # SPI slave controller drivers (upstream link)
+obj-$(CONFIG_SPI_MRST_SLAVE)                  += mrst_spi_slave.o
 # 	... add above this line ...
 
 # SPI slave drivers (protocol for that link)
diff --git a/drivers/spi/mrst_spi_slave.c b/drivers/spi/mrst_spi_slave.c
new file mode 100644
index 0000000..0e5a8a1
--- /dev/null
+++ b/drivers/spi/mrst_spi_slave.c
@@ -0,0 +1,1136 @@
+/*
+ *  mrst_spi_slave.c - Moorestown SPI slave controller driver
+ *  based on pxa2xx_spi.c
+ *
+ *  Copyright (C) Intel 2009
+ *  Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+
+/*
+ * Note:
+ *
+ * Supports interrupt programmed I/O, DMA and non-interrupt polled transfers.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/highmem.h>
+#include <linux/pci.h>
+
+#ifdef CONFIG_SPI_MRST_SLAVE_DMA
+#include <linux/dma-mapping.h>
+#include <linux/lnw_dma.h>
+#endif
+
+#include <linux/spi/spi.h>
+#include <linux/spi/mrst_spi_slave.h>
+
+
+#define DRIVER_NAME "mrst_spi_slave"
+
+#define SSP_NOT_SYNC 0x400000
+
+MODULE_AUTHOR("");
+MODULE_DESCRIPTION("Moorestown SPI Slave Contoller");
+MODULE_LICENSE("GPL");
+
+/*
+ * For testing SSCR1 changes that require SSP restart, basically
+ * everything except the service and interrupt enables
+ */
+#define SSCR1_CHANGE_MASK (SSCR1_TTELP | SSCR1_TTE | SSCR1_EBCEI | SSCR1_SCFR \
+				| SSCR1_ECRA | SSCR1_ECRB | SSCR1_SCLKDIR \
+				| SSCR1_SFRMDIR \
+				| SSCR1_RWOT | SSCR1_TRAIL | SSCR1_PINTE \
+				| SSCR1_STRF | SSCR1_EFWR | SSCR1_RFT \
+				| SSCR1_TFT | SSCR1_SPH | SSCR1_SPO)
+
+#define DEFINE_SSP_REG(reg, off) \
+static inline u32 read_##reg(void *p) { return __raw_readl(p + (off)); } \
+static inline void write_##reg(u32 v, void *p) { __raw_writel(v, p + (off)); }
+
+DEFINE_SSP_REG(SSCR0, 0x00)
+DEFINE_SSP_REG(SSCR1, 0x04)
+DEFINE_SSP_REG(SSSR, 0x08)
+DEFINE_SSP_REG(SSITR, 0x0c)
+DEFINE_SSP_REG(SSDR, 0x10)
+DEFINE_SSP_REG(SSTO, 0x28)
+DEFINE_SSP_REG(SSPSP, 0x2c)
+
+DEFINE_SSP_REG(I2CCTRL, 0x00);
+DEFINE_SSP_REG(I2CDATA, 0x04);
+
+DEFINE_SSP_REG(GPLR1, 0x04);
+DEFINE_SSP_REG(GPDR1, 0x0c);
+DEFINE_SSP_REG(GPSR1, 0x14);
+DEFINE_SSP_REG(GPCR1, 0x1C);
+DEFINE_SSP_REG(GAFR1_U, 0x44);
+
+#define START_STATE ((void *)0)
+#define RUNNING_STATE ((void *)1)
+#define DONE_STATE ((void *)2)
+#define ERROR_STATE ((void *)-1)
+
+struct driver_data {
+	/* Driver model hookup */
+	struct pci_dev *pdev;
+
+	/* SPI framework hookup */
+	struct spi_slave *slave;
+
+	/* SSP register addresses */
+	void *paddr;
+	void *ioaddr;
+	u32 iolen;
+	int irq;
+
+	/* I2C registers */
+	void *I2C_paddr;
+	void *I2C_ioaddr;
+
+	/* SSP masks*/
+	u32 dma_cr1;
+	u32 int_cr1;
+	u32 clear_sr;
+	u32 mask_sr;
+
+	struct tasklet_struct poll_transfer;
+
+	spinlock_t lock;
+	int busy;
+	int run;
+
+	/* Current message transfer state info */
+	struct spi_message *cur_msg;
+	size_t len;
+	void *tx;
+	void *tx_end;
+	void *rx;
+	void *rx_end;
+	int dma_mapped;
+	dma_addr_t rx_dma;
+	dma_addr_t tx_dma;
+	size_t rx_map_len;
+	size_t tx_map_len;
+	u8 n_bytes;
+	int (*write)(struct driver_data *drv_data);
+	int (*read)(struct driver_data *drv_data);
+	irqreturn_t (*transfer_handler)(struct driver_data *drv_data);
+	void (*cs_control)(u32 command);
+
+#ifdef CONFIG_SPI_MRST_SLAVE_DMA
+	struct lnw_dma_slave    dmas_tx;
+	struct lnw_dma_slave    dmas_rx;
+	struct dma_chan    *txchan;
+	struct dma_chan    *rxchan;
+
+	int txdma_done;
+	int rxdma_done;
+	u64 tx_param;
+	u64 rx_param;
+	struct pci_dev *dmac1;
+#endif
+};
+
+struct chip_data {
+	u32 cr0;
+	u32 cr1;
+	u32 psp;
+	u32 timeout;
+	u8 n_bytes;
+	u32 threshold;
+	u8 enable_dma;
+	u8 poll_mode;     /* 1 means use poll mode */
+	u8 bits_per_word;
+	int (*write)(struct driver_data *drv_data);
+	int (*read)(struct driver_data *drv_data);
+};
+
+static void flush(struct driver_data *drv_data)
+{
+	void *reg = drv_data->ioaddr;
+	u32 sssr;
+
+	/* If the transmit fifo is not empty, reset the interface. */
+	sssr = read_SSSR(reg);
+	if ((sssr & 0xf00) || (sssr & SSSR_TNF) == 0) {
+		write_SSCR0(read_SSCR0(reg) & ~SSCR0_SSE, reg);
+		return;
+	}
+
+	while (read_SSSR(reg) & SSSR_RNE)
+		read_SSDR(reg);
+
+	write_SSSR(SSSR_ROR, reg);
+	write_SSSR(SSSR_TUR, reg);
+
+	return;
+}
+
+static int null_writer(struct driver_data *drv_data)
+{
+	void *reg = drv_data->ioaddr;
+	u8 n_bytes = drv_data->n_bytes;
+
+	if (((read_SSSR(reg) & 0x00000f00) == 0x00000f00)
+		|| (drv_data->tx == drv_data->tx_end))
+		return 0;
+
+	write_SSDR(0, reg);
+	drv_data->tx += n_bytes;
+
+	return 1;
+}
+
+static int null_reader(struct driver_data *drv_data)
+{
+	void *reg = drv_data->ioaddr;
+	u8 n_bytes = drv_data->n_bytes;
+
+	while ((read_SSSR(reg) & SSSR_RNE)
+		&& (drv_data->rx < drv_data->rx_end)) {
+		read_SSDR(reg);
+		drv_data->rx += n_bytes;
+	}
+
+	return drv_data->rx == drv_data->rx_end;
+}
+
+static int u8_writer(struct driver_data *drv_data)
+{
+	void *reg = drv_data->ioaddr;
+	if (((read_SSSR(reg) & 0x00000f00) == 0x00000f00)
+		|| (drv_data->tx == drv_data->tx_end))
+		return 0;
+
+	write_SSDR(*(u8 *)(drv_data->tx), reg);
+	++drv_data->tx;
+
+	return 1;
+}
+
+static int u8_reader(struct driver_data *drv_data)
+{
+	void *reg = drv_data->ioaddr;
+	while ((read_SSSR(reg) & SSSR_RNE)
+		&& (drv_data->rx < drv_data->rx_end)) {
+		*(u8 *)(drv_data->rx) = read_SSDR(reg);
+		++drv_data->rx;
+	}
+
+	return drv_data->rx == drv_data->rx_end;
+}
+
+static int u16_writer(struct driver_data *drv_data)
+{
+	void *reg = drv_data->ioaddr;
+	if (((read_SSSR(reg) & 0x00000f00) == 0x00000f00)
+		|| (drv_data->tx == drv_data->tx_end))
+		return 0;
+
+	write_SSDR(*(u16 *)(drv_data->tx), reg);
+	drv_data->tx += 2;
+
+	return 1;
+}
+
+static int u16_reader(struct driver_data *drv_data)
+{
+	void *reg = drv_data->ioaddr;
+	while ((read_SSSR(reg) & SSSR_RNE)
+		&& (drv_data->rx < drv_data->rx_end)) {
+		*(u16 *)(drv_data->rx) = read_SSDR(reg);
+		drv_data->rx += 2;
+	}
+
+return drv_data->rx == drv_data->rx_end;
+}
+
+static int u32_writer(struct driver_data *drv_data)
+{
+void *reg = drv_data->ioaddr;
+	if (((read_SSSR(reg) & 0x00000f00) == 0x00000f00)
+		|| (drv_data->tx == drv_data->tx_end))
+		return 0;
+
+	write_SSDR(*(u32 *)(drv_data->tx), reg);
+	drv_data->tx += 4;
+
+	return 1;
+}
+
+static int u32_reader(struct driver_data *drv_data)
+{
+	void *reg = drv_data->ioaddr;
+	while ((read_SSSR(reg) & SSSR_RNE)
+		&& (drv_data->rx < drv_data->rx_end)) {
+		*(u32 *)(drv_data->rx) = read_SSDR(reg);
+		drv_data->rx += 4;
+	}
+
+	return drv_data->rx == drv_data->rx_end;
+}
+
+
+
+/* caller already set message->status; dma and pio irqs are blocked */
+static void giveback(struct driver_data *drv_data)
+{
+	struct spi_message *msg;
+
+	msg = drv_data->cur_msg;
+	msg->state = NULL;
+	if (msg->complete)
+		msg->complete(msg->context);
+}
+
+#ifdef CONFIG_SPI_MRST_SLAVE_DMA
+
+static bool chan_filter(struct dma_chan *chan, void *param)
+{
+	struct driver_data *drv_data = (struct driver_data *)param;
+	bool ret = false;
+
+	if (!drv_data->dmac1)
+		return ret;
+
+	if (chan->device->dev == &drv_data->dmac1->dev)
+		ret = true;
+
+	return ret;
+}
+
+static void int_transfer_complete(struct driver_data *drv_data);
+static void unmap_dma_buffers(struct driver_data *drv_data);
+
+static void mrst_spi_dma_done(void *arg)
+{
+	u64 *param = arg;
+	struct driver_data *drv_data;
+	int *done;
+
+	drv_data = (struct driver_data *)(u32)(*param >> 32);
+	done = (int *)(u32)(*param & 0xffffffff);
+	*done = 1;
+
+	unmap_dma_buffers(drv_data);
+
+	if (!drv_data->txdma_done || !drv_data->rxdma_done)
+		return;
+	int_transfer_complete(drv_data);
+}
+
+static void mrst_spi_dma_init(struct driver_data *drv_data)
+{
+	struct lnw_dma_slave *rxs, *txs;
+	dma_cap_mask_t mask;
+
+	/* Use DMAC1 */
+	drv_data->dmac1 = pci_get_device(PCI_VENDOR_ID_INTEL, 0x0814, NULL);
+	if (!drv_data->dmac1) {
+		printk(KERN_WARNING "SPI Slave:Can't find DMAC1\n");
+		return;
+	}
+
+/* 1. init rx channel */
+	rxs = &drv_data->dmas_rx;
+
+	rxs->dirn = DMA_FROM_DEVICE;
+	rxs->hs_mode = LNW_DMA_HW_HS;
+	rxs->cfg_mode = LNW_DMA_PER_TO_MEM;
+	rxs->src_width = LNW_DMA_WIDTH_16BIT;
+	rxs->dst_width = LNW_DMA_WIDTH_32BIT;
+	rxs->src_msize = LNW_DMA_MSIZE_8;
+	rxs->dst_msize = LNW_DMA_MSIZE_8;
+
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	drv_data->rxchan = dma_request_channel(mask, chan_filter, drv_data);
+	if (!drv_data->rxchan)
+		goto err_exit;
+
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
+	txs->src_msize = LNW_DMA_MSIZE_8;
+	txs->dst_msize = LNW_DMA_MSIZE_8;
+
+
+	dma_cap_set(DMA_SLAVE, mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+
+	drv_data->txchan = dma_request_channel(mask, chan_filter, drv_data);
+	if (!drv_data->txchan)
+		goto free_rxchan;
+	else
+
+	drv_data->txchan->private = txs;
+
+	/* set the dma done bit to 1 */
+	drv_data->txdma_done = 1;
+	drv_data->rxdma_done = 1;
+
+	drv_data->tx_param = ((u64)(u32)drv_data << 32)
+		| (u32)(&drv_data->txdma_done);
+	drv_data->rx_param = ((u64)(u32)drv_data << 32)
+		| (u32)(&drv_data->rxdma_done);
+	return;
+
+free_rxchan:
+	printk(KERN_ERR "SPI-Slave Error : DMA Channle Not available\n");
+	dma_release_channel(drv_data->rxchan);
+err_exit:
+	printk(KERN_ERR "SPI-Slave Error : DMA Channel Not available\n");
+	pci_dev_put(drv_data->dmac1);
+	return;
+}
+
+static void mrst_spi_dma_exit(struct driver_data *drv_data)
+{
+	dma_release_channel(drv_data->txchan);
+	dma_release_channel(drv_data->rxchan);
+	pci_dev_put(drv_data->dmac1);
+}
+
+static void dma_transfer(struct driver_data *drv_data)
+{
+	dma_addr_t ssdr_addr;
+	struct dma_async_tx_descriptor *txdesc = NULL, *rxdesc = NULL;
+	struct dma_chan *txchan, *rxchan;
+	enum dma_ctrl_flags flag;
+
+	/* get Data Read/Write address */
+	ssdr_addr = (dma_addr_t)(u32)(drv_data->paddr + 0x10);
+
+	if (drv_data->tx_dma)
+		drv_data->txdma_done = 0;
+
+	if (drv_data->rx_dma)
+		drv_data->rxdma_done = 0;
+
+	/* 2. start the TX dma transfer */
+	txchan = drv_data->txchan;
+	rxchan = drv_data->rxchan;
+
+	flag = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
+
+	if (drv_data->rx_dma) {
+		rxdesc = rxchan->device->device_prep_dma_memcpy
+		(rxchan,		/* DMA Channel */
+		drv_data->rx_dma,	/* DAR */
+		ssdr_addr,		/* SAR */
+		drv_data->len,		/* Data Length */
+		flag);			/* Flag */
+
+		rxdesc->callback = mrst_spi_dma_done;
+		rxdesc->callback_param = &drv_data->rx_param;
+	}
+
+/* 3. start the RX dma transfer */
+	if (drv_data->tx_dma) {
+		txdesc = txchan->device->device_prep_dma_memcpy
+		(txchan,		/* DMA Channel */
+		ssdr_addr,		/* DAR */
+		drv_data->tx_dma,	/* SAR */
+		drv_data->len,		/* Data Length */
+		flag);			/* Flag */
+
+		txdesc->callback = mrst_spi_dma_done;
+		txdesc->callback_param = &drv_data->tx_param;
+	}
+
+	if (rxdesc)
+		rxdesc->tx_submit(rxdesc);
+	if (txdesc)
+		txdesc->tx_submit(txdesc);
+}
+
+static int map_dma_buffers(struct driver_data *drv_data)
+{
+	struct device *dev = &drv_data->pdev->dev;
+
+	if (drv_data->dma_mapped)
+		return 1;
+
+	drv_data->tx_dma =
+		dma_map_single(dev, drv_data->tx, drv_data->len,
+			PCI_DMA_TODEVICE);
+	if (dma_mapping_error(dev, drv_data->tx_dma))
+		return 0;
+
+	drv_data->rx_dma =
+		dma_map_single(dev, drv_data->rx, drv_data->len,
+			PCI_DMA_FROMDEVICE);
+	if (dma_mapping_error(dev, drv_data->rx_dma)) {
+		dma_unmap_single(dev, drv_data->tx_dma,
+			drv_data->tx_map_len, DMA_TO_DEVICE);
+		return 0;
+	}
+
+	return 1;
+}
+
+static void unmap_dma_buffers(struct driver_data *drv_data)
+{
+	struct device *dev = &drv_data->pdev->dev;
+
+	if (!drv_data->dma_mapped)
+		return;
+	dma_unmap_single(dev, drv_data->rx_dma, drv_data->len,
+		PCI_DMA_FROMDEVICE);
+	dma_unmap_single(dev, drv_data->tx_dma, drv_data->len,
+		PCI_DMA_TODEVICE);
+	drv_data->dma_mapped = 0;
+}
+
+#endif
+
+static void int_error_stop(struct driver_data *drv_data, const char* msg)
+{
+	void *reg = drv_data->ioaddr;
+
+	/* Stop and reset SSP */
+	write_SSSR(drv_data->clear_sr, reg);
+	write_SSCR1(read_SSCR1(reg) & ~drv_data->int_cr1, reg);
+	write_SSTO(0, reg);
+	flush(drv_data);
+
+	dev_err(&drv_data->pdev->dev, "%s\n", msg);
+
+	drv_data->cur_msg->state = ERROR_STATE;
+}
+
+static void int_transfer_complete(struct driver_data *drv_data)
+{
+void *reg = drv_data->ioaddr;
+
+	/* Clear Status Register */
+	write_SSSR(drv_data->clear_sr, reg);
+
+#ifdef CONFIG_SPI_MRST_SLAVE_DMA
+	/* Disable Triggers to DMA */
+	write_SSCR1(read_SSCR1(reg) & ~drv_data->dma_cr1, reg);
+#else
+	/* Disable Interrupt */
+	write_SSCR1(read_SSCR1(reg) & ~drv_data->int_cr1, reg);
+#endif
+	/* Stop getting Time Outs */
+	write_SSTO(0, reg);
+
+	/* Update total byte transfered return count actual bytes read */
+	drv_data->cur_msg->actual_length += drv_data->len -
+	(drv_data->rx_end - drv_data->rx);
+
+	drv_data->cur_msg->status = 0;
+	giveback(drv_data);
+}
+
+static void transfer_complete(struct driver_data *drv_data)
+{
+	/* Update total byte transfered return count actual bytes read */
+	drv_data->cur_msg->actual_length +=
+		drv_data->len - (drv_data->rx_end - drv_data->rx);
+
+	drv_data->cur_msg->status = 0;
+	giveback(drv_data);
+}
+
+static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
+{
+	void *reg = drv_data->ioaddr;
+	u32 irq_mask = (read_SSCR1(reg) & SSCR1_TIE) ?
+	drv_data->mask_sr : drv_data->mask_sr & ~SSSR_TFS;
+
+	u32 irq_status = read_SSSR(reg) & irq_mask;
+	if (irq_status & SSSR_ROR) {
+		int_error_stop(drv_data, "interrupt_transfer: fifo overrun");
+		return IRQ_HANDLED;
+	}
+
+	if (irq_status & SSSR_TINT) {
+		write_SSSR(SSSR_TINT, reg);
+		if (drv_data->read(drv_data)) {
+			int_transfer_complete(drv_data);
+			return IRQ_HANDLED;
+		}
+	}
+
+/* Drain rx fifo, Fill tx fifo and prevent overruns */
+	do {
+		if (drv_data->read(drv_data)) {
+			int_transfer_complete(drv_data);
+			return IRQ_HANDLED;
+		}
+	} while (drv_data->write(drv_data));
+
+	if (drv_data->read(drv_data)) {
+		int_transfer_complete(drv_data);
+		return IRQ_HANDLED;
+	}
+
+	if (drv_data->tx == drv_data->tx_end)
+		write_SSCR1(read_SSCR1(reg) & ~SSCR1_TIE, reg);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ssp_int(int irq, void *dev_id)
+{
+	struct driver_data *drv_data = dev_id;
+	void *reg = drv_data->ioaddr;
+	u32 status = read_SSSR(reg);
+
+#ifdef CONFIG_SPI_MRST_SLAVE_DMA
+	if (status & SSSR_ROR || status & SSSR_TUR) {
+		printk(KERN_DEBUG "--- SPI ROR or TUR occurred : SSSR=%x\n",
+	status);
+		write_SSSR(SSSR_ROR, reg);		/* Clear ROR */
+		write_SSSR(SSSR_TUR, reg);		/* Clear TUR */
+		return IRQ_HANDLED;
+	}
+	return IRQ_NONE;
+#endif
+	/* just return if this is not our interrupt */
+	if (!(read_SSSR(reg) & drv_data->mask_sr))
+		return IRQ_NONE;
+
+	if (!drv_data->cur_msg) {
+		write_SSCR0(read_SSCR0(reg) & ~SSCR0_SSE, reg);
+		write_SSCR1(read_SSCR1(reg) & ~drv_data->int_cr1, reg);
+		write_SSSR(drv_data->clear_sr, reg);
+
+		/* Never fail */
+		return IRQ_HANDLED;
+	}
+	return drv_data->transfer_handler(drv_data);
+}
+
+static void poll_transfer(unsigned long data)
+{
+	struct driver_data *drv_data = (struct driver_data *)data;
+
+	if (drv_data->tx)
+		while (drv_data->tx != drv_data->tx_end) {
+			drv_data->write(drv_data);
+			drv_data->read(drv_data);
+		}
+
+	while (!drv_data->read(drv_data))
+		;
+
+	transfer_complete(drv_data);
+}
+
+static int transfer(struct spi_device *spi, struct spi_message *msg)
+{
+	struct driver_data *drv_data = \
+	spi_slave_get_devdata(spi->slave);
+	unsigned long flags;
+	struct chip_data *chip = NULL;
+	struct spi_transfer *transfer = NULL;
+	void *reg = drv_data->ioaddr;
+	void *i2cReg = drv_data->I2C_ioaddr;
+	u32 clk_div = 0;
+	u8 bits = 0;
+	u32 cr0;
+	u32 cr1;
+	u32 sssr;
+
+	spin_lock_irqsave(&drv_data->lock, flags);
+	msg->actual_length = 0;
+	msg->status = -EINPROGRESS;
+	drv_data->cur_msg = msg;
+	/* Initial message state*/
+	msg->state = START_STATE;
+
+	/* We handle only one transfer message since the protocol module has to
+	   control the out of band signaling. */
+	transfer = list_entry(msg->transfers.next,
+	struct spi_transfer,
+	transfer_list);
+
+	chip = spi_get_ctldata(msg->spi);
+
+	drv_data->busy = 1;
+
+/* Check transfer length */
+	if (transfer->len > 8192) {
+		dev_warn(&drv_data->pdev->dev, "SPI-SLAVE: transfer "
+		"length greater than 8192\n");
+		msg->status = -EINVAL;
+		giveback(drv_data);
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+		return 0;
+	}
+
+	/* Setup the transfer state based on the type of transfer */
+	flush(drv_data);
+	drv_data->n_bytes = chip->n_bytes;
+	drv_data->tx = (void *)transfer->tx_buf;
+	drv_data->tx_end = drv_data->tx + transfer->len;
+	drv_data->rx = transfer->rx_buf;
+	drv_data->rx_end = drv_data->rx + transfer->len;
+	drv_data->rx_dma = transfer->rx_dma;
+	drv_data->tx_dma = transfer->tx_dma;
+	drv_data->len = transfer->len;
+	drv_data->write = drv_data->tx ? chip->write : null_writer;
+	drv_data->read = drv_data->rx ? chip->read : null_reader;
+
+	/* Change speed and bit per word on a per transfer */
+	cr0 = chip->cr0;
+	if (transfer->bits_per_word) {
+		bits = chip->bits_per_word;
+		clk_div = 0x0;
+
+	if (transfer->bits_per_word)
+		bits = transfer->bits_per_word;
+
+
+	if (bits <= 8) {
+		drv_data->n_bytes = 1;
+		drv_data->read = drv_data->read != null_reader ?
+			u8_reader : null_reader;
+		drv_data->write = drv_data->write != null_writer ?
+			u8_writer : null_writer;
+	} else if (bits <= 16) {
+		drv_data->n_bytes = 2;
+		drv_data->read = drv_data->read != null_reader ?
+			u16_reader : null_reader;
+		drv_data->write = drv_data->write != null_writer ?
+			u16_writer : null_writer;
+	} else if (bits <= 32) {
+		drv_data->n_bytes = 4;
+		drv_data->read = drv_data->read != null_reader ?
+			u32_reader : null_reader;
+		drv_data->write = drv_data->write != null_writer ?
+			u32_writer : null_writer;
+	}
+
+	cr0 = clk_div
+		| SSCR0_Motorola
+		| SSCR0_DataSize(bits > 16 ? bits - 16 : bits)
+	| SSCR0_SSE
+	| SSCR0_TIM
+	| SSCR0_RIM
+	| (bits > 16 ? SSCR0_EDSS : 0);
+}
+#ifdef CONFIG_SPI_MRST_SLAVE_DMA
+	drv_data->dma_mapped = 0;
+	if (chip->enable_dma)
+		drv_data->dma_mapped = map_dma_buffers(drv_data);
+#endif
+	msg->state = RUNNING_STATE;
+	/* Ensure we have the correct interrupt handler    */
+	drv_data->transfer_handler = interrupt_transfer;
+	/* Clear status  */
+	cr1 = chip->cr1 | chip->threshold;
+	write_SSSR(drv_data->clear_sr, reg);
+
+	/* Reload the config and do bitbanging only if SSP not-enabled or
+	 * not-synchronized
+	 */
+	if ((read_SSSR(reg) & SSP_NOT_SYNC) ||
+		(!(read_SSCR0(reg) & SSCR0_SSE))) {
+		write_SSSR(drv_data->clear_sr, reg);	/* clear status */
+		write_SSCR0(cr0 & ~SSCR0_SSE, reg);
+		write_SSPSP(0x02010007, reg);
+		write_SSTO(chip->timeout, reg);
+		write_SSCR1(0x13001DC0, reg);	/* TBD remove hardcoded value */
+		write_SSCR0(cr0, reg);
+
+		/*
+		*  This routine uses the DFx block to override the SSP inputs
+		*  and outputs allowing us to bit bang SSPSCLK. On Langwell,
+		*  we have to generate the clock to clear busy.
+		*/
+
+		write_I2CDATA(0x3, i2cReg);
+		udelay(10);
+		write_I2CCTRL(0x01070034, i2cReg);
+		udelay(10);
+		write_I2CDATA(0x00000099, i2cReg);
+		udelay(10);
+		write_I2CCTRL(0x01070038, i2cReg);
+		udelay(10);
+		sssr = read_SSSR(reg);
+
+		/* Bit bang the clock until CSS clears */
+		while (sssr & 0x400000) {
+			write_I2CDATA(0x2, i2cReg);
+			udelay(10);
+			write_I2CCTRL(0x01070034, i2cReg);
+			udelay(10);
+			write_I2CDATA(0x3, i2cReg);
+			udelay(10);
+			write_I2CCTRL(0x01070034, i2cReg);
+			udelay(10);
+			sssr = read_SSSR(reg);
+		}
+
+		write_I2CDATA(0x0, i2cReg);
+		udelay(10);
+		write_I2CCTRL(0x01070038, i2cReg);
+
+	} else {
+		write_SSTO(chip->timeout, reg);
+		write_SSCR1(0x13001DC0, reg);
+	}
+
+	/* transfer using DMA */
+	if (drv_data->dma_mapped) {
+#ifdef CONFIG_SPI_MRST_SLAVE_DMA
+		cr1 = cr1 | drv_data->dma_cr1;
+		write_SSCR1(0x13701DC0, reg);
+		dma_transfer(drv_data);
+#endif
+	}
+
+/* transfer using non interrupt polling */
+	else if (chip->poll_mode)
+		tasklet_schedule(&drv_data->poll_transfer);
+
+	/* transfer using interrupt driven programmed I/O */
+	else {
+		cr1 = cr1 | drv_data->int_cr1;
+		write_SSCR1(cr1, reg);
+	}
+
+	spin_unlock_irqrestore(&drv_data->lock, flags);
+	return 0;
+}
+
+static int setup(struct spi_device *spi)
+{
+	struct mrst_spi_chip *chip_info = NULL;
+	struct chip_data *chip;
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	if ((spi->bits_per_word < 4 || spi->bits_per_word > 32))
+		return -EINVAL;
+
+/* Only alloc on first setup */
+	chip = spi_get_ctldata(spi);
+	if (!chip) {
+		chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
+		if (!chip) {
+			dev_err(&spi->dev,
+			"failed setup: can't allocate chip data\n");
+			return -ENOMEM;
+		}
+#ifdef CONFIG_SPI_MRST_SLAVE_DMA
+		chip->enable_dma = 1;
+		chip->poll_mode = 0;
+#else
+		chip->enable_dma = 0;
+		chip->poll_mode = 1;
+#endif
+		chip->timeout = 1000;
+		chip->threshold = SSCR1_RxTresh(1) | SSCR1_TxTresh(1);
+	}
+
+/*
+*  protocol drivers may change the chip settings, so...
+* if chip_info exists, use it
+*/
+	chip_info = spi->controller_data;
+
+	/* chip_info isn't always needed */
+	chip->cr1 = 0;
+	if (chip_info) {
+		chip->timeout = chip_info->timeout;
+
+		chip->threshold = (SSCR1_RxTresh(chip_info->rx_threshold) &
+			SSCR1_RFT) | (SSCR1_TxTresh(chip_info->tx_threshold) &
+			SSCR1_TFT);
+
+		if (chip_info->enable_loopback)
+			chip->cr1 = SSCR1_LBM;
+	}
+
+	chip->cr0 = SSCR0_Motorola | SSCR0_DataSize(spi->bits_per_word > 16 ?
+		spi->bits_per_word - 16 : spi->bits_per_word)
+			| SSCR0_SSE
+			| SSCR0_TIM
+			| SSCR0_RIM
+			| (spi->bits_per_word > 16 ? SSCR0_EDSS : 0);
+	chip->cr1 &= ~(SSCR1_SPO | SSCR1_SPH);
+	chip->cr1 |= (((spi->mode & SPI_CPHA) != 0) ? SSCR1_SPH : 0)
+		| (((spi->mode & SPI_CPOL) != 0) ? SSCR1_SPO : 0);
+	/* set slave mode */
+	chip->cr1 |= SSCR1_SCLKDIR | SSCR1_SFRMDIR;
+	chip->cr1 |= SSCR1_SCFR;       /* slave clock is not free running */
+	dev_dbg(&spi->dev, "%d bits/word, mode %d\n",
+		spi->bits_per_word,
+		spi->mode & 0x3);
+
+	if (spi->bits_per_word <= 8) {
+		chip->n_bytes = 1;
+		chip->read = u8_reader;
+		chip->write = u8_writer;
+	} else if (spi->bits_per_word <= 16) {
+		chip->n_bytes = 2;
+		chip->read = u16_reader;
+		chip->write = u16_writer;
+	} else if (spi->bits_per_word <= 32) {
+		chip->cr0 |= SSCR0_EDSS;
+		chip->n_bytes = 4;
+		chip->read = u32_reader;
+		chip->write = u32_writer;
+	} else {
+		dev_err(&spi->dev, "invalid wordsize\n");
+		return -ENODEV;
+	}
+	chip->bits_per_word = spi->bits_per_word;
+	spi_set_ctldata(spi, chip);
+
+	return 0;
+}
+
+static void cleanup(struct spi_device *spi)
+{
+	struct chip_data *chip = spi_get_ctldata(spi);
+	kfree(chip);
+}
+
+static int mrst_spi_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_slave *slave;
+	struct driver_data *drv_data = 0;
+	int status = 0;
+	int pci_bar = 0;
+
+	printk(KERN_INFO "SPI-Slave: found PCI SSP controller(ID: %04x:%04x)\n",
+		pdev->vendor, pdev->device);
+
+	status = pci_enable_device(pdev);
+	if (status)
+		return status;
+
+	/* Allocate Slave with space for drv_data and null dma buffer */
+	slave = spi_alloc_slave(dev, sizeof(struct driver_data));
+
+	if (!slave) {
+		dev_err(&pdev->dev, "cannot alloc spi_slave\n");
+		status = -ENOMEM;
+		goto err_free_slave0;
+	}
+
+	drv_data = spi_slave_get_devdata(slave);
+	drv_data->slave = slave;
+
+	drv_data->pdev = pdev;
+	spin_lock_init(&drv_data->lock);
+
+	slave->bus_num = 3;
+	slave->num_chipselect = 1;
+	slave->cleanup = cleanup;
+	slave->setup = setup;
+	slave->transfer = transfer;
+
+	/* get basic io resource and map it */
+	drv_data->paddr = (void *)pci_resource_start(pdev, pci_bar);
+	drv_data->iolen = pci_resource_len(pdev, pci_bar);
+
+	status = pci_request_region(pdev, pci_bar, dev_name(&pdev->dev));
+	if (status)
+		goto err_free_slave1;
+
+	drv_data->ioaddr =
+		ioremap_nocache((u32)drv_data->paddr, drv_data->iolen);
+	if (!drv_data->ioaddr) {
+		status = -ENOMEM;
+		goto err_free_slave2;
+	}
+
+	printk(KERN_INFO "SPI-Slave: ioaddr = : %08x\n", (int)drv_data->ioaddr);
+	printk(KERN_INFO "SPI-Slave: attaching to IRQ: %04x\n", pdev->irq);
+
+	/* get base address of I2C_Serbus registers */
+	drv_data->I2C_paddr = (void *)0xff12b000;
+	drv_data->I2C_ioaddr =
+		ioremap_nocache((unsigned long)drv_data->I2C_paddr, 0x10);
+	if (!drv_data->I2C_ioaddr) {
+		status = -ENOMEM;
+		goto err_free_slave3;
+	}
+
+	/* Attach to IRQ */
+	drv_data->irq = pdev->irq;
+	status = request_irq(drv_data->irq, ssp_int, IRQF_SHARED,
+		"mrst_spi3", drv_data);
+	if (status < 0) {
+		dev_err(&pdev->dev, "can not get IRQ\n");
+		goto err_free_slave4;
+	}
+
+	drv_data->int_cr1 = SSCR1_TIE | SSCR1_RIE | SSCR1_TINTE;
+	drv_data->dma_cr1 = SSCR1_TSRE | SSCR1_RSRE | SSCR1_TRAIL;
+	drv_data->clear_sr = SSSR_ROR | SSSR_TINT;
+	drv_data->mask_sr = SSSR_TINT | SSSR_RFS | SSSR_TFS | SSSR_ROR;
+
+	tasklet_init(&drv_data->poll_transfer, poll_transfer,
+		(unsigned long)drv_data);
+
+	/* Load default SSP configuration */
+	printk(KERN_INFO "SPI-Slave: setup default SSP configuration\n");
+	write_SSCR0(0, drv_data->ioaddr);
+	write_SSCR1(SSCR1_RxTresh(4) | SSCR1_TxTresh(12), drv_data->ioaddr);
+	write_SSCR0(SSCR0_Motorola | SSCR0_DataSize(8), drv_data->ioaddr);
+	write_SSTO(0, drv_data->ioaddr);
+	write_SSPSP(0x02010007, drv_data->ioaddr);
+
+	/* Register with the SPI framework */
+	printk(KERN_INFO "SPI-Slave: register with SPI framework\n");
+
+	status = spi_register_slave(slave);
+
+	if (status != 0) {
+		dev_err(&pdev->dev, "problem registering spi slave\n");
+		goto err_free_slave5;
+	}
+
+	/* Setup DMA if requested */
+#ifdef CONFIG_SPI_MRST_SLAVE_DMA
+	mrst_spi_dma_init(drv_data);
+#endif
+	pci_set_drvdata(pdev, drv_data);
+
+	return status;
+
+err_free_slave5:
+	free_irq(drv_data->irq, drv_data);
+err_free_slave4:
+	iounmap(drv_data->I2C_ioaddr);
+err_free_slave3:
+	iounmap(drv_data->ioaddr);
+err_free_slave2:
+	pci_release_region(pdev, pci_bar);
+err_free_slave1:
+	spi_slave_put(slave);
+err_free_slave0:
+	pci_disable_device(pdev);
+
+return status;
+}
+
+static void __devexit mrst_spi_remove(struct pci_dev *pdev)
+{
+	struct driver_data *drv_data = pci_get_drvdata(pdev);
+
+	if (!drv_data)
+		return;
+
+	pci_set_drvdata(pdev, NULL);
+
+#ifdef CONFIG_SPI_MRST_SLAVE_DMA
+	mrst_spi_dma_exit(drv_data);
+	pci_dev_put(drv_data->dmac1);
+#endif
+
+	/* Release IRQ */
+	free_irq(drv_data->irq, drv_data);
+
+	iounmap(drv_data->ioaddr);
+	iounmap(drv_data->I2C_ioaddr);
+
+	pci_release_region(pdev, 0);
+
+	/* disconnect from the SPI framework */
+	spi_unregister_slave(drv_data->slave);
+
+	pci_disable_device(pdev);
+
+	return;
+}
+
+#ifdef CONFIG_PM
+
+static int mrst_spi_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct driver_data *drv_data = pci_get_drvdata(pdev);
+	printk(KERN_ERR "spi-slave: suspend\n");
+
+	tasklet_disable(&drv_data->poll_transfer);
+
+	return 0;
+}
+
+static int mrst_spi_resume(struct pci_dev *pdev)
+{
+	struct driver_data *drv_data = pci_get_drvdata(pdev);
+	printk(KERN_ERR "spi-slave: resume\n");
+
+	tasklet_enable(&drv_data->poll_transfer);
+
+	return 0;
+}
+#else
+#define mrst_spi_suspend NULL
+#define mrst_spi_resume NULL
+#endif /* CONFIG_PM */
+
+
+static const struct pci_device_id pci_ids[] __devinitdata = {
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= 0x0815,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+	},
+	{},
+};
+
+static struct pci_driver mrst_spi_slave_driver = {
+	.name =		DRIVER_NAME,
+	.id_table =	pci_ids,
+	.probe =	mrst_spi_probe,
+	.remove =	__devexit_p(mrst_spi_remove),
+	.suspend =	mrst_spi_suspend,
+	.resume =	mrst_spi_resume,
+};
+
+static int __init mrst_spi_init(void)
+{
+	return pci_register_driver(&mrst_spi_slave_driver);
+}
+
+	late_initcall_sync(mrst_spi_init);
+
+static void __exit mrst_spi_exit(void)
+{
+	pci_unregister_driver(&mrst_spi_slave_driver);
+}
+
+module_exit(mrst_spi_exit);
-- 
1.5.4.3




------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
