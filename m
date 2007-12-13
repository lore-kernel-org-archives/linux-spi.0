From: Christer Weinigel <christer.weinigel-kQvG35nSl+M@public.gmane.org>
Subject: [PATCH] Samsung S3C24xx DMA capable SPI driver
Date: Thu, 13 Dec 2007 15:06:55 +0100
Message-ID: <20071213150655.13873844@cw05linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi David,

here's an updated version of my Samsung S3C24xx DMA capable SPI driver.
It's a patch against linux-2.6.23.  =


The driver should be fairly complete now.  It does have a bunch of
module options that ought to be moved to platform data, but to keep
the driver fairly self contained I'm keeping them as module options for
the moment.

There are three TODO comments in the code.  The first one has to do
with delay_usecs, how large can that value get?  Should I use udelay
for that delay or do you expect it to be so large that I ought to use
a timer instead?  =


The second one has to do with DMA mapping, I think the way I do things
is safe, as long as people don't play tricks with dma_map_noncoherent,
on the other hand, if they do, there's lots of other code that will
break anyway, so I think I'll ignore that, as long as people do sane
things it ought to work.  =


Finally, there is a slight cleanup issue with the DMA, but it should
normally not be a problem.

Any comments?

  /Christer

Signed-off-by: Christer Weinigel <christer.weinigel-kQvG35nSl+M@public.gmane.org>

Index: linux-2.6.23/drivers/spi/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.orig/drivers/spi/Kconfig
+++ linux-2.6.23/drivers/spi/Kconfig
@@ -174,6 +174,13 @@ config SPI_S3C24XX_GPIO
 	  the inbuilt hardware cannot provide the transfer mode, or
 	  where the board is using non hardware connected pins.
 =

+config SPI_S3C24XX_DMA
+	tristate "Samsung S3C24XX series SPI using DMA"
+	depends on SPI_MASTER && ARCH_S3C2410 && EXPERIMENTAL
+	help
+	  SPI driver for Samsung S3C24XX series ARM SoCs using DMA to
+	  perform the transfers.
+
 config SPI_TXX9
 	tristate "Toshiba TXx9 SPI controller"
 	depends on SPI_MASTER && GENERIC_GPIO && CPU_TX49XX
Index: linux-2.6.23/drivers/spi/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.orig/drivers/spi/Makefile
+++ linux-2.6.23/drivers/spi/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SPI_MPC52xx_PSC)		+=3D mpc52x
 obj-$(CONFIG_SPI_MPC83xx)		+=3D spi_mpc83xx.o
 obj-$(CONFIG_SPI_S3C24XX_GPIO)		+=3D spi_s3c24xx_gpio.o
 obj-$(CONFIG_SPI_S3C24XX)		+=3D spi_s3c24xx.o
+obj-$(CONFIG_SPI_S3C24XX_DMA)		+=3D spi_s3c24xx_dma.o
 obj-$(CONFIG_SPI_TXX9)			+=3D spi_txx9.o
 obj-$(CONFIG_SPI_XILINX)		+=3D xilinx_spi.o
 # 	... add above this line ...
