From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 05/10] spi: dw: disable all interrupts first when pump message
Date: Thu, 18 Sep 2014 20:08:55 +0300
Message-ID: <1411060140-2801-6-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1411060140-2801-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411060140-2801-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Always disable all interrupts before pump message. Enable them only for PIO
mode.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 0960cc7..d58edfe 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -342,6 +342,13 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 	return dws->transfer_handler(dws);
 }
 
+static void dw_spi_disable_intr(struct dw_spi *dws)
+{
+	spi_enable_chip(dws, 0);
+	spi_mask_intr(dws, 0xff);
+	spi_enable_chip(dws, 1);
+}
+
 /* Must be called inside pump_transfers() */
 static void poll_transfer(struct dw_spi *dws)
 {
@@ -474,6 +481,9 @@ static void pump_transfers(unsigned long data)
 		dws->transfer_handler = interrupt_transfer;
 	}
 
+	/* Disable all interrupts first */
+	dw_spi_disable_intr(dws);
+
 	/*
 	 * Reprogram registers only if
 	 *	1. chip select changes
@@ -490,7 +500,6 @@ static void pump_transfers(unsigned long data)
 		spi_chip_sel(dws, spi, 1);
 
 		/* Set the interrupt mask, for poll mode just disable all int */
-		spi_mask_intr(dws, 0xff);
 		if (imask)
 			spi_umask_intr(dws, imask);
 		if (txint_level)
@@ -611,9 +620,7 @@ static void dw_spi_cleanup(struct spi_device *spi)
 /* Restart the controller, disable all interrupts, clean rx fifo */
 static void spi_hw_init(struct dw_spi *dws)
 {
-	spi_enable_chip(dws, 0);
-	spi_mask_intr(dws, 0xff);
-	spi_enable_chip(dws, 1);
+	dw_spi_disable_intr(dws);
 
 	/*
 	 * Try to detect the FIFO depth if not set by interface driver,
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
