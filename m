From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 3/3] spi: dw-mid: follow new DMAengine workflow
Date: Thu,  2 Oct 2014 16:31:09 +0300
Message-ID: <1412256669-14828-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1412256669-14828-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412256669-14828-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Though intel-mid-dma does not follow a new DMA workflow (*) let's prepare SPI
DW driver for that.

(*) The client is obliged to call dma_async_issue_pending() which starts the
actual transfers. Old DMA drivers do not follow this, since requirement was
introduced in the discussion of [1].

[1] http://www.spinics.net/lists/arm-kernel/msg125987.html

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index a507add..46c6d58 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -150,7 +150,7 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 				&dws->tx_sgl,
 				1,
 				DMA_MEM_TO_DEV,
-				DMA_PREP_INTERRUPT);
+				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	txdesc->callback = dw_spi_dma_done;
 	txdesc->callback_param = dws;
 
@@ -172,13 +172,17 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 				&dws->rx_sgl,
 				1,
 				DMA_DEV_TO_MEM,
-				DMA_PREP_INTERRUPT);
+				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	rxdesc->callback = dw_spi_dma_done;
 	rxdesc->callback_param = dws;
 
 	/* rx must be started before tx due to spi instinct */
 	dmaengine_submit(rxdesc);
+	dma_async_issue_pending(dws->rxchan);
+
 	dmaengine_submit(txdesc);
+	dma_async_issue_pending(dws->txchan);
+
 	return 0;
 }
 
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
