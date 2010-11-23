From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dw_spi: add DMA support
Date: Tue, 23 Nov 2010 17:53:31 +0800
Message-ID: <20101123175331.3d7ed427@feng-i7>
References: <20101118200935.26334.53708.stgit@localhost.localdomain>
	<AANLkTik8v=H=exeOO93Q_oOxVU=snck_SGWDXuy+-db7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi mailing list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Williams,
	Dan J" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTik8v=H=exeOO93Q_oOxVU=snck_SGWDXuy+-db7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org



On Tue, 23 Nov 2010 14:48:39 +0800
Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> This is much better than last time but I still have questions...
> =

> 2010/11/18 Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>:
> =

> > + =A0 =A0 =A0 /* 1. Init rx channel */
> > + =A0 =A0 =A0 rxs =3D &dw_dma->dmas_rx;
> > + =A0 =A0 =A0 ds =3D &rxs->dma_slave;
> > + =A0 =A0 =A0 ds->direction =3D DMA_FROM_DEVICE;
> > + =A0 =A0 =A0 rxs->hs_mode =3D LNW_DMA_HW_HS;
> > + =A0 =A0 =A0 rxs->cfg_mode =3D LNW_DMA_PER_TO_MEM;
> > + =A0 =A0 =A0 ds->src_addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
> > + =A0 =A0 =A0 ds->dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> > + =A0 =A0 =A0 ds->src_maxburst =3D 16;
> > + =A0 =A0 =A0 ds->dst_maxburst =3D 16;
> =

> This is great stuff! That is exactly how ds is to be set up.
> I would prefer that you don't dereference the this rxs thing here
> but whatever.
> =

> > + =A0 =A0 =A0 dma_cap_zero(mask);
> > + =A0 =A0 =A0 dma_cap_set(DMA_MEMCPY, mask);
> > + =A0 =A0 =A0 dma_cap_set(DMA_SLAVE, mask);
> =

> This is not elegant. Are you going to do memcpy() or slave
> transfers? What you want to do is fix your DMA engine so that
> just asking for DMA_SLAVE works.
> =

> > + =A0 =A0 =A0 dma_cap_set(DMA_SLAVE, mask);
> > + =A0 =A0 =A0 dma_cap_set(DMA_MEMCPY, mask);
> =

> Here again...
> =

> > +static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
> > +{
> (...)
> > + =A0 =A0 =A0 flag =3D DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
> > + =A0 =A0 =A0 if (dws->tx_dma) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 txdesc =3D
> > txchan->device->device_prep_dma_memcpy(txchan,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dws->dma_=
addr, dws->tx_dma,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dws->len,=
 flag);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 txdesc->callback =3D dw_spi_dma_done;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 txdesc->callback_param =3D &dws->tx_param;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 /* 3. start the RX dma transfer */
> > + =A0 =A0 =A0 if (dws->rx_dma) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rxdesc =3D
> > rxchan->device->device_prep_dma_memcpy(rxchan,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dws->rx_d=
ma, dws->dma_addr,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dws->len,=
 flag);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rxdesc->callback =3D dw_spi_dma_done;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rxdesc->callback_param =3D &dws->rx_param;
> > + =A0 =A0 =A0 }
> =

> Using device_prep_dma_memcpy() for this is still nonsense, it should
> be device_prep_slave_sg().
> =

> I know the DMA driver needs fixing in order for this to work properly,
> so why not fix it?
> =

> These are the most important concerns I raised last iteration, so
> I challenge you to fix drivers/dma/dw_dmac.c or wherever the real
> problem sits.
> =

> Can you describe where the problem with fixing this to use real
> slave sglists is?
> =

> Yours,
> Linus Walleij

Hi Linus,

Thanks for the reviews, I made some dma change as you suggested, pls
help to review.

Thanks,
Feng

