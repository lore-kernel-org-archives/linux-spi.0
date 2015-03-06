From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2, resend for stable 1/1] spi: dw-mid: clear BUSY flag fist and test other one
Date: Fri,  6 Mar 2015 14:42:01 +0200
Message-ID: <1425645721-18142-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The logic of DMA completion is broken now since test_and_clear_bit() never
returns the other bit is set. It means condition are always false and we have
spi_finalize_current_transfer() called per each DMA completion which is wrong.

The patch fixes logic by clearing BUSY bit first and then check for the other
one.

Fixes: 30c8eb52cc4a (spi: dw-mid: split rx and tx callbacks when DMA)
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 3ce39d1..4f8c798 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -108,7 +108,8 @@ static void dw_spi_dma_tx_done(void *arg)
 {
 	struct dw_spi *dws = arg;
 
-	if (test_and_clear_bit(TX_BUSY, &dws->dma_chan_busy) & BIT(RX_BUSY))
+	clear_bit(TX_BUSY, &dws->dma_chan_busy);
+	if (test_bit(RX_BUSY, &dws->dma_chan_busy))
 		return;
 	dw_spi_xfer_done(dws);
 }
@@ -156,7 +157,8 @@ static void dw_spi_dma_rx_done(void *arg)
 {
 	struct dw_spi *dws = arg;
 
-	if (test_and_clear_bit(RX_BUSY, &dws->dma_chan_busy) & BIT(TX_BUSY))
+	clear_bit(RX_BUSY, &dws->dma_chan_busy);
+	if (test_bit(TX_BUSY, &dws->dma_chan_busy))
 		return;
 	dw_spi_xfer_done(dws);
 }
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
