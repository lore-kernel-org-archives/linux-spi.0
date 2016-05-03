From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC, 2/4] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Tue,  3 May 2016 16:36:43 -0400
Message-ID: <1462307805-24434-2-git-send-email-kdasu.kdev@gmail.com>
References: <1462307805-24434-1-git-send-email-kdasu.kdev@gmail.com>
Cc: vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yrdreddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462307805-24434-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Adding unified SPI flash and MSPI driver for Broadcom
BRCMSTB, NS2, NSP SoCs. Driver shall work with
brcm,7120-l2-intc or brcm-l2-intc or with a single
muxed L1 interrupt source.

Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/Kconfig        |    6 +
 drivers/spi/Makefile       |    1 +
 drivers/spi/spi-bcm-qspi.c | 1807 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1814 insertions(+)
 create mode 100644 drivers/spi/spi-bcm-qspi.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9d8c84b..6728082 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -153,6 +153,12 @@ config SPI_BCM63XX_HSSPI
 	  This enables support for the High Speed SPI controller present on
 	  newer Broadcom BCM63XX SoCs.
 
+config SPI_BCM_QSPI
+	tristate "Broadcom BSPI and MSPI controller support"
+	help
+	  Enables support for the Broadcom SPI flash and MSPI controller.
+	  Currently supports BRCMSTB, NSP, NS2 SoCs
+
 config SPI_BITBANG
 	tristate "Utilities for Bitbanging SPI masters"
 	help
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index fbb255c..62bb360 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_SPI_BCM2835AUX)		+= spi-bcm2835aux.o
 obj-$(CONFIG_SPI_BCM53XX)		+= spi-bcm53xx.o
 obj-$(CONFIG_SPI_BCM63XX)		+= spi-bcm63xx.o
 obj-$(CONFIG_SPI_BCM63XX_HSSPI)		+= spi-bcm63xx-hsspi.o
+obj-$(CONFIG_SPI_BCM_QSPI)		+= spi-bcm-qspi.o
 obj-$(CONFIG_SPI_BFIN5XX)		+= spi-bfin5xx.o
 obj-$(CONFIG_SPI_ADI_V3)                += spi-adi-v3.o
 obj-$(CONFIG_SPI_BFIN_SPORT)		+= spi-bfin-sport.o
diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
new file mode 100644
index 0000000..63143a4
--- /dev/null
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -0,0 +1,1807 @@
+/*
+ * Copyright (C) 2015 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * This file contains the Broadcom qspi driver. The qspi has two blocks named
+ * mspi and  bspi. The bspi is used for continuous reading purpose only.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mtd/cfi.h>
+#include <linux/mtd/spi-nor.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#define DRIVER_NAME "bcm_qspi"
+
+#define QSPI_STATE_IDLE				0
+#define QSPI_STATE_RUNNING			1
+#define QSPI_STATE_SHUTDOWN			2
+
+/* BSPI register offsets */
+#define QSPI_BSPI_REVISION_ID			0x000
+#define QSPI_BSPI_SCRATCH			0x004
+#define QSPI_BSPI_MAST_N_BOOT_CTRL		0x008
+#define QSPI_BSPI_BUSY_STATUS			0x00c
+#define QSPI_BSPI_INTR_STATUS			0x010
+#define QSPI_BSPI_B0_STATUS			0x014
+#define QSPI_BSPI_B0_CTRL			0x018
+#define QSPI_BSPI_B1_STATUS			0x01c
+#define QSPI_BSPI_B1_CTRL			0x020
+#define QSPI_BSPI_STRAP_OVERRIDE_CTRL		0x024
+#define QSPI_BSPI_FLEX_MODE_ENABLE		0x028
+#define QSPI_BSPI_BITS_PER_CYCLE		0x02c
+#define QSPI_BSPI_BITS_PER_PHASE		0x030
+#define QSPI_BSPI_CMD_AND_MODE_BYTE		0x034
+#define QSPI_BSPI_BSPI_FLASH_UPPER_ADDR_BYTE	0x038
+#define QSPI_BSPI_BSPI_XOR_VALUE		0x03c
+#define QSPI_BSPI_BSPI_XOR_ENABLE		0x040
+#define QSPI_BSPI_BSPI_PIO_MODE_ENABLE		0x044
+#define QSPI_BSPI_BSPI_PIO_IODIR		0x048
+#define QSPI_BSPI_BSPI_PIO_DATA			0x04c
+
+/* RAF register offsets */
+#define QSPI_RAF_START_ADDR			0x100
+#define QSPI_RAF_NUM_WORDS			0x104
+#define QSPI_RAF_CTRL				0x108
+#define QSPI_RAF_FULLNESS			0x10c
+#define QSPI_RAF_WATERMARK			0x110
+#define QSPI_RAF_STATUS				0x114
+#define QSPI_RAF_READ_DATA			0x118
+#define QSPI_RAF_WORD_CNT			0x11c
+#define QSPI_RAF_CURR_ADDR			0x120
+
+/* MSPI register offsets */
+#define QSPI_MSPI_SPCR0_LSB			0x000
+#define QSPI_MSPI_SPCR0_MSB			0x004
+#define QSPI_MSPI_SPCR1_LSB			0x008
+#define QSPI_MSPI_SPCR1_MSB			0x00c
+#define QSPI_MSPI_NEWQP				0x010
+#define QSPI_MSPI_ENDQP				0x014
+#define QSPI_MSPI_SPCR2				0x018
+#define QSPI_MSPI_MSPI_STATUS			0x020
+#define QSPI_MSPI_CPTQP				0x024
+#define QSPI_MSPI_SPCR3				0x028
+#define QSPI_MSPI_TXRAM				0x040
+#define QSPI_MSPI_RXRAM				0x0c0
+#define QSPI_MSPI_CDRAM				0x140
+#define QSPI_MSPI_WRITE_LOCK			0x180
+
+#define QSPI_MSPI_MASTER_BIT			BIT(7)
+
+#define QSPI_MSPI_NUM_CDRAM			16
+#define QSPI_MSPI_CDRAM_CONT_BIT		BIT(7)
+#define QSPI_MSPI_CDRAM_BITSE_BIT		BIT(6)
+
+#define QSPI_MSPI_SPCR2_SPE			BIT(6)
+#define QSPI_MSPI_SPCR2_CONT_AFTER_CMD		BIT(7)
+
+#define QSPI_MSPI_MSPI_STATUS_SPIF		BIT(0)
+
+#define PARMS_NO_OVERRIDE			0
+#define PARMS_OVERRIDE				1
+
+#define	BSPI_ADDRLEN_3BYTES			3
+#define	BSPI_ADDRLEN_4BYTES			4
+
+#define QSPI_BSPI_RAF_STATUS_FIFO_EMPTY_MASK	BIT(1)
+
+#define QSPI_BSPI_RAF_CTRL_START_MASK		BIT(0)
+#define QSPI_BSPI_RAF_CTRL_CLEAR_MASK		BIT(1)
+
+#define QSPI_BSPI_BPP_MODE_SELECT_MASK		BIT(8)
+#define QSPI_BSPI_BPP_ADDR_SELECT_MASK		BIT(16)
+
+/* HIF INTR2 offsets */
+#define HIF_SPI_INTR2_CPU_STATUS		0x00
+#define HIF_SPI_INTR2_CPU_SET			0x04
+#define HIF_SPI_INTR2_CPU_CLEAR			0x08
+#define HIF_SPI_INTR2_CPU_MASK_STATUS		0x0c
+#define HIF_SPI_INTR2_CPU_MASK_SET		0x10
+#define HIF_SPI_INTR2_CPU_MASK_CLEAR		0x14
+
+#define QSPI_INTR_BASE_BIT_SHIFT			0x02
+#define QSPI_INTR_COUNT					0x07
+
+/* MSPI Interrupt masks */
+#define QSPI_INTR_MSPI_HALTED_MASK                     BIT(6)
+#define QSPI_INTR_MSPI_DONE_MASK                       BIT(5)
+
+/* BSPI interrupt masks */
+#define QSPI_INTR_BSPI_LR_OVERREAD_MASK                BIT(4)
+#define QSPI_INTR_BSPI_LR_SESSION_DONE_MASK            BIT(3)
+#define QSPI_INTR_BSPI_LR_IMPATIENT_MASK               BIT(2)
+#define QSPI_INTR_BSPI_LR_SESSION_ABORTED_MASK         BIT(1)
+#define QSPI_INTR_BSPI_LR_FULLNESS_REACHED_MASK        BIT(0)
+
+/* Override mode masks */
+#define QSPI_BSPI_STRAP_OVERRIDE_CTRL_OVERRIDE		BIT(0)
+#define QSPI_BSPI_STRAP_OVERRIDE_CTRL_DATA_DUAL		BIT(1)
+#define QSPI_BSPI_STRAP_OVERRIDE_CTRL_ADDR_4BYTE	BIT(2)
+#define QSPI_BSPI_STRAP_OVERRIDE_CTRL_DATA_QUAD		BIT(3)
+#define QSPI_BSPI_STRAP_OVERRIDE_CTRL_ENDAIN_MODE	BIT(4)
+
+#define MSPI_INTERRUPTS_ALL				\
+	(QSPI_INTR_MSPI_DONE_MASK |			\
+	QSPI_INTR_MSPI_HALTED_MASK)
+
+#define BSPI_LR_INTERRUPTS_DATA				\
+	(QSPI_INTR_BSPI_LR_SESSION_DONE_MASK |		\
+	QSPI_INTR_BSPI_LR_FULLNESS_REACHED_MASK)
+
+#define BSPI_LR_INTERRUPTS_ERROR			\
+	(QSPI_INTR_BSPI_LR_OVERREAD_MASK |		\
+	QSPI_INTR_BSPI_LR_IMPATIENT_MASK |		\
+	QSPI_INTR_BSPI_LR_SESSION_ABORTED_MASK)
+
+#define BSPI_LR_INTERRUPTS_ALL				\
+	(BSPI_LR_INTERRUPTS_ERROR |			\
+	 BSPI_LR_INTERRUPTS_DATA)
+
+#define QSPI_INTERRUPTS_ALL				\
+	(MSPI_INTERRUPTS_ALL |				\
+	BSPI_LR_INTERRUPTS_ALL)
+
+#define BSPI_FLASH_TYPE_UNKNOWN			-1
+
+#define NUM_CHIPSELECT				4
+#define MSPI_BASE_FREQ				27000000UL
+#define QSPI_SPBR_MIN				8U
+#define QSPI_SPBR_MAX				255U
+#define MAX_SPEED_HZ				\
+					(MSPI_BASE_FREQ / (QSPI_SPBR_MIN * 2))
+
+#define OPCODE_DIOR				0xBB
+#define OPCODE_QIOR				0xEB
+#define OPCODE_DIOR_4B				0xBC
+#define OPCODE_QIOR_4B				0xEC
+
+/* stop at end of transfer, no other reason */
+#define QSPI_MSPI_XFR_BREAK_NONE		0
+/* stop at end of spi_message */
+#define QSPI_MSPI_XFR_BREAK_EOM			1
+/* stop at end of spi_transfer if delay */
+#define QSPI_MSPI_XFR_BREAK_DELAY		2
+/* stop at end of spi_transfer if cs_change */
+#define QSPI_MSPI_XFR_BREAK_CS_CHANGE		4
+/* stop if we run out of bytes */
+#define QSPI_MSPI_XFR_BREAK_NO_BYTES		8
+/* events that make us stop filling TX slots */
+#define QSPI_MSPI_XFR_BREAK_TX		(QSPI_MSPI_XFR_BREAK_EOM |	\
+					QSPI_MSPI_XFR_BREAK_DELAY |	\
+					QSPI_MSPI_XFR_BREAK_CS_CHANGE)
+
+/* events that make us deassert CS */
+#define QSPI_MSPI_XFR_BREAK_DESELECT	(QSPI_MSPI_XFR_BREAK_EOM |	\
+					QSPI_MSPI_XFR_BREAK_CS_CHANGE)
+
+static int bspi_flash = BSPI_FLASH_TYPE_UNKNOWN;
+
+struct bcm_qspi_parms {
+	u32 speed_hz;
+	u8 chip_select;
+	u8 mode;
+	u8 bits_per_word;
+};
+
+static const struct bcm_qspi_parms bcm_qspi_default_parms_cs0 = {
+	.speed_hz = MAX_SPEED_HZ,
+	.chip_select = 0,
+	.mode = SPI_MODE_3,
+	.bits_per_word = 8,
+};
+
+struct mspi_xfr_status {
+	struct spi_message *msg;
+	struct spi_transfer *trans;
+	int byte;
+};
+
+struct bcm_xfer_mode {
+	bool flex_mode;
+	unsigned int width;
+	unsigned int addrlen;
+	unsigned int hp;
+};
+
+enum base_type {
+	MSPI,
+	BSPI,
+	INTR,
+	INTR_STATUS,
+	CHIP_SELECT,
+	BASEMAX,
+};
+
+struct bcm_qspi_irq {
+	const char *irq_name;
+	const irq_handler_t irq_handler;
+	u32 mask;
+};
+
+struct bcm_qspi_dev_id {
+	const struct bcm_qspi_irq *irqp;
+	void *dev;
+};
+
+struct bcm_qspi {
+	struct platform_device *pdev;
+	struct spi_master *master;
+	struct tasklet_struct tasklet;
+
+	struct clk *clk;
+	u32 base_clk;
+	u32 max_speed_hz;
+
+	void __iomem *base[BASEMAX];
+	spinlock_t lock;
+	struct bcm_qspi_parms last_parms;
+	struct mspi_xfr_status pos;
+	struct list_head msg_queue;
+	int state;
+	int outstanding_bytes;
+	int next_udelay;
+	int cs_change;
+	int curr_cs;
+
+	int bspi_maj_rev;
+	int bspi_min_rev;
+	int bspi_enabled;
+	int bspi_cs_bmap;
+	struct spi_transfer *bspi_xfer;
+	struct spi_message *bspi_msg;
+	u32 bspi_xfer_idx;
+	u32 bspi_xfer_len;
+	u32 bspi_xfer_status;
+	u32 actual_length;
+	struct bcm_xfer_mode xfer_mode;
+	u32 s3_intr2_mask;
+	u32 s3_strap_override_ctrl;
+	bool hif_spi_mode;
+	bool bspi_mode;
+	int num_irqs;
+	struct bcm_qspi_dev_id *dev_ids;
+};
+
+
+static int bcm_qspi_flash_type(struct bcm_qspi *qspi);
+
+/* Read qspi controller register*/
+static inline u32 bcm_qspi_read(struct bcm_qspi *qspi, enum base_type type,
+				   unsigned int offset)
+{
+	if (!qspi->base[type])
+		return 0;
+
+	return readl(qspi->base[type] + offset);
+}
+
+/* Write qspi controller register*/
+static inline void bcm_qspi_write(struct bcm_qspi *qspi, enum base_type type,
+			 unsigned int offset, unsigned int data)
+{
+	if (!qspi->base[type])
+		return;
+
+	writel(data, (qspi->base[type] + offset));
+}
+
+static void bcm_qspi_enable_interrupt(struct bcm_qspi *qspi, u32 mask)
+{
+	unsigned int val;
+
+	if (!qspi->base[INTR])
+		return;
+
+	if (qspi->hif_spi_mode)
+		bcm_qspi_write(qspi, INTR, HIF_SPI_INTR2_CPU_MASK_CLEAR, mask);
+	else {
+		val = bcm_qspi_read(qspi, INTR, 0);
+		val = val | (mask << QSPI_INTR_BASE_BIT_SHIFT);
+		bcm_qspi_write(qspi, INTR, 0, val);
+	}
+}
+
+static void bcm_qspi_disable_interrupt(struct bcm_qspi *qspi, u32 mask)
+{
+	unsigned int val;
+
+	if (!qspi->base[INTR])
+		return;
+
+	if (qspi->hif_spi_mode)
+		bcm_qspi_write(qspi, INTR, HIF_SPI_INTR2_CPU_MASK_SET, mask);
+	else {
+		val = bcm_qspi_read(qspi, INTR, 0);
+		val = val & ~(mask << QSPI_INTR_BASE_BIT_SHIFT);
+		bcm_qspi_write(qspi, INTR, 0, val);
+	}
+}
+
+static void bcm_qspi_clear_interrupt(struct bcm_qspi *qspi, u32 mask)
+{
+	unsigned int val;
+
+	if (!qspi->base[INTR_STATUS])
+		return;
+
+	if (qspi->hif_spi_mode)
+		bcm_qspi_write(qspi, INTR_STATUS,
+			       HIF_SPI_INTR2_CPU_CLEAR, mask);
+	else {
+		for (val = 0; val < QSPI_INTR_COUNT; val++) {
+			if (mask & (1UL << val))
+				bcm_qspi_write(qspi, INTR_STATUS,
+							(val * 4), 1);
+		}
+	}
+}
+
+static u32 bcm_qspi_read_l2int_status(struct bcm_qspi *qspi)
+{
+	unsigned int val = 0;
+	unsigned int i = 0;
+
+	BUG_ON(!qspi->base[INTR_STATUS]);
+
+	if (qspi->hif_spi_mode)
+		val = bcm_qspi_read(qspi, INTR_STATUS,
+				    HIF_SPI_INTR2_CPU_STATUS);
+	else {
+		for (i = 0; i < QSPI_INTR_COUNT; i++) {
+			if (bcm_qspi_read(qspi, INTR_STATUS, (i * 4)))
+				val |= 1UL << i;
+		}
+	}
+	return val;
+}
+
+static int bcm_qspi_bspi_busy_poll(struct bcm_qspi *qspi)
+{
+	int i;
+
+	/* this should normally finish within 10us */
+	for (i = 0; i < 1000; i++) {
+		if (!(bcm_qspi_read(qspi, BSPI, QSPI_BSPI_BUSY_STATUS) & 1))
+			return 0;
+		udelay(1);
+	}
+	dev_warn(&qspi->pdev->dev, "timeout waiting for !busy_status\n");
+	return -EIO;
+}
+
+static inline bool bcm_qspi_bspi_ver_three(struct bcm_qspi *qspi)
+{
+	if (qspi->bspi_maj_rev < 4)
+		return true;
+	return false;
+}
+
+static void bcm_qspi_flush_prefetch_buffers(struct bcm_qspi *qspi)
+{
+	bcm_qspi_bspi_busy_poll(qspi);
+	/* Force rising edge for the b0/b1 'flush' field */
+	bcm_qspi_write(qspi, BSPI, QSPI_BSPI_B0_CTRL, 1);
+	bcm_qspi_write(qspi, BSPI, QSPI_BSPI_B1_CTRL, 1);
+	bcm_qspi_write(qspi, BSPI, QSPI_BSPI_B0_CTRL, 0);
+	bcm_qspi_write(qspi, BSPI, QSPI_BSPI_B1_CTRL, 0);
+}
+
+static int bcm_qspi_lr_is_fifo_empty(struct bcm_qspi *qspi)
+{
+	return (bcm_qspi_read(qspi, BSPI, QSPI_RAF_STATUS) &
+				QSPI_BSPI_RAF_STATUS_FIFO_EMPTY_MASK);
+}
+
+static inline u32 bcm_qspi_lr_read_fifo(struct bcm_qspi *qspi)
+{
+	u32 data = bcm_qspi_read(qspi, BSPI, QSPI_RAF_READ_DATA);
+
+	/* BSPI v3 LR is LE only, convert data to host endianness */
+	if (bcm_qspi_bspi_ver_three(qspi))
+		data = le32_to_cpu(data);
+
+	return data;
+}
+
+static inline void bcm_qspi_lr_start(struct bcm_qspi *qspi)
+{
+	bcm_qspi_write(qspi, BSPI, QSPI_RAF_CTRL,
+				QSPI_BSPI_RAF_CTRL_START_MASK);
+}
+
+static inline void bcm_qspi_lr_clear(struct bcm_qspi *qspi)
+{
+	bcm_qspi_write(qspi, BSPI, QSPI_RAF_CTRL,
+				QSPI_BSPI_RAF_CTRL_CLEAR_MASK);
+	bcm_qspi_flush_prefetch_buffers(qspi);
+}
+
+static void bcm_qspi_bspi_lr_data_read(struct bcm_qspi *qspi)
+{
+	u32 *buf = (u32 *)qspi->bspi_xfer->rx_buf;
+	u32 data = 0;
+
+	while (!bcm_qspi_lr_is_fifo_empty(qspi)) {
+		data = bcm_qspi_lr_read_fifo(qspi);
+		if (likely(qspi->bspi_xfer_len >= 4)) {
+			buf[qspi->bspi_xfer_idx++] = data;
+			qspi->bspi_xfer_len -= 4;
+		} else {
+			/* Read out remaining bytes, make sure*/
+			u8 *cbuf = (u8 *)&buf[qspi->bspi_xfer_idx];
+
+			data = cpu_to_le32(data);
+			while (qspi->bspi_xfer_len) {
+				*cbuf++ = (u8)data;
+				data >>= 8;
+				qspi->bspi_xfer_len--;
+			}
+		}
+	}
+}
+
+static inline int bcm_qspi_is_4_byte_mode(struct bcm_qspi *qspi)
+{
+	return qspi->xfer_mode.addrlen == BSPI_ADDRLEN_4BYTES;
+}
+static void bcm_qspi_bspi_set_xfer_params(struct bcm_qspi *qspi, u8 cmd_byte,
+					  int bpp, int bpc, int flex_mode)
+{
+	bcm_qspi_write(qspi, BSPI, QSPI_BSPI_FLEX_MODE_ENABLE, 0);
+	bcm_qspi_write(qspi, BSPI, QSPI_BSPI_BITS_PER_CYCLE, bpc);
+	bcm_qspi_write(qspi, BSPI, QSPI_BSPI_BITS_PER_PHASE, bpp);
+	bcm_qspi_write(qspi, BSPI, QSPI_BSPI_CMD_AND_MODE_BYTE, cmd_byte);
+	bcm_qspi_write(qspi, BSPI, QSPI_BSPI_FLEX_MODE_ENABLE, flex_mode);
+}
+
+static int bcm_qspi_bspi_set_flex_mode(struct bcm_qspi *qspi, int width,
+				       int addrlen, int hp)
+{
+	int bpc = 0, bpp = 0;
+	u8 command = SPINOR_OP_READ_FAST;
+	int flex_mode = 1, rv = 0;
+	bool spans_4byte = false;
+
+	dev_dbg(&qspi->pdev->dev, "set flex mode w %x addrlen %x hp %d\n",
+					width, addrlen, hp);
+
+	if (addrlen == BSPI_ADDRLEN_4BYTES) {
+		bpp = QSPI_BSPI_BPP_ADDR_SELECT_MASK;
+		spans_4byte = true;
+	}
+
+	bpp |= 8; /* dummy cycles */
+
+	switch (width) {
+	case SPI_NBITS_SINGLE:
+		if (addrlen == BSPI_ADDRLEN_3BYTES)
+			/* default mode, does not need flex_cmd */
+			flex_mode = 0;
+		else
+			command = SPINOR_OP_READ4_FAST;
+		break;
+	case SPI_NBITS_DUAL:
+		bpc = 0x00000001;
+		if (hp) {
+			bpc |= 0x00010100; /* address and mode are 2-bit */
+			bpp = QSPI_BSPI_BPP_MODE_SELECT_MASK;
+			command = OPCODE_DIOR;
+			if (spans_4byte == true)
+				command = OPCODE_DIOR_4B;
+		} else {
+			command = SPINOR_OP_READ_1_1_2;
+			if (spans_4byte == true)
+				command = SPINOR_OP_READ4_1_1_2;
+		}
+		break;
+	case SPI_NBITS_QUAD:
+		bpc = 0x00000002;
+		if (hp) {
+			bpc |= 0x00020200; /* address and mode are 4-bit */
+			bpp = 4; /* dummy cycles */
+			bpp |= QSPI_BSPI_BPP_ADDR_SELECT_MASK;
+			command = OPCODE_QIOR;
+			if (spans_4byte == true)
+				command = OPCODE_QIOR_4B;
+		} else {
+			command = SPINOR_OP_READ_1_1_4;
+			if (spans_4byte == true)
+				command = SPINOR_OP_READ4_1_1_4;
+		}
+		break;
+	default:
+		rv = -1;
+		break;
+	}
+
+	if (!rv)
+		bcm_qspi_bspi_set_xfer_params(qspi, command, bpp, bpc,
+					      flex_mode);
+
+	return rv;
+}
+
+static int bcm_qspi_bspi_set_override(struct bcm_qspi *qspi, int width,
+				      int addrlen, int hp)
+{
+	u32 data = bcm_qspi_read(qspi, BSPI, QSPI_BSPI_STRAP_OVERRIDE_CTRL);
+
+	dev_dbg(&qspi->pdev->dev, "set override mode w %x addrlen %x hp %d\n",
+					width, addrlen, hp);
+
+	switch (width) {
+	case SPI_NBITS_QUAD:
+		/* clear dual mode and set quad mode */
+		data &= ~QSPI_BSPI_STRAP_OVERRIDE_CTRL_DATA_DUAL;
+		data |= QSPI_BSPI_STRAP_OVERRIDE_CTRL_DATA_QUAD;
+		break;
+	case SPI_NBITS_DUAL:
+		/* clear quad mode set dual mode */
+		data &= ~QSPI_BSPI_STRAP_OVERRIDE_CTRL_DATA_QUAD;
+		data |= QSPI_BSPI_STRAP_OVERRIDE_CTRL_DATA_DUAL;
+		break;
+	case SPI_NBITS_SINGLE:
+		/* clear quad/dual mode */
+		data &= ~(QSPI_BSPI_STRAP_OVERRIDE_CTRL_DATA_QUAD |
+			  QSPI_BSPI_STRAP_OVERRIDE_CTRL_DATA_DUAL);
+		break;
+	default:
+		break;
+	}
+
+	if (addrlen == BSPI_ADDRLEN_4BYTES)
+		/* set 4byte mode*/
+		data |= QSPI_BSPI_STRAP_OVERRIDE_CTRL_ADDR_4BYTE;
+	else
+		/* clear 4 byte mode */
+		data &= ~QSPI_BSPI_STRAP_OVERRIDE_CTRL_ADDR_4BYTE;
+
+	/* set the override mode */
+	data |=	QSPI_BSPI_STRAP_OVERRIDE_CTRL_OVERRIDE;
+	bcm_qspi_write(qspi, BSPI, QSPI_BSPI_STRAP_OVERRIDE_CTRL, data);
+	bcm_qspi_bspi_set_xfer_params(qspi, SPINOR_OP_READ_FAST, 0, 0, 0);
+
+	return 0;
+}
+
+static void bcm_qspi_bspi_set_mode(struct bcm_qspi *qspi,
+				   int width, int addrlen, int hp)
+{
+	int error = 0;
+
+	if (width == -1)
+		width = qspi->xfer_mode.width;
+	if (addrlen == -1)
+		addrlen = qspi->xfer_mode.addrlen;
+	if (hp == -1)
+		hp = qspi->xfer_mode.hp;
+
+	/* default mode */
+	qspi->xfer_mode.flex_mode = true;
+
+	if (!bcm_qspi_bspi_ver_three(qspi)) {
+		u32 val, mask;
+
+		val = bcm_qspi_read(qspi, BSPI, QSPI_BSPI_STRAP_OVERRIDE_CTRL);
+		mask = QSPI_BSPI_STRAP_OVERRIDE_CTRL_OVERRIDE;
+		if (val & mask || qspi->s3_strap_override_ctrl & mask) {
+			qspi->xfer_mode.flex_mode = false;
+			bcm_qspi_write(qspi, BSPI, QSPI_BSPI_FLEX_MODE_ENABLE,
+				       0);
+
+			if ((val | qspi->s3_strap_override_ctrl) &
+			    QSPI_BSPI_STRAP_OVERRIDE_CTRL_DATA_DUAL)
+				width = SPI_NBITS_DUAL;
+			else if ((val |  qspi->s3_strap_override_ctrl) &
+				 QSPI_BSPI_STRAP_OVERRIDE_CTRL_DATA_QUAD)
+				width = SPI_NBITS_QUAD;
+
+			error = bcm_qspi_bspi_set_override(qspi, width, addrlen,
+							   hp);
+		}
+	}
+
+	if (qspi->xfer_mode.flex_mode)
+		error = bcm_qspi_bspi_set_flex_mode(qspi, width, addrlen, hp);
+
+	if (!error) {
+		qspi->xfer_mode.width = width;
+		qspi->xfer_mode.addrlen = addrlen;
+		qspi->xfer_mode.hp = hp;
+		dev_info(&qspi->pdev->dev,
+			"%d-lane output, %d-byte address%s\n",
+			qspi->xfer_mode.width,
+			qspi->xfer_mode.addrlen,
+			qspi->xfer_mode.hp ? ", high-performance mode" : "");
+	} else
+		dev_warn(&qspi->pdev->dev,
+			"INVALID COMBINATION: width=%d addrlen=%d hp=%d\n",
+			width, addrlen, hp);
+}
+
+static void bcm_qspi_chip_select(struct bcm_qspi *qspi, int cs)
+{
+	u32 data = 0;
+
+	if (qspi->curr_cs == cs)
+		return;
+	if (qspi->base[CHIP_SELECT]) {
+		data = bcm_qspi_read(qspi, CHIP_SELECT, 0);
+		data = (data & ~0xff) | (1 << cs);
+		bcm_qspi_write(qspi, CHIP_SELECT, 0, data);
+		udelay(10);
+	}
+	qspi->curr_cs = cs;
+}
+
+static inline int bcm_qspi_bspi_mode(struct bcm_qspi *qspi, u8 cs)
+{
+	return qspi->bspi_cs_bmap & (1 << cs);
+}
+
+static void bcm_qspi_disable_bspi(struct bcm_qspi *qspi)
+{
+	if ((!qspi->base[BSPI]) || (!qspi->bspi_enabled))
+		return;
+
+	qspi->bspi_enabled = 0;
+	bcm_qspi_bspi_busy_poll(qspi);
+	bcm_qspi_write(qspi, BSPI, QSPI_BSPI_MAST_N_BOOT_CTRL, 1);
+	udelay(1);
+}
+
+static void bcm_qspi_enable_bspi(struct bcm_qspi *qspi)
+{
+	if ((!qspi->base[BSPI]) || (qspi->bspi_enabled))
+		return;
+
+	bcm_qspi_flush_prefetch_buffers(qspi);
+	udelay(1);
+	qspi->bspi_enabled = 1;
+	bcm_qspi_write(qspi, BSPI, QSPI_BSPI_MAST_N_BOOT_CTRL, 0);
+	udelay(1);
+}
+
+static void bcm_qspi_hw_set_parms(struct bcm_qspi *qspi,
+				  const struct bcm_qspi_parms *xp)
+{
+	u32 spcr, spbr = 0;
+
+	if (xp->speed_hz)
+		spbr = qspi->base_clk / (2 * xp->speed_hz);
+
+	spcr = clamp_val(spbr, QSPI_SPBR_MIN, QSPI_SPBR_MAX);
+	bcm_qspi_write(qspi, MSPI, QSPI_MSPI_SPCR0_LSB, spcr);
+
+	spcr = QSPI_MSPI_MASTER_BIT;
+	/* for 16 bit the data should be zero */
+	if (xp->bits_per_word != 16)
+		spcr |= xp->bits_per_word << 2;
+	spcr |= xp->mode & 3;
+	bcm_qspi_write(qspi, MSPI, QSPI_MSPI_SPCR0_MSB, spcr);
+
+	qspi->last_parms = *xp;
+}
+
+static int bcm_qspi_update_parms(struct bcm_qspi *qspi,
+				 struct spi_device *spidev,
+				 struct spi_transfer *trans, int override)
+{
+	struct bcm_qspi_parms xp;
+
+	xp.speed_hz = min(trans->speed_hz ? trans->speed_hz :
+			(spidev->max_speed_hz ? spidev->max_speed_hz :
+			qspi->max_speed_hz), qspi->max_speed_hz);
+	xp.chip_select = spidev->chip_select;
+	xp.mode = spidev->mode;
+	xp.bits_per_word = trans->bits_per_word ? trans->bits_per_word :
+		(spidev->bits_per_word ? spidev->bits_per_word : 8);
+
+	if ((override == PARMS_OVERRIDE) ||
+		((xp.speed_hz == qspi->last_parms.speed_hz) &&
+		 (xp.chip_select == qspi->last_parms.chip_select) &&
+		 (xp.mode == qspi->last_parms.mode) &&
+		 (xp.bits_per_word == qspi->last_parms.bits_per_word))) {
+		bcm_qspi_hw_set_parms(qspi, &xp);
+		return 0;
+	}
+	/* no override, and parms do not match */
+	return 1;
+}
+
+static int bcm_qspi_setup(struct spi_device *spi)
+{
+	struct bcm_qspi_parms *xp;
+
+	if (spi->bits_per_word > 16)
+		return -EINVAL;
+
+	xp = spi_get_ctldata(spi);
+	if (!xp) {
+		xp = kzalloc(sizeof(struct bcm_qspi_parms), GFP_KERNEL);
+		if (!xp)
+			return -ENOMEM;
+		spi_set_ctldata(spi, xp);
+	}
+	xp->speed_hz = spi->max_speed_hz;
+	xp->chip_select = spi->chip_select;
+	xp->mode = spi->mode;
+	xp->bits_per_word = spi->bits_per_word ? spi->bits_per_word : 8;
+
+	return 0;
+}
+
+/*
+ * bcm_qspi_get_next_byte_info() - advance byte and check what flags should be
+ *					 set
+ * @qspi: pointer to bcm_qspi private struct
+ * @p: pointer to current position pointer
+ * @flags: flags to take into account at the end of a spi_transfer
+ *
+ * notes: Advances to the next byte, incrementing the byte in the position
+ * pointer p.
+ * If any flags are passed in and we're at the end of a transfer, those are
+ * applied to the return value if applicable to the spi_transfer.
+ *
+ * Return: flags describing the break condition or QSPI_MSPI_XFR_BREAK_NONE.
+ */
+static int bcm_qspi_get_next_byte_info(struct bcm_qspi *qspi,
+				       struct mspi_xfr_status *p,
+				       struct list_head *completed, int flags)
+{
+	int ret = QSPI_MSPI_XFR_BREAK_NONE;
+
+	p->byte++;
+	while (p->byte >= p->trans->len) {
+		/* we're at the end of the spi_transfer */
+
+		/* in TX mode, need to pause for a delay or CS change */
+		if (p->trans->delay_usecs &&
+				(flags & QSPI_MSPI_XFR_BREAK_DELAY))
+			ret |= QSPI_MSPI_XFR_BREAK_DELAY;
+		if (p->trans->cs_change &&
+				(flags & QSPI_MSPI_XFR_BREAK_CS_CHANGE))
+			ret |= QSPI_MSPI_XFR_BREAK_CS_CHANGE;
+		if (ret)
+			return ret;
+
+		/* advance to next spi_message? */
+		if (list_is_last(&p->trans->transfer_list,
+						&p->msg->transfers)) {
+			struct spi_message *next_msg = NULL;
+
+			/* TX breaks at the end of each message as well */
+			if (!completed || (flags & QSPI_MSPI_XFR_BREAK_EOM))
+				return QSPI_MSPI_XFR_BREAK_EOM;
+
+			if (!list_is_last(&p->msg->queue, &qspi->msg_queue)) {
+				next_msg = list_entry(p->msg->queue.next,
+					struct spi_message, queue);
+			}
+			/* delete from run queue, add to completion queue */
+			list_del(&p->msg->queue);
+			list_add_tail(&p->msg->queue, completed);
+
+			p->msg = next_msg;
+			p->byte = 0;
+			if (p->msg == NULL) {
+				p->trans = NULL;
+				ret = QSPI_MSPI_XFR_BREAK_NO_BYTES;
+				break;
+			}
+
+			/*
+			 * move on to the first spi_transfer of the new
+			 * spi_message
+			 */
+			p->trans = list_entry(p->msg->transfers.next,
+				struct spi_transfer, transfer_list);
+		} else {
+			/* or just advance to the next spi_transfer */
+			p->trans = list_entry(p->trans->transfer_list.next,
+				struct spi_transfer, transfer_list);
+			p->byte = 0;
+		}
+	}
+	dev_dbg(&qspi->pdev->dev, "Next byte: trans %p len %d byte %d ret %x\n",
+			p->trans, p->trans ? p->trans->len : 0, p->byte, ret);
+	return ret;
+}
+
+static void bcm_qspi_mspi_read(struct bcm_qspi *qspi,
+			       struct list_head *completed)
+{
+	struct mspi_xfr_status p;
+	int queue_ptr = 0, n = qspi->outstanding_bytes;
+
+	p = qspi->pos;
+	while (n > 0) {
+		BUG_ON(p.msg == NULL);
+		if (p.trans->rx_buf) {
+			u32 offset = QSPI_MSPI_RXRAM + (queue_ptr << 3);
+			u8 msb = bcm_qspi_read(qspi, MSPI, offset) & 0xff;
+			u8 lsb = bcm_qspi_read(qspi, MSPI, offset + 4) & 0xff;
+
+			dev_dbg(&qspi->pdev->dev, "RD %02x %02x\n", msb, lsb);
+			if (p.trans->bits_per_word <= 8) {
+				u8 *buf = p.trans->rx_buf;
+
+				buf[p.byte] = lsb;
+			} else {
+				u16 *buf = p.trans->rx_buf;
+
+				buf[p.byte] = (msb << 8) | lsb;
+			}
+		}
+		queue_ptr++;
+		n--;
+		p.msg->actual_length++;
+
+		bcm_qspi_get_next_byte_info(qspi, &p, completed,
+						QSPI_MSPI_XFR_BREAK_NONE);
+	}
+
+	qspi->pos = p;
+	qspi->outstanding_bytes = 0;
+}
+
+static void bcm_qspi_mspi_write(struct bcm_qspi *qspi)
+{
+	struct mspi_xfr_status p;
+	int queue_ptr = 0, fnb = 0;
+	struct spi_message *msg = NULL;
+	u32 val = 0, offset = 0;
+
+	bcm_qspi_disable_bspi(qspi);
+
+	p = qspi->pos;
+
+	while (1) {
+		if (p.msg == NULL)
+			break;
+		if (!msg) {
+			msg = p.msg;
+			bcm_qspi_update_parms(qspi, msg->spi, p.trans,
+				PARMS_OVERRIDE);
+		} else {
+			/* break if the speed, bits, etc. changed */
+			if (bcm_qspi_update_parms(qspi, msg->spi, p.trans,
+				PARMS_NO_OVERRIDE)) {
+				break;
+			}
+		}
+
+		offset = QSPI_MSPI_TXRAM + (queue_ptr << 3);
+		if (p.trans->bits_per_word <= 8) {
+			const u8 *buf = p.trans->tx_buf;
+
+			val = buf ? (buf[p.byte] & 0xff) : 0xff;
+			dev_dbg(&qspi->pdev->dev, "WR %02x\n", val);
+			bcm_qspi_write(qspi, MSPI, offset, val);
+		} else {
+			/* 16 bit transfer */
+			const u16 *buf = p.trans->tx_buf;
+
+			val = buf ? ((buf[p.byte >> 1] >> 8) & 0xff) : 0xff;
+			bcm_qspi_write(qspi, MSPI, offset, val);
+
+			val = buf ? ((buf[p.byte >> 1]) & 0xff) : 0xff;
+			bcm_qspi_write(qspi, MSPI, (offset + 4), val);
+		}
+
+		val = (~(1 << msg->spi->chip_select)) & 0x0f;
+		val |= QSPI_MSPI_CDRAM_CONT_BIT;
+		if (p.trans->bits_per_word <= 8)
+			val |= QSPI_MSPI_CDRAM_BITSE_BIT;
+		offset = QSPI_MSPI_CDRAM + (queue_ptr << 2);
+		bcm_qspi_write(qspi, MSPI, offset, val);
+
+		queue_ptr++;
+
+		fnb = bcm_qspi_get_next_byte_info(qspi, &p, NULL,
+						QSPI_MSPI_XFR_BREAK_TX);
+
+		if (fnb & QSPI_MSPI_XFR_BREAK_CS_CHANGE)
+			qspi->cs_change = 1;
+		if (fnb & QSPI_MSPI_XFR_BREAK_DELAY)
+			qspi->next_udelay = p.trans->delay_usecs;
+		if (fnb || (queue_ptr == QSPI_MSPI_NUM_CDRAM))
+			break;
+	}
+
+	if (queue_ptr) {
+		dev_dbg(&qspi->pdev->dev, "submitting %d queue_ptr\n",
+				queue_ptr);
+		bcm_qspi_write(qspi, MSPI, QSPI_MSPI_NEWQP, 0);
+		bcm_qspi_write(qspi, MSPI, QSPI_MSPI_ENDQP, (queue_ptr - 1));
+
+		/* deassert CS on the final byte */
+		if (fnb & QSPI_MSPI_XFR_BREAK_DESELECT) {
+			offset = QSPI_MSPI_CDRAM + ((queue_ptr - 1) << 2);
+			val = bcm_qspi_read(qspi, MSPI, offset);
+			bcm_qspi_write(qspi, MSPI, offset,
+					val & ~(QSPI_MSPI_CDRAM_CONT_BIT));
+		}
+		bcm_qspi_chip_select(qspi, msg->spi->chip_select);
+
+		if (qspi->bspi_mode)
+			bcm_qspi_write(qspi, MSPI, QSPI_MSPI_WRITE_LOCK, 1);
+		/* flush previous writes before starting MSPI operation */
+		mb();
+		bcm_qspi_write(qspi, MSPI, QSPI_MSPI_SPCR2, 0xe0);
+
+		qspi->state = QSPI_STATE_RUNNING;
+		qspi->outstanding_bytes = queue_ptr;
+	} else {
+		if (qspi->bspi_mode)
+			bcm_qspi_write(qspi, MSPI, QSPI_MSPI_WRITE_LOCK, 0);
+		qspi->state = QSPI_STATE_IDLE;
+	}
+}
+
+#define DWORD_ALIGNED(a) (!(((unsigned long)(a)) & 3))
+#define ADDR_TO_4MBYTE_SEGMENT(addr)	(((u32)(addr)) >> 22)
+
+static int bcm_qspi_emulate_flash_read(struct bcm_qspi *qspi,
+				     struct spi_message *msg)
+{
+	struct spi_transfer *trans;
+	u32 addr, len, len_words;
+	u8 *buf;
+	unsigned long flags;
+	int idx;
+
+	if (bcm_qspi_bspi_ver_three(qspi))
+		if (bcm_qspi_is_4_byte_mode(qspi))
+			return -1;
+
+	/* acquire lock when the MSPI is idle */
+	while (1) {
+		spin_lock_irqsave(&qspi->lock, flags);
+		if (qspi->state == QSPI_STATE_IDLE)
+			break;
+		spin_unlock_irqrestore(&qspi->lock, flags);
+		if (qspi->state == QSPI_STATE_SHUTDOWN)
+			return -EIO;
+		udelay(1);
+	}
+	bcm_qspi_chip_select(qspi, msg->spi->chip_select);
+
+	/* first transfer - OPCODE_READ + {3,4}-byte address */
+	trans = list_entry(msg->transfers.next, struct spi_transfer,
+		transfer_list);
+	buf = (void *)trans->tx_buf;
+
+	idx = 1;
+
+	if (bcm_qspi_bspi_ver_three(qspi) == false) {
+		if (bcm_qspi_is_4_byte_mode(qspi))
+			addr = buf[idx++] << 24;
+		else
+			addr = 0;
+		bcm_qspi_write(qspi, BSPI,
+				QSPI_BSPI_BSPI_FLASH_UPPER_ADDR_BYTE, addr);
+	}
+
+	addr = (buf[idx] << 16) | (buf[idx+1] << 8) | buf[idx+2];
+
+	/*
+	   when using override mode we need to send
+	   the upper address byte to mspi
+	*/
+	if (qspi->xfer_mode.flex_mode == false)
+		addr |= bcm_qspi_read(qspi, BSPI,
+				      QSPI_BSPI_BSPI_FLASH_UPPER_ADDR_BYTE);
+
+	/* second transfer - read result into buffer */
+	trans = list_entry(msg->transfers.next->next, struct spi_transfer,
+		transfer_list);
+
+	buf = (void *)trans->rx_buf;
+	len = trans->len;
+
+	if (bcm_qspi_bspi_ver_three(qspi) == true) {
+		/*
+		 * The address coming into this function is a raw flash offset.
+		 * But for BSPI <= V3, we need to convert it to a remapped BSPI
+		 * address. If it crosses a 4MB boundary, just revert back to
+		 * using MSPI.
+		 */
+		addr = (addr + 0xc00000) & 0xffffff;
+
+		if (ADDR_TO_4MBYTE_SEGMENT(addr) ^
+		    ADDR_TO_4MBYTE_SEGMENT(addr + len - 1)) {
+			spin_unlock_irqrestore(&qspi->lock, flags);
+			return -1;
+		}
+	}
+	/* non-aligned and very short transfers are handled by MSPI */
+	if (unlikely(!DWORD_ALIGNED(addr) ||
+		     !DWORD_ALIGNED(buf) ||
+		     len < sizeof(u32))) {
+		spin_unlock_irqrestore(&qspi->lock, flags);
+		return -1;
+	}
+
+	bcm_qspi_enable_bspi(qspi);
+
+	len_words = (len + 3) >> 2;
+
+	qspi->bspi_xfer_status = 0;
+	qspi->bspi_xfer = trans;
+	qspi->bspi_xfer_idx = 0;
+	qspi->bspi_xfer_len = len;
+	qspi->bspi_msg = msg;
+	qspi->actual_length = idx + 4 + trans->len;
+	dev_dbg(&qspi->pdev->dev, "bspi xfr addr 0x%x len 0x%x", addr, len);
+	bcm_qspi_write(qspi, BSPI, QSPI_RAF_START_ADDR, addr);
+	bcm_qspi_write(qspi, BSPI, QSPI_RAF_NUM_WORDS, len_words);
+	bcm_qspi_write(qspi, BSPI, QSPI_RAF_WATERMARK, 0);
+
+	bcm_qspi_clear_interrupt(qspi, QSPI_INTERRUPTS_ALL);
+	bcm_qspi_enable_interrupt(qspi, BSPI_LR_INTERRUPTS_ALL);
+	bcm_qspi_lr_start(qspi);
+	spin_unlock_irqrestore(&qspi->lock, flags);
+
+	return 0;
+}
+
+/*
+ * m25p80_read() calls wait_till_ready() before each read to check
+ * the flash status register for pending writes.
+ *
+ * This can be safely skipped if our last transaction was just an
+ * emulated BSPI read.
+ */
+static int bcm_qspi_emulate_flash_rdsr(struct bcm_qspi *qspi    ,
+	struct spi_message *msg)
+{
+	u8 *buf;
+	struct spi_transfer *trans;
+
+	if (qspi->bspi_enabled == 1)
+		return 1;
+
+	trans = list_entry(msg->transfers.next->next, struct spi_transfer,
+		transfer_list);
+
+	buf = (void *)trans->rx_buf;
+	*buf = 0x00;
+
+	msg->actual_length = 2;
+	msg->complete(msg->context);
+	msg->status = 0;
+
+	return 0;
+}
+
+static bool bcm_qspi_bspi_read(struct bcm_qspi *qspi, struct spi_message *msg)
+{
+	struct spi_transfer *trans;
+	bool ret = false;
+	u32 nbits = SPI_NBITS_SINGLE;
+
+	trans = list_entry(msg->transfers.next,
+			struct spi_transfer, transfer_list);
+
+	if (trans && trans->len && trans->tx_buf) {
+		u8 command = ((u8 *)trans->tx_buf)[0];
+
+		if (trans->rx_nbits)
+			nbits = trans->rx_nbits;
+		switch (command) {
+		case SPINOR_OP_READ4_FAST:
+			if (!bcm_qspi_is_4_byte_mode(qspi))
+				bcm_qspi_bspi_set_mode(qspi, nbits,
+					       BSPI_ADDRLEN_4BYTES, -1);
+				/* fall through */
+		case SPINOR_OP_READ_FAST:
+			if (bcm_qspi_emulate_flash_read(qspi, msg) == 0)
+				ret = true;
+			break;
+		case OPCODE_QIOR_4B:
+		case SPINOR_OP_READ_1_1_4:
+		case SPINOR_OP_READ4_1_1_4:
+			if (bcm_qspi_emulate_flash_read(qspi, msg) == 0)
+				ret = true;
+			break;
+		case SPINOR_OP_RDSR:
+			if (bcm_qspi_emulate_flash_rdsr(qspi, msg) == 0)
+				ret = true;
+			break;
+		case SPINOR_OP_EN4B:
+			dev_dbg(&qspi->pdev->dev, "EN4B MODE\n");
+			bcm_qspi_bspi_set_mode(qspi, nbits,
+					BSPI_ADDRLEN_4BYTES, -1);
+			break;
+		case SPINOR_OP_EX4B:
+			dev_dbg(&qspi->pdev->dev, "EX4B MODE\n");
+			bcm_qspi_bspi_set_mode(qspi, nbits,
+					BSPI_ADDRLEN_3BYTES, -1);
+			break;
+		case SPINOR_OP_BRWR:
+			{
+				u8 enable = ((u8 *)trans->tx_buf)[1];
+
+				dev_dbg(&qspi->pdev->dev, " %s 4-BYTE MODE\n",
+					    enable ? "ENABLE" : "DISABLE");
+				bcm_qspi_bspi_set_mode(qspi, nbits,
+					enable ? BSPI_ADDRLEN_4BYTES :
+					BSPI_ADDRLEN_3BYTES, -1);
+			}
+			break;
+		default:
+			break;
+		}
+	}
+	return ret;
+}
+
+static int bcm_qspi_transfer(struct spi_device *spi, struct spi_message *msg)
+{
+	struct bcm_qspi *qspi = spi_master_get_devdata(spi->master);
+	unsigned long flags;
+
+	if (bcm_qspi_bspi_mode(qspi, msg->spi->chip_select)) {
+		if (bcm_qspi_bspi_read(qspi, msg))
+			return 0;
+	}
+
+	spin_lock_irqsave(&qspi->lock, flags);
+
+	if (qspi->state == QSPI_STATE_SHUTDOWN) {
+		spin_unlock_irqrestore(&qspi->lock, flags);
+		return -EIO;
+	}
+
+	msg->actual_length = 0;
+
+	list_add_tail(&msg->queue, &qspi->msg_queue);
+
+	if (qspi->state == QSPI_STATE_IDLE) {
+		BUG_ON(qspi->pos.msg != NULL);
+		qspi->pos.msg = msg;
+		qspi->pos.trans = list_entry(msg->transfers.next,
+			struct spi_transfer, transfer_list);
+		qspi->pos.byte = 0;
+
+		bcm_qspi_mspi_write(qspi);
+	}
+	spin_unlock_irqrestore(&qspi->lock, flags);
+
+	return 0;
+}
+
+static void bcm_qspi_cleanup(struct spi_device *spi)
+{
+	struct bcm_qspi_parms *xp = spi_get_ctldata(spi);
+
+	kfree(xp);
+}
+
+static irqreturn_t bcm_qspi_mspi_l2_isr(int irq, void *dev_id)
+{
+	struct bcm_qspi_dev_id *qspi_dev_id = dev_id;
+	struct bcm_qspi *qspi = qspi_dev_id->dev;
+	u32 status = bcm_qspi_read(qspi, MSPI, QSPI_MSPI_MSPI_STATUS);
+
+	if (status & QSPI_MSPI_MSPI_STATUS_SPIF) {
+		/* clear interrupt */
+		status &= ~QSPI_MSPI_MSPI_STATUS_SPIF;
+		bcm_qspi_write(qspi, INTR, QSPI_MSPI_MSPI_STATUS, status);
+		bcm_qspi_clear_interrupt(qspi, QSPI_INTR_MSPI_DONE_MASK);
+
+		tasklet_schedule(&qspi->tasklet);
+		return IRQ_HANDLED;
+	} else
+		return IRQ_NONE;
+}
+
+static irqreturn_t bcm_qspi_bspi_lr_l2_isr(int irq, void *dev_id)
+{
+	struct bcm_qspi_dev_id *qspi_dev_id = dev_id;
+	struct bcm_qspi *qspi = qspi_dev_id->dev;
+	u32 status = qspi_dev_id->irqp->mask;
+
+	if (qspi->bspi_enabled && qspi->bspi_xfer) {
+		if (status & BSPI_LR_INTERRUPTS_DATA)
+			bcm_qspi_bspi_lr_data_read(qspi);
+
+		bcm_qspi_bspi_lr_data_read(qspi);
+
+		if (qspi->bspi_xfer_len == 0) {
+			qspi->bspi_xfer = NULL;
+
+			bcm_qspi_disable_interrupt(qspi, BSPI_LR_INTERRUPTS_ALL);
+
+			if (qspi->bspi_xfer_status) {
+				bcm_qspi_lr_clear(qspi);
+			} else {
+				bcm_qspi_flush_prefetch_buffers(qspi);
+
+				if (qspi->bspi_msg) {
+					qspi->bspi_msg->actual_length =
+						qspi->actual_length;
+					qspi->bspi_msg->complete(
+						qspi->bspi_msg->context);
+					qspi->bspi_msg->status = 0;
+				}
+			}
+			qspi->bspi_msg = NULL;
+		}
+		bcm_qspi_clear_interrupt(qspi, status);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static irqreturn_t bcm_qspi_bspi_lr_err_l2_isr(int irq, void *dev_id)
+{
+	struct bcm_qspi_dev_id *qspi_dev_id = dev_id;
+	struct bcm_qspi *qspi = qspi_dev_id->dev;
+	u32 status = qspi_dev_id->irqp->mask;
+
+	if (qspi_dev_id->irqp->mask & BSPI_LR_INTERRUPTS_ERROR) {
+		dev_err(&qspi->pdev->dev, "INT error %02x\n", status);
+		qspi->bspi_xfer_status = -EIO;
+		bcm_qspi_clear_interrupt(qspi, status);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static irqreturn_t bcm_qspi_l1_isr(int irq, void *dev_id)
+{
+	struct bcm_qspi_dev_id *qspi_dev_id = dev_id;
+	struct bcm_qspi *qspi = qspi_dev_id->dev;
+	u32 status = bcm_qspi_read_l2int_status(qspi);
+	irqreturn_t ret = IRQ_NONE;
+
+	if (status & MSPI_INTERRUPTS_ALL)
+		ret = bcm_qspi_mspi_l2_isr(irq, dev_id);
+	else if (status & BSPI_LR_INTERRUPTS_DATA)
+		ret = bcm_qspi_bspi_lr_l2_isr(irq, dev_id);
+	else if (status & BSPI_LR_INTERRUPTS_ERROR)
+		ret = bcm_qspi_bspi_lr_err_l2_isr(irq, dev_id);
+
+	return ret;
+}
+
+static const struct bcm_qspi_irq qspi_irq_tab[] = {
+	{
+		.irq_name = "spi_lr_fullness_reached",
+		.irq_handler = bcm_qspi_bspi_lr_l2_isr,
+		.mask = QSPI_INTR_BSPI_LR_FULLNESS_REACHED_MASK,
+	},
+	{
+		.irq_name = "spi_lr_session_aborted",
+		.irq_handler = bcm_qspi_bspi_lr_err_l2_isr,
+		.mask = QSPI_INTR_BSPI_LR_SESSION_ABORTED_MASK,
+	},
+	{
+		.irq_name = "spi_lr_impatient",
+		.irq_handler = bcm_qspi_bspi_lr_err_l2_isr,
+		.mask = QSPI_INTR_BSPI_LR_IMPATIENT_MASK,
+	},
+	{
+		.irq_name = "spi_lr_session_done",
+		.irq_handler = bcm_qspi_bspi_lr_l2_isr,
+		.mask = QSPI_INTR_BSPI_LR_SESSION_DONE_MASK,
+	},
+	{
+		.irq_name = "spi_lr_overread",
+		.irq_handler = bcm_qspi_bspi_lr_err_l2_isr,
+		.mask = QSPI_INTR_BSPI_LR_OVERREAD_MASK,
+	},
+	{
+		.irq_name = "mspi_done",
+		.irq_handler = bcm_qspi_mspi_l2_isr,
+		.mask = QSPI_INTR_MSPI_DONE_MASK,
+	},
+	{
+		.irq_name = "mspi_halted",
+		.irq_handler = bcm_qspi_mspi_l2_isr,
+		.mask = QSPI_INTR_MSPI_HALTED_MASK,
+	},
+	{
+		/* single muxed L1 interrupt source */
+		.irq_name = "spi_l1_intr",
+		.irq_handler = bcm_qspi_l1_isr,
+		.mask = QSPI_INTERRUPTS_ALL,
+	},
+};
+
+static void bcm_qspi_tasklet(unsigned long param)
+{
+	struct bcm_qspi *qspi = (void *)param;
+	struct list_head completed;
+	struct spi_message *msg;
+	unsigned long flags;
+
+	INIT_LIST_HEAD(&completed);
+	spin_lock_irqsave(&qspi->lock, flags);
+
+	if (qspi->next_udelay) {
+		udelay(qspi->next_udelay);
+		qspi->next_udelay = 0;
+	}
+
+	msg = qspi->pos.msg;
+
+	bcm_qspi_mspi_read(qspi, &completed);
+	if (qspi->cs_change) {
+		udelay(10);
+		qspi->cs_change = 0;
+	}
+	bcm_qspi_mspi_write(qspi);
+	spin_unlock_irqrestore(&qspi->lock, flags);
+
+	while (!list_empty(&completed)) {
+		msg = list_first_entry(&completed, struct spi_message, queue);
+		list_del(&msg->queue);
+		msg->status = 0;
+		msg->complete(msg->context);
+	}
+
+}
+
+static void bcm_qspi_complete(void *arg)
+{
+	complete(arg);
+}
+
+static int bcm_qspi_simple_transaction(struct bcm_qspi *qspi,
+	const void *tx_buf, int tx_len, void *rx_buf, int rx_len)
+{
+	struct bcm_qspi_parms *xp = &qspi->last_parms;
+	DECLARE_COMPLETION_ONSTACK(fini);
+	struct spi_message m;
+	struct spi_transfer t_tx, t_rx;
+	struct spi_device spi;
+	int ret;
+
+	memset(&spi, 0, sizeof(spi));
+	spi.max_speed_hz = xp->speed_hz;
+	spi.chip_select = xp->chip_select;
+	spi.mode = xp->mode;
+	spi.bits_per_word = xp->bits_per_word;
+	spi.master = qspi->master;
+
+	spi_message_init(&m);
+	m.complete = bcm_qspi_complete;
+	m.context = &fini;
+	m.spi = &spi;
+
+	memset(&t_tx, 0, sizeof(t_tx));
+	memset(&t_rx, 0, sizeof(t_rx));
+	t_tx.tx_buf = tx_buf;
+	t_tx.len = tx_len;
+	t_rx.rx_buf = rx_buf;
+	t_rx.len = rx_len;
+
+	if (tx_len)
+		spi_message_add_tail(&t_tx, &m);
+	if (rx_len)
+		spi_message_add_tail(&t_rx, &m);
+	ret = bcm_qspi_transfer(&spi, &m);
+
+	if (!ret)
+		wait_for_completion(&fini);
+
+	return ret;
+}
+
+static void bcm_qspi_hw_init(struct bcm_qspi *qspi)
+{
+	u32 val = 0;
+	struct bcm_qspi_parms default_parms;
+
+	bcm_qspi_write(qspi, MSPI, QSPI_MSPI_SPCR1_LSB, 0);
+	bcm_qspi_write(qspi, MSPI, QSPI_MSPI_SPCR1_MSB, 0);
+	bcm_qspi_write(qspi, MSPI, QSPI_MSPI_NEWQP, 0);
+	bcm_qspi_write(qspi, MSPI, QSPI_MSPI_ENDQP, 0);
+	bcm_qspi_write(qspi, MSPI, QSPI_MSPI_SPCR2, 0x20);
+
+	default_parms.chip_select = 0;
+	default_parms.mode = SPI_MODE_3;
+	default_parms.bits_per_word = 8;
+	of_property_read_u32(qspi->pdev->dev.of_node, "clock-frequency", &val);
+	if (val > 0) {
+		default_parms.speed_hz = val;
+		bcm_qspi_hw_set_parms(qspi, &default_parms);
+	} else {
+		bcm_qspi_hw_set_parms(qspi, &bcm_qspi_default_parms_cs0);
+	}
+
+	if (!qspi->base[BSPI])
+		return;
+	val = bcm_qspi_read(qspi, BSPI, QSPI_BSPI_REVISION_ID);
+	qspi->bspi_maj_rev = (val >> 8) & 0xff;
+	qspi->bspi_min_rev = val & 0xff;
+	if (!(bcm_qspi_bspi_ver_three(qspi))) {
+		/* Force mapping of BSPI address -> flash offset */
+		bcm_qspi_write(qspi, BSPI, QSPI_BSPI_BSPI_XOR_VALUE, 0);
+		bcm_qspi_write(qspi, BSPI, QSPI_BSPI_BSPI_XOR_ENABLE, 1);
+	}
+	qspi->bspi_enabled = 1;
+	bcm_qspi_disable_bspi(qspi);
+	bcm_qspi_write(qspi, BSPI, QSPI_BSPI_B0_CTRL, 1);
+	bcm_qspi_write(qspi, BSPI, QSPI_BSPI_B1_CTRL, 1);
+}
+
+static void bcm_qspi_hw_uninit(struct bcm_qspi *qspi)
+{
+	bcm_qspi_write(qspi, MSPI, QSPI_MSPI_SPCR2, 0);
+	/* disable irq and enable bits */
+	bcm_qspi_enable_bspi(qspi);
+}
+
+static int __maybe_unused bcm_qspi_flash_type(struct bcm_qspi *qspi)
+{
+	char tx_buf[4];
+	unsigned char jedec_id[5] = {0};
+
+	if (bspi_flash != BSPI_FLASH_TYPE_UNKNOWN)
+		return bspi_flash;
+
+	tx_buf[0] = SPINOR_OP_RDID;
+	bcm_qspi_simple_transaction(qspi, tx_buf, 1, jedec_id, 5);
+	bspi_flash = jedec_id[0];
+
+	return bspi_flash;
+}
+
+/* Get BSPI chip-selects info */
+static int bcm_qspi_get_bspi_cs(struct bcm_qspi *qspi)
+{
+	struct device_node *np = qspi->pdev->dev.of_node, *childnode;
+	int num_bspi_cs;
+	u32 vals[10], i;
+	struct spi_master *master = qspi->master;
+
+	qspi->bspi_cs_bmap = 0;
+	if (!qspi->base[BSPI])
+		return 0;
+
+	if (of_find_property(np, "bspi-sel", NULL)) {
+		num_bspi_cs = of_property_count_u32_elems(np, "bspi-sel");
+		if (num_bspi_cs) {
+			of_property_read_u32_array(np, "bspi-sel", vals,
+						   num_bspi_cs);
+			for (i = 0; i < num_bspi_cs; i++)
+				qspi->bspi_cs_bmap |= (1 << vals[i]);
+		}
+	} else {
+		/*
+		 * if using m25p80 compatible driver,
+		 * find the chip select info in the child node
+		 */
+		for_each_child_of_node(np, childnode) {
+			if (of_find_property(childnode, "use-bspi", NULL)) {
+				const u32 *regp;
+				int size;
+
+				/* "reg" field holds chip-select number */
+				regp = of_get_property(childnode, "reg", &size);
+				if (!regp || size != sizeof(*regp))
+					return -EINVAL;
+				if (regp[0] < master->num_chipselect)
+					qspi->bspi_cs_bmap |=
+						(1 << regp[0]);
+			}
+		}
+	}
+	dev_dbg(&qspi->pdev->dev, "bspi chip selects bitmap 0x%x",
+						qspi->bspi_cs_bmap);
+	return 0;
+}
+
+static int bcm_qspi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct bcm_qspi *qspi;
+	struct spi_master *master;
+	struct resource *res;
+	int irq, ret = 0, num_ints = 0;
+	u32 val;
+	const char *name = NULL;
+	int num_irqs = ARRAY_SIZE(qspi_irq_tab);
+
+	master = spi_alloc_master(dev, sizeof(struct bcm_qspi));
+	if (!master) {
+		dev_err(dev, "error allocating spi_master\n");
+		return -ENOMEM;
+	}
+
+	qspi = spi_master_get_devdata(master);
+	qspi->pdev = pdev;
+	qspi->state = QSPI_STATE_IDLE;
+	qspi->pos.msg = NULL;
+	qspi->master = master;
+
+	master->bus_num = pdev->id;
+	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_RX_DUAL | SPI_RX_QUAD;
+	master->setup = bcm_qspi_setup;
+	master->transfer = bcm_qspi_transfer;
+	master->cleanup = bcm_qspi_cleanup;
+	master->dev.of_node = dev->of_node;
+	master->num_chipselect = NUM_CHIPSELECT;
+
+	if (!of_property_read_u32(dev->of_node, "num-cs", &val))
+		master->num_chipselect = val;
+
+	if ((res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hif_mspi")) ||
+	     (res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mspi")))
+	{
+		qspi->base[MSPI]  = devm_ioremap_resource(dev, res);
+		if (IS_ERR(qspi->base[MSPI])) {
+			ret = PTR_ERR(qspi->base[MSPI]);
+			goto err2;
+		}
+	} else
+		goto err2;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "bspi");
+	if (res) {
+		qspi->base[BSPI]  = devm_ioremap_resource(dev, res);
+		if (IS_ERR(qspi->base[BSPI])) {
+			ret = PTR_ERR(qspi->base[BSPI]);
+			goto err2;
+		}
+		qspi->bspi_mode = true;
+	} else
+		qspi->bspi_mode = false;
+
+	if (!qspi->bspi_mode)
+		master->bus_num += 1;
+
+	dev_info(dev, "using %smspi mode\n", qspi->bspi_mode ? "bspi-" : "");
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cs_reg");
+	if (res) {
+		qspi->base[CHIP_SELECT]  = devm_ioremap_resource(dev, res);
+		if (IS_ERR(qspi->base[CHIP_SELECT])) {
+			ret = PTR_ERR(qspi->base[CHIP_SELECT]);
+			goto err2;
+		}
+	}
+
+	qspi->hif_spi_mode = false;
+	/* SoC based interrupt resource differences are handled here */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "intr_regs");
+	if (res) {
+		qspi->base[INTR]  = devm_ioremap_resource(dev, res);
+		if (IS_ERR(qspi->base[INTR])) {
+			ret = PTR_ERR(qspi->base[INTR]);
+			goto err2;
+		}
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   "intr_status_reg");
+		if (res) {
+			qspi->base[INTR_STATUS]  = devm_ioremap_resource(dev, res);
+			if (IS_ERR(qspi->base[INTR_STATUS])) {
+				ret = PTR_ERR(qspi->base[INTR_STATUS]);
+				goto err2;
+			}
+		}
+	} else {
+		/* SoCs with hif_spi_intr */
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   "hif_spi_intr2");
+		if (res) {
+			qspi->base[INTR] = devm_ioremap_resource(dev, res);
+			if (IS_ERR(qspi->base[INTR])) {
+				ret = PTR_ERR(qspi->base[INTR]);
+				goto err2;
+			}
+			qspi->hif_spi_mode = true;
+			qspi->base[INTR_STATUS] = qspi->base[INTR];
+		}
+	}
+
+	bcm_qspi_disable_interrupt(qspi, QSPI_INTERRUPTS_ALL);
+	bcm_qspi_clear_interrupt(qspi, QSPI_INTERRUPTS_ALL);
+
+	qspi->dev_ids = kcalloc(num_irqs, sizeof(struct bcm_qspi_dev_id),
+				GFP_KERNEL);
+	if (IS_ERR(qspi->dev_ids)) {
+		ret = PTR_ERR(qspi->dev_ids);
+		goto err2;
+	}
+
+	for (val = 0; val < num_irqs; val++) {
+		irq = -1;
+		name = qspi_irq_tab[val].irq_name;
+		if (val <  (num_irqs - 1))
+			/* get the l2 interrupts */
+			irq = platform_get_irq_byname(pdev, name);
+		else if (!num_ints) {
+			/* all mspi, bspi intrs muxed to one L1 intr */
+			irq = platform_get_irq(pdev, 0);
+			of_property_read_string(dev->of_node,
+						"interrupt-names",
+						&name);
+		}
+
+		if (irq  >= 0) {
+			ret = devm_request_irq(&pdev->dev, irq,
+					       qspi_irq_tab[val].irq_handler, 0,
+					       name,
+					       &qspi->dev_ids[val]);
+			if (ret < 0) {
+				dev_err(&pdev->dev, "unable to allocate IRQ\n");
+				goto err2;
+			}
+
+			qspi->dev_ids[val].dev = qspi;
+			qspi->dev_ids[val].irqp = &qspi_irq_tab[val];
+			num_ints++;
+			dev_dbg(&pdev->dev, "registered IRQ %s %d\n",
+				qspi_irq_tab[val].irq_name,
+				irq);
+		}
+	}
+
+	if (!num_ints) {
+		dev_err(&pdev->dev, "no IRQs registered, cannot init driver\n");
+		goto err2;
+	}
+
+	bcm_qspi_enable_interrupt(qspi, QSPI_INTR_MSPI_DONE_MASK);
+
+	qspi->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(qspi->clk)) {
+		dev_err(dev, "unable to get clock\n");
+		goto err2;
+	}
+	ret = clk_prepare_enable(qspi->clk);
+	if (ret) {
+		dev_err(dev, "failed to prepare clock\n");
+		goto err2;
+	}
+
+	qspi->base_clk = clk_get_rate(qspi->clk);
+	qspi->max_speed_hz = qspi->base_clk/(QSPI_SPBR_MIN);
+
+	bcm_qspi_hw_init(qspi);
+	qspi->curr_cs = -1;
+	INIT_LIST_HEAD(&qspi->msg_queue);
+	spin_lock_init(&qspi->lock);
+
+	platform_set_drvdata(pdev, qspi);
+
+	tasklet_init(&qspi->tasklet, bcm_qspi_tasklet, (unsigned long)qspi);
+	bcm_qspi_get_bspi_cs(qspi);
+
+	qspi->xfer_mode.width = SPI_NBITS_SINGLE;
+	qspi->xfer_mode.addrlen = BSPI_ADDRLEN_3BYTES;
+	qspi->xfer_mode.hp = -1;
+
+	if (qspi->bspi_cs_bmap) {
+		bcm_qspi_bspi_set_mode(qspi, qspi->xfer_mode.width,
+				       qspi->xfer_mode.addrlen, 0);
+	}
+
+	ret = devm_spi_register_master(&pdev->dev, master);
+	if (ret < 0) {
+		dev_err(dev, "can't register master\n");
+		goto err1;
+	}
+	return 0;
+
+err1:
+	bcm_qspi_hw_uninit(qspi);
+	clk_disable_unprepare(qspi->clk);
+err2:
+	spi_master_put(master);
+	kfree(qspi->dev_ids);
+	return ret;
+}
+
+static int bcm_qspi_remove(struct platform_device *pdev)
+{
+	struct bcm_qspi *qspi = platform_get_drvdata(pdev);
+	unsigned long flags;
+
+	/* acquire lock when the MSPI is idle */
+	while (1) {
+		spin_lock_irqsave(&qspi->lock, flags);
+		if (qspi->state == QSPI_STATE_IDLE)
+			break;
+		spin_unlock_irqrestore(&qspi->lock, flags);
+		udelay(100);
+	}
+	qspi->state = QSPI_STATE_SHUTDOWN;
+	spin_unlock_irqrestore(&qspi->lock, flags);
+
+	tasklet_kill(&qspi->tasklet);
+	platform_set_drvdata(pdev, NULL);
+	bcm_qspi_hw_uninit(qspi);
+	clk_disable_unprepare(qspi->clk);
+	kfree(qspi->dev_ids);
+	spi_unregister_master(qspi->master);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int bcm_qspi_suspend(struct device *dev)
+{
+	struct bcm_qspi *qspi = dev_get_drvdata(dev);
+
+	qspi->s3_intr2_mask = bcm_qspi_read(qspi, INTR,
+				HIF_SPI_INTR2_CPU_MASK_STATUS);
+	clk_disable(qspi->clk);
+	return 0;
+};
+
+static int bcm_qspi_resume(struct device *dev)
+{
+	struct bcm_qspi *qspi = dev_get_drvdata(dev);
+	int curr_cs = qspi->curr_cs;
+
+	if (qspi->hif_spi_mode) {
+		bcm_qspi_write(qspi, INTR, HIF_SPI_INTR2_CPU_MASK_CLEAR,
+						~qspi->s3_intr2_mask);
+		bcm_qspi_read(qspi, INTR, HIF_SPI_INTR2_CPU_MASK_CLEAR);
+	}
+	bcm_qspi_hw_init(qspi);
+	bcm_qspi_bspi_set_mode(qspi, -1, -1, -1);
+	qspi->curr_cs = -1;
+	bcm_qspi_chip_select(qspi, curr_cs);
+
+	return clk_enable(qspi->clk);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(bcm_qspi_pm_ops, bcm_qspi_suspend, bcm_qspi_resume);
+
+static const struct of_device_id bcm_qspi_of_match[] = {
+	{ .compatible = "brcm,spi-bcm-qspi" },
+	{ .compatible = "brcm,qspi-brcmstb" },
+	{ .compatible = "brcm,spi-brcmstb-mspi"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, bcm_qspi_of_match);
+
+static struct platform_driver bcm_qspi_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.bus = &platform_bus_type,
+		.owner = THIS_MODULE,
+		.pm = &bcm_qspi_pm_ops,
+		.of_match_table = bcm_qspi_of_match,
+	},
+	.probe = bcm_qspi_probe,
+	.remove = bcm_qspi_remove,
+};
+module_platform_driver(bcm_qspi_driver);
+
+MODULE_AUTHOR("Broadcom Corporation");
+MODULE_DESCRIPTION("BCM QSPI driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
