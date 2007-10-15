From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [patch 2.6.23-git] spi doesn't need
	class_device
Date: Mon, 15 Oct 2007 16:09:54 -0700
Message-ID: <20071015160954.c36e273a.akpm@linux-foundation.org>
References: <200710141500.47548.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, tonyj-l3A5Bk7waGM@public.gmane.org,
	Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200710141500.47548.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Sun, 14 Oct 2007 15:00:47 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> From: Tony Jones <tonyj-l3A5Bk7waGM@public.gmane.org>
> 
> Make the SPI framework and drivers stop using class_device.
> Update docs accordingly ... highlighting just which sysfs
> paths should be "safe"/stable.
> 
> Signed-off-by: Tony Jones <tonyj-l3A5Bk7waGM@public.gmane.org>
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

ug.  Half of this patch seems to have got into Greg's tree, as
spi-convert-from-class_device-to-device-for-spi.patch.

patching file drivers/spi/spi.c
Hunk #1 FAILED at 204.
Hunk #2 FAILED at 239.
Hunk #3 FAILED at 338.
Hunk #4 FAILED at 357.
Hunk #5 FAILED at 383.
Hunk #6 FAILED at 415.
Hunk #7 FAILED at 440.
Hunk #8 FAILED at 478.
Hunk #9 FAILED at 495.
9 out of 9 hunks FAILED -- saving rejects to file drivers/spi/spi.c.rej
patching file drivers/spi/spi_lm70llp.c
Hunk #1 FAILED at 82.
1 out of 1 hunk FAILED -- saving rejects to file drivers/spi/spi_lm70llp.c.rej
patching file include/linux/spi/spi.h
Hunk #1 FAILED at 195.
Hunk #2 FAILED at 222.
Hunk #3 FAILED at 268.
Hunk #4 FAILED at 286.
4 out of 4 hunks FAILED -- saving rejects to file include/linux/spi/spi.h.rej
patching file drivers/spi/spi_bitbang.c
Hunk #1 FAILED at 472.
1 out of 1 hunk FAILED -- saving rejects to file drivers/spi/spi_bitbang.c.rej
patching file Documentation/spi/spi-summary
Hunk #1 FAILED at 156.
Hunk #2 FAILED at 345.
Hunk #3 FAILED at 451.
Hunk #4 FAILED at 461.
4 out of 4 hunks FAILED -- saving rejects to file Documentation/spi/spi-summary.rej
patching file drivers/mmc/host/mmc_spi.c
patching file drivers/spi/atmel_spi.c
patching file drivers/spi/mpc52xx_psc_spi.c
patching file drivers/spi/pxa2xx_spi.c
Hunk #1 succeeded at 1242 (offset -1 lines).
patching file drivers/spi/spi_bfin5xx.c
Hunk #1 succeeded at 1106 (offset -1 lines).
patching file drivers/spi/spi_imx.c
patching file drivers/spi/spi_txx9.c

I queued up a patch which re-adds all the missing bits, but one wonders
what happened here?


From: Tony Jones <tonyj-l3A5Bk7waGM@public.gmane.org>

Make the SPI framework and drivers stop using class_device.  Update docs
accordingly ...  highlighting just which sysfs paths should be
"safe"/stable.

Signed-off-by: Tony Jones <tonyj-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
---

 drivers/mmc/host/mmc_spi.c    |    4 ++--
 drivers/spi/atmel_spi.c       |   14 +++++++-------
 drivers/spi/mpc52xx_psc_spi.c |    2 +-
 drivers/spi/pxa2xx_spi.c      |    2 +-
 drivers/spi/spi_bfin5xx.c     |    2 +-
 drivers/spi/spi_imx.c         |    2 +-
 drivers/spi/spi_txx9.c        |    2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff -puN drivers/mmc/host/mmc_spi.c~spi-doesnt-need-class_device drivers/mmc/host/mmc_spi.c
