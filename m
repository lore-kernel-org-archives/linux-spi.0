From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: pxa2xx: Use newer more explicit DMAengine terminate API
Date: Thu,  3 Mar 2016 13:02:14 +0200
Message-ID: <1457002934-9671-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Commit b36f09c3c441 ("dmaengine: Add transfer termination
synchronization support") marked dmaengine_terminate_all() as
deprecated and is being replaced by explicit synchronous and asynchronous
terminate functions.

Here DMA termination are done in two cases: FIFO overrun and module
removal.

FIFO overrun is handled in interrupt context and converting
dmaengine_terminate_all() to dmaengine_terminate_async() does the same than
before.

Using synchronous termination in module removal however adds a bit more
robustness as it waits all completion callbacks have finished. Although it
looks all known DMA engines used with spi-pxa2xx don't implement
device_synchronize() callback so this too appears to be a no-op in
practice.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index bd8b369a343c..365fc22c3572 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -254,8 +254,8 @@ irqreturn_t pxa2xx_spi_dma_transfer(struct driver_data *drv_data)
 	if (status & SSSR_ROR) {
 		dev_err(&drv_data->pdev->dev, "FIFO overrun\n");
 
-		dmaengine_terminate_all(drv_data->rx_chan);
-		dmaengine_terminate_all(drv_data->tx_chan);
+		dmaengine_terminate_async(drv_data->rx_chan);
+		dmaengine_terminate_async(drv_data->tx_chan);
 
 		pxa2xx_spi_dma_transfer_complete(drv_data, true);
 		return IRQ_HANDLED;
@@ -331,13 +331,13 @@ int pxa2xx_spi_dma_setup(struct driver_data *drv_data)
 void pxa2xx_spi_dma_release(struct driver_data *drv_data)
 {
 	if (drv_data->rx_chan) {
-		dmaengine_terminate_all(drv_data->rx_chan);
+		dmaengine_terminate_sync(drv_data->rx_chan);
 		dma_release_channel(drv_data->rx_chan);
 		sg_free_table(&drv_data->rx_sgt);
 		drv_data->rx_chan = NULL;
 	}
 	if (drv_data->tx_chan) {
-		dmaengine_terminate_all(drv_data->tx_chan);
+		dmaengine_terminate_sync(drv_data->tx_chan);
 		dma_release_channel(drv_data->tx_chan);
 		sg_free_table(&drv_data->tx_sgt);
 		drv_data->tx_chan = NULL;
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
