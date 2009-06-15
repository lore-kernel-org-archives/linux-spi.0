From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] spi: driver for SPI controller of
 Intel Moorestown platform
Date: Mon, 15 Jun 2009 17:39:37 +0800
Message-ID: <20090615173937.34a30fa2@feng-desktop>
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

>From 5aeff10330cef37792857c5f6977503607deb3b0 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date: Mon, 15 Jun 2009 16:50:44 +0800
Subject: [PATCH 1/2] spi: driver for SPI controller of Intel Moorestown platform

The controller is a PCI device, and supports both PIO and DMA mode.

This driver has been tested with Maxim's Max3110 UART device and
Option's 3G modem GTM501L, both PIO and DMA works fine, and these
2 slave devcies can work simultaneously

User can use "dw_apb_ssi_db.pdf" from Synopsys as HW datasheet

Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Kconfig          |    9 +
 drivers/spi/Makefile         |    1 +
 drivers/spi/mrst_spi.c       | 1153 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/mrst_spi.h |  143 ++++++
 4 files changed, 1306 insertions(+), 0 deletions(-)
 create mode 100644 drivers/spi/mrst_spi.c
 create mode 100644 include/linux/spi/mrst_spi.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 83a185d..e1cba00 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -220,6 +220,15 @@ config SPI_XILINX
 	  See the "OPB Serial Peripheral Interface (SPI) (v1.00e)"
 	  Product Specification document (DS464) for hardware details.
 
+config SPI_MRST
+	tristate "SPI controller driver for Intel Moorestown platform "
+	depends on SPI_MASTER && PCI
+	help
+	  Driver for SPI controller on Intel Moorestown platform.
+
+	  The controller is a PCI device, and its core is a Synopsis
+	  DesignWare SPI controller.
+
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 5d04519..d07825d 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_SPI_S3C24XX)		+= spi_s3c24xx.o
 obj-$(CONFIG_SPI_TXX9)			+= spi_txx9.o
 obj-$(CONFIG_SPI_XILINX)		+= xilinx_spi.o
 obj-$(CONFIG_SPI_SH_SCI)		+= spi_sh_sci.o
+obj-$(CONFIG_SPI_MRST)			+= mrst_spi.o
 # 	... add above this line ...
 
 # SPI protocol drivers (device/link on bus)
