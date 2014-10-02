From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/3] spi: dw-mid: change magic numbers to the constants
Date: Thu,  2 Oct 2014 16:31:07 +0300
Message-ID: <1412256669-14828-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Instead of using magic numbers in the code we create a bit map definition of
the DMACR register and use it.

There is no functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 4 ++--
 drivers/spi/spi-dw.h     | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index ecae30f..7bdf937 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -124,9 +124,9 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 		dw_writew(dws, DW_SPI_DMARDLR, 0xf);
 		dw_writew(dws, DW_SPI_DMATDLR, 0x10);
 		if (dws->tx_dma)
-			dma_ctrl |= 0x2;
+			dma_ctrl |= SPI_DMA_TDMAE;
 		if (dws->rx_dma)
-			dma_ctrl |= 0x1;
+			dma_ctrl |= SPI_DMA_RDMAE;
 		dw_writew(dws, DW_SPI_DMACR, dma_ctrl);
 		spi_enable_chip(dws, 1);
 	}
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 089fc4b..83a103a 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -74,6 +74,10 @@
 #define SPI_INT_RXFI			(1 << 4)
 #define SPI_INT_MSTI			(1 << 5)
 
+/* Bit fields in DMACR */
+#define SPI_DMA_RDMAE			(1 << 0)
+#define SPI_DMA_TDMAE			(1 << 1)
+
 /* TX RX interrupt level threshold, max can be 256 */
 #define SPI_INT_THRESHOLD		32
 
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