>From b77efc5945e31442b53b285d6a3f77def376ebb3 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date: Tue, 23 Nov 2010 17:34:28 +0800
Subject: [PATCH]     spi/dw_spi: add DMA support

    dw_spi driver in upstream only supports PIO mode, and this patch
    will support it to cowork with the Designware DMA controller used
    on Intel Moorestown platform

    It has been tested with a Option GTM501L 3G modem, to use DMA mode,
    DMA controller 2 of Moorestown has to be enabled

    Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    [Typo fix and renames to match intel_mid_dma renaming]
    Signed-off-by: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    [Clean up, change dma interface suggested by Linus Walleij]
    Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    [Fix timing delay, add cpu_relax]
    Signed-off-by: Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
    Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/Kconfig        |    4 +
 drivers/spi/Makefile       |    3 +-
 drivers/spi/dw_spi.c       |   48 ++++++----
 drivers/spi/dw_spi_mid.c   |  225 ++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/spi/dw_spi_pci.c   |   14 ++-
 include/linux/spi/dw_spi.h |   24 ++++-
 6 files changed, 288 insertions(+), 30 deletions(-)
 create mode 100644 drivers/spi/dw_spi_mid.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 78f9fd0..d53c830 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -396,6 +396,10 @@ config SPI_DW_PCI
 	tristate "PCI interface driver for DW SPI core"
 	depends on SPI_DESIGNWARE && PCI
 =

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
@@ -17,7 +17,8 @@ obj-$(CONFIG_SPI_BUTTERFLY)		+=3D spi_butterfly.o
 obj-$(CONFIG_SPI_COLDFIRE_QSPI)		+=3D coldfire_qspi.o
 obj-$(CONFIG_SPI_DAVINCI)		+=3D davinci_spi.o
 obj-$(CONFIG_SPI_DESIGNWARE)		+=3D dw_spi.o
-obj-$(CONFIG_SPI_DW_PCI)		+=3D dw_spi_pci.o
+obj-$(CONFIG_SPI_DW_PCI)		+=3D dw_spi_midpci.o
+dw_spi_midpci-objs			:=3D dw_spi_pci.o dw_spi_mid.o
 obj-$(CONFIG_SPI_DW_MMIO)		+=3D dw_spi_mmio.o
 obj-$(CONFIG_SPI_EP93XX)		+=3D ep93xx_spi.o
 obj-$(CONFIG_SPI_GPIO)			+=3D spi_gpio.o
diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
index 9043931..69cc223 100644
--- a/drivers/spi/dw_spi.c
+++ b/drivers/spi/dw_spi.c
@@ -164,20 +164,23 @@ static inline void mrst_spi_debugfs_remove(struct dw_=
spi *dws)
 =

 static void wait_till_not_busy(struct dw_spi *dws)
 {
-	unsigned long end =3D jiffies + 1 + usecs_to_jiffies(1000);
+	unsigned long end =3D jiffies + 1 + usecs_to_jiffies(5000);
 =

 	while (time_before(jiffies, end)) {
 		if (!(dw_readw(dws, sr) & SR_BUSY))
 			return;
+		cpu_relax();
 	}
 	dev_err(&dws->master->dev,
-		"DW SPI: Status keeps busy for 1000us after a read/write!\n");
+		"DW SPI: Status keeps busy for 5000us after a read/write!\n");
 }
 =

 static void flush(struct dw_spi *dws)
 {
-	while (dw_readw(dws, sr) & SR_RF_NOT_EMPT)
+	while (dw_readw(dws, sr) & SR_RF_NOT_EMPT) {
 		dw_readw(dws, dr);
+		cpu_relax();
+	}
 =

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
 =

 	if (dws->cur_transfer->tx_dma)
@@ -338,7 +343,7 @@ static void int_error_stop(struct dw_spi *dws, const ch=
ar *msg)
 	tasklet_schedule(&dws->pump_transfers);
 }
 =

-static void transfer_complete(struct dw_spi *dws)
+void dw_spi_xfer_done(struct dw_spi *dws)
 {
 	/* Update total byte transfered return count actual bytes read */
 	dws->cur_msg->actual_length +=3D dws->len;
@@ -353,6 +358,7 @@ static void transfer_complete(struct dw_spi *dws)
 	} else
 		tasklet_schedule(&dws->pump_transfers);
 }
