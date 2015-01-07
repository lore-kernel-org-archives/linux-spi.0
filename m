From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 2/2] spi: dw: print debug message with FIFO size
Date: Wed,  7 Jan 2015 16:56:55 +0200
Message-ID: <1420642615-8986-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1420642615-8986-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420642615-8986-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When autodetection is used it would be useful to know what the FIFO size is.
The patch adds a debug message for this purpose.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 8edcd1b..5a97a62 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -608,7 +608,7 @@ static void dw_spi_cleanup(struct spi_device *spi)
 }
 
 /* Restart the controller, disable all interrupts, clean rx fifo */
-static void spi_hw_init(struct dw_spi *dws)
+static void spi_hw_init(struct device *dev, struct dw_spi *dws)
 {
 	spi_enable_chip(dws, 0);
 	spi_mask_intr(dws, 0xff);
@@ -626,9 +626,10 @@ static void spi_hw_init(struct dw_spi *dws)
 			if (fifo != dw_readw(dws, DW_SPI_TXFLTR))
 				break;
 		}
+		dw_writew(dws, DW_SPI_TXFLTR, 0);
 
 		dws->fifo_len = (fifo == 2) ? 0 : fifo - 1;
-		dw_writew(dws, DW_SPI_TXFLTR, 0);
+		dev_dbg(dev, "Detected FIFO size: %u bytes\n", dws->fifo_len);
 	}
 }
 
@@ -668,7 +669,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	master->dev.of_node = dev->of_node;
 
 	/* Basic HW init */
-	spi_hw_init(dws);
+	spi_hw_init(dev, dws);
 
 	if (dws->dma_ops && dws->dma_ops->dma_init) {
 		ret = dws->dma_ops->dma_init(dws);
@@ -731,7 +732,7 @@ int dw_spi_resume_host(struct dw_spi *dws)
 {
 	int ret;
 
-	spi_hw_init(dws);
+	spi_hw_init(&dws->master->dev, dws);
 	ret = spi_master_resume(dws->master);
 	if (ret)
 		dev_err(&dws->master->dev, "fail to start queue (%d)\n", ret);
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
