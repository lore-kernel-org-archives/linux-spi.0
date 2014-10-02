From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/3] spi: dw-mid: convert to use DMAengine wrappers
Date: Thu,  2 Oct 2014 16:31:08 +0300
Message-ID: <1412256669-14828-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1412256669-14828-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412256669-14828-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Instead of direct dereference to dmaengine callbacks we are going to use
DMAengine wrappers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 7bdf937..a507add 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -113,8 +113,7 @@ static void dw_spi_dma_done(void *arg)
 
 static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 {
-	struct dma_async_tx_descriptor *txdesc = NULL, *rxdesc = NULL;
-	struct dma_chan *txchan, *rxchan;
+	struct dma_async_tx_descriptor *txdesc, *rxdesc;
 	struct dma_slave_config txconf, rxconf;
 	u16 dma_ctrl = 0;
 
@@ -132,8 +131,6 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 	}
 
 	dws->dma_chan_done = 0;
-	txchan = dws->txchan;
-	rxchan = dws->rxchan;
 
 	/* 2. Prepare the TX dma transfer */
 	txconf.direction = DMA_MEM_TO_DEV;
@@ -143,14 +140,13 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 	txconf.dst_addr_width = dws->dma_width;
 	txconf.device_fc = false;
 
-	txchan->device->device_control(txchan, DMA_SLAVE_CONFIG,
-				       (unsigned long) &txconf);
+	dmaengine_slave_config(dws->txchan, &txconf);
 
 	memset(&dws->tx_sgl, 0, sizeof(dws->tx_sgl));
 	dws->tx_sgl.dma_address = dws->tx_dma;
 	dws->tx_sgl.length = dws->len;
 
-	txdesc = dmaengine_prep_slave_sg(txchan,
+	txdesc = dmaengine_prep_slave_sg(dws->txchan,
 				&dws->tx_sgl,
 				1,
 				DMA_MEM_TO_DEV,
@@ -166,14 +162,13 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 	rxconf.src_addr_width = dws->dma_width;
 	rxconf.device_fc = false;
 
-	rxchan->device->device_control(rxchan, DMA_SLAVE_CONFIG,
-				       (unsigned long) &rxconf);
+	dmaengine_slave_config(dws->rxchan, &rxconf);
 
 	memset(&dws->rx_sgl, 0, sizeof(dws->rx_sgl));
 	dws->rx_sgl.dma_address = dws->rx_dma;
 	dws->rx_sgl.length = dws->len;
 
-	rxdesc = dmaengine_prep_slave_sg(rxchan,
+	rxdesc = dmaengine_prep_slave_sg(dws->rxchan,
 				&dws->rx_sgl,
 				1,
 				DMA_DEV_TO_MEM,
@@ -182,8 +177,8 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 	rxdesc->callback_param = dws;
 
 	/* rx must be started before tx due to spi instinct */
-	rxdesc->tx_submit(rxdesc);
-	txdesc->tx_submit(txdesc);
+	dmaengine_submit(rxdesc);
+	dmaengine_submit(txdesc);
 	return 0;
 }
 
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