+EXPORT_SYMBOL_GPL(dw_spi_xfer_done);
 =

 static irqreturn_t interrupt_transfer(struct dw_spi *dws)
 {
@@ -384,7 +390,7 @@ static irqreturn_t interrupt_transfer(struct dw_spi *dw=
s)
 		if (dws->tx_end > dws->tx)
 			spi_umask_intr(dws, SPI_INT_TXEI);
 		else
-			transfer_complete(dws);
+			dw_spi_xfer_done(dws);
 	}
 =

 	return IRQ_HANDLED;
@@ -414,11 +420,7 @@ static void poll_transfer(struct dw_spi *dws)
 	while (dws->write(dws))
 		dws->read(dws);
 =

-	transfer_complete(dws);
-}
-
-static void dma_transfer(struct dw_spi *dws, int cs_change)
-{
+	dw_spi_xfer_done(dws);
 }
 =

 static void pump_transfers(unsigned long data)
@@ -600,7 +602,7 @@ static void pump_transfers(unsigned long data)
 	}
 =

 	if (dws->dma_mapped)
-		dma_transfer(dws, cs_change);
+		dws->dma_ops->dma_transfer(dws, cs_change);
 =

 	if (chip->poll_mode)
 		poll_transfer(dws);
@@ -896,11 +898,15 @@ int __devinit dw_spi_add_host(struct dw_spi *dws)
 	master->setup =3D dw_spi_setup;
 	master->transfer =3D dw_spi_transfer;
 =

-	dws->dma_inited =3D 0;
-
 	/* Basic HW init */
 	spi_hw_init(dws);
 =

