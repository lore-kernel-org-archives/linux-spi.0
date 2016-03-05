From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Use newer more explicit DMAengine terminate API" to the spi tree
Date: Sat, 05 Mar 2016 21:26:06 +0900
Message-ID: <E1acBHa-0003Xj-Mp@finisterre>
References: <1457002934-9671-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457002934-9671-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Use newer more explicit DMAengine terminate API

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 590745017ef3658b33a581fe0c6d60b70e92df85 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Thu, 3 Mar 2016 13:02:14 +0200
Subject: [PATCH] spi: pxa2xx: Use newer more explicit DMAengine terminate API

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
Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
