From: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] SPI slave driver for the Intel SSP
	controller
Date: Mon, 01 Jun 2009 20:54:44 -0700
Message-ID: <1243914884.29453.1.camel@ubuntu-vmware>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi mailing list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

This is a new SPI slave driver to support the Intel Moorestown platform.

Signed-off-by: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Kconfig                |    6 +
 drivers/spi/Makefile               |    1 +
 drivers/spi/mrst_spi_slave.c       | 1263
++++++++++++++++++++++++++++++++++++
 include/linux/spi/mrst_spi_slave.h |  143 ++++
 4 files changed, 1413 insertions(+), 0 deletions(-)
 create mode 100644 drivers/spi/mrst_spi_slave.c
 create mode 100644 include/linux/spi/mrst_spi_slave.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 83a185d..f34528c 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -256,4 +256,10 @@ endif # SPI_MASTER
 
 # (slave support would go here)
 
+config SPI_MRST_SLAVE
+        tristate "SPI slave controller driver for Intel Moorestown
platform "
+        depends on SPI_MASTER
+        help
+          This is the SPI slave controller driver for Intel Moorestown
platform
+
 endif # SPI
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 5d04519..8475072 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_SPI_TLE62X0)	+= tle62x0.o
 # 	... add above this line ...
 
 # SPI slave controller drivers (upstream link)
+obj-$(CONFIG_SPI_MRST_SLAVE)            += mrst_spi_slave.o
 # 	... add above this line ...
 
 # SPI slave drivers (protocol for that link)
