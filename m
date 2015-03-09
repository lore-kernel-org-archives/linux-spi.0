From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 3/7] spi: dw-mid: take care of FIFO overrun/underrun when do DMA
Date: Mon,  9 Mar 2015 16:48:47 +0200
Message-ID: <1425912531-23457-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1425912531-23457-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425912531-23457-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In according to documentation SPI in DMA mode may encounter underrun/overrun
failures in rare cases. When such failure occurs, an error recovery protocol is
expected to be implemented in the device driver so that the failed transaction
can be restarted.

This patch enables FIFO overrun / underrun interrupts in DMA case and adds a
handler for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 4b4d266..3729cdd 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -100,6 +100,22 @@ static void mid_spi_dma_exit(struct dw_spi *dws)
 	dma_release_channel(dws->rxchan);
 }
 
+static irqreturn_t dma_transfer(struct dw_spi *dws)
+{
+	u16 irq_status = dw_readw(dws, DW_SPI_ISR);
+
+	if (!irq_status)
+		return IRQ_NONE;
+
+	dw_readw(dws, DW_SPI_ICR);
+	spi_reset_chip(dws);
+
+	dev_err(&dws->master->dev, "%s: FIFO overrun/underrun\n", __func__);
+	dws->master->cur_msg->status = -EIO;
+	spi_finalize_current_transfer(dws->master);
+	return IRQ_HANDLED;
+}
+
 static enum dma_slave_buswidth convert_dma_width(u32 dma_width) {
 	if (dma_width == 1)
 		return DMA_SLAVE_BUSWIDTH_1_BYTE;
@@ -220,6 +236,11 @@ static int mid_spi_dma_setup(struct dw_spi *dws)
 		dma_ctrl |= SPI_DMA_RDMAE;
 	dw_writew(dws, DW_SPI_DMACR, dma_ctrl);
 
+	/* Set the interrupt mask */
+	spi_umask_intr(dws, SPI_INT_TXOI | SPI_INT_RXUI | SPI_INT_RXOI);
+
+	dws->transfer_handler = dma_transfer;
+
 	return 0;
 }
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