--- a/drivers/mmc/host/mmc_spi.c~spi-doesnt-need-class_device
+++ a/drivers/mmc/host/mmc_spi.c
@@ -1280,8 +1280,8 @@ static int mmc_spi_probe(struct spi_devi
 	if (!host->data)
 		goto fail_nobuf1;
 
-	if (spi->master->cdev.dev->dma_mask) {
-		struct device	*dev = spi->master->cdev.dev;
+	if (spi->master->dev.parent->dma_mask) {
+		struct device	*dev = spi->master->dev.parent;
 
 		host->dma_dev = dev;
 		host->ones_dma = dma_map_single(dev, ones,
diff -puN drivers/spi/atmel_spi.c~spi-doesnt-need-class_device drivers/spi/atmel_spi.c
--- a/drivers/spi/atmel_spi.c~spi-doesnt-need-class_device
+++ a/drivers/spi/atmel_spi.c
@@ -211,7 +211,7 @@ static void atmel_spi_next_message(struc
 	msg = list_entry(as->queue.next, struct spi_message, queue);
 	spi = msg->spi;
 
-	dev_dbg(master->cdev.dev, "start message %p for %s\n",
+	dev_dbg(master->dev.parent, "start message %p for %s\n",
 			msg, spi->dev.bus_id);
 
 	/* select chip if it's not still active */
@@ -266,10 +266,10 @@ static void atmel_spi_dma_unmap_xfer(str
 				     struct spi_transfer *xfer)
 {
 	if (xfer->tx_dma != INVALID_DMA_ADDRESS)
-		dma_unmap_single(master->cdev.dev, xfer->tx_dma,
+		dma_unmap_single(master->dev.parent, xfer->tx_dma,
 				 xfer->len, DMA_TO_DEVICE);
 	if (xfer->rx_dma != INVALID_DMA_ADDRESS)
-		dma_unmap_single(master->cdev.dev, xfer->rx_dma,
+		dma_unmap_single(master->dev.parent, xfer->rx_dma,
 				 xfer->len, DMA_FROM_DEVICE);
 }
 
@@ -285,7 +285,7 @@ atmel_spi_msg_done(struct spi_master *ma
 	list_del(&msg->queue);
 	msg->status = status;
 
-	dev_dbg(master->cdev.dev,
+	dev_dbg(master->dev.parent,
 		"xfer complete: %u bytes transferred\n",
 		msg->actual_length);
 
@@ -348,7 +348,7 @@ atmel_spi_interrupt(int irq, void *dev_i
 		if (xfer->delay_usecs)
 			udelay(xfer->delay_usecs);
 
-		dev_warn(master->cdev.dev, "fifo overrun (%u/%u remaining)\n",
+		dev_warn(master->dev.parent, "fifo overrun (%u/%u remaining)\n",
 			 spi_readl(as, TCR), spi_readl(as, RCR));
 
 		/*
@@ -363,7 +363,7 @@ atmel_spi_interrupt(int irq, void *dev_i
 			if (spi_readl(as, SR) & SPI_BIT(TXEMPTY))
 				break;
 		if (!timeout)
-			dev_warn(master->cdev.dev,
+			dev_warn(master->dev.parent,
 				 "timeout waiting for TXEMPTY");
 		while (spi_readl(as, SR) & SPI_BIT(RDRF))
 			spi_readl(as, RDR);
@@ -526,7 +526,7 @@ static int atmel_spi_transfer(struct spi
 	struct atmel_spi	*as;
 	struct spi_transfer	*xfer;
 	unsigned long		flags;
-	struct device		*controller = spi->master->cdev.dev;
+	struct device		*controller = spi->master->dev.parent;
 
 	as = spi_master_get_devdata(spi->master);
 
diff -puN drivers/spi/mpc52xx_psc_spi.c~spi-doesnt-need-class_device drivers/spi/mpc52xx_psc_spi.c
--- a/drivers/spi/mpc52xx_psc_spi.c~spi-doesnt-need-class_device
+++ a/drivers/spi/mpc52xx_psc_spi.c
@@ -503,7 +503,7 @@ static int __init mpc52xx_psc_spi_do_pro
 	INIT_LIST_HEAD(&mps->queue);
 
 	mps->workqueue = create_singlethread_workqueue(
-		master->cdev.dev->bus_id);
+		master->dev.parent->bus_id);
 	if (mps->workqueue == NULL) {
 		ret = -EBUSY;
 		goto free_irq;
diff -puN drivers/spi/pxa2xx_spi.c~spi-doesnt-need-class_device drivers/spi/pxa2xx_spi.c
--- a/drivers/spi/pxa2xx_spi.c~spi-doesnt-need-class_device
+++ a/drivers/spi/pxa2xx_spi.c
@@ -1242,7 +1242,7 @@ static int __init init_queue(struct driv
 
 	INIT_WORK(&drv_data->pump_messages, pump_messages);
 	drv_data->workqueue = create_singlethread_workqueue(
-					drv_data->master->cdev.dev->bus_id);
+					drv_data->master->dev.parent->bus_id);
 	if (drv_data->workqueue == NULL)
 		return -EBUSY;
 
diff -puN drivers/spi/spi_bfin5xx.c~spi-doesnt-need-class_device drivers/spi/spi_bfin5xx.c
--- a/drivers/spi/spi_bfin5xx.c~spi-doesnt-need-class_device
+++ a/drivers/spi/spi_bfin5xx.c
@@ -1106,7 +1106,7 @@ static inline int init_queue(struct driv
 	/* init messages workqueue */
 	INIT_WORK(&drv_data->pump_messages, pump_messages);
 	drv_data->workqueue =
-	    create_singlethread_workqueue(drv_data->master->cdev.dev->bus_id);
+	    create_singlethread_workqueue(drv_data->master->dev.parent->bus_id);
 	if (drv_data->workqueue == NULL)
 		return -EBUSY;
 
diff -puN drivers/spi/spi_imx.c~spi-doesnt-need-class_device drivers/spi/spi_imx.c
--- a/drivers/spi/spi_imx.c~spi-doesnt-need-class_device
+++ a/drivers/spi/spi_imx.c
@@ -1374,7 +1374,7 @@ static int __init init_queue(struct driv
 
 	INIT_WORK(&drv_data->work, pump_messages);
 	drv_data->workqueue = create_singlethread_workqueue(
-					drv_data->master->cdev.dev->bus_id);
+					drv_data->master->dev.parent->bus_id);
 	if (drv_data->workqueue == NULL)
 		return -EBUSY;
 
diff -puN drivers/spi/spi_txx9.c~spi-doesnt-need-class_device drivers/spi/spi_txx9.c
--- a/drivers/spi/spi_txx9.c~spi-doesnt-need-class_device
+++ a/drivers/spi/spi_txx9.c
@@ -400,7 +400,7 @@ static int __init txx9spi_probe(struct p
 		goto exit;
 	}
 
-	c->workqueue = create_singlethread_workqueue(master->cdev.dev->bus_id);
+	c->workqueue = create_singlethread_workqueue(master->dev.parent->bus_id);
 	if (!c->workqueue)
 		goto exit;
 	c->last_chipselect = -1;
_


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