diff --git a/drivers/spi/mrst_spi_slave.c b/drivers/spi/mrst_spi_slave.c
new file mode 100644
index 0000000..429f6ea
--- /dev/null
+++ b/drivers/spi/mrst_spi_slave.c
@@ -0,0 +1,1263 @@
+/*
+ *  mrst_spi_slave.c - Moorestown SPI slave controller driver
+ *  based on pxa2xx_spi.c
+ *
+ *  Copyright (C) Intel 2009
+ *  Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ *
+ *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or
modify
+ *  it under the terms of the GNU General Public License as published
by
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
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307  USA
+ *
+ *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+
+/*
+ * Note:
+ *
+ * 1. Cuurently supports interrupt programmed I/O and
+ * 	  non-interrupt polled transfers.
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
+#define DRIVER_NAME "mrst_spi_slave"
+
+MODULE_AUTHOR("");
+MODULE_DESCRIPTION("Moorestown SPI Slave Contoller");
+MODULE_LICENSE("GPL");
+
+/*
+ * For testing SSCR1 changes that require SSP restart, basically
+ * everything except the service and interrupt enables
+ */
+#define SSCR1_CHANGE_MASK (SSCR1_TTELP | SSCR1_TTE | SSCR1_EBCEI |
SSCR1_SCFR \
+				| SSCR1_ECRA | SSCR1_ECRB | SSCR1_SCLKDIR \
+				| SSCR1_SFRMDIR \
+				| SSCR1_RWOT | SSCR1_TRAIL | SSCR1_PINTE \
+				| SSCR1_STRF | SSCR1_EFWR | SSCR1_RFT \
+				| SSCR1_TFT | SSCR1_SPH | SSCR1_SPO)
+
+#define DEFINE_SSP_REG(reg, off) \
+static inline u32 read_##reg(void *p) { return __raw_readl(p +
(off)); } \
+static inline void write_##reg(u32 v, void *p) { __raw_writel(v, p +
(off)); }
+
+DEFINE_SSP_REG(SSCR0, 0x00)
+DEFINE_SSP_REG(SSCR1, 0x04)
+DEFINE_SSP_REG(SSSR, 0x08)
+DEFINE_SSP_REG(SSITR, 0x0c)
+DEFINE_SSP_REG(SSDR, 0x10)
+DEFINE_SSP_REG(SSTO, 0x28)
+DEFINE_SSP_REG(SSPSP, 0x2c)
+
+DEFINE_SSP_REG(IPCCSR, 0x00);
+DEFINE_SSP_REG(IPCPISR, 0x08);
+DEFINE_SSP_REG(IPCPIMR, 0x10);
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
+
+	struct spi_slave *slave;
+	struct pci_dev *dmac1;
+
+	/* DMA setup stuff */
+	int rx_channel;
+	int tx_channel;
+	u32 *null_dma_buf;
+
+	/* SSP register addresses */
+	void *paddr;
+	void *ioaddr;
+	u32 iolen;
+	int irq;
+
+	/* IPC registers */
+	void *IPC_paddr;
+	void *IPC_ioaddr;
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
+	u32 dma_width;
+	int cs_change;
+	int (*write)(struct driver_data *drv_data);
+	int (*read)(struct driver_data *drv_data);
+	irqreturn_t (*transfer_handler)(struct driver_data *drv_data);
+	void (*cs_control)(u32 command);
+
+#ifdef CONFIG_SPI_MRST_SLAVE_DMA
+	struct lnw_dma_slave	dmas_tx;
+	struct lnw_dma_slave	dmas_rx;
+	struct dma_chan		*txchan;
+	struct dma_chan		*rxchan;
+
+	int dma_inited;
+	int txdma_done;
+	int rxdma_done;
+#endif
+};
+
+struct chip_data {
+	u32 cr0;
+	u32 cr1;
+	u32 psp;
+	u32 timeout;
+	u8 n_bytes;
+	u32 dma_width;
+	u32 dma_burst_size;
+	u32 threshold;
+	u32 dma_threshold;
+	u8 enable_dma;
+	u8 poll_mode;		/* 1 means use poll mode */
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
+	return drv_data->rx == drv_data->rx_end;
+}
+
+static int u32_writer(struct driver_data *drv_data)
+{
+	void *reg = drv_data->ioaddr;
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
+static void dma_transfer_complete(struct driver_data *drv_data)
+{
+	void *reg = drv_data->ioaddr;
+
+	/* Stop SSP */
+	write_SSSR(drv_data->clear_sr, reg);
+	write_SSCR1(read_SSCR1(reg) & ~drv_data->int_cr1, reg);
+	write_SSTO(0, reg);
+
+	/* Update total byte transfered return count actual bytes read */
+	drv_data->cur_msg->actual_length += drv_data->len -
+				(drv_data->rx_end - drv_data->rx);
+
+	drv_data->cur_msg->status = 0;
+	giveback(drv_data);
+}
+
+static void mrst_dma_done(void *arg)
+{
+	u64 *param = arg;
+	struct driver_data *drv_data;
+
+	drv_data = (struct driver_data *)(u32)(*param >> 32);
+	dma_transfer_complete(drv_data);
+	return;
+}
+
+static void mrst_spi_dma_init(struct driver_data *drv_data)
+{
+	struct lnw_dma_slave *rxs, *txs;
+	dma_cap_mask_t mask;
+	int myparam = 100;		/* Temp only */
+
+	drv_data->txchan = NULL;
+	drv_data->rxchan = NULL;
+
+	/* 1. init rx channel */
+	rxs = &drv_data->dmas_rx;
+
+	rxs->dirn = DMA_FROM_DEVICE;
+	rxs->hs_mode = LNW_DMA_SW_HS;
+	rxs->cfg_mode = LNW_DMA_PER_TO_MEM;
+	rxs->src_width = LNW_DMA_WIDTH_16BIT;
+	rxs->dst_width = LNW_DMA_WIDTH_32BIT;
+	rxs->src_msize = LNW_DMA_MSIZE_16;
+	rxs->dst_msize = LNW_DMA_MSIZE_16;
+	rxs->rx_reg = (dma_addr_t)(drv_data->paddr + 0x10);
+	rxs->tx_reg = (dma_addr_t)0;
+
+	rxs->callback = mrst_dma_done;
+	rxs->callback_param = &myparam;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	drv_data->rxchan = dma_request_channel(mask, chan_filter,
+						&drv_data);
+	if (!drv_data->rxchan) {
+		printk(KERN_ERR "SPI-Slave: Could not get Rx channel\n");
+		goto err_exit;
+	}
+	drv_data->rxchan->private = rxs;
+
+	/* 2. init tx channel */
+	txs = &drv_data->dmas_tx;
+
+	txs->dirn = DMA_TO_DEVICE;
+	txs->hs_mode = LNW_DMA_SW_HS;
+	txs->cfg_mode = LNW_DMA_MEM_TO_PER;
+	txs->src_width = LNW_DMA_WIDTH_32BIT;
+	txs->dst_width = LNW_DMA_WIDTH_16BIT;
+	txs->src_msize = LNW_DMA_MSIZE_16;
+	txs->dst_msize = LNW_DMA_MSIZE_16;
+	txs->tx_reg = (dma_addr_t)(drv_data->paddr + 0x10);
+	txs->rx_reg = (dma_addr_t)0;
+
+	txs->callback = mrst_dma_done;
+	txs->callback_param = &myparam;
+
+	dma_cap_set(DMA_SLAVE, mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+
+	drv_data->txchan = dma_request_channel(mask, chan_filter,
+						&drv_data->txchan);
+	if (!drv_data->txchan) {
+		printk(KERN_ERR "SPI-Slave: Could not get Tx channel\n");
+		goto free_rxchan;
+	}
+	drv_data->txchan->private = txs;
+
+	/* set the dma done bit to 1 */
+	drv_data->dma_inited = 1;
+	drv_data->txdma_done = 1;
+	drv_data->rxdma_done = 1;
+
+	return;
+
+free_rxchan:
+	dma_release_channel(drv_data->rxchan);
+err_exit:
+	printk(KERN_ERR "SPI-Slave: Could not get rx channel\n");
+	return;
+}
+
+static void mrst_spi_dma_exit(struct driver_data *drv_data)
+{
+	dma_release_channel(drv_data->txchan);
+	dma_release_channel(drv_data->rxchan);
+}
+
+static void dma_transfer(struct driver_data *drv_data)
+{
+	struct dma_async_tx_descriptor *txdesc = NULL, *rxdesc = NULL;
+	struct dma_chan *txchan, *rxchan;
+	enum dma_ctrl_flags flag;
+	static u64 rx_param, tx_param;
+
+	printk(KERN_ERR "SPI-SLAVE: entering dma-transfer\n");
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
+	if (drv_data->tx_dma) {
+		txdesc = txchan->device->device_prep_dma_memcpy(txchan,
+				drv_data->dmas_tx.tx_reg, drv_data->tx_dma,
+				drv_data->len, flag);
+
+		txdesc->callback = mrst_dma_done;
+		tx_param = ((u64)(u32)drv_data << 32)
+				| (u32)(&drv_data->txdma_done);
+		txdesc->callback_param = &tx_param;
+	}
+
+	/* 3. start the RX dma transfer */
+	if (drv_data->rx_dma) {
+		rxdesc = rxchan->device->device_prep_dma_memcpy(rxchan,
+				drv_data->rx_dma, drv_data->dmas_rx.rx_reg,
+				drv_data->len, flag);
+
+		rxdesc->callback = mrst_dma_done;
+		rx_param = ((u64)(u32)drv_data << 32)
+				| (u32)(&drv_data->rxdma_done);
+		rxdesc->callback_param = &rx_param;
+	}
+
+	if (rxdesc)
+		rxdesc->tx_submit(rxdesc);
+	if (txdesc)
+		txdesc->tx_submit(txdesc);
+
+	/*
+	txchan->device->device_issue_pending(txchan);
+	rxchan->device->device_issue_pending(rxchan);
+	*/
+}
+#endif
+
+static void int_error_stop(struct driver_data *drv_data, const char*
msg)
+{
+	void *reg = drv_data->ioaddr;
+
+	/* Stop and reset SSP */
+	write_SSSR(drv_data->clear_sr, reg);
+	write_SSCR1(read_SSCR1(reg) & ~drv_data->int_cr1, reg);
+	write_SSTO(0, reg);
+	flush(drv_data);
+	write_SSCR0(read_SSCR0(reg) & ~SSCR0_SSE, reg);
+
+	dev_err(&drv_data->pdev->dev, "%s\n", msg);
+
+	drv_data->cur_msg->state = ERROR_STATE;
+}
+
+static void int_transfer_complete(struct driver_data *drv_data)
+{
+	void *reg = drv_data->ioaddr;
+
+	/* Stop SSP */
+	write_SSSR(drv_data->clear_sr, reg);
+	write_SSCR1(read_SSCR1(reg) & ~drv_data->int_cr1, reg);
+	write_SSTO(0, reg);
+
+	/* Update total byte transfered return count actual bytes read */
+	drv_data->cur_msg->actual_length += drv_data->len -
+				(drv_data->rx_end - drv_data->rx);
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
+			drv_data->mask_sr : drv_data->mask_sr & ~SSSR_TFS;
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
+	/* Drain rx fifo, Fill tx fifo and prevent overruns */
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
+
+	/* just return if this is not our interrupt */
+	if (!(read_SSSR(reg) & drv_data->mask_sr))
+		return IRQ_NONE;
+
+	if (!drv_data->cur_msg) {
+		printk(KERN_ERR "SPI-Slave: bad message: %d\n",
+			(int)drv_data->cur_msg);
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
+	}
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
+			spi_slave_get_devdata(spi->slave);
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
+
+	spin_lock_irqsave(&drv_data->lock, flags);
+	msg->actual_length = 0;
+	msg->status = -EINPROGRESS;
+	drv_data->cur_msg = msg;
+	/* Initial message state*/
+	msg->state = START_STATE;
+
+	/* We handle only one transfer message since the protocol module has
to
+	   control the out of band signaling. */
+	transfer = list_entry(msg->transfers.next,
+						struct spi_transfer,
+						transfer_list);
+
+	chip = spi_get_ctldata(msg->spi);
+
+	drv_data->busy = 1;
+
+	/* Handle for abort */
+
+	/* Check transfer length */
+	if (transfer->len > 8191) {
+		dev_warn(&drv_data->pdev->dev, "SPI-SLAVE: transfer "
+				"length greater than 8191\n");
+		msg->status = -EINVAL;
+		giveback(drv_data);
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+		return 0;
+	}
+
+	/* Setup the transfer state based on the type of transfer */
+	flush(drv_data);
+	drv_data->n_bytes = chip->n_bytes;
+	drv_data->dma_width = chip->dma_width;
+	drv_data->tx = (void *)transfer->tx_buf;
+	drv_data->tx_end = drv_data->tx + transfer->len;
+	drv_data->rx = transfer->rx_buf;
+	drv_data->rx_end = drv_data->rx + transfer->len;
+	drv_data->rx_dma = transfer->rx_dma;
+	drv_data->tx_dma = transfer->tx_dma;
+	drv_data->len = transfer->len;
+	drv_data->write = drv_data->tx ? chip->write : null_writer;
+	drv_data->read = drv_data->rx ? chip->read : null_reader;
+	drv_data->cs_change = transfer->cs_change;
+
+	/* Change speed and bit per word on a per transfer */
+	cr0 = chip->cr0;
+	if (transfer->bits_per_word) {
+
+		bits = chip->bits_per_word;
+
+		clk_div = 0x0;
+
+		if (transfer->bits_per_word)
+			bits = transfer->bits_per_word;
+
+
+		if (bits <= 8) {
+			drv_data->n_bytes = 1;
+			drv_data->dma_width = 1;
+			drv_data->read = drv_data->read != null_reader ?
+						u8_reader : null_reader;
+			drv_data->write = drv_data->write != null_writer ?
+						u8_writer : null_writer;
+		} else if (bits <= 16) {
+			drv_data->n_bytes = 2;
+			drv_data->dma_width = 2;
+			drv_data->read = drv_data->read != null_reader ?
+						u16_reader : null_reader;
+			drv_data->write = drv_data->write != null_writer ?
+						u16_writer : null_writer;
+		} else if (bits <= 32) {
+			drv_data->n_bytes = 4;
+			drv_data->dma_width = 4;
+			drv_data->read = drv_data->read != null_reader ?
+						u32_reader : null_reader;
+			drv_data->write = drv_data->write != null_writer ?
+						u32_writer : null_writer;
+		}
+
+		cr0 = clk_div
+			| SSCR0_Motorola
+			| SSCR0_DataSize(bits > 16 ? bits - 16 : bits)
+			| SSCR0_SSE
+			| SSCR0_TIM
+			| SSCR0_RIM
+			| (bits > 16 ? SSCR0_EDSS : 0);
+	}
+
+#ifdef CONFIG_SPI_MRST_SLAVE_DMA
+
+	if (chip->enable_dma) {
+		drv_data->dma_mapped = 0;
+
+		if (drv_data->tx)
+			drv_data->tx_dma = (dma_addr_t)drv_data->tx;
+
+		if (drv_data->rx)
+			drv_data->rx_dma = (dma_addr_t)drv_data->rx;
+
+		if (drv_data->tx || drv_data->rx)
+			drv_data->dma_mapped = 1;
+	}
+#endif
+
+	msg->state = RUNNING_STATE;
+		/* Ensure we have the correct interrupt handler	*/
+	drv_data->transfer_handler = interrupt_transfer;
+		/* Clear status  */
+	cr1 = chip->cr1 | chip->threshold;
+	write_SSSR(drv_data->clear_sr, reg);
+
+	/* see if we need to reload the config registers */
+
+	if ((read_SSCR0(reg) != cr0)
+		|| (read_SSCR1(reg) & SSCR1_CHANGE_MASK) !=
+			(cr1 & SSCR1_CHANGE_MASK)) {
+
+		write_SSCR0(cr0 & ~SSCR0_SSE, reg);
+		write_SSPSP(0x02010007, reg);
+		write_SSTO(chip->timeout, reg);
+		write_SSCR1(cr1, reg);
+		write_SSCR0(cr0, reg);
+
+		/*
+		 *  This routine uses the DFx block to override the SSP inputs
+		 *  and outputs allowing us to bit bang SSPSCLK. On Langwell,
+		 *  we have to generate the clock to clear busy.
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
+
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
+		write_SSCR1(cr1, reg);
+	}
+
+	/* transfer using DMA */
+	if (drv_data->dma_mapped) {
+		cr1 = cr1 | drv_data->dma_cr1;
+		cr1 = cr1 & (~drv_data->int_cr1);
+
+		write_SSCR1(cr1, reg);
+
+#ifdef CONFIG_SPI_MRST_SLAVE_DMA
+		dma_transfer(drv_data);
+#endif
+	}
+
+	/* transfer using non interrupt polling */
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
+	/* Only alloc on first setup */
+	chip = spi_get_ctldata(spi);
+	if (!chip) {
+		chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
+		if (!chip) {
+			dev_err(&spi->dev,
+				"failed setup: can't allocate chip data\n");
+			return -ENOMEM;
+		}
+
+		chip->enable_dma = 0;
+		chip->poll_mode = 1;
+		chip->timeout = 1000;
+		chip->threshold = SSCR1_RxTresh(1) | SSCR1_TxTresh(1);
+		chip->dma_burst_size = 0;
+		chip->dma_threshold = 0;
+	}
+
+	/*
+	 *  protocol drivers may change the chip settings, so...
+	 * if chip_info exists, use it
+	 */
+	chip_info = spi->controller_data;
+
+	/* chip_info isn't always needed */
+	chip->cr1 = 0;
+	if (chip_info) {
+
+		chip->timeout = chip_info->timeout;
+
+		chip->threshold = (SSCR1_RxTresh(chip_info->rx_threshold) &
+								SSCR1_RFT) |
+				(SSCR1_TxTresh(chip_info->tx_threshold) &
+								SSCR1_TFT);
+
+
+		if (chip_info->enable_loopback)
+			chip->cr1 = SSCR1_LBM;
+	}
+
+	chip->cr0 =	SSCR0_Motorola
+			| SSCR0_DataSize(spi->bits_per_word > 16 ?
+				spi->bits_per_word - 16 : spi->bits_per_word)
+			| SSCR0_SSE
+			| SSCR0_TIM
+			| SSCR0_RIM
+			| (spi->bits_per_word > 16 ? SSCR0_EDSS : 0);
+	chip->cr1 &= ~(SSCR1_SPO | SSCR1_SPH);
+	chip->cr1 |= (((spi->mode & SPI_CPHA) != 0) ? SSCR1_SPH : 0)
+			| (((spi->mode & SPI_CPOL) != 0) ? SSCR1_SPO : 0);
+	/* set slave mode */
+	chip->cr1 |= SSCR1_SCLKDIR | SSCR1_SFRMDIR;
+	chip->cr1 |= SSCR1_SCFR;	/* slave clock is not free running */
+	dev_dbg(&spi->dev, "%d bits/word, mode %d\n",
+			spi->bits_per_word,
+			spi->mode & 0x3);
+
+	if (spi->bits_per_word <= 8) {
+		chip->n_bytes = 1;
+		chip->dma_width = 1;
+		chip->read = u8_reader;
+		chip->write = u8_writer;
+	} else if (spi->bits_per_word <= 16) {
+		chip->n_bytes = 2;
+		chip->dma_width = 2;
+		chip->read = u16_reader;
+		chip->write = u16_writer;
+	} else if (spi->bits_per_word <= 32) {
+		chip->cr0 |= SSCR0_EDSS;
+		chip->n_bytes = 4;
+		chip->dma_width = 4;
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
+
+	kfree(chip);
+}
+
+static struct mrst_spi_chip spidev_chip_info = {
+	.tx_threshold = 8, /* SSP hardware FIFO threshold */
+	.rx_threshold = 8, /* SSP hardware FIFO threshold */
+	.dma_burst_size = 8, /* Byte wide transfers used so 8 byte bursts */
+	.timeout = 235, /* See Intel documentation */
+};
+
+/*
+ * mrst_parse_spi_dib - mrst-ssp parse the spi device info block
+ * 	table
+ * @pdev: spi controller pci device structure
+ * @drv_data: spi controller driver data
+ * Context: can sleep
+ *
+ * ssp controller needs to parse the spi device info block table
+ * saved in PCI bar 1 and register them with the spi core subsystem.
+ */
+static void mrst_parse_spi_dib(struct pci_dev *pdev,
+						struct driver_data *drv_data)
+{
+	u32 dib_len;
+	void *dib_vaddr;
+	unsigned long dib_paddr;
+	struct spi_board_info info[1];
+	struct spi_dib_header *header;
+	struct spi_dib *dib;
+	int info_num, i, j, dib_bar;
+	u16  *pval;
+
+	dib_bar = 1;
+	dib_paddr = pci_resource_start(pdev, dib_bar);
+	dib_len = pci_resource_len(pdev, dib_bar);
+
+	printk(KERN_INFO "SPI-Slave: %s() - paddr = 0x%08lx, "
+			"iolen = 0x%x\n", __func__, dib_paddr, dib_len);
+
+	dib_vaddr = ioremap(dib_paddr, dib_len);
+	if (!dib_vaddr) {
+		dev_err(&pdev->dev, "%s(): ioremap failed\n", __func__);
+		goto err_ioremap;
+	}
+
+	/* bar1 contains a pointer to the SPI DIB table */
+	if (dib_len == 8) {
+		u32 *ptemp = (u32 *)dib_vaddr;
+		dib_len = *(ptemp + 1);
+		dib_vaddr = ioremap(*(unsigned long *)dib_vaddr, dib_len);
+		iounmap(ptemp);
+	}
+
+	header = (struct spi_dib_header *)dib_vaddr;
+	info_num = (header->length - sizeof(*header)) /
+								sizeof(*dib);
+	dib = (struct spi_dib *)&header[1];
+
+	/* search for our dib entry. */
+	for (i = 0; i < info_num; i++)
+		if (dib[i].host_num == 3)
+			break;
+	if (i == info_num)
+		return;
+
+	strncpy(info[0].modalias, dib[i].name, SPI_DIB_NAME_LEN);
+	info[0].irq = dib[i].irq;
+	info[0].bus_num = dib[i].host_num;
+	info[0].chip_select = dib[i].cs;
+	info[0].mode = 0;
+	info[0].max_speed_hz = 0;
+
+	printk(KERN_INFO "SPI-Slave: name = %s, irq = 0x%x, "
+		"bus = %d, cs = %d\n", info[0].modalias, info[0].irq,
+		info[0].bus_num, info[0].chip_select);
+
+	pval = (u16 *)&(dib[i].dev_data[0]);
+
+	info[0].controller_data = &spidev_chip_info; /* Slave chip config */
+
+	for (j = 0; j < 5; j++) {
+		spidev_chip_info.extra_data[j] = *pval;
+		pval++;
+	}
+
+	spi_register_board_info(info, 1);
+
+err_ioremap:
+	pci_release_region(pdev, dib_bar);
+
+	return;
+}
+
+static int mrst_spi_probe(struct pci_dev *pdev, const struct
pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_slave *slave;
+	struct driver_data *drv_data = 0;
+	int status = 0;
+	int pci_bar = 0;
+
+	printk(KERN_INFO "SPI-Slave: found PCI SSP controller(ID: %04x:%
04x)\n",
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
+		/* get basic io resource and map it */
+	drv_data->paddr = (void *)pci_resource_start(pdev, pci_bar);
+	printk(KERN_INFO "SPI-Slave: paddr = : %08x\n", (int)drv_data->paddr);
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
+	printk(KERN_INFO "SPI-Slave: ioaddr = : %08x\n",
(int)drv_data->ioaddr);
+	printk(KERN_INFO "SPI-Slave: attaching to IRQ: %04x\n", pdev->irq);
+
+	mrst_parse_spi_dib(pdev, drv_data);
+
+	/* get base address of IPC registers */
+	drv_data->IPC_paddr = (void *)0xffae8000;
+	drv_data->IPC_ioaddr =
+		ioremap_nocache((unsigned long)drv_data->IPC_paddr, 0x80);
+	if (!drv_data->IPC_ioaddr) {
+		status = -ENOMEM;
+		goto err_free_slave3;
+	}
+	/* get base address of I2C_Serbus registers */
+	drv_data->I2C_paddr = (void *)0xff12b000;
+	drv_data->I2C_ioaddr =
+		ioremap_nocache((unsigned long)drv_data->I2C_paddr, 0x10);
+	if (!drv_data->I2C_ioaddr) {
+		status = -ENOMEM;
+		goto err_free_slave4;
+	}
+
+
+	printk(KERN_INFO "SPI-Slave: IPC_ioaddr = : %08x\n",
+		(int)drv_data->IPC_ioaddr);
+	printk(KERN_INFO "SPI-Slave: IPCCSR = : %08x\n",
+		read_IPCCSR(drv_data->IPC_ioaddr));
+	write_IPCCSR(0x802, drv_data->IPC_ioaddr);
+	printk(KERN_INFO "SPI-Slave: IPCCSR = : %08x\n",
+		read_IPCCSR(drv_data->IPC_ioaddr));
+
+	/* Attach to IRQ */
+	drv_data->irq = pdev->irq;
+	status = request_irq(drv_data->irq, ssp_int, IRQF_SHARED,
+			"mrst_spi3", drv_data);
+	if (status < 0) {
+		dev_err(&pdev->dev, "can not get IRQ\n");
+		goto err_free_slave5;
+	}
+
+	drv_data->int_cr1 = SSCR1_TIE | SSCR1_RIE | SSCR1_TINTE;
+	drv_data->dma_cr1 = SSCR1_TSRE | SSCR1_RSRE | SSCR1_TINTE;
+	drv_data->clear_sr = SSSR_ROR | SSSR_TINT;
+	drv_data->mask_sr = SSSR_TINT | SSSR_RFS | SSSR_TFS | SSSR_ROR;
+
+	tasklet_init(&drv_data->poll_transfer,
+			poll_transfer,	(unsigned long)drv_data);
+
+	/* Setup DMA if requested */
+	drv_data->tx_channel = -1;
+	drv_data->rx_channel = -1;
+
+	/* Load default SSP configuration */
+	printk(KERN_INFO "SPI-Slave: setup default SSP configuration\n");
+	write_SSCR0(0, drv_data->ioaddr);
+	write_SSCR1(SSCR1_RxTresh(4) | SSCR1_TxTresh(12), drv_data->ioaddr);
+	write_SSCR0(SSCR0_Motorola
+			| SSCR0_DataSize(8),
+			drv_data->ioaddr);
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
+		goto err_free_slave6;
+	}
+
+#ifdef CONFIG_SPI_MRST_SLAVE_DMA
+	drv_data->dmac1 = pci_get_device(PCI_VENDOR_ID_INTEL, 0x0814, NULL);
+	mrst_spi_dma_init(drv_data);
+#endif
+
+	pci_set_drvdata(pdev, drv_data);
+
+	return status;
+
+err_free_slave6:
+	free_irq(drv_data->irq, drv_data);
+err_free_slave5:
+	iounmap(drv_data->I2C_ioaddr);
+err_free_slave4:
+	iounmap(drv_data->IPC_ioaddr);
+err_free_slave3:
+	iounmap(drv_data->ioaddr);
+err_free_slave2:
+	pci_release_region(pdev, pci_bar);
+err_free_slave1:
+	spi_slave_put(slave);
+err_free_slave0:
+	pci_disable_device(pdev);
+
+	return status;
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
+	/* Disable the SSP at the peripheral and SOC level */
+	write_SSCR0(0, drv_data->ioaddr);
+
+	/* Release IRQ */
+	free_irq(drv_data->irq, drv_data);
+
+	iounmap(drv_data->ioaddr);
+	iounmap(drv_data->I2C_ioaddr);
+	iounmap(drv_data->IPC_ioaddr);
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
+	write_SSCR0(0, drv_data->ioaddr);
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
+
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
+	.resume	=	mrst_spi_resume,
+};
+
+static int __init mrst_spi_init(void)
+{
+	printk(KERN_ERR "SPI-Slave: mrst_spi_init()\n");
+	return pci_register_driver(&mrst_spi_slave_driver);
+}
+
+late_initcall_sync(mrst_spi_init);
+
+static void __exit mrst_spi_exit(void)
+{
+	pci_unregister_driver(&mrst_spi_slave_driver);
+}
+module_exit(mrst_spi_exit);
diff --git a/include/linux/spi/mrst_spi_slave.h
b/include/linux/spi/mrst_spi_slave.h
new file mode 100644
index 0000000..a5f4a90
--- /dev/null
+++ b/include/linux/spi/mrst_spi_slave.h
@@ -0,0 +1,143 @@
+/*
+ *  Copyright (C) Intel 2009
+ *  Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ *
+ *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or
modify
+ *  it under the terms of the GNU General Public License as published
by
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
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307  USA
+ *
+ *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+#ifndef MRST_SSP_H_
+#define MRST_SSP_H_
+
+
+/*
+ * Langwell SSP serial port register definitions
+ */
+
+#define SSCR0_DSS	(0x0000000f)	/* Data Size Select (mask) */
+#define SSCR0_DataSize(x)  ((x) - 1)	/* Data Size Select [4..16] */
+#define SSCR0_FRF	(0x00000030)	/* FRame Format (mask) */
+#define SSCR0_Motorola	(0x0 << 4)	/* Motorola's SPI mode */
+#define SSCR0_ECS	(1 << 6)	/* External clock select */
+#define SSCR0_SSE	(1 << 7)	/* Synchronous Serial Port Enable */
+
+
+#define SSCR0_SCR	(0x000fff00)	/* Serial Clock Rate (mask) */
+#define SSCR0_SerClkDiv(x) (((x) - 1) << 8) /* Divisor [1..4096] */
+#define SSCR0_EDSS	(1 << 20)	/* Extended data size select */
+#define SSCR0_NCS	(1 << 21)	/* Network clock select */
+#define SSCR0_RIM	(1 << 22)	/* Receive FIFO overrrun int mask */
+#define SSCR0_TUM	(1 << 23)	/* Transmit FIFO underrun int mask */
+#define SSCR0_FRDC	(0x07000000)	/* Frame rate divider control (mask) */
+#define SSCR0_SlotsPerFrm(x) (((x) - 1) << 24)	/* Time slots per frame
*/
+#define SSCR0_ADC	(1 << 30)	/* Audio clock select */
+#define SSCR0_MOD	(1 << 31)	/* Mode (normal or network) */
+
+
+#define SSCR1_RIE	(1 << 0)	/* Receive FIFO Interrupt Enable */
+#define SSCR1_TIE	(1 << 1)	/* Transmit FIFO Interrupt Enable */
+#define SSCR1_LBM	(1 << 2)	/* Loop-Back Mode */
+#define SSCR1_SPO	(1 << 3)	/* SSPSCLK polarity setting */
+#define SSCR1_SPH	(1 << 4)	/* Motorola SPI SSPSCLK phase setting */
+#define SSCR1_MWDS	(1 << 5)	/* Microwire Transmit Data Size */
+#define SSCR1_TFT	(0x000003c0)	/* Transmit FIFO Threshold (mask) */
+#define SSCR1_TxTresh(x) (((x) - 1) << 6) /* level [1..16] */
+#define SSCR1_RFT	(0x00003c00)	/* Receive FIFO Threshold (mask) */
+#define SSCR1_RxTresh(x) (((x) - 1) << 10) /* level [1..16] */
+
+#define SSSR_TNF	(1 << 2)	/* Transmit FIFO Not Full */
+#define SSSR_RNE	(1 << 3)	/* Receive FIFO Not Empty */
+#define SSSR_BSY	(1 << 4)	/* SSP Busy */
+#define SSSR_TFS	(1 << 5)	/* Transmit FIFO Service Request */
+#define SSSR_RFS	(1 << 6)	/* Receive FIFO Service Request */
+#define SSSR_ROR	(1 << 7)	/* Receive FIFO Overrun */
+
+#define SSCR0_TIM	(1 << 23) 	/* Transmit FIFO Under Run Int Mask */
+#define SSCR0_RIM	(1 << 22) 	/* Receive FIFO Over Run int Mask */
+#define SSCR0_NCS	(1 << 21)	/* Network Clock Select */
+#define SSCR0_EDSS	(1 << 20)	/* Extended Data Size Select */
+
+#define SSCR0_TISSP	(1 << 4)	/* TI Sync Serial Protocol */
+#define SSCR0_PSP	(3 << 4)	/* PSP - Programmable Serial Protocol */
+#define SSCR1_TTELP	(1 << 31)	/* TXD Tristate Enable Last Phase */
+#define SSCR1_TTE	(1 << 30)	/* TXD Tristate Enable */
+#define SSCR1_EBCEI	(1 << 29)	/* Enable Bit Count Error interrupt */
+#define SSCR1_SCFR	(1 << 28)	/* Slave Clock free Running */
+#define SSCR1_ECRA	(1 << 27)	/* Enable Clock Request A */
+#define SSCR1_ECRB	(1 << 26)	/* Enable Clock request B */
+#define SSCR1_SCLKDIR	(1 << 25)	/* Serial Bit Rate Clock Direction */
+#define SSCR1_SFRMDIR	(1 << 24)	/* Frame Direction */
+#define SSCR1_RWOT	(1 << 23)	/* Receive Without Transmit */
+#define SSCR1_TRAIL	(1 << 22)	/* Trailing Byte */
+#define SSCR1_TSRE	(1 << 21)	/* Transmit Service Request Enable */
+#define SSCR1_RSRE	(1 << 20)	/* Receive Service Request Enable */
+#define SSCR1_TINTE	(1 << 19)	/* Receiver Time-out Interrupt enable */
+#define SSCR1_PINTE	(1 << 18)	/* Trailing Byte Interupt Enable */
+#define SSCR1_STRF	(1 << 15)	/* Select FIFO or EFWR */
+#define SSCR1_EFWR	(1 << 14)	/* Enable FIFO Write/Read */
+
+#define SSSR_BCE	(1 << 23)	/* Bit Count Error */
+#define SSSR_CSS	(1 << 22)	/* Clock Synchronisation Status */
+#define SSSR_TUR	(1 << 21)	/* Transmit FIFO Under Run */
+#define SSSR_EOC	(1 << 20)	/* End Of Chain */
+#define SSSR_TINT	(1 << 19)	/* Receiver Time-out Interrupt */
+#define SSSR_PINT	(1 << 18)	/* Peripheral Trailing Byte Interrupt */
+
+#define SSPSP_FSRT	(1 << 25)	/* Frame Sync Relative Timing */
+#define SSPSP_DMYSTOP(x) ((x) << 23)	/* Dummy Stop */
+#define SSPSP_SFRMWDTH(x) ((x) << 16)	/* Serial Frame Width */
+#define SSPSP_SFRMDLY(x) ((x) << 9)	/* Serial Frame Delay */
+#define SSPSP_DMYSTRT(x) ((x) << 7)	/* Dummy Start */
+#define SSPSP_STRTDLY(x) ((x) << 4)	/* Start Delay */
+#define SSPSP_ETDS	(1 << 3)	/* End of Transfer data State */
+#define SSPSP_SFRMP	(1 << 2)	/* Serial Frame Polarity */
+#define SSPSP_SCMODE(x)	((x) << 0)	/* Serial Bit Rate Clock Mode */
+
+/* spi_board_info.controller_data for SPI slave devices,
+ * copied to spi_device.platform_data ... mostly for dma tuning
+ */
+struct mrst_spi_chip {
+	u8 tx_threshold;
+	u8 rx_threshold;
+	u8 dma_burst_size;
+	u32 timeout;
+	u8 enable_loopback;
+	u16 extra_data[5];
+};
+
+
+#define SPI_DIB_NAME_LEN	16
+#define SPI_DIB_SPEC_INFO_LEN	10
+
+struct spi_dib_header {
+	u32	signature;
+	u32	length;
+	u8	rev;
+	u8	checksum;
+	u8	dib[0];
+} __attribute__((packed));
+
+struct spi_dib {
+	u16	host_num;
+	u16	cs;
+	u16	irq;
+	char	name[SPI_DIB_NAME_LEN];
+	u8	dev_data[SPI_DIB_SPEC_INFO_LEN];
+} __attribute__((packed));
+
+#endif /*MRST_SSP_H_*/
-- 
1.5.4.3



------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