diff --git a/drivers/spi/mrst_spi.c b/drivers/spi/mrst_spi.c
new file mode 100644
index 0000000..99a1129
--- /dev/null
+++ b/drivers/spi/mrst_spi.c
@@ -0,0 +1,1153 @@
+/*
+ *  mrst_spi.c
+ *
+ *  SPI controller driver for Intel Moorestown platform (refer pxa2xx_spi.c)
+ *
+ *  Copyright (C) Intel 2008 Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
+#include <linux/delay.h>
+#include <linux/highmem.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/mrst_spi.h>
+
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#endif
+
+#define DRIVER_NAME "mrst_spi"
+
+#define START_STATE	((void *)0)
+#define RUNNING_STATE	((void *)1)
+#define DONE_STATE	((void *)2)
+#define ERROR_STATE	((void *)-1)
+
+#define QUEUE_RUNNING	0
+#define QUEUE_STOPPED	1
+
+#define MRST_SPI_DEASSERT	0
+#define MRST_SPI_ASSERT		1
+
+#define MRST_SPIC_MAX_FREQ	25000000
+
+/* per controller struct */
+struct driver_data {
+	/* Driver model hookup */
+	struct pci_dev *pdev;
+	struct spi_master *master;
+
+	struct spi_device *devices;
+	struct spi_device *cur_dev;
+	enum mrst_ssi_type type;
+
+	/* phy and virtual register addresses */
+	void *paddr;
+	void *vaddr;
+	u32 iolen;
+	int irq;
+
+	/* Driver message queue */
+	struct workqueue_struct	*workqueue;
+	struct work_struct pump_messages;
+	spinlock_t lock;
+	struct list_head queue;
+	int busy;
+	int run;
+
+	/* Message Transfer pump */
+	struct tasklet_struct pump_transfers;
+
+	/* Current message transfer state info */
+	struct spi_message *cur_msg;
+	struct spi_transfer *cur_transfer;
+	struct chip_data *cur_chip;
+	struct chip_data *prev_chip;
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
+	u8 n_bytes;		/* current is a 1/2 bytes op */
+	u8 max_bits_per_word;	/* SPI0's maxim width is 16 bits */
+	u32 dma_width;
+	int cs_change;
+	int (*write)(struct driver_data *drv_data);
+	int (*read)(struct driver_data *drv_data);
+	irqreturn_t (*transfer_handler)(struct driver_data *drv_data);
+	void (*cs_control)(u32 command);
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs;
+#endif
+
+	int dma_inited;
+};
+
+/* slave spi_dev related */
+struct chip_data {
+	/* cr0 and cr1 are only 16b valid */
+	u16 cr0;
+	u16 cr1;
+
+	u8 cs;			/* chip select pin */
+	u8 n_bytes;		/* current is a 1/2/4 byte op */
+	u8 tmode;		/* TR/TO/RO/EEPROM */
+	u8 type;		/* SPI/SSP/MicroWire */
+
+	u8 poll_mode;		/* 1 means use poll mode */
+
+	u32 dma_width;
+	u32 rx_threshold;
+	u32 tx_threshold;
+	u8 enable_dma;
+	u8 bits_per_word;
+	u16 clk_div;		/* baud rate divider */
+	u32 speed_hz;		/* baud rate */
+	int (*write)(struct driver_data *drv_data);
+	int (*read)(struct driver_data *drv_data);
+	void (*cs_control)(u32 command);
+};
+
+#ifdef CONFIG_DEBUG_FS
+static int spi_show_regs_open(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+	return 0;
+}
+
+#define SPI_REGS_BUFSIZE	1024
+static ssize_t  spi_show_regs(struct file *file, char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	char *buf;
+	u32 len = 0;
+	ssize_t ret;
+	struct driver_data *drv_data;
+	void *reg;
+
+	drv_data = (struct driver_data *)file->private_data;
+	reg = drv_data->vaddr;
+
+	buf = kzalloc(SPI_REGS_BUFSIZE, GFP_KERNEL);
+	if (!buf)
+		return 0;
+
+	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			"MRST SPI0 registers:\n");
+	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			"=================================\n");
+	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			"CTRL0: \t\t0x%08x\n", read_ctrl0(reg));
+	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			"CTRL1: \t\t0x%08x\n", read_ctrl1(reg));
+	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			"SSIENR: \t0x%08x\n", read_ssienr(reg));
+	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			"SER: \t\t0x%08x\n", read_ser(reg));
+	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			"BAUDR: \t\t0x%08x\n", read_baudr(reg));
+	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			"TXFTLR: \t0x%08x\n", read_txftlr(reg));
+	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			"RXFTLR: \t0x%08x\n", read_rxftlr(reg));
+	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			"TXFLR: \t\t0x%08x\n", read_txflr(reg));
+	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			"RXFLR: \t\t0x%08x\n", read_rxflr(reg));
+	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			"SR: \t\t0x%08x\n", read_sr(reg));
+	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			"IMR: \t\t0x%08x\n", read_imr(reg));
+	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			"ISR: \t\t0x%08x\n", read_isr(reg));
+	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			"DMACR: \t\t0x%08x\n", read_dmacr(reg));
+	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			"DMATDLR: \t0x%08x\n", read_dmatdlr(reg));
+	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			"DMARDLR: \t0x%08x\n", read_dmardlr(reg));
+	len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
+			"=================================\n");
+
+	ret =  simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	kfree(buf);
+	return ret;
+}
+
+static const struct file_operations mrst_spi_regs_ops = {
+	.owner		= THIS_MODULE,
+	.open		= spi_show_regs_open,
+	.read		= spi_show_regs,
+};
+
+static int mrst_spi_debugfs_init(struct driver_data *drv_data)
+{
+	drv_data->debugfs = debugfs_create_dir("mrst_spi", NULL);
+	if (!drv_data->debugfs)
+		return -ENOMEM;
+
+	debugfs_create_file("registers", S_IFREG | S_IRUGO,
+		drv_data->debugfs, (void *)drv_data, &mrst_spi_regs_ops);
+	return 0;
+}
+
+static void mrst_spi_debugfs_remove(struct driver_data *drv_data)
+{
+	if (drv_data->debugfs)
+		debugfs_remove_recursive(drv_data->debugfs);
+}
+
+#else
+static inline int mrst_spi_debugfs_init(struct driver_data *drv_data)
+{
+	return 0;
+}
+
+static inline void mrst_spi_debugfs_remove(struct driver_data *drv_data)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
+static int flush(struct driver_data *drv_data)
+{
+	unsigned long limit = loops_per_jiffy << 1;
+	void *reg = drv_data->vaddr;
+
+	while (read_sr(reg) & SR_RF_NOT_EMPT) {
+		limit = loops_per_jiffy << 1;
+		while ((read_sr(reg) & SR_BUSY) && limit--)
+			;
+		read_dr(reg);
+	}
+	return limit;
+}
+
+static void null_cs_control(u32 command)
+{
+}
+
+static int null_writer(struct driver_data *drv_data)
+{
+	void *reg = drv_data->vaddr;
+	u8 n_bytes = drv_data->n_bytes;
+
+	if (!(read_sr(reg) & SR_TF_NOT_FULL)
+		|| (drv_data->tx == drv_data->tx_end))
+		return 0;
+
+	write_dr(0, reg);
+	drv_data->tx += n_bytes;
+	return 1;
+}
+
+static int null_reader(struct driver_data *drv_data)
+{
+	void *reg = drv_data->vaddr;
+	u8 n_bytes = drv_data->n_bytes;
+
+	while ((read_sr(reg) & SR_RF_NOT_EMPT)
+		&& (drv_data->rx < drv_data->rx_end)) {
+		read_dr(reg);
+		drv_data->rx += n_bytes;
+	}
+	return drv_data->rx == drv_data->rx_end;
+}
+
+static int u8_writer(struct driver_data *drv_data)
+{
+	void *reg = drv_data->vaddr;
+
+	if (!(read_sr(reg) & SR_TF_NOT_FULL)
+		|| (drv_data->tx == drv_data->tx_end))
+		return 0;
+
+	write_dr(*(u8 *)(drv_data->tx), reg);
+	++drv_data->tx;
+
+	while (read_sr(reg) & SR_BUSY)
+		;
+	return 1;
+}
+
+static int u8_reader(struct driver_data *drv_data)
+{
+	void *reg = drv_data->vaddr;
+
+	while ((read_sr(reg) & SR_RF_NOT_EMPT)
+		&& (drv_data->rx < drv_data->rx_end)) {
+		*(u8 *)(drv_data->rx) = read_dr(reg);
+		++drv_data->rx;
+	}
+
+	while (read_sr(reg) & SR_BUSY)
+		;
+	return drv_data->rx == drv_data->rx_end;
+}
+
+static int u16_writer(struct driver_data *drv_data)
+{
+	void *reg = drv_data->vaddr;
+
+	if (!(read_sr(reg) & SR_TF_NOT_FULL)
+		|| (drv_data->tx == drv_data->tx_end))
+		return 0;
+
+	write_dr(*(u16 *)(drv_data->tx), reg);
+	drv_data->tx += 2;
+	while (read_sr(reg) & SR_BUSY)
+		;
+
+	return 1;
+}
+
+static int u16_reader(struct driver_data *drv_data)
+{
+	void *reg = drv_data->vaddr;
+	u16 temp;
+
+	while ((read_sr(reg) & SR_RF_NOT_EMPT)
+		&& (drv_data->rx < drv_data->rx_end)) {
+		temp = read_dr(reg);
+		*(u16 *)(drv_data->rx) = temp;
+		drv_data->rx += 2;
+	}
+
+	while (read_sr(reg) & SR_BUSY)
+		;
+
+	return drv_data->rx == drv_data->rx_end;
+}
+
+static void *next_transfer(struct driver_data *drv_data)
+{
+	struct spi_message *msg = drv_data->cur_msg;
+	struct spi_transfer *trans = drv_data->cur_transfer;
+
+	/* Move to next transfer */
+	if (trans->transfer_list.next != &msg->transfers) {
+		drv_data->cur_transfer =
+			list_entry(trans->transfer_list.next,
+					struct spi_transfer,
+					transfer_list);
+		return RUNNING_STATE;
+	} else
+		return DONE_STATE;
+}
+
+/*
+ * Note: first step is the protocol driver prepares
+ * a dma-capable memory, and this func just need translate
+ * the virt addr to physical
+ */
+static int map_dma_buffers(struct driver_data *drv_data)
+{
+	if (!drv_data->cur_msg->is_dma_mapped || !drv_data->dma_inited
+		|| !drv_data->cur_chip->enable_dma)
+		return 0;
+
+	if (drv_data->cur_transfer->tx_dma)
+		drv_data->tx_dma = drv_data->cur_transfer->tx_dma;
+
+	if (drv_data->cur_transfer->rx_dma)
+		drv_data->rx_dma = drv_data->cur_transfer->rx_dma;
+
+	return 1;
+}
+
+static inline void unmap_dma_buffers(struct driver_data *drv_data)
+{
+	if (!drv_data->dma_mapped)
+		return;
+	drv_data->dma_mapped = 0;
+}
+
+/* caller already set message->status; dma and pio irqs are blocked */
+static void giveback(struct driver_data *drv_data)
+{
+	struct spi_transfer *last_transfer;
+	unsigned long flags;
+	struct spi_message *msg;
+
+	spin_lock_irqsave(&drv_data->lock, flags);
+	msg = drv_data->cur_msg;
+	drv_data->cur_msg = NULL;
+	drv_data->cur_transfer = NULL;
+	drv_data->prev_chip = drv_data->cur_chip;
+	drv_data->cur_chip = NULL;
+	queue_work(drv_data->workqueue, &drv_data->pump_messages);
+	spin_unlock_irqrestore(&drv_data->lock, flags);
+
+	last_transfer = list_entry(msg->transfers.prev,
+					struct spi_transfer,
+					transfer_list);
+
+	if (!last_transfer->cs_change)
+		drv_data->cs_control(MRST_SPI_DEASSERT);
+
+	msg->state = NULL;
+	if (msg->complete)
+		msg->complete(msg->context);
+}
+
+static void dma_transfer(struct driver_data *drv_data, int cs_change)
+{
+
+}
+
+static void int_error_stop(struct driver_data *drv_data, const char *msg)
+{
+	void *reg = drv_data->vaddr;
+
+	/* Stop and reset hw */
+	flush(drv_data);
+	write_ssienr(0, reg);
+
+	dev_err(&drv_data->pdev->dev, "%s\n", msg);
+
+	drv_data->cur_msg->state = ERROR_STATE;
+	tasklet_schedule(&drv_data->pump_transfers);
+}
+
+static void transfer_complete(struct driver_data *drv_data)
+{
+	/* Update total byte transfered return count actual bytes read */
+	drv_data->cur_msg->actual_length += drv_data->len;
+
+	/* Move to next transfer */
+	drv_data->cur_msg->state = next_transfer(drv_data);
+
+	/* handle end of message */
+	if (drv_data->cur_msg->state == DONE_STATE) {
+		drv_data->cur_msg->status = 0;
+		giveback(drv_data);
+	} else
+		tasklet_schedule(&drv_data->pump_transfers);
+}
+
+static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
+{
+	void *reg = drv_data->vaddr;
+	u32 irq_status, irq_mask = 0x3f;
+
+	irq_status = read_isr(reg) & irq_mask;
+
+	/* error handling */
+	if (irq_status & (SPI_INT_TXOI | SPI_INT_RXOI | SPI_INT_RXUI)) {
+		read_txoicr(reg);
+		read_rxoicr(reg);
+		read_rxuicr(reg);
+		int_error_stop(drv_data, "interrupt_transfer: fifo overrun");
+		return IRQ_HANDLED;
+	}
+
+	/* INT comes from tx */
+	if (drv_data->tx && (irq_status & SPI_INT_TXEI))
+		while (drv_data->tx < drv_data->tx_end) {
+			drv_data->write(drv_data);
+
+		if (drv_data->tx == drv_data->tx_end) {
+			spi_mask_intr(reg, SPI_INT_TXEI);
+			transfer_complete(drv_data);
+		}
+	}
+
+	/* INT comes from rx */
+	if (drv_data->rx && (irq_status & SPI_INT_RXFI)) {
+		if (drv_data->read(drv_data))
+			transfer_complete(drv_data);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mrst_spi_irq(int irq, void *dev_id)
+{
+	struct driver_data *drv_data = dev_id;
+	void *reg = drv_data->vaddr;
+
+	if (!drv_data->cur_msg) {
+		spi_mask_intr(reg, SPI_INT_TXEI);
+		/* Never fail */
+		return IRQ_HANDLED;
+	}
+
+	return drv_data->transfer_handler(drv_data);
+}
+
+/* must be called inside pump_transfers() */
+static void poll_transfer(struct driver_data *drv_data)
+{
+	if (drv_data->tx)
+		while (drv_data->write(drv_data))
+			drv_data->read(drv_data);
+
+	drv_data->read(drv_data);
+	transfer_complete(drv_data);
+}
+
+static void pump_transfers(unsigned long data)
+{
+	struct driver_data *drv_data = (struct driver_data *)data;
+	struct spi_message *message = NULL;
+	struct spi_transfer *transfer = NULL;
+	struct spi_transfer *previous = NULL;
+	struct spi_device *spi = NULL;
+	struct chip_data *chip = NULL;
+	void *reg = drv_data->vaddr;
+	u8 bits = 0;
+	u8 imask = 0;
+	u8 cs_change = 0;
+	u16 rxint_level = 0;
+	u16 txint_level = 0;
+	u16 clk_div = 0;
+	u32 speed = 0;
+	u32 cr0 = 0;
+
+	/* get current state information */
+	message = drv_data->cur_msg;
+	transfer = drv_data->cur_transfer;
+	chip = drv_data->cur_chip;
+	spi = message->spi;
+
+	/* handle for abort */
+	if (message->state == ERROR_STATE) {
+		message->status = -EIO;
+		goto early_exit;
+	}
+
+	/* handle end of message */
+	if (message->state == DONE_STATE) {
+		message->status = 0;
+		goto early_exit;
+	}
+
+	/* delay if requested at end of transfer*/
+	if (message->state == RUNNING_STATE) {
+		previous = list_entry(transfer->transfer_list.prev,
+					struct spi_transfer,
+					transfer_list);
+		if (previous->delay_usecs)
+			udelay(previous->delay_usecs);
+	}
+
+	drv_data->n_bytes = chip->n_bytes;
+	drv_data->dma_width = chip->dma_width;
+	drv_data->cs_control = chip->cs_control;
+
+	drv_data->rx_dma = transfer->rx_dma;
+	drv_data->tx_dma = transfer->tx_dma;
+	drv_data->tx = (void *)transfer->tx_buf;
+	drv_data->tx_end = drv_data->tx + transfer->len;
+	drv_data->rx = transfer->rx_buf;
+	drv_data->rx_end = drv_data->rx + transfer->len;
+	drv_data->write = drv_data->tx ? chip->write : null_writer;
+	drv_data->read = drv_data->rx ? chip->read : null_reader;
+	drv_data->cs_change = transfer->cs_change;
+	drv_data->len = drv_data->cur_transfer->len;
+	if (chip != drv_data->prev_chip)
+		cs_change = 1;
+
+	/* handle per transfer options for bpw and speed */
+	cr0 = chip->cr0;
+	if (transfer->speed_hz) {
+		speed = chip->speed_hz;
+
+		if (transfer->speed_hz != speed) {
+			speed = transfer->speed_hz;
+			if (speed > MRST_SPIC_MAX_FREQ) {
+				printk(KERN_ERR "MRST SPI0: unsupported"
+					"freq: %dHz\n", speed);
+				message->status = -EIO;
+				goto early_exit;
+			}
+
+			/* clk_div doesn't support odd number */
+			clk_div = MRST_SPIC_MAX_FREQ / speed;
+			clk_div = (clk_div >> 1) << 1;
+
+			chip->speed_hz = speed;
+			chip->clk_div = clk_div;
+		}
+	}
+
+	if (transfer->bits_per_word) {
+		bits = transfer->bits_per_word;
+
+		switch (bits) {
+		case 8:
+			drv_data->n_bytes = 1;
+			drv_data->dma_width = 1;
+			drv_data->read = drv_data->read != null_reader ?
+						u8_reader : null_reader;
+			drv_data->write = drv_data->write != null_writer ?
+						u8_writer : null_writer;
+			break;
+		case 16:
+			drv_data->n_bytes = 2;
+			drv_data->dma_width = 2;
+			drv_data->read = drv_data->read != null_reader ?
+						u16_reader : null_reader;
+			drv_data->write = drv_data->write != null_writer ?
+						u16_writer : null_writer;
+			break;
+		default:
+			printk(KERN_ERR "MRST SPI0: unsupported bits:"
+				"%db\n", bits);
+			message->status = -EIO;
+			goto early_exit;
+		}
+
+		cr0 = (bits - 1)
+			| (chip->type << SPI_FRF_OFFSET)
+			| (spi->mode << SPI_MODE_OFFSET)
+			| (chip->tmode << SPI_TMOD_OFFSET);
+	}
+
+	message->state = RUNNING_STATE;
+
+	/* try to map dma buffer and do a dma transfer if successful */
+	drv_data->dma_mapped = 0;
+	if (drv_data->len)
+		drv_data->dma_mapped = map_dma_buffers(drv_data);
+
+	if (!drv_data->dma_mapped && !chip->poll_mode) {
+		if (drv_data->rx) {
+			if (drv_data->len >= SPI_INT_THRESHOLD)
+				rxint_level = SPI_INT_THRESHOLD;
+			else
+				rxint_level = drv_data->len;
+			imask |= SPI_INT_RXFI;
+		}
+
+		if (drv_data->tx)
+			imask |= SPI_INT_TXEI;
+		drv_data->transfer_handler = interrupt_transfer;
+	}
+
+	/*
+	 * reprogram registers only if
+	 * 1. chip select changes
+	 * 2. clk_div is changed
+	 * 3. control parameter changes
+	 */
+	if (read_ctrl0(reg) != cr0 || cs_change || clk_div) {
+		mrst_spi_enable(reg, 0);
+
+		if (read_ctrl0(reg) != cr0)
+			write_ctrl0(cr0, reg);
+
+		if (txint_level)
+			write_txftlr(txint_level, reg);
+
+		if (rxint_level)
+			write_rxftlr(rxint_level, reg);
+
+		/* set the interrupt mask, for poll mode just diable all int */
+		spi_mask_intr(reg, 0xff);
+		if (!chip->poll_mode)
+			spi_umask_intr(reg, imask);
+
+		spi_enable_clk(reg, clk_div ? clk_div : chip->clk_div);
+		spi_chip_sel(reg, spi->chip_select);
+		mrst_spi_enable(reg, 1);
+
+		if (cs_change)
+			drv_data->prev_chip = chip;
+	}
+
+	if (drv_data->dma_mapped)
+		dma_transfer(drv_data, cs_change);
+
+	if (chip->poll_mode)
+		poll_transfer(drv_data);
+
+	return;
+
+early_exit:
+	giveback(drv_data);
+	return;
+}
+
+static void pump_messages(struct work_struct *work)
+{
+	struct driver_data *drv_data =
+		container_of(work, struct driver_data, pump_messages);
+	unsigned long flags;
+
+	/* Lock queue and check for queue work */
+	spin_lock_irqsave(&drv_data->lock, flags);
+	if (list_empty(&drv_data->queue) || drv_data->run == QUEUE_STOPPED) {
+		drv_data->busy = 0;
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+		return;
+	}
+
+	/* Make sure we are not already running a message */
+	if (drv_data->cur_msg) {
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+		return;
+	}
+
+	/* Extract head of queue */
+	drv_data->cur_msg = list_entry(drv_data->queue.next,
+					struct spi_message, queue);
+	list_del_init(&drv_data->cur_msg->queue);
+
+	/* Initial message state*/
+	drv_data->cur_msg->state = START_STATE;
+	drv_data->cur_transfer = list_entry(drv_data->cur_msg->transfers.next,
+						struct spi_transfer,
+						transfer_list);
+	drv_data->cur_chip = spi_get_ctldata(drv_data->cur_msg->spi);
+
+	/* Mark as busy and launch transfers */
+	tasklet_schedule(&drv_data->pump_transfers);
+
+	drv_data->busy = 1;
+	spin_unlock_irqrestore(&drv_data->lock, flags);
+}
+
+/* spi_device use this to queue in the their spi_msg */
+static int mrst_spi_transfer(struct spi_device *spi, struct spi_message *msg)
+{
+	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
+	unsigned long flags;
+
+	spin_lock_irqsave(&drv_data->lock, flags);
+
+	if (drv_data->run == QUEUE_STOPPED) {
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+		return -ESHUTDOWN;
+	}
+
+	msg->actual_length = 0;
+	msg->status = -EINPROGRESS;
+	msg->state = START_STATE;
+
+	list_add_tail(&msg->queue, &drv_data->queue);
+
+	if (drv_data->run == QUEUE_RUNNING && !drv_data->busy) {
+
+		if (drv_data->cur_transfer || drv_data->cur_msg)
+			queue_work(drv_data->workqueue,
+					&drv_data->pump_messages);
+		else {
+			/* if no other data transaction in air, just go */
+			spin_unlock_irqrestore(&drv_data->lock, flags);
+			pump_messages(&drv_data->pump_messages);
+			return 0;
+		}
+	}
+
+	spin_unlock_irqrestore(&drv_data->lock, flags);
+	return 0;
+}
+
+/* the spi->mode bits understood by this driver: */
+#define MODEBITS (SPI_CPOL | SPI_CPHA)
+
+/* this may be called twice for each spi dev */
+static int mrst_spi_setup(struct spi_device *spi)
+{
+	struct mrst_spi_chip *chip_info = NULL;
+	struct chip_data *chip;
+
+	/* Abort device setup if requested features are not supported */
+	if (spi->mode & ~(SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST)) {
+		dev_err(&spi->dev, "requested mode not fully supported\n");
+		return -EINVAL;
+	}
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 16;	/* default to SPI-UART */
+
+	if (spi->bits_per_word != 8 && spi->bits_per_word != 16)
+		return -EINVAL;
+
+	/* Only alloc on first setup */
+	chip = spi_get_ctldata(spi);
+	if (!chip) {
+		chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
+		if (!chip)
+			return -ENOMEM;
+
+		chip->cs_control = null_cs_control;
+		chip->enable_dma = 0;
+	}
+
+	/* protocol drivers may change the chip settings, so...
+	 * if chip_info exists, use it */
+	chip_info = spi->controller_data;
+
+	/* chip_info doesn't always exist */
+	if (chip_info) {
+		if (chip_info->cs_control)
+			chip->cs_control = chip_info->cs_control;
+
+		chip->poll_mode = chip_info->poll_mode;
+		chip->type = chip_info->type;
+
+		chip->rx_threshold = 0;
+		chip->tx_threshold = 0;
+
+		chip->enable_dma = chip_info->enable_dma;
+	}
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
+	} else {
+		/* never take >16b case for MRST SPIC */
+		dev_err(&spi->dev, "invalid wordsize\n");
+		return -ENODEV;
+	}
+	chip->bits_per_word = spi->bits_per_word;
+
+	chip->speed_hz = spi->max_speed_hz;
+	if (chip->speed_hz)
+		chip->clk_div = 25000000 / chip->speed_hz;
+	else
+		chip->clk_div = 8;	/* default for uart device */
+
+	chip->tmode = 0; /* Tx & Rx */
+	/* default SPI mode is SCPOL = 0, SCPH = 0 */
+	chip->cr0 = (chip->bits_per_word - 1)
+			| (chip->type << SPI_FRF_OFFSET)
+			| (spi->mode  << SPI_MODE_OFFSET)
+			| (chip->tmode << SPI_TMOD_OFFSET);
+
+	spi_set_ctldata(spi, chip);
+	return 0;
+}
+
+static void mrst_spi_cleanup(struct spi_device *spi)
+{
+	struct chip_data *chip = spi_get_ctldata(spi);
+
+	kfree(chip);
+}
+
+static int __init init_queue(struct driver_data *drv_data)
+{
+	INIT_LIST_HEAD(&drv_data->queue);
+	spin_lock_init(&drv_data->lock);
+
+	drv_data->run = QUEUE_STOPPED;
+	drv_data->busy = 0;
+
+	tasklet_init(&drv_data->pump_transfers,
+			pump_transfers,	(unsigned long)drv_data);
+
+	INIT_WORK(&drv_data->pump_messages, pump_messages);
+	drv_data->workqueue = create_singlethread_workqueue(
+					dev_name(drv_data->master->dev.parent));
+	if (drv_data->workqueue == NULL)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int start_queue(struct driver_data *drv_data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&drv_data->lock, flags);
+
+	if (drv_data->run == QUEUE_RUNNING || drv_data->busy) {
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+		return -EBUSY;
+	}
+
+	drv_data->run = QUEUE_RUNNING;
+	drv_data->cur_msg = NULL;
+	drv_data->cur_transfer = NULL;
+	drv_data->cur_chip = NULL;
+	drv_data->prev_chip = NULL;
+	spin_unlock_irqrestore(&drv_data->lock, flags);
+
+	queue_work(drv_data->workqueue, &drv_data->pump_messages);
+
+	return 0;
+}
+
+static int stop_queue(struct driver_data *drv_data)
+{
+	unsigned long flags;
+	unsigned limit = 500;
+	int status = 0;
+
+	spin_lock_irqsave(&drv_data->lock, flags);
+	drv_data->run = QUEUE_STOPPED;
+	while (!list_empty(&drv_data->queue) && drv_data->busy && limit--) {
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+		msleep(10);
+		spin_lock_irqsave(&drv_data->lock, flags);
+	}
+
+	if (!list_empty(&drv_data->queue) || drv_data->busy)
+		status = -EBUSY;
+	spin_unlock_irqrestore(&drv_data->lock, flags);
+
+	return status;
+}
+
+static int destroy_queue(struct driver_data *drv_data)
+{
+	int status;
+
+	status = stop_queue(drv_data);
+	if (status != 0)
+		return status;
+	destroy_workqueue(drv_data->workqueue);
+	return 0;
+}
+
+/* restart the spic, disable all interrupts, clean rx fifo */
+static void spi_hw_init(struct driver_data *drv_data)
+{
+	void *reg = drv_data->vaddr;
+
+	mrst_spi_enable(reg, 0x0);
+	spi_mask_intr(reg, 0xff);
+	mrst_spi_enable(reg, 0x1);
+
+	flush(drv_data);
+}
+
+static int __devinit mrst_spi_probe(struct pci_dev *pdev,
+	const struct pci_device_id *ent)
+{
+	int ret;
+	struct driver_data *drv_data;
+	struct spi_master *master;
+	struct device *dev = &pdev->dev;
+	int pci_bar = 0;
+
+	BUG_ON(pdev == NULL);
+	BUG_ON(ent == NULL);
+
+	printk(KERN_INFO "MRST: found PCI SPI controller(ID: %04x:%04x)\n",
+		pdev->vendor, pdev->device);
+
+	ret = pci_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	master = spi_alloc_master(dev, sizeof(struct driver_data));
+	if (!master) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	drv_data = spi_master_get_devdata(master);
+	drv_data->master = master;
+	drv_data->pdev = pdev;
+	drv_data->type = SSI_MOTO_SPI;
+	drv_data->prev_chip = NULL;
+
+	/* get basic io resource and map it */
+	drv_data->paddr = (void *)pci_resource_start(pdev, pci_bar);
+	drv_data->iolen = pci_resource_len(pdev, pci_bar);
+
+	ret = pci_request_region(pdev, pci_bar, dev_name(&pdev->dev));
+	if (ret)
+		goto err_free_master;
+
+	drv_data->vaddr = ioremap_nocache((unsigned long)drv_data->paddr,
+			drv_data->iolen);
+	if (!drv_data->vaddr) {
+		ret = -ENOMEM;
+		goto err_free_master;
+	}
+
+	drv_data->irq = pdev->irq;
+	ret = request_irq(drv_data->irq, mrst_spi_irq, 0,
+			"mrst_spic0", drv_data);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "can not get IRQ\n");
+		goto err_free_master;
+	}
+
+	spin_lock_init(&drv_data->lock);
+
+	master->bus_num = 0;
+	master->num_chipselect = 4;
+	master->cleanup = mrst_spi_cleanup;
+	master->setup = mrst_spi_setup;
+	master->transfer = mrst_spi_transfer;
+
+	drv_data->dma_inited = 0;
+
+	/* basic HW init */
+	spi_hw_init(drv_data);
+
+	/* Initial and start queue */
+	ret = init_queue(drv_data);
+	if (ret) {
+		dev_err(&pdev->dev, "problem initializing queue\n");
+		goto err_diable_hw;
+	}
+	ret = start_queue(drv_data);
+	if (ret) {
+		dev_err(&pdev->dev, "problem starting queue\n");
+		goto err_diable_hw;
+	}
+
+	ret = spi_register_master(master);
+	if (ret) {
+		dev_err(&pdev->dev, "problem registering spi master\n");
+		goto err_queue_alloc;
+	}
+
+	/* PCI hook and SPI hook use the same drv data */
+	pci_set_drvdata(pdev, drv_data);
+	mrst_spi_debugfs_init(drv_data);
+
+	return 0;
+
+err_queue_alloc:
+	destroy_queue(drv_data);
+err_diable_hw:
+	mrst_spi_enable(drv_data->vaddr, 0);
+	free_irq(drv_data->irq, drv_data);
+err_free_master:
+	iounmap(drv_data->vaddr);
+	pci_release_region(pdev, pci_bar);
+	pci_disable_device(pdev);
+	spi_master_put(master);
+exit:
+	return ret;
+}
+
+static void __devexit mrst_spi_remove(struct pci_dev *pdev)
+{
+	struct driver_data *drv_data = pci_get_drvdata(pdev);
+	void *reg;
+	int status = 0;
+
+	if (!drv_data)
+		return;
+
+	mrst_spi_debugfs_remove(drv_data);
+	pci_set_drvdata(pdev, NULL);
+
+	/* remove the queue */
+	status = destroy_queue(drv_data);
+	if (status != 0)
+		dev_err(&pdev->dev, "mrst_spi_remove: workqueue will not "
+			"complete, message memory not freed\n");
+
+	reg = drv_data->vaddr;
+	mrst_spi_enable(reg, 0);
+	spi_disable_clk(reg);
+
+	/* release IRQ */
+	free_irq(drv_data->irq, drv_data);
+
+	iounmap(drv_data->vaddr);
+	pci_release_region(pdev, 0);
+
+	/* disconnect from the SPI framework */
+	spi_unregister_master(drv_data->master);
+	pci_disable_device(pdev);
+}
+
+#ifdef CONFIG_PM
+static int mrst_spi_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct driver_data *drv_data = pci_get_drvdata(pdev);
+	void *reg = drv_data->vaddr;
+	int status = 0;
+
+	status = stop_queue(drv_data);
+	if (status)
+		return status;
+
+	mrst_spi_enable(reg, 0);
+	spi_disable_clk(reg);
+	return status;
+}
+
+static int mrst_spi_resume(struct pci_dev *pdev)
+{
+	struct driver_data *drv_data = pci_get_drvdata(pdev);
+	int status = 0;
+
+	spi_hw_init(drv_data);
+
+	/* Start the queue running */
+	status = start_queue(drv_data);
+	if (status)
+		dev_err(&pdev->dev, "problem starting queue (%d)\n", status);
+	return status;
+}
+#else
+#define mrst_spi_suspend	NULL
+#define mrst_spi_resume		NULL
+#endif
+
+static const struct pci_device_id pci_ids[] __devinitdata = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0800) },
+	{},
+};
+
+static struct pci_driver mrst_spi_driver = {
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
+	return pci_register_driver(&mrst_spi_driver);
+}
+
+static void __exit mrst_spi_exit(void)
+{
+	pci_unregister_driver(&mrst_spi_driver);
+}
+
+module_init(mrst_spi_init);
+module_exit(mrst_spi_exit);
+
+MODULE_AUTHOR("Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION("Intel Moorestown SPI controller driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/spi/mrst_spi.h b/include/linux/spi/mrst_spi.h
new file mode 100644
index 0000000..93f1c73
--- /dev/null
+++ b/include/linux/spi/mrst_spi.h
@@ -0,0 +1,143 @@
+#ifndef MRST_SPI_HEADER_H
+#define MRST_SPI_HEADER_H
+#include <linux/io.h>
+
+/* bit fields in CTRLR0 */
+#define SPI_DFS_OFFSET			0
+
+#define SPI_FRF_OFFSET			4
+#define SPI_FRF_SPI			0x0
+#define SPI_FRF_SSP			0x1
+#define SPI_FRF_MICROWIRE		0x2
+#define SPI_FRF_RESV			0x3
+
+#define SPI_MODE_OFFSET			6
+#define SPI_SCPH_OFFSET			6
+#define SPI_SCOL_OFFSET			7
+#define SPI_TMOD_OFFSET			8
+#define	SPI_TMOD_TR			0x0		/* xmit & recv */
+#define SPI_TMOD_TO			0x1		/* xmit only */
+#define SPI_TMOD_RO			0x2		/* recv only */
+#define SPI_TMOD_EPROMREAD		0x3		/* eeprom read mode */
+
+#define SPI_SLVOE_OFFSET		10
+#define SPI_SRL_OFFSET			11
+#define SPI_CFS_OFFSET			12
+
+/* bit fields in SR, 7 bits */
+#define SR_MASK				0x7f		/* cover 7 bits */
+#define SR_BUSY				(1 << 0)
+#define SR_TF_NOT_FULL			(1 << 1)
+#define SR_TF_EMPT			(1 << 2)
+#define SR_RF_NOT_EMPT			(1 << 3)
+#define SR_RF_FULL			(1 << 4)
+#define SR_TX_ERR			(1 << 5)
+#define SR_DCOL				(1 << 6)
+
+/* bit fields in ISR, IMR, RISR, 7 bits */
+#define SPI_INT_TXEI			(1 << 0)
+#define SPI_INT_TXOI			(1 << 1)
+#define SPI_INT_RXUI			(1 << 2)
+#define SPI_INT_RXOI			(1 << 3)
+#define SPI_INT_RXFI			(1 << 4)
+#define SPI_INT_MSTI			(1 << 5)
+
+/* TX RX interrupt level threshhold, max can be 256 */
+#define SPI_INT_THRESHOLD		32
+
+#define DEFINE_MRST_SPI_RW_REG(reg, off) \
+static inline u32 read_##reg(void *p) \
+{ return readl(p + (off)); } \
+static inline void write_##reg(u32 v, void *p) \
+{ writel(v, p + (off)); }
+
+#define DEFINE_MRST_SPI_RO_REG(reg, off) \
+static inline u32 read_##reg(void *p) \
+{ return readl(p + (off)); } \
+
+DEFINE_MRST_SPI_RW_REG(ctrl0, 0x00)
+DEFINE_MRST_SPI_RW_REG(ctrl1, 0x04)
+DEFINE_MRST_SPI_RW_REG(ssienr, 0x08)
+DEFINE_MRST_SPI_RW_REG(mwcr, 0x0c)
+DEFINE_MRST_SPI_RW_REG(ser, 0x10)
+DEFINE_MRST_SPI_RW_REG(baudr, 0x14)
+DEFINE_MRST_SPI_RW_REG(txftlr, 0x18)
+DEFINE_MRST_SPI_RW_REG(rxftlr, 0x1c)
+DEFINE_MRST_SPI_RO_REG(txflr, 0x20)
+DEFINE_MRST_SPI_RO_REG(rxflr, 0x24)
+DEFINE_MRST_SPI_RO_REG(sr, 0x28)
+DEFINE_MRST_SPI_RW_REG(imr, 0x2c)
+DEFINE_MRST_SPI_RO_REG(isr, 0x30)
+DEFINE_MRST_SPI_RO_REG(risr, 0x34)
+DEFINE_MRST_SPI_RO_REG(txoicr, 0x38)
+DEFINE_MRST_SPI_RO_REG(rxoicr, 0x3c)
+DEFINE_MRST_SPI_RO_REG(rxuicr, 0x40)
+DEFINE_MRST_SPI_RO_REG(msticr, 0x44)
+DEFINE_MRST_SPI_RO_REG(icr, 0x48)
+DEFINE_MRST_SPI_RW_REG(dmacr, 0x4c)
+DEFINE_MRST_SPI_RW_REG(dmatdlr, 0x50)
+DEFINE_MRST_SPI_RW_REG(dmardlr, 0x54)
+DEFINE_MRST_SPI_RO_REG(idr, 0x58)
+DEFINE_MRST_SPI_RO_REG(version, 0x5c)
+DEFINE_MRST_SPI_RW_REG(dr, 0x60)
+
+static inline void mrst_spi_enable(void *reg, int enable)
+{
+	if (enable)
+		write_ssienr(0x1, reg);
+	else
+		write_ssienr(0x0, reg);
+}
+
+static inline  void spi_enable_clk(void *reg, u16 div)
+{
+	write_baudr(div, reg);
+}
+
+static inline void spi_chip_sel(void *reg, u16 cs)
+{
+	if (cs > 4)
+		return;
+	write_ser((1 << cs), reg);
+}
+
+static inline void spi_disable_clk(void *reg)
+{
+	/* set the divider to 0 will diable the clock */
+	write_baudr(0, reg);
+}
+
+/* disable some INT */
+static inline  void spi_mask_intr(void *reg, u32 mask)
+{
+	u32 imr;
+	imr = read_imr(reg) & ~mask;
+	write_imr(imr, reg);
+}
+
+/* enable INT */
+static inline void spi_umask_intr(void *reg, u32 mask)
+{
+	u32 imr;
+	imr = read_imr(reg) | mask;
+	write_imr(imr, reg);
+}
+
+enum mrst_ssi_type {
+	SSI_MOTO_SPI = 0,
+	SSI_TI_SSP,
+	SSI_NS_MICROWIRE,
+};
+
+/*
+ * platform data for a spi slave device, which will connct
+ * MRST SPI0 controller, usually in spi_dev's controller_data
+ */
+struct mrst_spi_chip {
+	u8 poll_mode;
+	u8 enable_dma;
+	u8 type;	/* SPI/SSP/Micrwire */
+	void (*cs_control)(u32 command);
+};
+
+#endif /* #ifndef MRST_SPI_HEADER_H */
-- 
1.5.6.3

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
