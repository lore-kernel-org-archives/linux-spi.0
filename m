From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ARM PL022 SSP/SPI driver v1
Date: Thu, 28 May 2009 00:19:15 +0200
Message-ID: <63386a3d0905271519x1afc6c4bo8d40315e2e387b63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>,
	Alessandro Rubini <rubini-list-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org>, sachin.verma-qxv4g6HH51o@public.gmane.org,
	andrea.gallo-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

This adds a driver for the ARM PL022 PrimeCell SSP/SPI
driver found in the U300 platforms as well as in some
ARM reference hardware, and in a modified version on the
Nomadik board.

Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/spi/Kconfig        |    9 +
 drivers/spi/Makefile       |    1 +
 drivers/spi/amba-pl022.c   | 1887 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/amba/pl022.h |  264 ++++++
 4 files changed, 2161 insertions(+), 0 deletions(-)
 create mode 100644 drivers/spi/amba-pl022.c
 create mode 100644 include/linux/amba/pl022.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 83a185d..39cb8cf 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -171,6 +171,15 @@ config SPI_ORION
 	help
 	  This enables using the SPI master controller on the Orion chips.

+config SPI_PL022
+	tristate "ARM AMBA PL022 SSP controller"
+	depends on ARM_AMBA && EXPERIMENTAL
+	default y if MACH_U300
+	help
+	  This selects the ARM(R) AMBA(R) PrimeCell PL022 SSP
+	  controller. If you have an embedded system with an AMBA(R)
+	  bus and a PL022 controller, say Y or M here.
+
 config SPI_PXA2XX
 	tristate "PXA2xx SSP SPI master"
 	depends on ARCH_PXA && EXPERIMENTAL
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 5d04519..ecfadb1 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_SPI_PXA2XX)		+= pxa2xx_spi.o
 obj-$(CONFIG_SPI_OMAP_UWIRE)		+= omap_uwire.o
 obj-$(CONFIG_SPI_OMAP24XX)		+= omap2_mcspi.o
 obj-$(CONFIG_SPI_ORION)			+= orion_spi.o
+obj-$(CONFIG_SPI_PL022)			+= amba-pl022.o
 obj-$(CONFIG_SPI_MPC52xx_PSC)		+= mpc52xx_psc_spi.o
 obj-$(CONFIG_SPI_MPC83xx)		+= spi_mpc83xx.o
 obj-$(CONFIG_SPI_S3C24XX_GPIO)		+= spi_s3c24xx_gpio.o
diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
new file mode 100644
index 0000000..3939aeb
--- /dev/null
+++ b/drivers/spi/amba-pl022.c
@@ -0,0 +1,1887 @@
+/*
+ * drivers/spi/amba-pl022.c
+ *
+ * A driver for the ARM PL022 PrimeCell SSP/SPI bus master.
+ *
+ * Copyright (C) 2008-2009 ST-Ericsson AB
+ * Copyright (C) 2006 STMicroelectronics Pvt. Ltd.
+ *
+ * Author: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
+ *
+ * Initial version inspired by:
+ *	linux-2.6.17-rc3-mm1/drivers/spi/pxa2xx_spi.c
+ * Initial adoption to PL022 by:
+ *      Sachin Verma <sachin.verma-qxv4g6HH51o@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/*
+ * TODO:
+ * - add timeout on polled transfers
+ * - add generic DMA framework support
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/ioport.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/spi/spi.h>
+#include <linux/workqueue.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/amba/bus.h>
+#include <linux/amba/pl022.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <asm/irq.h>
+
+/*
+ * This macro is used to define some register default values.
+ * reg is masked with mask, the OR:ed with an (again masked)
+ * val shifted sb steps to the left.
+ */
+#define SSP_WRITE_BITS(reg, val, mask, sb) \
+ ((reg) = (((reg) & ~(mask)) | (((val)<<(sb)) & (mask))))
+
+/*
+ * This macro is also used to define some default values.
+ * It will just shift val by sb steps to the left and mask
+ * the result with mask.
+ */
+#define GEN_MASK_BITS(val, mask, sb) \
+ (((val)<<(sb)) & (mask))
+
+#define DRIVE_TX		0
+#define DO_NOT_DRIVE_TX		1
+
+#define DO_NOT_QUEUE_DMA	0
+#define QUEUE_DMA		1
+
+#define RX_TRANSFER		1
+#define TX_TRANSFER		2
+
+/*
+ * Macros to access SSP Registers with their offsets
+ */
+#define SSP_CR0(r)	(r + 0x000)
+#define SSP_CR1(r)	(r + 0x004)
+#define SSP_DR(r)	(r + 0x008)
+#define SSP_SR(r)	(r + 0x00C)
+#define SSP_CPSR(r)	(r + 0x010)
+#define SSP_IMSC(r)	(r + 0x014)
+#define SSP_RIS(r)	(r + 0x018)
+#define SSP_MIS(r)	(r + 0x01C)
+#define SSP_ICR(r)	(r + 0x020)
+#define SSP_DMACR(r)	(r + 0x024)
+#define SSP_ITCR(r)	(r + 0x080)
+#define SSP_ITIP(r)	(r + 0x084)
+#define SSP_ITOP(r)	(r + 0x088)
+#define SSP_TDR(r)	(r + 0x08C)
+
+#define SSP_PID0(r)	(r + 0xFE0)
+#define SSP_PID1(r)	(r + 0xFE4)
+#define SSP_PID2(r)	(r + 0xFE8)
+#define SSP_PID3(r)	(r + 0xFEC)
+
+#define SSP_CID0(r)	(r + 0xFF0)
+#define SSP_CID1(r)	(r + 0xFF4)
+#define SSP_CID2(r)	(r + 0xFF8)
+#define SSP_CID3(r)	(r + 0xFFC)
+
+/*
+ * SSP Control Register 0  - SSP_CR0
+ */
+#define SSP_CR0_MASK_DSS		(0x1FUL << 0)
+#define SSP_CR0_MASK_HALFDUP		(0x1UL << 5)
+#define SSP_CR0_MASK_SPO		(0x1UL << 6)
+#define SSP_CR0_MASK_SPH		(0x1UL << 7)
+#define SSP_CR0_MASK_SCR		(0xFFUL << 8)
+#define SSP_CR0_MASK_CSS		(0x1FUL << 16)
+#define SSP_CR0_MASK_FRF		(0x3UL << 21)
+
+/*
+ * SSP Control Register 0  - SSP_CR1
+ */
+#define SSP_CR1_MASK_LBM		(0x1UL << 0)
+#define SSP_CR1_MASK_SSE		(0x1UL << 1)
+#define SSP_CR1_MASK_MS			(0x1UL << 2)
+#define SSP_CR1_MASK_SOD		(0x1UL << 3)
+#define SSP_CR1_MASK_RENDN		(0x1UL << 4)
+#define SSP_CR1_MASK_TENDN		(0x1UL << 5)
+#define SSP_CR1_MASK_MWAIT		(0x1UL << 6)
+#define SSP_CR1_MASK_RXIFLSEL		(0x7UL << 7)
+#define SSP_CR1_MASK_TXIFLSEL		(0x7UL << 10)
+
+/*
+ * SSP Data Register - SSP_DR
+ */
+#define SSP_DR_MASK_DATA		0xFFFFFFFF
+
+/*
+ * SSP Status Register - SSP_SR
+ */
+/* Transmit FIFO empty */
+#define SSP_SR_MASK_TFE			(0x1UL << 0)
+/* Transmit FIFO not full */
+#define SSP_SR_MASK_TNF			(0x1UL << 1)
+/* Receive FIFO not empty */
+#define SSP_SR_MASK_RNE			(0x1UL << 2)
+/* Receive FIFO full */
+#define SSP_SR_MASK_RFF 		(0x1UL << 3)
+/* Busy Flag */
+#define SSP_SR_MASK_BSY			(0x1UL << 4)
+
+/*
+ * SSP Clock Prescale Register  - SSP_CPSR
+ */
+#define SSP_CPSR_MASK_CPSDVSR	 	(0xFFUL << 0)
+
+/*
+ * SSP Interrupt Mask Set/Clear Register - SSP_IMSC
+ */
+/* Receive Overrun Interrupt mask */
+#define SSP_IMSC_MASK_RORIM		(0x1UL << 0)
+/* Receive timeout Interrupt mask */
+#define SSP_IMSC_MASK_RTIM		(0x1UL << 1)
+/* Receive FIFO Interrupt mask */
+#define SSP_IMSC_MASK_RXIM		(0x1UL << 2)
+/* Transmit FIFO Interrupt mask */
+#define SSP_IMSC_MASK_TXIM		(0x1UL << 3)
+
+/*
+ * SSP Raw Interrupt Status Register - SSP_RIS
+ */
+/* Receive Overrun Raw Interrupt status */
+#define SSP_RIS_MASK_RORRIS		(0x1UL << 0)
+/* Receive Timeout Raw Interrupt status */
+#define SSP_RIS_MASK_RTRIS		(0x1UL << 1)
+/* Receive FIFO Raw Interrupt status */
+#define SSP_RIS_MASK_RXRIS		(0x1UL << 2)
+/* Transmit FIFO Raw Interrupt status */
+#define SSP_RIS_MASK_TXRIS		(0x1UL << 3)
+
+/*
+ * SSP Masked Interrupt Status Register - SSP_MIS
+ */
+/* Receive Overrun Masked Interrupt status */
+#define SSP_MIS_MASK_RORMIS		(0x1UL << 0)
+/* Receive Timeout Masked Interrupt status */
+#define SSP_MIS_MASK_RTMIS		(0x1UL << 1)
+/* Receive FIFO Masked Interrupt status */
+#define SSP_MIS_MASK_RXMIS		(0x1UL << 2)
+/* Transmit FIFO Masked Interrupt status */
+#define SSP_MIS_MASK_TXMIS		(0x1UL << 3)
+
+/*
+ * SSP Interrupt Clear Register - SSP_ICR
+ */
+/* Receive Overrun Raw Clear Interrupt bit */
+#define SSP_ICR_MASK_RORIC		(0x1UL << 0)
+/* Receive Timeout Clear Interrupt bit */
+#define SSP_ICR_MASK_RTIC		(0x1UL << 1)
+
+/*
+ * SSP DMA Control Register - SSP_DMACR
+ */
+/* Receive DMA Enable bit */
+#define SSP_DMACR_MASK_RXDMAE		(0x1UL << 0)
+/* Transmit DMA Enable bit */
+#define SSP_DMACR_MASK_TXDMAE		(0x1UL << 1)
+
+/*
+ * SSP Integration Test control Register - SSP_ITCR
+ */
+#define SSP_ITCR_MASK_ITEN		(0x1UL << 0)
+#define SSP_ITCR_MASK_TESTFIFO		(0x1UL << 1)
+
+/*
+ * SSP Integration Test Input Register - SSP_ITIP
+ */
+#define ITIP_MASK_SSPRXD		 (0x1UL << 0)
+#define ITIP_MASK_SSPFSSIN		 (0x1UL << 1)
+#define ITIP_MASK_SSPCLKIN		 (0x1UL << 2)
+#define ITIP_MASK_RXDMAC		 (0x1UL << 3)
+#define ITIP_MASK_TXDMAC		 (0x1UL << 4)
+#define ITIP_MASK_SSPTXDIN		 (0x1UL << 5)
+
+/*
+ * SSP Integration Test output Register - SSP_ITOP
+ */
+#define ITOP_MASK_SSPTXD		 (0x1UL << 0)
+#define ITOP_MASK_SSPFSSOUT		 (0x1UL << 1)
+#define ITOP_MASK_SSPCLKOUT		 (0x1UL << 2)
+#define ITOP_MASK_SSPOEn		 (0x1UL << 3)
+#define ITOP_MASK_SSPCTLOEn		 (0x1UL << 4)
+#define ITOP_MASK_RORINTR		 (0x1UL << 5)
+#define ITOP_MASK_RTINTR		 (0x1UL << 6)
+#define ITOP_MASK_RXINTR		 (0x1UL << 7)
+#define ITOP_MASK_TXINTR		 (0x1UL << 8)
+#define ITOP_MASK_INTR			 (0x1UL << 9)
+#define ITOP_MASK_RXDMABREQ		 (0x1UL << 10)
+#define ITOP_MASK_RXDMASREQ		 (0x1UL << 11)
+#define ITOP_MASK_TXDMABREQ		 (0x1UL << 12)
+#define ITOP_MASK_TXDMASREQ		 (0x1UL << 13)
+
+/*
+ * SSP Test Data Register - SSP_TDR
+ */
+#define TDR_MASK_TESTDATA 		(0xFFFFFFFF)
+
+/*
+ * Message State
+ * we use the spi_message.state (void *) pointer to
+ * hold a single state value, that's why all this
+ * (void *) casting is done here.
+ */
+#define START_STATE                     ((void *) 0)
+#define RUNNING_STATE                   ((void *) 1)
+#define DONE_STATE                      ((void *) 2)
+#define ERROR_STATE                     ((void *) -1)
+
+/*
+ * Queue State
+ */
+#define QUEUE_RUNNING                   (0)
+#define QUEUE_STOPPED                   (1)
+/*
+ * SSP State - Whether Enabled or Disabled
+ */
+#define SSP_DISABLED 			(0)
+#define SSP_ENABLED 			(1)
+
+/*
+ * SSP DMA State - Whether DMA Enabled or Disabled
+ */
+#define SSP_DMA_DISABLED 		(0)
+#define SSP_DMA_ENABLED 		(1)
+
+/*
+ * SSP Clock Defaults
+ */
+#define NMDK_SSP_DEFAULT_CLKRATE 0x2
+#define NMDK_SSP_DEFAULT_PRESCALE 0x40
+
+/*
+ * SSP Clock Parameter ranges
+ */
+#define MIN_CPSDVR 0x02
+#define MAX_CPSDVR 0xFE
+#define MIN_SCR 0x00
+#define MAX_SCR 0xFF
+
+/*
+ * SSP Interrupt related Macros
+ */
+#define DEFAULT_SSP_REG_IMSC  0x0UL
+#define DISABLE_ALL_INTERRUPTS DEFAULT_SSP_REG_IMSC
+#define ENABLE_ALL_INTERRUPTS (~DEFAULT_SSP_REG_IMSC)
+
+#define CLEAR_ALL_INTERRUPTS  0x3
+
+
+/*
+ * The type of reading going on on this chip
+ */
+enum ssp_reading {
+	NULL_READING,
+	U8_READING,
+	U16_READING,
+	U32_READING
+};
+
+/**
+ * The type of writing going on on this chip
+ */
+enum ssp_writing {
+	NULL_WRITING,
+	U8_WRITING,
+	U16_WRITING,
+	U32_WRITING
+};
+
+/**
+ * struct vendor_data - vendor-specific config parameters
+ * for PL022 derivates
+ * @fifodepth: depth of FIFOs (both)
+ * @max_bpw: maximum number of bits per word
+ * @unidir: supports unidirection transfers
+ */
+struct vendor_data {
+	int fifodepth;
+	int max_bpw;
+	bool unidir;
+};
+
+/**
+ * struct pl022 - This is the private SSP driver data structure
+ * @adev: AMBA device model hookup
+ * @phybase: The physical memory where the SSP device resides
+ * @virtbase: The virtual memory where the SSP is mapped
+ * @master: SPI framework hookup
+ * @master_info: controller-specific data from machine setup
+ * @regs: SSP controller register's virtual address
+ * @pump_messages: Work struct for scheduling work to the workqueue
+ * @lock: spinlock to syncronise access to driver data
+ * @workqueue: a workqueue on which any spi_message request is queued
+ * @busy: workqueue is busy
+ * @run: workqueue is running
+ * @pump_transfers: Tasklet used in Interrupt Transfer mode
+ * @cur_msg: Pointer to current spi_message being processed
+ * @cur_transfer: Pointer to current spi_transfer
+ * @cur_chip: pointer to current clients chip(assigned from controller_state)
+ * @tx: current position in Tx buffer to be read
+ * @tx_end: end position in Tx buffer to be read
+ * @rx: current position in Rx buffer to be written
+ * @rx_end: end position in Rx buffer to be written
+ * @readingtype: the type of read currently going on
+ * @writingtype: the type or write currently going on
+ */
+struct pl022 {
+	struct amba_device	    *adev;
+	struct vendor_data	    *vendor;
+	resource_size_t             phybase;
+	void __iomem		    *virtbase;
+	struct clk		    *clk;
+	struct spi_master           *master;
+	struct pl022_ssp_controller *master_info;
+	/* Driver message queue */
+	struct workqueue_struct	    *workqueue;
+	struct work_struct          pump_messages;
+	spinlock_t                  queue_lock;
+	struct list_head            queue;
+	int                         busy;
+	int                         run;
+	/* Message transfer pump */
+	struct tasklet_struct       pump_transfers;
+	struct spi_message          *cur_msg;
+	struct spi_transfer         *cur_transfer;
+	struct chip_data            *cur_chip;
+	void                        *tx;
+	void                        *tx_end;
+	void                        *rx;
+	void                        *rx_end;
+	enum ssp_reading            read;
+	enum ssp_writing            write;
+};
+
+/**
+ * struct chip_data - To maintain runtime state of SSP for each client chip
+ * @cr0: Value of control register CR0 of SSP
+ * @cr1: Value of control register CR1 of SSP
+ * @dmacr: Value of DMA control Register of SSP
+ * @cpsr: Value of Clock prescale register
+ * @n_bytes: how many bytes(power of 2) reqd for a given data width of client
+ * @enable_dma: Whether to enable DMA or not
+ * @write: function ptr to be used to write when doing xfer for this chip
+ * @read: function ptr to be used to read when doing xfer for this chip
+ * @cs_control: chip select callback provided by chip
+ * @xfer_type: polling/interrupt/DMA
+ *
+ * Runtime state of the SSP controller, maintained per chip,
+ * This would be set according to the current message that would be served
+ */
+struct chip_data {
+	u16 cr0;
+	u16 cr1;
+	u16 dmacr;
+	u16 cpsr;
+	u8 n_bytes;
+	u8 enable_dma:1;
+	enum ssp_reading read;
+	enum ssp_writing write;
+	void (*cs_control) (u32 command);
+	int xfer_type;
+};
+
+/**
+ * null_cs_control - Dummy chip select function
+ * @command: select/delect the chip
+ *
+ * If no chip select function is provided by client this is used as dummy
+ * chip select
+ */
+static void null_cs_control(u32 command)
+{
+	pr_debug("pl022: dummy chip select control, CS=0x%x\n", command);
+}
+
+/**
+ * giveback - current spi_message is over, schedule next message and call
+ * callback of this message. Assumes that caller already
+ * set message->status; dma and pio irqs are blocked
+ * @pl022: SSP driver private data structure
+ */
+static void giveback(struct pl022 *pl022)
+{
+	struct spi_transfer *last_transfer;
+	unsigned long flags;
+	struct spi_message *msg;
+	void (*curr_cs_control) (u32 command);
+
+	/*
+	 * This local reference to the chip select function
+	 * is needed because we set curr_chip to NULL
+	 * as a step toward termininating the message.
+	 */
+	curr_cs_control = pl022->cur_chip->cs_control;
+	spin_lock_irqsave(&pl022->queue_lock, flags);
+	msg = pl022->cur_msg;
+	pl022->cur_msg = NULL;
+	pl022->cur_transfer = NULL;
+	pl022->cur_chip = NULL;
+	queue_work(pl022->workqueue, &pl022->pump_messages);
+	spin_unlock_irqrestore(&pl022->queue_lock, flags);
+
+	last_transfer = list_entry(msg->transfers.prev,
+					struct spi_transfer,
+					transfer_list);
+
+	/* Delay if requested before any change in chip select */
+	if (last_transfer->delay_usecs)
+		/*
+		 * FIXME: This runs in interrupt context.
+		 * Is this really smart?
+		 */
+		udelay(last_transfer->delay_usecs);
+
+	/*
+	 * Drop chip select UNLESS cs_change is true or we are returning
+	 * a message with an error, or next message is for another chip
+	 */
+	if (!last_transfer->cs_change)
+		curr_cs_control(SSP_CHIP_DESELECT);
+	else {
+		struct spi_message *next_msg;
+
+		/* Holding of cs was hinted, but we need to make sure
+		 * the next message is for the same chip.  Don't waste
+		 * time with the following tests unless this was hinted.
+		 *
+		 * We cannot postpone this until pump_messages, because
+		 * after calling msg->complete (below) the driver that
+		 * sent the current message could be unloaded, which
+		 * could invalidate the cs_control() callback...
+		 */
+
+		/* get a pointer to the next message, if any */
+		spin_lock_irqsave(&pl022->queue_lock, flags);
+		if (list_empty(&pl022->queue))
+			next_msg = NULL;
+		else
+			next_msg = list_entry(pl022->queue.next,
+					struct spi_message, queue);
+		spin_unlock_irqrestore(&pl022->queue_lock, flags);
+
+		/* see if the next and current messages point
+		 * to the same chip
+		 */
+		if (next_msg && next_msg->spi != msg->spi)
+			next_msg = NULL;
+		if (!next_msg || msg->state == ERROR_STATE)
+			curr_cs_control(SSP_CHIP_DESELECT);
+	}
+	msg->state = NULL;
+	if (msg->complete)
+		msg->complete(msg->context);
+	/* This message is completed, so let's turn off the clock! */
+	clk_disable(pl022->clk);
+}
+
+/**
+ * flush - flush the FIFO to reach a clean state
+ * @pl022: SSP driver private data structure
+ */
+static int flush(struct pl022 *pl022)
+{
+	unsigned long limit = loops_per_jiffy << 1;
+
+	dev_dbg(&pl022->adev->dev, "flush\n");
+	do {
+		while (readw(SSP_SR(pl022->virtbase)) & SSP_SR_MASK_RNE)
+			readw(SSP_DR(pl022->virtbase));
+	} while ((readw(SSP_SR(pl022->virtbase)) & SSP_SR_MASK_BSY) && limit--);
+	return limit;
+}
+
+/**
+ * restore_state - Load configuration of current chip
+ * @pl022: SSP driver private data structure
+ */
+static void restore_state(struct pl022 *pl022)
+{
+	struct chip_data *chip = pl022->cur_chip;
+
+	writew(chip->cr0, SSP_CR0(pl022->virtbase));
+	writew(chip->cr1, SSP_CR1(pl022->virtbase));
+	writew(chip->dmacr, SSP_DMACR(pl022->virtbase));
+	writew(chip->cpsr, SSP_CPSR(pl022->virtbase));
+	writew(DISABLE_ALL_INTERRUPTS, SSP_IMSC(pl022->virtbase));
+	writew(CLEAR_ALL_INTERRUPTS, SSP_ICR(pl022->virtbase));
+}
+
+/**
+ * load_ssp_default_config - Load default configuration for SSP
+ * @pl022: SSP driver private data structure
+ */
+
+/*
+ * Default SSP Register Values
+ */
+#define DEFAULT_SSP_REG_CR0 ( \
+	GEN_MASK_BITS(SSP_DATA_BITS_12, SSP_CR0_MASK_DSS, 0)	| \
+	GEN_MASK_BITS(SSP_MICROWIRE_CHANNEL_FULL_DUPLEX, SSP_CR0_MASK_HALFDUP, 5) | \
+	GEN_MASK_BITS(SSP_CLK_POL_IDLE_LOW, SSP_CR0_MASK_SPO, 6) | \
+	GEN_MASK_BITS(SSP_CLK_FALLING_EDGE, SSP_CR0_MASK_SPH, 7) | \
+	GEN_MASK_BITS(NMDK_SSP_DEFAULT_CLKRATE, SSP_CR0_MASK_SCR, 8) | \
+	GEN_MASK_BITS(SSP_BITS_8, SSP_CR0_MASK_CSS, 16)	| \
+	GEN_MASK_BITS(SSP_INTERFACE_MOTOROLA_SPI, SSP_CR0_MASK_FRF, 21) \
+)
+
+#define DEFAULT_SSP_REG_CR1 ( \
+	GEN_MASK_BITS(LOOPBACK_DISABLED, SSP_CR1_MASK_LBM, 0) | \
+	GEN_MASK_BITS(SSP_DISABLED, SSP_CR1_MASK_SSE, 1) | \
+	GEN_MASK_BITS(SSP_MASTER, SSP_CR1_MASK_MS, 2) | \
+	GEN_MASK_BITS(DO_NOT_DRIVE_TX, SSP_CR1_MASK_SOD, 3) | \
+	GEN_MASK_BITS(SSP_RX_MSB, SSP_CR1_MASK_RENDN, 4) | \
+	GEN_MASK_BITS(SSP_TX_MSB, SSP_CR1_MASK_TENDN, 5) | \
+	GEN_MASK_BITS(SSP_MWIRE_WAIT_ZERO, SSP_CR1_MASK_MWAIT, 6) |\
+	GEN_MASK_BITS(SSP_RX_1_OR_MORE_ELEM, SSP_CR1_MASK_RXIFLSEL, 7) | \
+	GEN_MASK_BITS(SSP_TX_1_OR_MORE_EMPTY_LOC, SSP_CR1_MASK_TXIFLSEL, 10) \
+)
+
+#define DEFAULT_SSP_REG_CPSR ( \
+	GEN_MASK_BITS(NMDK_SSP_DEFAULT_PRESCALE, SSP_CPSR_MASK_CPSDVSR, 0) \
+)
+
+#define DEFAULT_SSP_REG_DMACR (\
+	GEN_MASK_BITS(SSP_DMA_DISABLED, SSP_DMACR_MASK_RXDMAE, 0) | \
+	GEN_MASK_BITS(SSP_DMA_DISABLED, SSP_DMACR_MASK_TXDMAE, 1) \
+)
+
+
+static void load_ssp_default_config(struct pl022 *pl022)
+{
+	writew(DEFAULT_SSP_REG_CR0, SSP_CR0(pl022->virtbase));
+	writew(DEFAULT_SSP_REG_CR1, SSP_CR1(pl022->virtbase));
+	writew(DEFAULT_SSP_REG_DMACR, SSP_DMACR(pl022->virtbase));
+	writew(DEFAULT_SSP_REG_CPSR, SSP_CPSR(pl022->virtbase));
+	writew(DISABLE_ALL_INTERRUPTS, SSP_IMSC(pl022->virtbase));
+	writew(CLEAR_ALL_INTERRUPTS, SSP_ICR(pl022->virtbase));
+}
+
+/**
+ * This will write to TX and read from RX according to the parameters
+ * set in pl022.
+ */
+static void readwriter(struct pl022 *pl022)
+{
+
+	/*
+	 * The FIFO depth is different inbetween primecell variants.
+	 * I believe filling in too much in the FIFO might cause
+	 * errons in 8bit wide transfers on ARM variants (just 8 words
+	 * FIFO, means only 8x8 = 64 bits in FIFO) at least.
+	 *
+	 * FIXME: currently we have no logic to account for this.
+	 * perhaps there is even something broken in HW regarding
+	 * 8bit transfers (it doesn't fail on 16bit) so this needs
+	 * more investigation...
+	 */
+	dev_dbg(&pl022->adev->dev,
+		"%s, rx: %p, rxend: %p, tx: %p, txend: %p\n",
+		__func__, pl022->rx, pl022->rx_end, pl022->tx, pl022->tx_end);
+
+	/* Read as much as you can */
+	while ((readw(SSP_SR(pl022->virtbase)) & SSP_SR_MASK_RNE)
+	       && (pl022->rx < pl022->rx_end)) {
+		switch (pl022->read) {
+		case NULL_READING:
+			readw(SSP_DR(pl022->virtbase));
+			break;
+		case U8_READING:
+			*(u8 *) (pl022->rx) =
+				readw(SSP_DR(pl022->virtbase)) & 0xFFU;
+			break;
+		case U16_READING:
+			*(u16 *) (pl022->rx) =
+				(u16) readw(SSP_DR(pl022->virtbase));
+			break;
+		case U32_READING:
+			*(u32 *) (pl022->rx) =
+				readl(SSP_DR(pl022->virtbase));
+			break;
+		}
+		pl022->rx += (pl022->cur_chip->n_bytes);
+	}
+	/*
+	 * Write as much as you can, while keeping an eye on the RX FIFO!
+	 */
+	while ((readw(SSP_SR(pl022->virtbase)) & SSP_SR_MASK_TNF)
+	       && (pl022->tx < pl022->tx_end)) {
+		switch (pl022->write) {
+		case NULL_WRITING:
+			writew(0x0, SSP_DR(pl022->virtbase));
+			break;
+		case U8_WRITING:
+			writew(*(u8 *) (pl022->tx), SSP_DR(pl022->virtbase));
+			break;
+		case U16_WRITING:
+			writew((*(u16 *) (pl022->tx)), SSP_DR(pl022->virtbase));
+			break;
+		case U32_WRITING:
+			writel(*(u32 *) (pl022->tx), SSP_DR(pl022->virtbase));
+			break;
+		}
+		pl022->tx += (pl022->cur_chip->n_bytes);
+		/*
+		 * This inner reader takes care of things appearing in the RX
+		 * FIFO as we're transmitting. This will happen a lot since the
+		 * clock starts running when you put things into the TX FIFO,
+		 * and then things are continously clocked into the RX FIFO.
+		 */
+		while ((readw(SSP_SR(pl022->virtbase)) & SSP_SR_MASK_RNE)
+		       && (pl022->rx < pl022->rx_end)) {
+			switch (pl022->read) {
+			case NULL_READING:
+				readw(SSP_DR(pl022->virtbase));
+				break;
+			case U8_READING:
+				*(u8 *) (pl022->rx) =
+					readw(SSP_DR(pl022->virtbase)) & 0xFFU;
+				break;
+			case U16_READING:
+				*(u16 *) (pl022->rx) =
+					(u16) readw(SSP_DR(pl022->virtbase));
+				break;
+			case U32_READING:
+				*(u32 *) (pl022->rx) =
+					readl(SSP_DR(pl022->virtbase));
+				break;
+			}
+			pl022->rx += (pl022->cur_chip->n_bytes);
+		}
+	}
+	/*
+	 * When we exit here the TX FIFO should be full and the RX FIFO
+	 * should be empty
+	 */
+}
+
+
+/**
+ * next_transfer - Move to the Next transfer in the current spi message
+ * @pl022: SSP driver private data structure
+ *
+ * This function moves though the linked list of spi transfers in the
+ * current spi message and returns with the state of current spi
+ * message i.e whether its last transfer is done(DONE_STATE) or
+ * Next transfer is ready(RUNNING_STATE)
+ */
+static void *next_transfer(struct pl022 *pl022)
+{
+	struct spi_message *msg = pl022->cur_msg;
+	struct spi_transfer *trans = pl022->cur_transfer;
+
+	/* Move to next transfer */
+	if (trans->transfer_list.next != &msg->transfers) {
+		pl022->cur_transfer =
+		    list_entry(trans->transfer_list.next,
+			       struct spi_transfer, transfer_list);
+		return RUNNING_STATE;
+	}
+	return DONE_STATE;
+}
+/**
+ * pl022_interrupt_handler - Interrupt handler for SSP controller
+ *
+ * This function handles interrupts generated for an interrupt based transfer.
+ * If a receive overrun (ROR) interrupt is there then we disable SSP, flag the
+ * current message's state as ERROR_STATE and schedule the tasklet
+ * pump_transfers which will do the postprocessing of the current message by
+ * calling giveback(). Otherwise it reads data from Rx FIFO till there is no
+ * more data, and writes data in Tx FIFO till it is not full. If we complete
+ * the transfer we move to the next transfer and schedule the tasklet.
+ */
+static irqreturn_t pl022_interrupt_handler(int irq, void *dev_id)
+{
+	struct pl022 *pl022 = dev_id;
+	struct spi_message *msg = pl022->cur_msg;
+	u16 irq_status = 0;
+	u16 flag = 0;
+
+	if (unlikely(!msg)) {
+		dev_err(&pl022->adev->dev,
+			"bad message state in interrupt handler");
+		/* Never fail */
+		return IRQ_HANDLED;
+	}
+	/* Read the Interrupt Status Register */
+	irq_status = readw(SSP_MIS(pl022->virtbase));
+
+	if (likely(irq_status)) {
+		if (unlikely(irq_status & SSP_MIS_MASK_RORMIS)) {
+			/*
+			 * Overrun interrupt - bail out since our Data has been
+			 * corrupted
+			 */
+			dev_err(&pl022->adev->dev,
+				"FIFO overrun\n");
+			if (readw(SSP_SR(pl022->virtbase)) & SSP_SR_MASK_RFF)
+				dev_err(&pl022->adev->dev,
+					"RXFIFO is full\n");
+			if (readw(SSP_SR(pl022->virtbase)) & SSP_SR_MASK_TNF)
+				dev_err(&pl022->adev->dev,
+					"TXFIFO is full\n");
+			/* Disable and clear interrupts, disable SSP */
+			writew(DISABLE_ALL_INTERRUPTS,
+			       SSP_IMSC(pl022->virtbase));
+			writew(CLEAR_ALL_INTERRUPTS, SSP_ICR(pl022->virtbase));
+			writew((readw(SSP_CR1(pl022->virtbase)) &
+				(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
+			msg->state = ERROR_STATE;
+			tasklet_schedule(&pl022->pump_transfers);
+			return IRQ_HANDLED;
+		}
+
+		readwriter(pl022);
+
+		if ((pl022->tx == pl022->tx_end) && (flag == 0)) {
+			flag = 1;
+			/* Disable Transmit interrupt */
+			writew(readw(SSP_IMSC(pl022->virtbase)) &
+			       (~SSP_IMSC_MASK_TXIM),
+			       SSP_IMSC(pl022->virtbase));
+		}
+		/*
+		 * Since all transactions must write as much as shall be read,
+		 * we can conclude the entire transaction once RX is complete.
+		 * At this point, all TX will always be finished.
+		 */
+		if (pl022->rx >= pl022->rx_end) {
+			writew(DISABLE_ALL_INTERRUPTS,
+			       SSP_IMSC(pl022->virtbase));
+			writew(CLEAR_ALL_INTERRUPTS, SSP_ICR(pl022->virtbase));
+			if (unlikely(pl022->rx > pl022->rx_end)) {
+				dev_warn(&pl022->adev->dev, "read %u surplus "
+					 "bytes (did you request an odd "
+					 "number of bytes on a 16bit bus?)\n",
+					 (u32) (pl022->rx - pl022->rx_end));
+			}
+			/* Update total bytes transfered */
+			msg->actual_length += pl022->cur_transfer->len;
+			if (pl022->cur_transfer->cs_change)
+				pl022->cur_chip->
+				    cs_control(SSP_CHIP_DESELECT);
+			/* Move to next transfer */
+			msg->state = next_transfer(pl022);
+			tasklet_schedule(&pl022->pump_transfers);
+			return IRQ_HANDLED;
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+/**
+ * This sets up the pointers to memory for the next message to
+ * send out on the SPI bus.
+ */
+static int set_up_next_transfer(struct pl022 *pl022,
+				struct spi_transfer *transfer)
+{
+	int residue;
+
+	/* Sanity check the message for this bus width */
+	residue = pl022->cur_transfer->len % pl022->cur_chip->n_bytes;
+	if (unlikely(residue != 0)) {
+		dev_err(&pl022->adev->dev,
+			"message of %u bytes to transmit but the current "
+			"chip bus has a data width of %u bytes!\n",
+			pl022->cur_transfer->len,
+			pl022->cur_chip->n_bytes);
+		dev_err(&pl022->adev->dev, "skipping this message\n");
+		return -EIO;
+	}
+	pl022->tx = (void *)transfer->tx_buf;
+	pl022->tx_end = pl022->tx + pl022->cur_transfer->len;
+	pl022->rx = (void *)transfer->rx_buf;
+	pl022->rx_end = pl022->rx + pl022->cur_transfer->len;
+	pl022->write =
+	    pl022->tx ? pl022->cur_chip->write : NULL_WRITING;
+	pl022->read = pl022->rx ? pl022->cur_chip->read : NULL_READING;
+	return 0;
+}
+
+/**
+ * pump_transfers - Tasklet function which schedules next interrupt transfer
+ * when running in interrupt transfer mode.
+ * @data: SSP driver private data structure
+ *
+ */
+static void pump_transfers(unsigned long data)
+{
+	struct pl022 *pl022 = (struct pl022 *) data;
+	struct spi_message *message = NULL;
+	struct spi_transfer *transfer = NULL;
+	struct spi_transfer *previous = NULL;
+
+	/* Get current state information */
+	message = pl022->cur_msg;
+	transfer = pl022->cur_transfer;
+
+	/* Handle for abort */
+	if (message->state == ERROR_STATE) {
+		message->status = -EIO;
+		giveback(pl022);
+		return;
+	}
+
+	/* Handle end of message */
+	if (message->state == DONE_STATE) {
+		message->status = 0;
+		giveback(pl022);
+		return;
+	}
+
+	/* Delay if requested at end of transfer before CS change */
+	if (message->state == RUNNING_STATE) {
+		previous = list_entry(transfer->transfer_list.prev,
+					struct spi_transfer,
+					transfer_list);
+		if (previous->delay_usecs)
+			/*
+			 * FIXME: This runs in interrupt context.
+			 * Is this really smart?
+			 */
+			udelay(previous->delay_usecs);
+
+		/* Drop chip select only if cs_change is requested */
+		if (previous->cs_change)
+			pl022->cur_chip->cs_control(SSP_CHIP_SELECT);
+	} else {
+		/* START_STATE */
+		message->state = RUNNING_STATE;
+	}
+
+	if (set_up_next_transfer(pl022, transfer)) {
+		message->state = ERROR_STATE;
+		message->status = -EIO;
+		giveback(pl022);
+		return;
+	}
+	/* Flush the FIFOs and let's go! */
+	flush(pl022);
+	writew(ENABLE_ALL_INTERRUPTS, SSP_IMSC(pl022->virtbase));
+}
+
+/**
+ * NOT IMPLEMENTED
+ * configure_dma - It configures the DMA pipes for DMA transfers
+ * @data: SSP driver's private data structure
+ *
+ */
+static int configure_dma(void *data)
+{
+	struct pl022 *pl022 = data;
+	dev_dbg(&pl022->adev->dev, "configure DMA\n");
+	return -ENOTSUPP;
+}
+
+/**
+ * do_dma_transfer - It handles transfers of the current message
+ * if it is DMA xfer.
+ * NOT FULLY IMPLEMENTED
+ * @data: SSP driver's private data structure
+ */
+static void do_dma_transfer(void *data)
+{
+	struct pl022 *pl022 = data;
+
+	if (configure_dma(data)) {
+		dev_dbg(&pl022->adev->dev, "configuration of DMA Failed!\n");
+		goto err_config_dma;
+	}
+
+	/* TODO: Implememt DMA setup of pipes here */
+
+	/* Enable target chip, set up transfer */
+	pl022->cur_chip->cs_control(SSP_CHIP_SELECT);
+	if (set_up_next_transfer(pl022, pl022->cur_transfer)) {
+		/* Error path */
+		pl022->cur_msg->state = ERROR_STATE;
+		pl022->cur_msg->status = -EIO;
+		giveback(pl022);
+		return;
+	}
+	/* Enable SSP */
+	writew((readw(SSP_CR1(pl022->virtbase)) | SSP_CR1_MASK_SSE),
+	       SSP_CR1(pl022->virtbase));
+
+	/* TODO: Enable the DMA transfer here */
+	return;
+
+ err_config_dma:
+	pl022->cur_msg->state = ERROR_STATE;
+	pl022->cur_msg->status = -EIO;
+	giveback(pl022);
+	return;
+}
+
+static void do_interrupt_transfer(void *data)
+{
+	struct pl022 *pl022 = data;
+
+	/* Enable target chip */
+	pl022->cur_chip->cs_control(SSP_CHIP_SELECT);
+	if (set_up_next_transfer(pl022, pl022->cur_transfer)) {
+		/* Error path */
+		pl022->cur_msg->state = ERROR_STATE;
+		pl022->cur_msg->status = -EIO;
+		giveback(pl022);
+		return;
+	}
+	/* Enable SSP, turn on interrupts */
+	writew((readw(SSP_CR1(pl022->virtbase)) | SSP_CR1_MASK_SSE),
+	       SSP_CR1(pl022->virtbase));
+	writew(ENABLE_ALL_INTERRUPTS, SSP_IMSC(pl022->virtbase));
+}
+
+static void do_polling_transfer(void *data)
+{
+	struct pl022 *pl022 = data;
+	struct spi_message *message = NULL;
+	struct spi_transfer *transfer = NULL;
+	struct spi_transfer *previous = NULL;
+	struct chip_data *chip;
+
+	chip = pl022->cur_chip;
+	message = pl022->cur_msg;
+
+	while (message->state != DONE_STATE) {
+		/* Handle for abort */
+		if (message->state == ERROR_STATE)
+			break;
+		transfer = pl022->cur_transfer;
+
+		/* Delay if requested at end of transfer */
+		if (message->state == RUNNING_STATE) {
+			previous =
+			    list_entry(transfer->transfer_list.prev,
+				       struct spi_transfer, transfer_list);
+			if (previous->delay_usecs)
+				udelay(previous->delay_usecs);
+			if (previous->cs_change)
+				pl022->cur_chip->cs_control(SSP_CHIP_SELECT);
+		} else {
+			/* START_STATE */
+			message->state = RUNNING_STATE;
+			pl022->cur_chip->cs_control(SSP_CHIP_SELECT);
+		}
+
+		/* Configuration Changing Per Transfer */
+		if (set_up_next_transfer(pl022, transfer)) {
+			/* Error path */
+			message->state = ERROR_STATE;
+			break;
+		}
+		/* Flush FIFOs and enable SSP */
+		flush(pl022);
+		writew((readw(SSP_CR1(pl022->virtbase)) | SSP_CR1_MASK_SSE),
+		       SSP_CR1(pl022->virtbase));
+
+		dev_dbg(&pl022->adev->dev, "POLLING TRANSFER ONGOING ... \n");
+		/* FIXME: insert a timeout so we don't hang here indefinately */
+		while (pl022->tx < pl022->tx_end || pl022->rx < pl022->rx_end)
+			readwriter(pl022);
+
+		/* Update total byte transfered */
+		message->actual_length += pl022->cur_transfer->len;
+		if (pl022->cur_transfer->cs_change)
+			pl022->cur_chip->cs_control(SSP_CHIP_DESELECT);
+		/* Move to next transfer */
+		message->state = next_transfer(pl022);
+	}
+
+	/* Handle end of message */
+	if (message->state == DONE_STATE)
+		message->status = 0;
+	else
+		message->status = -EIO;
+
+	giveback(pl022);
+	return;
+}
+
+/**
+ * pump_messages - Workqueue function which processes spi message queue
+ * @data: pointer to private data of SSP driver
+ *
+ * This function checks if there is any spi message in the queue that
+ * needs processing and delegate control to appropriate function
+ * do_polling_transfer()/do_interrupt_transfer()/do_dma_transfer()
+ * based on the kind of the transfer
+ *
+ */
+static void pump_messages(struct work_struct *work)
+{
+	struct pl022 *pl022 =
+		container_of(work, struct pl022, pump_messages);
+	unsigned long flags;
+
+	/* Lock queue and check for queue work */
+	spin_lock_irqsave(&pl022->queue_lock, flags);
+	if (list_empty(&pl022->queue) || pl022->run == QUEUE_STOPPED) {
+		pl022->busy = 0;
+		spin_unlock_irqrestore(&pl022->queue_lock, flags);
+		return;
+	}
+	/* Make sure we are not already running a message */
+	if (pl022->cur_msg) {
+		spin_unlock_irqrestore(&pl022->queue_lock, flags);
+		return;
+	}
+	/* Extract head of queue */
+	pl022->cur_msg =
+	    list_entry(pl022->queue.next, struct spi_message, queue);
+
+	list_del_init(&pl022->cur_msg->queue);
+	pl022->busy = 1;
+	spin_unlock_irqrestore(&pl022->queue_lock, flags);
+
+	/* Initial message state */
+	pl022->cur_msg->state = START_STATE;
+	pl022->cur_transfer = list_entry(pl022->cur_msg->transfers.next,
+					    struct spi_transfer,
+					    transfer_list);
+
+	/* Setup the SPI using the per chip configuration */
+	pl022->cur_chip = spi_get_ctldata(pl022->cur_msg->spi);
+	/*
+	 * We enable the clock here, then the clock will be disabled when
+	 * giveback() is called in each method (poll/interrupt/DMA)
+	 */
+	clk_enable(pl022->clk);
+	restore_state(pl022);
+	flush(pl022);
+
+	if (pl022->cur_chip->xfer_type == POLLING_TRANSFER)
+		do_polling_transfer(pl022);
+	else if (pl022->cur_chip->xfer_type == INTERRUPT_TRANSFER)
+		do_interrupt_transfer(pl022);
+	else
+		do_dma_transfer(pl022);
+}
+
+
+static int __init init_queue(struct pl022 *pl022)
+{
+	INIT_LIST_HEAD(&pl022->queue);
+	spin_lock_init(&pl022->queue_lock);
+
+	pl022->run = QUEUE_STOPPED;
+	pl022->busy = 0;
+
+	tasklet_init(&pl022->pump_transfers,
+			pump_transfers,	(unsigned long)pl022);
+
+	INIT_WORK(&pl022->pump_messages, pump_messages);
+	pl022->workqueue = create_singlethread_workqueue(
+					dev_name(pl022->master->dev.parent));
+	if (pl022->workqueue == NULL)
+		return -EBUSY;
+
+	return 0;
+}
+
+
+static int start_queue(struct pl022 *pl022)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pl022->queue_lock, flags);
+
+	if (pl022->run == QUEUE_RUNNING || pl022->busy) {
+		spin_unlock_irqrestore(&pl022->queue_lock, flags);
+		return -EBUSY;
+	}
+
+	pl022->run = QUEUE_RUNNING;
+	pl022->cur_msg = NULL;
+	pl022->cur_transfer = NULL;
+	pl022->cur_chip = NULL;
+	spin_unlock_irqrestore(&pl022->queue_lock, flags);
+
+	queue_work(pl022->workqueue, &pl022->pump_messages);
+
+	return 0;
+}
+
+
+static int stop_queue(struct pl022 *pl022)
+{
+	unsigned long flags;
+	unsigned limit = 500;
+	int status = 0;
+
+	spin_lock_irqsave(&pl022->queue_lock, flags);
+
+	/* This is a bit lame, but is optimized for the common execution path.
+	 * A wait_queue on the pl022->busy could be used, but then the common
+	 * execution path (pump_messages) would be required to call wake_up or
+	 * friends on every SPI message. Do this instead */
+	pl022->run = QUEUE_STOPPED;
+	while (!list_empty(&pl022->queue) && pl022->busy && limit--) {
+		spin_unlock_irqrestore(&pl022->queue_lock, flags);
+		msleep(10);
+		spin_lock_irqsave(&pl022->queue_lock, flags);
+	}
+
+	if (!list_empty(&pl022->queue) || pl022->busy)
+		status = -EBUSY;
+
+	spin_unlock_irqrestore(&pl022->queue_lock, flags);
+
+	return status;
+}
+
+static int destroy_queue(struct pl022 *pl022)
+{
+	int status;
+
+	status = stop_queue(pl022);
+	/* we are unloading the module or failing to load (only two calls
+	 * to this routine), and neither call can handle a return value.
+	 * However, destroy_workqueue calls flush_workqueue, and that will
+	 * block until all work is done.  If the reason that stop_queue
+	 * timed out is that the work will never finish, then it does no
+	 * good to call destroy_workqueue, so return anyway. */
+	if (status != 0)
+		return status;
+
+	destroy_workqueue(pl022->workqueue);
+
+	return 0;
+}
+
+static int verify_controller_parameters(struct pl022 *pl022,
+					struct pl022_config_chip *chip_info)
+{
+	if ((chip_info->lbm != LOOPBACK_ENABLED)
+	    && (chip_info->lbm != LOOPBACK_DISABLED)) {
+		dev_err(chip_info->dev,
+			"loopback Mode is configured incorrectly\n");
+		return -EINVAL;
+	}
+	if ((chip_info->iface < SSP_INTERFACE_MOTOROLA_SPI)
+	    || (chip_info->iface > SSP_INTERFACE_UNIDIRECTIONAL)) {
+		dev_err(chip_info->dev,
+			"interface is configured incorrectly\n");
+		return -EINVAL;
+	}
+	if ((chip_info->iface == SSP_INTERFACE_UNIDIRECTIONAL) &&
+	    (!pl022->vendor->unidir)) {
+		dev_err(chip_info->dev,
+			"unidirectional mode not supported in this "
+			"hardware version\n");
+		return -EINVAL;
+	}
+	if ((chip_info->hierarchy != SSP_MASTER)
+	    && (chip_info->hierarchy != SSP_SLAVE)) {
+		dev_err(chip_info->dev,
+			"hierarchy is configured incorrectly\n");
+		return -EINVAL;
+	}
+	if (((chip_info->clk_freq).cpsdvsr < MIN_CPSDVR)
+	    || ((chip_info->clk_freq).cpsdvsr > MAX_CPSDVR)) {
+		dev_err(chip_info->dev,
+			"cpsdvsr is configured incorrectly\n");
+		return -EINVAL;
+	}
+	if ((chip_info->endian_rx != SSP_RX_MSB)
+	    && (chip_info->endian_rx != SSP_RX_LSB)) {
+		dev_err(chip_info->dev,
+			"Rx FIFO endianess is configured incorrectly\n");
+		return -EINVAL;
+	}
+	if ((chip_info->endian_tx != SSP_TX_MSB)
+	    && (chip_info->endian_tx != SSP_TX_LSB)) {
+		dev_err(chip_info->dev,
+			"Tx FIFO endianess is configured incorrectly\n");
+		return -EINVAL;
+	}
+	if ((chip_info->data_size < SSP_DATA_BITS_4)
+	    || (chip_info->data_size > SSP_DATA_BITS_32)) {
+		dev_err(chip_info->dev,
+			"DATA Size is configured incorrectly\n");
+		return -EINVAL;
+	}
+	if ((chip_info->com_mode != INTERRUPT_TRANSFER)
+	    && (chip_info->com_mode != DMA_TRANSFER)
+	    && (chip_info->com_mode != POLLING_TRANSFER)) {
+		dev_err(chip_info->dev,
+			"Communication mode is configured incorrectly\n");
+		return -EINVAL;
+	}
+	if ((chip_info->rx_lev_trig < SSP_RX_1_OR_MORE_ELEM)
+	    || (chip_info->rx_lev_trig > SSP_RX_32_OR_MORE_ELEM)) {
+		dev_err(chip_info->dev,
+			"Rx FIFO Trigger Level is configured incorrectly\n");
+		return -EINVAL;
+	}
+	if ((chip_info->tx_lev_trig < SSP_TX_1_OR_MORE_EMPTY_LOC)
+	    || (chip_info->tx_lev_trig > SSP_TX_32_OR_MORE_EMPTY_LOC)) {
+		dev_err(chip_info->dev,
+			"Tx FIFO Trigger Level is configured incorrectly\n");
+		return -EINVAL;
+	}
+	if (chip_info->iface == SSP_INTERFACE_MOTOROLA_SPI) {
+		if ((chip_info->clk_phase != SSP_CLK_RISING_EDGE)
+		    && (chip_info->clk_phase != SSP_CLK_FALLING_EDGE)) {
+			dev_err(chip_info->dev,
+				"Clock Phase is configured incorrectly\n");
+			return -EINVAL;
+		}
+		if ((chip_info->clk_pol != SSP_CLK_POL_IDLE_LOW)
+		    && (chip_info->clk_pol != SSP_CLK_POL_IDLE_HIGH)) {
+			dev_err(chip_info->dev,
+				"Clock Polarity is configured incorrectly\n");
+			return -EINVAL;
+		}
+	}
+	if (chip_info->iface == SSP_INTERFACE_NATIONAL_MICROWIRE) {
+		if ((chip_info->ctrl_len < SSP_BITS_4)
+		    || (chip_info->ctrl_len > SSP_BITS_32)) {
+			dev_err(chip_info->dev,
+				"CTRL LEN is configured incorrectly\n");
+			return -EINVAL;
+		}
+		if ((chip_info->wait_state != SSP_MWIRE_WAIT_ZERO)
+		    && (chip_info->wait_state != SSP_MWIRE_WAIT_ONE)) {
+			dev_err(chip_info->dev,
+				"Wait State is configured incorrectly\n");
+			return -EINVAL;
+		}
+		if ((chip_info->duplex != SSP_MICROWIRE_CHANNEL_FULL_DUPLEX)
+		    && (chip_info->duplex !=
+			SSP_MICROWIRE_CHANNEL_HALF_DUPLEX)) {
+			dev_err(chip_info->dev,
+				"DUPLEX is configured incorrectly\n");
+			return -EINVAL;
+		}
+	}
+	if (chip_info->cs_control == NULL) {
+		dev_warn(chip_info->dev,
+			"Chip Select Function is NULL for this chip\n");
+		chip_info->cs_control = null_cs_control;
+	}
+	return 0;
+}
+
+/**
+ * pl022_transfer - transfer function registered to SPI master framework
+ * @spi: spi device which is requesting transfer
+ * @msg: spi message which is to handled is queued to driver queue
+ *
+ * This function is registered to the SPI framework for this SPI master
+ * controller. It will queue the spi_message in the queue of driver if
+ * the queue is not stopped and return.
+ */
+static int pl022_transfer(struct spi_device *spi, struct spi_message *msg)
+{
+	struct pl022 *pl022 = spi_master_get_devdata(spi->master);
+	unsigned long flags;
+
+	spin_lock_irqsave(&pl022->queue_lock, flags);
+
+	if (pl022->run == QUEUE_STOPPED) {
+		spin_unlock_irqrestore(&pl022->queue_lock, flags);
+		return -ESHUTDOWN;
+	}
+	msg->actual_length = 0;
+	msg->status = -EINPROGRESS;
+	msg->state = START_STATE;
+
+	list_add_tail(&msg->queue, &pl022->queue);
+	if (pl022->run == QUEUE_RUNNING && !pl022->busy)
+		queue_work(pl022->workqueue, &pl022->pump_messages);
+
+	spin_unlock_irqrestore(&pl022->queue_lock, flags);
+	return 0;
+}
+
+static int calculate_effective_freq(struct pl022 *pl022,
+				    int freq,
+				    struct ssp_clock_params *clk_freq)
+{
+	/* Lets calculate the frequency parameters */
+	u16 cpsdvsr = 2;
+	u16 scr = 0;
+	bool freq_found = false;
+	u32 rate;
+	u32 max_tclk;
+	u32 min_tclk;
+
+	rate = clk_get_rate(pl022->clk);
+	/* cpsdvscr = 2 & scr 0 */
+	max_tclk = (rate / (MIN_CPSDVR * (1 + MIN_SCR)));
+	/* cpsdvsr = 254 & scr = 255 */
+	min_tclk = (rate / (MAX_CPSDVR * (1 + MAX_SCR)));
+
+	if ((freq <= max_tclk) && (freq >= min_tclk)) {
+		while (cpsdvsr <= MAX_CPSDVR && !freq_found) {
+			while (scr <= MAX_SCR && !freq_found) {
+				if ((rate /
+				     (cpsdvsr * (1 + scr))) > freq)
+					scr += 1;
+				else {
+					/*
+					 * This bool is made true when
+					 * effective frequency >=
+					 * target frequency is found
+					 */
+					freq_found = true;
+					if ((rate /
+					     (cpsdvsr * (1 + scr))) != freq) {
+						if (scr == MIN_SCR) {
+							cpsdvsr -= 2;
+							scr = MAX_SCR;
+						} else
+							scr -= 1;
+					}
+				}
+			}
+			if (!freq_found) {
+				cpsdvsr += 2;
+				scr = MIN_SCR;
+			}
+		}
+		if (cpsdvsr != 0) {
+			dev_dbg(&pl022->adev->dev,
+				"SSP Effective Frequency is %u\n",
+				(rate / (cpsdvsr * (1 + scr))));
+			clk_freq->cpsdvsr = (u8) (cpsdvsr & 0xFF);
+			clk_freq->scr = (u8) (scr & 0xFF);
+			dev_dbg(&pl022->adev->dev,
+				"SSP cpsdvsr = %d, scr = %d\n",
+				clk_freq->cpsdvsr, clk_freq->scr);
+		}
+	} else {
+		dev_err(&pl022->adev->dev,
+			"controller data is incorrect: out of range frequency");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/**
+ * NOT IMPLEMENTED
+ * process_dma_info - Processes the DMA info provided by client drivers
+ * @chip_info: chip info provided by client device
+ * @chip: Runtime state maintained by the SSP controller for each spi device
+ *
+ * This function processes and stores DMA config provided by client driver
+ * into the runtime state maintained by the SSP controller driver
+ */
+static int process_dma_info(struct pl022_config_chip *chip_info,
+			    struct chip_data *chip)
+{
+	dev_err(chip_info->dev,
+		"cannot process DMA info, DMA not implemented!\n");
+	return -ENOTSUPP;
+}
+
+/**
+ * pl022_setup - setup function registered to SPI master framework
+ * @spi: spi device which is requesting setup
+ *
+ * This function is registered to the SPI framework for this SPI master
+ * controller. If it is the first time when setup is called by this device,
+ * this function will initialize the runtime state for this chip and save
+ * the same in the device structure. Else it will update the runtime info
+ * with the updated chip info. Nothing is really being written to the
+ * controller hardware here, that is not done until the actual transfer
+ * commence.
+ */
+
+/* FIXME: JUST GUESSING the spi->mode bits understood by this driver */
+#define MODEBITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
+			| SPI_LSB_FIRST | SPI_LOOP)
+
+static int pl022_setup(struct spi_device *spi)
+{
+	struct pl022_config_chip *chip_info;
+	struct chip_data *chip;
+	int status = 0;
+	struct pl022 *pl022 = spi_master_get_devdata(spi->master);
+
+	if (spi->mode & ~MODEBITS) {
+		dev_dbg(&spi->dev, "unsupported mode bits %x\n",
+			spi->mode & ~MODEBITS);
+		return -EINVAL;
+	}
+
+	if (!spi->max_speed_hz)
+		return -EINVAL;
+
+	/* Get controller_state if one is supplied */
+	chip = spi_get_ctldata(spi);
+
+	if (chip == NULL) {
+		chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
+		if (!chip) {
+			dev_err(&spi->dev,
+				"cannot allocate controller state\n");
+			return -ENOMEM;
+		}
+		dev_dbg(&spi->dev,
+			"allocated memory for controller's runtime state\n");
+	}
+
+	/* Get controller data if one is supplied */
+	chip_info = spi->controller_data;
+
+	if (chip_info == NULL) {
+		/* spi_board_info.controller_data not is supplied */
+		dev_dbg(&spi->dev,
+			"using default controller_data settings\n");
+
+		chip_info =
+			kzalloc(sizeof(struct pl022_config_chip), GFP_KERNEL);
+
+		if (!chip_info) {
+			dev_err(&spi->dev,
+				"cannot allocate controller data\n");
+			status = -ENOMEM;
+			goto err_first_setup;
+		}
+
+		dev_dbg(&spi->dev, "allocated memory for controller data\n");
+
+		/* Pointer back to the SPI device */
+		chip_info->dev = &spi->dev;
+		/*
+		 * Set controller data default values:
+		 * Polling is supported by default
+		 */
+		chip_info->lbm = LOOPBACK_DISABLED;
+		chip_info->com_mode = POLLING_TRANSFER;
+		chip_info->iface = SSP_INTERFACE_MOTOROLA_SPI;
+		chip_info->hierarchy = SSP_SLAVE;
+		chip_info->slave_tx_disable = DO_NOT_DRIVE_TX;
+		chip_info->endian_tx = SSP_TX_LSB;
+		chip_info->endian_rx = SSP_RX_LSB;
+		chip_info->data_size = SSP_DATA_BITS_12;
+		chip_info->rx_lev_trig = SSP_RX_1_OR_MORE_ELEM;
+		chip_info->tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC;
+		chip_info->clk_phase = SSP_CLK_FALLING_EDGE;
+		chip_info->clk_pol = SSP_CLK_POL_IDLE_LOW;
+		chip_info->ctrl_len = SSP_BITS_8;
+		chip_info->wait_state = SSP_MWIRE_WAIT_ZERO;
+		chip_info->duplex = SSP_MICROWIRE_CHANNEL_FULL_DUPLEX;
+		chip_info->cs_control = null_cs_control;
+	} else {
+		dev_dbg(&spi->dev,
+			"using user supplied controller_data settings\n");
+	}
+
+	/*
+	 * We can override with custom divisors, else we use the board
+	 * frequency setting
+	 */
+	if ((0 == chip_info->clk_freq.cpsdvsr)
+	    && (0 == chip_info->clk_freq.scr)) {
+		status = calculate_effective_freq(pl022,
+						  spi->max_speed_hz,
+						  &chip_info->clk_freq);
+		if (status < 0)
+			goto err_config_params;
+	} else {
+		if ((chip_info->clk_freq.cpsdvsr % 2) != 0)
+			chip_info->clk_freq.cpsdvsr =
+				chip_info->clk_freq.cpsdvsr - 1;
+	}
+	status = verify_controller_parameters(pl022, chip_info);
+	if (status) {
+		dev_err(&spi->dev, "controller data is incorrect");
+		goto err_config_params;
+	}
+	/* Now set controller state based on controller data */
+	chip->xfer_type = chip_info->com_mode;
+	chip->cs_control = chip_info->cs_control;
+
+	if (chip_info->data_size <= 8) {
+		dev_dbg(&spi->dev, "1 <= n <=8 bits per word\n");
+		chip->n_bytes = 1;
+		chip->read = U8_READING;
+		chip->write = U8_WRITING;
+	} else if (chip_info->data_size <= 16) {
+		dev_dbg(&spi->dev, "9 <= n <= 16 bits per word\n");
+		chip->n_bytes = 2;
+		chip->read = U16_READING;
+		chip->write = U16_WRITING;
+	} else {
+		if (pl022->vendor->max_bpw >= 32) {
+			dev_dbg(&spi->dev, "17 <= n <= 32 bits per word\n");
+			chip->n_bytes = 4;
+			chip->read = U32_READING;
+			chip->write = U32_WRITING;
+		} else {
+			dev_err(&spi->dev,
+				"illegal data size for this controller!\n");
+			dev_err(&spi->dev,
+				"a standard pl022 can only handle "
+				"1 <= n <= 16 bit words\n");
+			goto err_config_params;
+		}
+	}
+
+	/* Now Initialize all register settings required for this chip */
+	chip->cr0 = 0;
+	chip->cr1 = 0;
+	chip->dmacr = 0;
+	chip->cpsr = 0;
+	if ((chip_info->com_mode == DMA_TRANSFER)
+	    && ((pl022->master_info)->enable_dma)) {
+		chip->enable_dma = 1;
+		dev_dbg(&spi->dev, "DMA mode set in controller state\n");
+		status = process_dma_info(chip_info, chip);
+		if (status < 0)
+			goto err_config_params;
+		SSP_WRITE_BITS(chip->dmacr, SSP_DMA_ENABLED,
+			       SSP_DMACR_MASK_RXDMAE, 0);
+		SSP_WRITE_BITS(chip->dmacr, SSP_DMA_ENABLED,
+			       SSP_DMACR_MASK_TXDMAE, 1);
+	} else {
+		chip->enable_dma = 0;
+		dev_dbg(&spi->dev, "DMA mode NOT set in controller state\n");
+		SSP_WRITE_BITS(chip->dmacr, SSP_DMA_DISABLED,
+			       SSP_DMACR_MASK_RXDMAE, 0);
+		SSP_WRITE_BITS(chip->dmacr, SSP_DMA_DISABLED,
+			       SSP_DMACR_MASK_TXDMAE, 1);
+	}
+
+	chip->cpsr = chip_info->clk_freq.cpsdvsr;
+
+	SSP_WRITE_BITS(chip->cr0, chip_info->data_size, SSP_CR0_MASK_DSS, 0);
+	SSP_WRITE_BITS(chip->cr0, chip_info->duplex, SSP_CR0_MASK_HALFDUP, 5);
+	SSP_WRITE_BITS(chip->cr0, chip_info->clk_pol, SSP_CR0_MASK_SPO, 6);
+	SSP_WRITE_BITS(chip->cr0, chip_info->clk_phase, SSP_CR0_MASK_SPH, 7);
+	SSP_WRITE_BITS(chip->cr0, chip_info->clk_freq.scr, SSP_CR0_MASK_SCR, 8);
+	SSP_WRITE_BITS(chip->cr0, chip_info->ctrl_len, SSP_CR0_MASK_CSS, 16);
+	SSP_WRITE_BITS(chip->cr0, chip_info->iface, SSP_CR0_MASK_FRF, 21);
+	SSP_WRITE_BITS(chip->cr1, chip_info->lbm, SSP_CR1_MASK_LBM, 0);
+	SSP_WRITE_BITS(chip->cr1, SSP_DISABLED, SSP_CR1_MASK_SSE, 1);
+	SSP_WRITE_BITS(chip->cr1, chip_info->hierarchy, SSP_CR1_MASK_MS, 2);
+	SSP_WRITE_BITS(chip->cr1, chip_info->slave_tx_disable, SSP_CR1_MASK_SOD, 3);
+	SSP_WRITE_BITS(chip->cr1, chip_info->endian_rx, SSP_CR1_MASK_RENDN, 4);
+	SSP_WRITE_BITS(chip->cr1, chip_info->endian_tx, SSP_CR1_MASK_TENDN, 5);
+	SSP_WRITE_BITS(chip->cr1, chip_info->wait_state, SSP_CR1_MASK_MWAIT, 6);
+	SSP_WRITE_BITS(chip->cr1, chip_info->rx_lev_trig, SSP_CR1_MASK_RXIFLSEL, 7);
+	SSP_WRITE_BITS(chip->cr1, chip_info->tx_lev_trig, SSP_CR1_MASK_TXIFLSEL, 10);
+
+	/* Save controller_state */
+	spi_set_ctldata(spi, chip);
+	return status;
+ err_config_params:
+ err_first_setup:
+	kfree(chip);
+	return status;
+}
+
+/**
+ * pl022_cleanup - cleanup function registered to SPI master framework
+ * @spi: spi device which is requesting cleanup
+ *
+ * This function is registered to the SPI framework for this SPI master
+ * controller. It will free the runtime state of chip.
+ */
+static void pl022_cleanup(struct spi_device *spi)
+{
+	struct chip_data *chip = spi_get_ctldata(spi);
+
+	kfree(chip);
+}
+
+
+static int __init
+pl022_probe(struct amba_device *adev, struct amba_id *id)
+{
+	struct device *dev = &adev->dev;
+	struct pl022_ssp_controller *platform_info = adev->dev.platform_data;
+	struct spi_master *master;
+	struct pl022 *pl022 = NULL;	/*Data for this driver */
+	int status = 0;
+
+	dev_info(&adev->dev,
+		 "ARM PL022 driver, device ID: 0x%08x\n", adev->periphid);
+	if (platform_info == NULL) {
+		dev_err(&adev->dev, "probe - no platform data supplied\n");
+		status = -ENODEV;
+		goto err_no_pdata;
+	}
+
+	/* Allocate master with space for data */
+	master = spi_alloc_master(dev, sizeof(struct pl022));
+	if (master == NULL) {
+		dev_err(&adev->dev, "probe - cannot alloc SPI master\n");
+		status = -ENOMEM;
+		goto err_no_master;
+	}
+
+	pl022 = spi_master_get_devdata(master);
+	pl022->master = master;
+	pl022->master_info = platform_info;
+	pl022->adev = adev;
+	pl022->vendor = id->data;
+
+	/*
+	 * Bus Number Which has been Assigned to this SSP controller
+	 * on this board
+	 */
+	master->bus_num = platform_info->bus_id;
+	master->num_chipselect = platform_info->num_chipselect;
+	master->cleanup = pl022_cleanup;
+	master->setup = pl022_setup;
+	master->transfer = pl022_transfer;
+
+	dev_dbg(&adev->dev, "BUSNO: %d\n", master->bus_num);
+
+	/*Get Hold of Device Register Area... */
+	if (request_mem_region(adev->res.start, SZ_4K, "pl022 I/O Area")
+	    == NULL) {
+		status = -EBUSY;
+		goto err_no_ioregion;
+	}
+
+	pl022->virtbase = ioremap(adev->res.start, SZ_4K);
+	if (pl022->virtbase == NULL) {
+		status = -ENOMEM;
+		goto err_no_ioremap;
+	}
+	printk(KERN_INFO "pl022: mapped registers from 0x%08x to %p\n",
+	       adev->res.start, pl022->virtbase);
+
+	pl022->clk = clk_get(&adev->dev, NULL);
+	if (IS_ERR(pl022->clk)) {
+		status = PTR_ERR(pl022->clk);
+		dev_err(&adev->dev, "could not retrieve SSP/SPI bus clock\n");
+		goto err_no_clk;
+	}
+
+	/* Disable SSP */
+	clk_enable(pl022->clk);
+	writew((readw(SSP_CR1(pl022->virtbase)) & (~SSP_CR1_MASK_SSE)),
+	       SSP_CR1(pl022->virtbase));
+	load_ssp_default_config(pl022);
+	clk_disable(pl022->clk);
+
+	status = request_irq(adev->irq[0], pl022_interrupt_handler, 0, "pl022",
+			     pl022);
+	if (status < 0) {
+		dev_err(&adev->dev, "probe - cannot get IRQ (%d)\n", status);
+		goto err_no_irq;
+	}
+	/* Initialize and start queue */
+	status = init_queue(pl022);
+	if (status != 0) {
+		dev_err(&adev->dev, "probe - problem initializing queue\n");
+		goto err_init_queue;
+	}
+	status = start_queue(pl022);
+	if (status != 0) {
+		dev_err(&adev->dev, "probe - problem starting queue\n");
+		goto err_start_queue;
+	}
+	/* Register with the SPI framework */
+	amba_set_drvdata(adev, pl022);
+	status = spi_register_master(master);
+	if (status != 0) {
+		dev_err(&adev->dev,
+			"probe - problem registering spi master\n");
+		goto err_spi_register;
+	}
+	dev_dbg(dev, "probe succeded\n");
+	return 0;
+
+ err_spi_register:
+ err_start_queue:
+ err_init_queue:
+	destroy_queue(pl022);
+	free_irq(adev->irq[0], pl022);
+ err_no_irq:
+	clk_put(pl022->clk);
+ err_no_clk:
+	iounmap(pl022->virtbase);
+ err_no_ioremap:
+	release_mem_region(adev->res.start, SZ_4K);
+ err_no_ioregion:
+	spi_master_put(master);
+ err_no_master:
+ err_no_pdata:
+	return status;
+}
+
+static int __exit
+pl022_remove(struct amba_device *adev)
+{
+	struct pl022 *pl022 = amba_get_drvdata(adev);
+	int status = 0;
+	if (!pl022)
+		return 0;
+
+	/* Remove the queue */
+	status = destroy_queue(pl022);
+	if (status != 0) {
+		dev_err(&adev->dev,
+			"queue remove failed (%d)\n", status);
+		return status;
+	}
+	load_ssp_default_config(pl022);
+	free_irq(adev->irq[0], pl022);
+	clk_disable(pl022->clk);
+	clk_put(pl022->clk);
+	iounmap(pl022->virtbase);
+	release_mem_region(adev->res.start, SZ_4K);
+	tasklet_disable(&pl022->pump_transfers);
+	spi_unregister_master(pl022->master);
+	spi_master_put(pl022->master);
+	amba_set_drvdata(adev, NULL);
+	dev_dbg(&adev->dev, "remove succeded\n");
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int suspend_devices(struct device *dev, void *pm_message)
+{
+	pm_message_t *state = pm_message;
+
+	if (dev->power.power_state.event != state->event) {
+		dev_warn(dev, "pm state does not match request\n");
+		return -EPERM;
+	}
+	return 0;
+}
+
+static int pl022_suspend(struct amba_device *adev, pm_message_t state)
+{
+	struct pl022 *pl022 = amba_get_drvdata(adev);
+	int status = 0;
+
+	/* Check all children (connected SPI chips) for current power state */
+	status = device_for_each_child(&adev->dev, &state, suspend_devices);
+	if (status) {
+		dev_warn(&adev->dev,
+			 "children (SPI chips) not in the same power "
+			 "state, suspend aborted\n");
+		return status;
+	}
+
+	status = stop_queue(pl022);
+	if (status) {
+		dev_warn(&adev->dev, "suspend cannot stop queue\n");
+		return status;
+	}
+
+	clk_enable(pl022->clk);
+	load_ssp_default_config(pl022);
+	clk_disable(pl022->clk);
+	dev_dbg(&adev->dev, "suspended\n");
+	return 0;
+}
+
+static int pl022_resume(struct amba_device *adev)
+{
+	struct pl022 *pl022 = amba_get_drvdata(adev);
+	int status = 0;
+
+	/* Start the queue running */
+	status = start_queue(pl022);
+	if (status)
+		dev_err(&adev->dev, "problem starting queue (%d)\n", status);
+	else
+		dev_dbg(&adev->dev, "resumed\n");
+
+	return status;
+}
+
+#else
+#define pl022_suspend NULL
+#define pl022_resume NULL
+#endif				/* CONFIG_PM */
+
+static struct vendor_data vendor_arm = {
+	.fifodepth = 8,
+	.max_bpw = 16,
+	.unidir = false,
+};
+
+
+static struct vendor_data vendor_st = {
+	.fifodepth = 32,
+	.max_bpw = 32,
+	.unidir = false,
+};
+
+static struct amba_id pl022_ids[] __initdata = {
+	{
+		/*
+		 * ARM PL022 variant, this has a 16bit wide
+		 * and 8 locations deep TX/RX FIFO
+		 */
+		.id	= 0x00041022,
+		.mask	= 0x000fffff,
+		.data	= &vendor_arm,
+	},
+	{
+		/*
+		 * ST Micro derivative, this has 32bit wide
+		 * and 32 locations deep TX/RX FIFO
+		 */
+		.id	= 0x00108022,
+		.mask	= 0xffffffff,
+		.data	= &vendor_st,
+	},
+	{ 0, 0 },
+};
+
+static struct amba_driver pl022_driver = {
+	.drv = {
+		.name	= "ssp-pl022",
+	},
+	.id_table	= pl022_ids,
+	.probe		= pl022_probe,
+	.remove		= __exit_p(pl022_remove),
+	.suspend        = pl022_suspend,
+	.resume         = pl022_resume,
+};
+
+
+static int __init pl022_init(void)
+{
+	return amba_driver_register(&pl022_driver);
+}
+
+module_init(pl022_init);
+
+static void __exit pl022_exit(void)
+{
+	amba_driver_unregister(&pl022_driver);
+}
+
+module_exit(pl022_exit);
+
+MODULE_AUTHOR("Linus Walleij <linus.walleij-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>");
+MODULE_DESCRIPTION("PL022 SSP Controller Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
new file mode 100644
index 0000000..dcad0ff
--- /dev/null
+++ b/include/linux/amba/pl022.h
@@ -0,0 +1,264 @@
+/*
+ * include/linux/amba/pl022.h
+ *
+ * Copyright (C) 2008-2009 ST-Ericsson AB
+ * Copyright (C) 2006 STMicroelectronics Pvt. Ltd.
+ *
+ * Author: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
+ *
+ * Initial version inspired by:
+ *	linux-2.6.17-rc3-mm1/drivers/spi/pxa2xx_spi.c
+ * Initial adoption to PL022 by:
+ *      Sachin Verma <sachin.verma-qxv4g6HH51o@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _SSP_PL022_H
+#define _SSP_PL022_H
+
+#include <linux/device.h>
+
+/**
+ * whether SSP is in loopback mode or not
+ */
+enum ssp_loopback {
+	LOOPBACK_DISABLED,
+	LOOPBACK_ENABLED
+};
+
+/**
+ * enum ssp_interface - interfaces allowed for this SSP Controller
+ * @SSP_INTERFACE_MOTOROLA_SPI: Motorola Interface
+ * @SSP_INTERFACE_TI_SYNC_SERIAL: Texas Instrument Synchronous Serial
+ * interface
+ * @SSP_INTERFACE_NATIONAL_MICROWIRE: National Semiconductor Microwire
+ * interface
+ * @SSP_INTERFACE_UNIDIRECTIONAL: Unidirectional interface (STn8810
+ * &STn8815 only)
+ */
+enum ssp_interface {
+	SSP_INTERFACE_MOTOROLA_SPI,
+	SSP_INTERFACE_TI_SYNC_SERIAL,
+	SSP_INTERFACE_NATIONAL_MICROWIRE,
+	SSP_INTERFACE_UNIDIRECTIONAL
+};
+
+/**
+ * enum ssp_hierarchy - whether SSP is configured as Master or Slave
+ */
+enum ssp_hierarchy {
+	SSP_MASTER,
+	SSP_SLAVE
+};
+
+/**
+ * enum ssp_clock_params - clock parameters, to set SSP clock at a
+ * desired freq
+ */
+struct ssp_clock_params {
+	u8 cpsdvsr; /* value from 2 to 254 (even only!) */
+	u8 scr;	    /* value from 0 to 255 */
+};
+
+/**
+ * enum ssp_rx_endian - endianess of Rx FIFO Data
+ */
+enum ssp_rx_endian {
+	SSP_RX_MSB,
+	SSP_RX_LSB
+};
+
+/**
+ * enum ssp_tx_endian - endianess of Tx FIFO Data
+ */
+enum ssp_tx_endian {
+	SSP_TX_MSB,
+	SSP_TX_LSB
+};
+
+/**
+ * enum ssp_data_size - number of bits in one data element
+ */
+enum ssp_data_size {
+	SSP_DATA_BITS_4 = 0x03, SSP_DATA_BITS_5, SSP_DATA_BITS_6,
+	SSP_DATA_BITS_7, SSP_DATA_BITS_8, SSP_DATA_BITS_9,
+	SSP_DATA_BITS_10, SSP_DATA_BITS_11, SSP_DATA_BITS_12,
+	SSP_DATA_BITS_13, SSP_DATA_BITS_14, SSP_DATA_BITS_15,
+	SSP_DATA_BITS_16, SSP_DATA_BITS_17, SSP_DATA_BITS_18,
+	SSP_DATA_BITS_19, SSP_DATA_BITS_20, SSP_DATA_BITS_21,
+	SSP_DATA_BITS_22, SSP_DATA_BITS_23, SSP_DATA_BITS_24,
+	SSP_DATA_BITS_25, SSP_DATA_BITS_26, SSP_DATA_BITS_27,
+	SSP_DATA_BITS_28, SSP_DATA_BITS_29, SSP_DATA_BITS_30,
+	SSP_DATA_BITS_31, SSP_DATA_BITS_32
+};
+
+/**
+ * enum ssp_mode - SSP mode of operation (Communication modes)
+ */
+enum ssp_mode {
+	INTERRUPT_TRANSFER,
+	POLLING_TRANSFER,
+	DMA_TRANSFER
+};
+
+/**
+ * enum ssp_rx_level_trig - receive FIFO watermark level which triggers
+ * IT: Interrupt fires when _N_ or more elements in RX FIFO.
+ */
+enum ssp_rx_level_trig {
+	SSP_RX_1_OR_MORE_ELEM,
+	SSP_RX_4_OR_MORE_ELEM,
+	SSP_RX_8_OR_MORE_ELEM,
+	SSP_RX_16_OR_MORE_ELEM,
+	SSP_RX_32_OR_MORE_ELEM
+};
+
+/**
+ * Transmit FIFO watermark level which triggers (IT Interrupt fires
+ * when _N_ or more empty locations in TX FIFO)
+ */
+enum ssp_tx_level_trig {
+	SSP_TX_1_OR_MORE_EMPTY_LOC,
+	SSP_TX_4_OR_MORE_EMPTY_LOC,
+	SSP_TX_8_OR_MORE_EMPTY_LOC,
+	SSP_TX_16_OR_MORE_EMPTY_LOC,
+	SSP_TX_32_OR_MORE_EMPTY_LOC
+};
+
+/**
+ * enum SPI Clock Phase - clock phase (Motorola SPI interface only)
+ * @SSP_CLK_RISING_EDGE: Receive data on rising edge
+ * @SSP_CLK_FALLING_EDGE: Receive data on falling edge
+ */
+enum ssp_spi_clk_phase {
+	SSP_CLK_RISING_EDGE,
+	SSP_CLK_FALLING_EDGE
+};
+
+/**
+ * enum SPI Clock Polarity - clock polarity (Motorola SPI interface only)
+ * @SSP_CLK_POL_IDLE_LOW: Low inactive level
+ * @SSP_CLK_POL_IDLE_HIGH: High inactive level
+ */
+enum ssp_spi_clk_pol {
+	SSP_CLK_POL_IDLE_LOW,
+	SSP_CLK_POL_IDLE_HIGH
+};
+
+/**
+ * Microwire Conrol Lengths Command size in microwire format
+ */
+enum ssp_microwire_ctrl_len {
+	SSP_BITS_4 = 0x03, SSP_BITS_5, SSP_BITS_6,
+	SSP_BITS_7, SSP_BITS_8, SSP_BITS_9,
+	SSP_BITS_10, SSP_BITS_11, SSP_BITS_12,
+	SSP_BITS_13, SSP_BITS_14, SSP_BITS_15,
+	SSP_BITS_16, SSP_BITS_17, SSP_BITS_18,
+	SSP_BITS_19, SSP_BITS_20, SSP_BITS_21,
+	SSP_BITS_22, SSP_BITS_23, SSP_BITS_24,
+	SSP_BITS_25, SSP_BITS_26, SSP_BITS_27,
+	SSP_BITS_28, SSP_BITS_29, SSP_BITS_30,
+	SSP_BITS_31, SSP_BITS_32
+};
+
+/**
+ * enum Microwire Wait State
+ * @SSP_MWIRE_WAIT_ZERO: No wait state inserted after last command bit
+ * @SSP_MWIRE_WAIT_ONE: One wait state inserted after last command bit
+ */
+enum ssp_microwire_wait_state {
+	SSP_MWIRE_WAIT_ZERO,
+	SSP_MWIRE_WAIT_ONE
+};
+
+/**
+ * enum Microwire - whether Full/Half Duplex
+ * @SSP_MICROWIRE_CHANNEL_FULL_DUPLEX: SSPTXD becomes bi-directional,
+ *     SSPRXD not used
+ * @SSP_MICROWIRE_CHANNEL_HALF_DUPLEX: SSPTXD is an output, SSPRXD is
+ *     an input.
+ */
+enum ssp_duplex {
+	SSP_MICROWIRE_CHANNEL_FULL_DUPLEX,
+	SSP_MICROWIRE_CHANNEL_HALF_DUPLEX
+};
+
+/**
+ * CHIP select/deselect commands
+ */
+enum ssp_chip_select {
+	SSP_CHIP_SELECT,
+	SSP_CHIP_DESELECT
+};
+
+
+/**
+ * struct pl022_ssp_master - device.platform_data for SPI controller devices.
+ * @num_chipselect: chipselects are used to distinguish individual
+ *     SPI slaves, and are numbered from zero to num_chipselects - 1.
+ *     each slave has a chipselect signal, but it's common that not
+ *     every chipselect is connected to a slave.
+ * @enable_dma: if true enables DMA driven transfers.
+ */
+struct pl022_ssp_controller {
+	u16 bus_id;
+	u8 num_chipselect;
+	u8 enable_dma:1;
+};
+
+/**
+ * struct ssp_config_chip - spi_board_info.controller_data for SPI
+ * slave devices, copied to spi_device.controller_data.
+ *
+ * @lbm: used for test purpose to internally connect RX and TX
+ * @iface: Interface type(Motorola, TI, Microwire, Universal)
+ * @hierarchy: sets whether interface is master or slave
+ * @slave_tx_disable: SSPTXD is disconnected (in slave mode only)
+ * @clk_freq: Tune freq parameters of SSP(when in master mode)
+ * @endian_rx: Endianess of Data in Rx FIFO
+ * @endian_tx: Endianess of Data in Tx FIFO
+ * @data_size: Width of data element(4 to 32 bits)
+ * @com_mode: communication mode: polling, Interrupt or DMA
+ * @rx_lev_trig: Rx FIFO watermark level (for IT & DMA mode)
+ * @tx_lev_trig: Tx FIFO watermark level (for IT & DMA mode)
+ * @clk_phase: Motorola SPI interface Clock phase
+ * @clk_pol: Motorola SPI interface Clock polarity
+ * @ctrl_len: Microwire interface: Control length
+ * @wait_state: Microwire interface: Wait state
+ * @duplex: Microwire interface: Full/Half duplex
+ * @cs_control: function pointer to board-specific function to
+ * assert/deassert I/O port to control HW generation of devices chip-select.
+ * @dma_xfer_type: Type of DMA xfer (Mem-to-periph or Periph-to-Periph)
+ * @dma_config: DMA configuration for SSP controller and peripheral
+ */
+struct pl022_config_chip {
+	struct device *dev;
+	enum ssp_loopback lbm;
+	enum ssp_interface iface;
+	enum ssp_hierarchy hierarchy;
+	bool slave_tx_disable;
+	struct ssp_clock_params clk_freq;
+	enum ssp_rx_endian endian_rx;
+	enum ssp_tx_endian endian_tx;
+	enum ssp_data_size data_size;
+	enum ssp_mode com_mode;
+	enum ssp_rx_level_trig rx_lev_trig;
+	enum ssp_tx_level_trig tx_lev_trig;
+	enum ssp_spi_clk_phase clk_phase;
+	enum ssp_spi_clk_pol clk_pol;
+	enum ssp_microwire_ctrl_len ctrl_len;
+	enum ssp_microwire_wait_state wait_state;
+	enum ssp_duplex duplex;
+	void (*cs_control) (u32 control);
+};
+
+#endif /* _SSP_PL022_H */
-- 
1.6.2.1

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
