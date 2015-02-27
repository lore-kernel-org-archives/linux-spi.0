From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 2/3] spi: dw: program registers as soon as possible
Date: Fri, 27 Feb 2015 18:36:16 +0200
Message-ID: <1425054977-9859-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1425054977-9859-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425054977-9859-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch refactors the code in pump_transfers() to reprogram the registers
immediately when we have a new configuration data. The behaviour is slightly
modified:
 - chip is always disabled and reenabled
 - CTRL0 is always reprogrammed

This change allows to do a further refactoring and simplier conversion to use
SPI core DMA routines in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 24aaaf98..9bc9c13 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -421,6 +421,8 @@ static void pump_transfers(unsigned long data)
 	if (chip != dws->prev_chip)
 		cs_change = 1;
 
+	spi_enable_chip(dws, 0);
+
 	cr0 = chip->cr0;
 
 	/* Handle per transfer options for bpw and speed */
@@ -435,6 +437,8 @@ static void pump_transfers(unsigned long data)
 
 			chip->speed_hz = speed;
 			chip->clk_div = clk_div;
+
+			spi_set_clk(dws, chip->clk_div);
 		}
 	}
 	if (transfer->bits_per_word) {
@@ -463,44 +467,34 @@ static void pump_transfers(unsigned long data)
 		cr0 |= (chip->tmode << SPI_TMOD_OFFSET);
 	}
 
+	dw_writew(dws, DW_SPI_CTRL0, cr0);
+	spi_chip_sel(dws, spi, 1);
+
 	/* Check if current transfer is a DMA transaction */
 	dws->dma_mapped = map_dma_buffers(dws);
 
 	/*
 	 * Interrupt mode
 	 * we only need set the TXEI IRQ, as TX/RX always happen syncronizely
+	 * Set the interrupt mask, for poll mode just disable all interrupts.
 	 */
-	if (!dws->dma_mapped && !chip->poll_mode) {
+	if (chip->poll_mode) {
+		spi_mask_intr(dws, 0xff);
+	} else if (dws->dma_mapped) {
+		spi_mask_intr(dws, 0xff);
+	} else {
 		txlevel = min_t(u16, dws->fifo_len / 2, dws->len / dws->n_bytes);
+		dw_writew(dws, DW_SPI_TXFLTR, txlevel);
 
+		spi_mask_intr(dws, 0xff);
 		imask |= SPI_INT_TXEI | SPI_INT_TXOI |
 			 SPI_INT_RXUI | SPI_INT_RXOI;
+		spi_umask_intr(dws, imask);
+
 		dws->transfer_handler = interrupt_transfer;
 	}
 
-	/*
-	 * Reprogram registers only if
-	 *	1. chip select changes
-	 *	2. clk_div is changed
-	 *	3. control value changes
-	 */
-	if (dw_readw(dws, DW_SPI_CTRL0) != cr0 || cs_change || clk_div || imask) {
-		spi_enable_chip(dws, 0);
-
-		dw_writew(dws, DW_SPI_CTRL0, cr0);
-
-		spi_set_clk(dws, chip->clk_div);
-		spi_chip_sel(dws, spi, 1);
-
-		/* Set the interrupt mask, for poll mode just disable all int */
-		spi_mask_intr(dws, 0xff);
-		if (imask)
-			spi_umask_intr(dws, imask);
-		if (txlevel)
-			dw_writew(dws, DW_SPI_TXFLTR, txlevel);
-
-		spi_enable_chip(dws, 1);
-	}
+	spi_enable_chip(dws, 1);
 
 	if (cs_change)
 		dws->prev_chip = chip;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