Index: linux-2.6.23/drivers/spi/spi_s3c24xx_dma.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6.23/drivers/spi/spi_s3c24xx_dma.c
@@ -0,0 +1,830 @@
+/* DMA capable SPI driver for the S3C24xx Processors.
+ *
+ * Copyright (C) 2007 Nordnav Technologies AB
+ *	Christer Weinigel <christer.weinigel-kQvG35nSl+M@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+
+#include <linux/spi/spi.h>
+
+#include <asm/dma.h>
+
+#include <asm/arch/spi.h>
+#include <asm/arch/regs-gpio.h>
+
+#include <asm/plat-s3c24xx/dma.h>
+#include <asm/plat-s3c24xx/regs-spi.h>
+
+/* Setting up a DMA transfer and doing the DMA mapping is a rather
+ * heavy operation (takes about 20-30 usecs on a 200 MHz S3C24A0) so
+ * for short transfers it's a waste of CPU to do DMA.  Add a tunable
+ * that tells the driver at what size to start using use DMA
+ * transfers.
+ *
+ * To disable DMA entirely, set use_dma to 0.
+ */
+static unsigned use_dma =3D 32;
+module_param(use_dma, int, 0444);
+MODULE_PARM_DESC(use_dma,
+		 "0: no DMA, >=3D1: Use DMA for transfers above this size");
+
+/* For fast bitrates using interrupts is really wasteful because the
+ * interrupt latency is much longer than the time it takes to transfer
+ * a byte, so most time is spent entering and exiting the interrupt
+ * handler.  It's faster to just poll the status register until the
+ * READY bit goes high.  This option tells the driver to use polling
+ * transfers above the specified frequency.
+ *
+ * For a 200 MHz S3C24A0 the interrupt latency seems to be around 4
+ * us, so it's probably worth turning on polling at bitrates above
+ * 8 bits / 4 us =3D 2 MBit/s.
+ *
+ * To disable polling entirely, set it to a ridiculously large value.
+ */
+static unsigned use_poll =3D 2000000;
+module_param(use_poll, int, 0444);
+MODULE_PARM_DESC(use_poll,
+		 "Use polling for transfers above this frequency");
+
+/* This setting just limits the number of times the driver tries to
+ * poll the status register for READY before it falls back to IRQ
+ * driven transfers.
+ *
+ * If you have set use_poll to a too low value and the max_poll check
+ * triggers, you want to either increase use_poll so that it uses
+ * interrupt transfers instear or increase max_poll so that the driver
+ * shuts up.  But increasing max_poll will waste a lot of CPU, so you
+ * really don't want to do that.
+ */
+static unsigned max_poll =3D 1000;
+module_param(max_poll, int, 0444);
+MODULE_PARM_DESC(max_poll,
+		 "Maximum number of times to poll the status register before"
+		 "falling back to IRQ driven transfers");
+
+static struct s3c2410_dma_client spi_s3c24xx_dma_client =3D {
+	.name =3D "spi_s3c24xx_dma"
+};
+
+struct spi_s3c24xx_dma_hw {
+	/* the base of SPI registers for this port */
+	void *regs;
+
+	/* the base value for spcon, i.e. including the CPOL and CPHA
+	 * bits and but excluding the SMOD and TAGD bits */
+	unsigned spcon;
+
+	/* state used during transfers */
+	int active;
+	size_t count;
+	unsigned char *rx_ptr;
+	const unsigned char *tx_ptr;
+
+	/* state used during DMA transfers */
+	dma_addr_t xfer_dma_addr;
+	enum dma_data_direction xfer_direction;
+
+	/* state used for activating and deactivating a board */
+	int cs;			/* last chip selected or -1 if none */
+	int cs_pol;		/* cs polarity for last cs */
+	u32 speed_hz;		/* last selected speed */
+
+	/* callbacks optionally defined by the platform data */
+	void (*set_cs)(struct s3c2410_spi_info *spi, int cs, int pol);
+	struct s3c2410_spi_info *pdata;
+
+	/* queue of messages waiting to be processed */
+	struct list_head queue;
+	/* message queue lock */
+	spinlock_t queue_lock;
+
+	/* the current transfer */
+	struct spi_transfer *transfer;
+
+	/* resource handling */
+	struct device *dev;
+	struct clk *clk;
+	struct resource *iomem;
+	struct resource *irq;
+	dmach_t dmach;
+	int have_dma;
+};
+
+static void spi_s3c24xx_dma_start_transfer(struct spi_s3c24xx_dma_hw *hw);
+static void spi_s3c24xx_dma_wake(struct spi_s3c24xx_dma_hw *hw);
+
+static void spi_s3c24xx_dma_default_set_cs(struct s3c2410_spi_info *spi,
+					   int cs, int pol)
+{
+	s3c2410_gpio_setpin(cs, pol);
+}
+
+static void spi_s3c24xx_dma_activate(struct spi_s3c24xx_dma_hw *hw,
+				     struct spi_device *spi,
+				     struct spi_transfer *transfer)
+{
+	unsigned long hz;
+	unsigned long actual_hz;
+	unsigned sppre;
+
+	if (hw->cs !=3D spi->chip_select) {
+		if (hw->cs !=3D -1)
+			hw->set_cs(hw->pdata, hw->cs, !hw->cs_pol);
+
+		hw->spcon =3D S3C2410_SPCON_ENSCK | S3C2410_SPCON_MSTR;
+
+		hw->cs =3D spi->chip_select;
+		hw->cs_pol =3D spi->mode & SPI_CS_HIGH ? 1 : 0;
+
+		hw->set_cs(hw->pdata, hw->cs, hw->cs_pol);
+	}
+
+	if (spi->mode & SPI_CPOL)
+		hw->spcon |=3D S3C2410_SPCON_CPOL_HIGH;
+	else
+		hw->spcon |=3D S3C2410_SPCON_CPOL_LOW;
+
+	if (spi->mode & SPI_CPHA)
+		hw->spcon |=3D S3C2410_SPCON_CPHA_FMTA;
+	else
+		hw->spcon |=3D S3C2410_SPCON_CPHA_FMTB;
+
+	writel(hw->spcon | S3C2410_SPCON_SMOD_POLL,
+	       hw->regs + S3C2410_SPCON);
+
+	hz =3D transfer->speed_hz;
+	if (hz =3D=3D 0 || hz > spi->max_speed_hz)
+		hz =3D spi->max_speed_hz;
+
+	if (hw->speed_hz !=3D hz) {
+		sppre =3D ((clk_get_rate(hw->clk) + hz - 1) / hz + 1) / 2 - 1;
+		if (sppre < 0)
+			sppre =3D 0;
+		if (sppre > 255)
+			sppre =3D 255;
+
+		writel(sppre, hw->regs + S3C2410_SPPRE);
+
+		actual_hz =3D clk_get_rate(hw->clk) / 2 / (sppre + 1);
+		dev_info(hw->dev,
+			 "bus speed %lu Hz (%u), requested %lu Hz\n",
+			 actual_hz, sppre, hz);
+
+		hw->speed_hz =3D hz;
+	}
+}
+
+static void spi_s3c24xx_dma_deactivate(struct spi_s3c24xx_dma_hw *hw)
+{
+	if (hw->cs !=3D -1) {
+		hw->set_cs(hw->pdata, hw->cs, !hw->cs_pol);
+		hw->cs =3D -1;
+	}
+}
+
+static void spi_s3c24xx_dma_transfer_done(struct spi_s3c24xx_dma_hw *hw)
+{
+	struct spi_message *message;
+	struct spi_transfer *transfer;
+	unsigned long flags;
+
+	writel(hw->spcon | S3C2410_SPCON_SMOD_POLL,
+	       hw->regs + S3C2410_SPCON);
+
+	message =3D list_first_entry(&hw->queue,
+				   struct spi_message, queue);
+
+	transfer =3D hw->transfer;
+
+	dev_dbg(hw->dev, "done\n");
+
+	/* TODO maybe compensate for the time it takes to get here, If
+	 * the interrupt latency and everything else is large, it
+	 * might be a good idea to subtract that time. */
+
+	/* TODO How large is the delay?  If it's large, we might have
+	 * to use a timer instead of udelay. */
+
+	if (transfer->delay_usecs) {
+		dev_dbg(hw->dev, "delay %u usecs\n", transfer->delay_usecs);
+		udelay(transfer->delay_usecs);
+	}
+
+	if (transfer->cs_change)
+		spi_s3c24xx_dma_deactivate(hw);
+
+	if (0 && transfer->rx_buf) {
+		int i;
+		printk(KERN_DEBUG "receive 0x%x bytes:", transfer->len);
+		for (i =3D 0; i < transfer->len; i++)
+			printk(" %02x",
+			       ((unsigned char *)transfer->rx_buf)[i]);
+		printk("\n");
+	}
+
+	message->actual_length +=3D transfer->len;
+
+	if (list_is_last(&transfer->transfer_list, &message->transfers)) {
+		spin_lock_irqsave(&hw->queue_lock, flags);
+		hw->transfer =3D NULL;
+		list_del(&message->queue);
+		spin_unlock_irqrestore(&hw->queue_lock, flags);
+
+		spi_s3c24xx_dma_wake(hw);
+
+		if (message->complete) {
+			message->status =3D 0;
+			message->complete(message->context);
+		}
+	} else {
+		hw->transfer =3D list_entry(transfer->transfer_list.next,
+					  struct spi_transfer,
+					  transfer_list);
+
+		spi_s3c24xx_dma_start_transfer(hw);
+	}
+}
+
+static int spi_s3c24xx_dma_poll(struct spi_s3c24xx_dma_hw *hw)
+{
+	unsigned status;
+	unsigned i;
+	static int poll_warned;
+
+	do {
+		for (i =3D 0; i <=3D max_poll; i++) {
+			status =3D readl(hw->regs + S3C2410_SPSTA);
+			if (status & S3C2410_SPSTA_READY)
+				goto ready;
+		}
+
+		if (poll_warned < 5) {
+			dev_warn(hw->dev, "poll timeout (%d attempts), "
+				 "falling back to interrupts\n", i);
+			poll_warned++;
+		}
+
+		/* there is more data to transfer, so return 1 */
+		return 1;
+
+ready:
+		pr_debug("%s: poll loops %d, count %d\n",
+			 __func__, i, hw->count);
+
+		if (hw->rx_ptr)
+			*hw->rx_ptr++ =3D readl(hw->regs + S3C2410_SPRDAT);
+
+		if (!hw->count) {
+			spi_s3c24xx_dma_transfer_done(hw);
+			return 0;
+		}
+
+		if (hw->tx_ptr)
+			writel(*hw->tx_ptr++,
+			       hw->regs + S3C2410_SPTDAT);
+		else
+			writel(0xff, hw->regs + S3C2410_SPTDAT);
+		hw->count--;
+	} while (use_poll <=3D hw->speed_hz);
+
+	/* there's more work to be done */
+	return 1;
+}
+
+static irqreturn_t spi_s3c24xx_dma_irq(int irq, void *dev_id)
+{
+	struct spi_s3c24xx_dma_hw *hw =3D dev_id;
+	unsigned status;
+
+	if (!hw->active) {
+		dev_warn(hw->dev, "%s: called when not active\n", __func__);
+		writel(hw->spcon | S3C2410_SPCON_SMOD_POLL,
+		       hw->regs + S3C2410_SPCON);
+		return IRQ_HANDLED;
+	}
+
+	status =3D readl(hw->regs + S3C2410_SPSTA);
+
+	if (status !=3D S3C2410_SPSTA_READY) {
+		dev_warn(hw->dev, "%s: unexpected status 0x%x, count %d\n",
+			__func__, status, hw->count);
+	}
+
+	pr_debug("%s: count %d,  status 0x%x\n", __func__, hw->count, status);
+
+	writel(hw->spcon | S3C2410_SPCON_SMOD_POLL,
+	       hw->regs + S3C2410_SPCON);
+
+	if (spi_s3c24xx_dma_poll(hw)) {
+		writel(hw->spcon | S3C2410_SPCON_SMOD_INT,
+		       hw->regs + S3C2410_SPCON);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void spi_s3c24xx_dma_start_int(struct spi_s3c24xx_dma_hw *hw)
+{
+	pr_debug("%s: count =3D %u\n", __func__, hw->count);
+
+	writel(hw->spcon | S3C2410_SPCON_SMOD_POLL,
+	       hw->regs + S3C2410_SPCON);
+
+	if (spi_s3c24xx_dma_poll(hw)) {
+		writel(hw->spcon | S3C2410_SPCON_SMOD_INT,
+		       hw->regs + S3C2410_SPCON);
+	}
+}
+
+static void spi_s3c24xx_dma_callback(struct s3c2410_dma_chan *dma_ch,
+				     void *buf_id, int size,
+				     enum s3c2410_dma_buffresult result)
+{
+	struct spi_s3c24xx_dma_hw *hw =3D buf_id;
+	struct spi_message *message =3D
+		list_first_entry(&hw->queue, struct spi_message, queue);
+	struct spi_transfer *transfer =3D hw->transfer;
+
+	pr_debug("%s: count %u, size %u, result %u\n",
+		 __func__, hw->count, size, result);
+
+	if (!hw->active) {
+		dev_warn(hw->dev, "%s: called when not active\n", __func__);
+		writel(hw->spcon | S3C2410_SPCON_SMOD_POLL,
+		       hw->regs + S3C2410_SPCON);
+		return;
+	}
+
+	if (size > hw->count) {
+		dev_err(hw->dev, "%s: DMA size %u larger expected count %u\n",
+			__func__, size, hw->count);
+		/* things are messed up for this to happen, so don't
+		 * do anything here, just return and hope nothing bad
+		 * has happened */
+		return;
+	}
+
+	hw->count -=3D size;
+
+	if (hw->rx_ptr)
+		hw->rx_ptr +=3D size;
+	if (hw->tx_ptr)
+		hw->tx_ptr +=3D size;
+
+	if (!message->is_dma_mapped) {
+		dma_unmap_single(hw->dev, hw->xfer_dma_addr,
+				 transfer->len, hw->xfer_direction);
+	}
+
+	spi_s3c24xx_dma_start_int(hw);
+}
+
+static int spi_s3c24xx_dma_start_dma(struct spi_s3c24xx_dma_hw *hw)
+{
+	struct spi_message *message =3D
+		list_first_entry(&hw->queue, struct spi_message, queue);
+	struct spi_transfer *transfer =3D hw->transfer;
+	void *cpu_addr;
+
+	pr_debug("%s: count =3D %u, is_dma_mapped %d\n", __func__,
+		 hw->count, message->is_dma_mapped);
+
+	if (message->is_dma_mapped) {
+		/* TODO how does rx_dma work with the last byte which
+		 * is transferred using polling?  If the memory is
+		 * allocated with dma_alloc_coherent, it ought to
+		 * work, if the memory is allocated with
+		 * dma_alloc_noncoherent and the caller is doing
+		 * dma_sync by hand, it'll most probably break
+		 * horribly.  OTOH, in that case any polled I/O,
+		 * i.e. the INT transfers, will break too. */
+		if (hw->rx_ptr)
+			hw->xfer_dma_addr =3D transfer->rx_dma;
+		else
+			hw->xfer_dma_addr =3D transfer->tx_dma;
+	} else {
+		if (hw->rx_ptr) {
+			cpu_addr =3D transfer->rx_buf;
+			hw->xfer_direction =3D DMA_FROM_DEVICE;
+		} else {
+			cpu_addr =3D (void *)transfer->tx_buf;
+			hw->xfer_direction =3D DMA_TO_DEVICE;
+		}
+
+		hw->xfer_dma_addr =3D dma_map_single(hw->dev,
+						   cpu_addr,
+						   transfer->len,
+						   hw->xfer_direction);
+
+		if (dma_mapping_error(hw->xfer_dma_addr)) {
+			dev_warn(hw->dev,
+				 "dma_map_single(%p, %u, %u) failed\n",
+				 cpu_addr, transfer->len,
+				 hw->xfer_direction);
+			return 0;
+		}
+	}
+
+	if (hw->rx_ptr) {
+		s3c2410_dma_devconfig(hw->dmach, S3C2410_DMASRC_HW,
+				      S3C2410_DISRCC_INC | S3C2410_DISRCC_APB,
+				      hw->iomem->start + S3C2410_SPRDAT);
+		writel(hw->spcon | S3C2410_SPCON_SMOD_DMA | S3C2410_SPCON_TAGD,
+		       hw->regs + S3C2410_SPCON);
+	} else {
+		s3c2410_dma_devconfig(hw->dmach, S3C2410_DMASRC_MEM,
+				      S3C2410_DISRCC_INC | S3C2410_DISRCC_APB,
+				      hw->iomem->start + S3C2410_SPTDAT);
+		writel(hw->spcon | S3C2410_SPCON_SMOD_DMA,
+		       hw->regs + S3C2410_SPCON);
+	}
+
+	s3c2410_dma_enqueue(hw->dmach, hw, hw->xfer_dma_addr, hw->count);
+
+	return 1;
+}
+
+static int spi_s3c24xx_dma_setup(struct spi_device *spi)
+{
+	struct spi_master *master =3D spi->master;
+	struct spi_s3c24xx_dma_hw *hw =3D spi_master_get_devdata(master);
+
+	dev_info(hw->dev,
+		 "setup %s, mode 0x%x, bits %u, hz %d\n",
+		 spi->dev.bus_id,
+		 spi->mode, spi->bits_per_word, spi->max_speed_hz);
+
+	if (spi->mode & ~(SPI_CS_HIGH | SPI_CPOL | SPI_CPHA)) {
+		dev_err(hw->dev, "setup %s, unsupported mode 0x%x\n",
+			spi->dev.bus_id, spi->mode);
+		return -EINVAL;
+	}
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word =3D 8;
+
+	if (spi->bits_per_word !=3D 8) {
+		dev_err(hw->dev, "setup %s, unsupported bits_per_word (%u)\n",
+			spi->dev.bus_id, spi->bits_per_word);
+		return -EINVAL;
+	}
+
+	if (!spi->max_speed_hz) {
+		dev_err(hw->dev, "setup %s, no max speed set, "
+			"you have to supply a sensible value\n",
+			spi->dev.bus_id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void spi_s3c24xx_dma_start_transfer(struct spi_s3c24xx_dma_hw *hw)
+{
+	struct spi_message *message;
+	struct spi_transfer *transfer;
+
+	transfer =3D hw->transfer;
+
+	dev_dbg(hw->dev, "start: %s%s, hz %d, bits %d, len %d, cs %d\n",
+		transfer->rx_buf ? "R":"", transfer->tx_buf ? "W":"",
+		transfer->speed_hz, transfer->bits_per_word,
+		transfer->len, transfer->cs_change);
+
+	hw->count =3D transfer->len;
+
+	hw->rx_ptr =3D transfer->rx_buf;
+	hw->tx_ptr =3D transfer->tx_buf;
+
+	if (0 && transfer->tx_buf) {
+		int i;
+		printk(KERN_DEBUG "transmit 0x%x bytes:", transfer->len);
+		for (i =3D 0; i < transfer->len; i++)
+			printk(" %02x",
+			       ((unsigned char *)transfer->tx_buf)[i]);
+		printk("\n");
+	}
+
+	message =3D list_first_entry(&hw->queue,
+				   struct spi_message, queue);
+
+	spi_s3c24xx_dma_activate(hw, message->spi, transfer);
+
+	if (hw->rx_ptr) {
+		/* Write the first byte of TX data to transfer the
+		 * first byte and to fill the read FIFO. */
+		writel(hw->spcon | S3C2410_SPCON_SMOD_POLL,
+		       hw->regs + S3C2410_SPCON);
+
+		if (hw->tx_ptr)
+			writel(*hw->tx_ptr++, hw->regs + S3C2410_SPTDAT);
+		else
+			writel(0xff, hw->regs + S3C2410_SPTDAT);
+		hw->count--;
+	}
+
+	/* Since there is only one DMA channel available per SPI
+	 * controller, we can only use DMA when doing a transfer in
+	 * one direction, simultaneous transmit and receive would need
+	 * two DMA channels.
+	 */
+	if ((hw->rx_ptr && hw->tx_ptr) || /* if transfer is bidirectional */
+	    !hw->have_dma ||		  /* or DMA is disabled */
+	    hw->count < use_dma || /* or transfer is too small  */
+	    !spi_s3c24xx_dma_start_dma(hw)) /* or dma mapping failed */
+		spi_s3c24xx_dma_start_int(hw); /* fall back to int transfer */
+}
+
+static void spi_s3c24xx_dma_wake(struct spi_s3c24xx_dma_hw *hw)
+{
+	struct spi_message *message =3D NULL;
+	unsigned long flags;
+
+	dev_dbg(hw->dev, "%s\n", __func__);
+
+	spin_lock_irqsave(&hw->queue_lock, flags);
+	if (!hw->transfer && !list_empty(&hw->queue)) {
+		message =3D list_first_entry(&hw->queue,
+					   struct spi_message,
+					   queue);
+		hw->transfer =3D list_first_entry(&message->transfers,
+						struct spi_transfer,
+						transfer_list);
+	}
+	spin_unlock_irqrestore(&hw->queue_lock, flags);
+
+	if (message)
+		spi_s3c24xx_dma_start_transfer(hw);
+}
+
+static int spi_s3c24xx_dma_transfer(struct spi_device *spi,
+				    struct spi_message *message)
+{
+	struct spi_master *master =3D spi->master;
+	struct spi_s3c24xx_dma_hw *hw =3D spi_master_get_devdata(master);
+	struct spi_transfer *transfer;
+	unsigned long flags;
+
+	dev_dbg(hw->dev, "%s\n", __func__);
+
+	message->actual_length =3D 0;
+	message->status =3D -EINPROGRESS;
+
+	list_for_each_entry (transfer, &message->transfers, transfer_list) {
+		dev_dbg(&spi->dev, "%s%s, hz %d, bits %d, len %d, cs %d\n",
+			transfer->rx_buf ? "R":"", transfer->tx_buf ? "W":"",
+			transfer->speed_hz, transfer->bits_per_word,
+			transfer->len, transfer->cs_change);
+
+		if (!transfer->rx_buf && !transfer->tx_buf)
+			return -EINVAL;
+
+		if (transfer->bits_per_word && transfer->bits_per_word !=3D 8)
+			return -EINVAL;
+	}
+
+	spin_lock_irqsave(&hw->queue_lock, flags);
+	list_add_tail(&message->queue, &hw->queue);
+	spin_unlock_irqrestore(&hw->queue_lock, flags);
+
+	spi_s3c24xx_dma_wake(hw);
+
+	return 0;
+}
+
+static void spi_s3c24xx_dma_free(struct spi_master *master)
+{
+	struct spi_s3c24xx_dma_hw *hw =3D spi_master_get_devdata(master);
+
+	dev_set_drvdata(hw->dev, NULL);
+
+	hw->active =3D 0;
+
+	if (hw->have_dma) {
+		int value;
+
+		/* TODO it seems this cleanup can sometimes leave a
+		 * DMA request pending, is there any way to do a
+		 * better cleanup.  */
+
+		s3c2410_dma_ctrl(hw->dmach, S3C2410_DMAOP_FLUSH);
+		msleep(100);
+		s3c2410_dma_ctrl(hw->dmach, S3C2410_DMAOP_STOP);
+		msleep(100);
+
+		writel(S3C2410_SPCON_SMOD_POLL, hw->regs + S3C2410_SPCON);
+		value =3D readb(hw->regs + S3C2410_SPRDAT);
+
+		s3c2410_dma_free(hw->dmach, &spi_s3c24xx_dma_client);
+	}
+	if (hw->irq)
+		free_irq(hw->irq->start, hw);
+	if (hw->regs)
+		iounmap(hw->regs);
+	if (hw->iomem) {
+		release_resource(hw->iomem);
+		kfree(hw->iomem);
+	}
+	if (hw->clk)
+		clk_disable(hw->clk);
+
+	spi_master_put(master);
+}
+
+static int spi_s3c24xx_dma_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct spi_s3c24xx_dma_hw *hw;
+	struct spi_board_info *board;
+	struct spi_master *master;
+	struct resource *res;
+	int ret;
+	int i;
+
+	if (!dev->platform_data) {
+		dev_err(dev, "no platform data available\n");
+		return -EINVAL;
+	}
+
+	master =3D spi_alloc_master(dev, sizeof(*hw));
+	if (!master) {
+		dev_err(dev, "failed to allocate spi_master\n");
+		return -ENOMEM;
+	}
+	platform_set_drvdata(pdev, master);
+
+	hw =3D spi_master_get_devdata(master);
+	memset(hw, 0, sizeof(*hw));
+
+	master->bus_num =3D pdev->id;
+	master->setup =3D spi_s3c24xx_dma_setup;
+	master->transfer =3D spi_s3c24xx_dma_transfer;
+	master->num_chipselect =3D ~0; /* all possible GPIOs */
+
+	hw->spcon =3D S3C2410_SPCON_ENSCK | S3C2410_SPCON_MSTR;
+	hw->cs =3D -1;
+	hw->pdata =3D dev->platform_data;
+	hw->set_cs =3D hw->pdata->set_cs;
+	if (!hw->set_cs)
+		hw->set_cs =3D spi_s3c24xx_dma_default_set_cs;
+	INIT_LIST_HEAD(&hw->queue);
+	spin_lock_init(&hw->queue_lock);
+
+	hw->dev =3D dev;
+
+	hw->clk =3D clk_get(dev, "spi");
+	if (IS_ERR(hw->clk)) {
+		dev_err(dev, "clk_get failed\n");
+		ret =3D -ENOENT;
+		goto out;
+	}
+
+	dev_dbg(dev, "clk %p\n", hw->clk);
+
+	clk_enable(hw->clk);
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "unable to find registers\n");
+		ret =3D -ENOENT;
+		goto out;
+	}
+
+	hw->iomem =3D request_mem_region(res->start,
+				       (res->end-res->start)+1,
+				       pdev->name);
+	if (!hw->iomem) {
+		dev_err(dev, "request_mem_region failed\n");
+		ret =3D -ENXIO;
+		goto out;
+	}
+
+	hw->regs =3D ioremap(res->start, (res->end-res->start)+1);
+	if (!hw->regs) {
+		dev_err(dev, "ioremap failed\n");
+		ret =3D -ENXIO;
+		goto out;
+	}
+
+	writel(255, hw->regs + S3C2410_SPPRE);
+	writel(hw->spcon | S3C2410_SPCON_SMOD_POLL,
+	       hw->regs + S3C2410_SPCON);
+	writel(S3C2410_SPPIN_RESERVED, hw->regs + S3C2410_SPPIN);
+
+	res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get IORESOURCE_IRQ\n");
+		ret =3D -ENOENT;
+		goto out;
+	}
+
+	ret =3D request_irq(res->start, spi_s3c24xx_dma_irq, 0, pdev->name, hw);
+	if (ret) {
+		dev_err(&pdev->dev, "request_irq failed\n");
+		goto out;
+	}
+	hw->irq =3D res;
+
+	if (use_dma) {
+		res =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
+		if (!res) {
+			dev_err(dev, "unable to find dma\n");
+			ret =3D -ENOENT;
+			goto out;
+		}
+		hw->dmach =3D res->start;
+
+		if (s3c2410_dma_request(hw->dmach, &spi_s3c24xx_dma_client,
+					NULL)) {
+			dev_err(dev, "unable to allocate dma channel\n");
+			ret =3D -ENOENT;
+			goto out;
+		}
+		hw->have_dma =3D 1;
+
+		s3c2410_dma_config(hw->dmach, 1, 0);
+		s3c2410_dma_set_buffdone_fn(hw->dmach,
+					    spi_s3c24xx_dma_callback);
+		s3c2410_dma_setflags(hw->dmach, S3C2410_DMAF_AUTOSTART);
+	}
+
+	board =3D hw->pdata->board_info;
+	for (i =3D 0; i < hw->pdata->board_size; i++) {
+		board->controller_data =3D hw;
+		spi_new_device(master, board);
+		board++;
+	}
+
+	hw->active =3D 1;
+
+	ret =3D spi_register_master(master);
+	if (ret) {
+		dev_err(dev, "unable to register spi master\n");
+		goto out;
+	}
+
+	ret =3D 0;
+
+out:
+	if (ret)
+		spi_s3c24xx_dma_free(master);
+
+	return ret;
+}
+
+static int spi_s3c24xx_dma_remove(struct platform_device *pdev)
+{
+	struct spi_master *master =3D spi_master_get(platform_get_drvdata(pdev));
+	struct spi_s3c24xx_dma_hw *hw =3D spi_master_get_devdata(master);
+
+	spi_s3c24xx_dma_deactivate(hw);
+
+	spi_unregister_master(master);
+	spi_s3c24xx_dma_free(master);
+
+	return 0;
+}
+
+static struct platform_driver spi_s3c24xx_dma_driver =3D {
+	.probe		=3D spi_s3c24xx_dma_probe,
+	.remove		=3D spi_s3c24xx_dma_remove,
+	.driver		=3D {
+		.name	=3D "s3c2410-spi",
+		.owner	=3D THIS_MODULE,
+	},
+};
+
+static int __init spi_s3c24xx_dma_init(void)
+{
+	pr_info("S3C24xx SPI DMA driver (c) 2007 Nordnav Technologies AB\n");
+
+	return platform_driver_probe(&spi_s3c24xx_dma_driver,
+				     spi_s3c24xx_dma_probe);
+}
+
+static void __exit spi_s3c24xx_dma_exit(void)
+{
+	platform_driver_unregister(&spi_s3c24xx_dma_driver);
+}
+
+module_init(spi_s3c24xx_dma_init);
+module_exit(spi_s3c24xx_dma_exit);
+
+MODULE_DESCRIPTION("S3C24xx SPI DMA Driver");
+MODULE_LICENSE("GPL");

-- =

Christer Weinigel
CSR Stockholm
Stadsg=E5rden 10
116 45 Stockholm, SWEDEN
+46 703 30 59 31

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