+	if (dws->dma_ops && dws->dma_ops->dma_init) {
+		ret =3D dws->dma_ops->dma_init(dws);
+		if (ret)
+			goto err_diable_hw;
+	}
+
 	/* Initial and start queue */
 	ret =3D init_queue(dws);
 	if (ret) {
@@ -925,6 +931,8 @@ int __devinit dw_spi_add_host(struct dw_spi *dws)
 =

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
 =

 void __devexit dw_spi_remove_host(struct dw_spi *dws)
 {
@@ -949,6 +957,8 @@ void __devexit dw_spi_remove_host(struct dw_spi *dws)
 		dev_err(&dws->master->dev, "dw_spi_remove: workqueue will not "
 			"complete, message memory not freed\n");
 =

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
 =

 int dw_spi_suspend_host(struct dw_spi *dws)
 {
@@ -970,7 +980,7 @@ int dw_spi_suspend_host(struct dw_spi *dws)
 	spi_set_clk(dws, 0);
 	return ret;
 }
-EXPORT_SYMBOL(dw_spi_suspend_host);
+EXPORT_SYMBOL_GPL(dw_spi_suspend_host);
 =

 int dw_spi_resume_host(struct dw_spi *dws)
 {
@@ -982,7 +992,7 @@ int dw_spi_resume_host(struct dw_spi *dws)
 		dev_err(&dws->master->dev, "fail to start queue (%d)\n", ret);
 	return ret;
 }
-EXPORT_SYMBOL(dw_spi_resume_host);
+EXPORT_SYMBOL_GPL(dw_spi_resume_host);
 =

 MODULE_AUTHOR("Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
 MODULE_DESCRIPTION("Driver for DesignWare SPI controller core");
diff --git a/drivers/spi/dw_spi_mid.c b/drivers/spi/dw_spi_mid.c
new file mode 100644
index 0000000..e60a8a5
--- /dev/null
+++ b/drivers/spi/dw_spi_mid.c
@@ -0,0 +1,225 @@
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
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
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
+	struct dw_spi *dws =3D param;
+
+	if (dws->dmac && &dws->dmac->dev =3D=3D chan->device->dev)
+		return true;
+	else
+		return false;
+}
+
+static int mid_spi_dma_init(struct dw_spi *dws)
+{
+	struct mid_dma *dw_dma =3D dws->dma_priv;
+	struct intel_mid_dma_slave *rxs, *txs;
+	dma_cap_mask_t mask;
+
+	/* Get pci device for DMA */
+	dws->dmac =3D pci_get_device(PCI_VENDOR_ID_INTEL, 0x813, NULL);
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	/* 1. Init rx channel */
+	dws->rxchan =3D dma_request_channel(mask, mid_spi_dma_chan_filter, dws);
+	if (!dws->rxchan)
+		goto err_exit;
+	rxs =3D &dw_dma->dmas_rx;
+	rxs->hs_mode =3D LNW_DMA_HW_HS;
+	rxs->cfg_mode =3D LNW_DMA_PER_TO_MEM;
+	dws->rxchan->private =3D rxs;
+
+	/* 2. Init tx channel */
+	dws->txchan =3D dma_request_channel(mask, mid_spi_dma_chan_filter, dws);
+	if (!dws->txchan)
+		goto free_rxchan;
+	txs =3D &dw_dma->dmas_tx;
+	txs->hs_mode =3D LNW_DMA_HW_HS;
+	txs->cfg_mode =3D LNW_DMA_MEM_TO_PER;
+	dws->txchan->private =3D txs;
+
+	dws->dma_inited =3D 1;
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
+	struct dw_spi *dws =3D arg;
+
+	if (++dws->dma_chan_done !=3D 2)
+		return;
+	dw_spi_xfer_done(dws);
+}
+
+static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
+{
+	struct dma_async_tx_descriptor *txdesc =3D NULL, *rxdesc =3D NULL;
+	struct dma_chan *txchan, *rxchan;
+	struct dma_slave_config txconf, rxconf;
+	u16 dma_ctrl =3D 0;
+
+	/* 1. setup DMA related registers */
+	if (cs_change) {
+		spi_enable_chip(dws, 0);
+		dw_writew(dws, dmardlr, 0xf);
+		dw_writew(dws, dmatdlr, 0x10);
+		if (dws->tx_dma)
+			dma_ctrl |=3D 0x2;
+		if (dws->rx_dma)
+			dma_ctrl |=3D 0x1;
+		dw_writew(dws, dmacr, dma_ctrl);
+		spi_enable_chip(dws, 1);
+	}
+
+	dws->dma_chan_done =3D 0;
+	txchan =3D dws->txchan;
+	rxchan =3D dws->rxchan;
+
+	/* 2. Prepare the TX dma transfer */
+	txconf.direction =3D DMA_TO_DEVICE;
+	txconf.dst_addr =3D dws->dma_addr;
+	txconf.dst_maxburst =3D LNW_DMA_MSIZE_16;
+	txconf.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
+	txconf.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
+
+	txchan->device->device_control(txchan, DMA_SLAVE_CONFIG,
+				       (unsigned long) &txconf);
+
+	memset(&dws->tx_sgl, 0, sizeof(dws->tx_sgl));
+	dws->tx_sgl.dma_address =3D dws->tx_dma;
+	dws->tx_sgl.length =3D dws->len;
+
+	txdesc =3D txchan->device->device_prep_slave_sg(txchan,
+				&dws->tx_sgl,
+				1,
+				DMA_TO_DEVICE,
+				DMA_PREP_INTERRUPT | DMA_COMPL_SKIP_DEST_UNMAP);
+	txdesc->callback =3D dw_spi_dma_done;
+	txdesc->callback_param =3D dws;
+
+	/* 3. Prepare the RX dma transfer */
+	rxconf.direction =3D DMA_FROM_DEVICE;
+	rxconf.src_addr =3D dws->dma_addr;
+	rxconf.src_maxburst =3D LNW_DMA_MSIZE_16;
+	rxconf.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
+	rxconf.src_addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
+
+	rxchan->device->device_control(rxchan, DMA_SLAVE_CONFIG,
+				       (unsigned long) &rxconf);
+
+	memset(&dws->rx_sgl, 0, sizeof(dws->rx_sgl));
+	dws->rx_sgl.dma_address =3D dws->rx_dma;
+	dws->rx_sgl.length =3D dws->len;
+
+	rxdesc =3D rxchan->device->device_prep_slave_sg(rxchan,
+				&dws->rx_sgl,
+				1,
+				DMA_FROM_DEVICE,
+				DMA_PREP_INTERRUPT | DMA_COMPL_SKIP_DEST_UNMAP);
+	rxdesc->callback =3D dw_spi_dma_done;
+	rxdesc->callback_param =3D dws;
+
+	/* rx must be started before tx due to spi instinct */
+	rxdesc->tx_submit(rxdesc);
+	txdesc->tx_submit(txdesc);
+	return 0;
+}
+
+static struct dw_spi_dma_ops mid_dma_ops =3D {
+	.dma_init	=3D mid_spi_dma_init,
+	.dma_exit	=3D mid_spi_dma_exit,
+	.dma_transfer	=3D mid_spi_dma_transfer,
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
+	clk_reg =3D ioremap_nocache(MRST_CLK_SPI0_REG, 16);
+	if (!clk_reg)
+		return -ENOMEM;
+
+	/* get SPI controller operating freq info */
+	clk_cdiv  =3D ((*clk_reg) & CLK_SPI_CDIV_MASK) >> CLK_SPI_CDIV_OFFSET;
+	dws->max_freq =3D MRST_SPI_CLK_BASE / (clk_cdiv + 1);
+	iounmap(clk_reg);
+
+	dws->num_cs =3D 16;
+	dws->fifo_len =3D 40;	/* FIFO has 40 words buffer */
+
+#ifdef CONFIG_SPI_DW_MID_DMA
+	dws->dma_priv =3D kzalloc(sizeof(struct mid_dma), GFP_KERNEL);
+	if (!dws->dma_priv)
+		return -ENOMEM;
+	dws->dma_ops =3D &mid_dma_ops;
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
 =

 struct dw_spi_pci {
-	struct pci_dev		*pdev;
-	struct dw_spi		dws;
+	struct pci_dev	*pdev;
+	struct dw_spi	dws;
 };
 =

 static int __devinit spi_pci_probe(struct pci_dev *pdev,
@@ -72,9 +72,13 @@ static int __devinit spi_pci_probe(struct pci_dev *pdev,
 	dws->parent_dev =3D &pdev->dev;
 	dws->bus_num =3D 0;
 	dws->num_cs =3D 4;
-	dws->max_freq =3D 25000000;	/* for Moorestwon */
 	dws->irq =3D pdev->irq;
-	dws->fifo_len =3D 40;		/* FIFO has 40 words buffer */
+
+	if (pdev->device =3D=3D 0x0800) {
+		ret =3D dw_spi_mid_init(dws);
+		if (ret)
+			goto err_unmap;
+	}
 =

 	ret =3D dw_spi_add_host(dws);
 	if (ret)
diff --git a/include/linux/spi/dw_spi.h b/include/linux/spi/dw_spi.h
index c91302f..95a9653 100644
--- a/include/linux/spi/dw_spi.h
+++ b/include/linux/spi/dw_spi.h
@@ -1,5 +1,6 @@
 #ifndef DW_SPI_HEADER_H
 #define DW_SPI_HEADER_H
+
 #include <linux/io.h>
 =

 /* Bit fields in CTRLR0 */
@@ -82,6 +83,13 @@ struct dw_spi_reg {
 				though only low 16 bits matters */
 } __packed;
 =

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
+	dma_addr_t		dma_addr;  /* phy addr of the Data register */
+	struct dw_spi_dma_ops	*dma_ops;
+	void			*dma_priv; /* platform relate info */
+	struct pci_dev		*dmac;
 =

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
-- =

1.7.0.4


---------------------------------------------------------------------------=
---
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
