From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH 4/5] spi: spi-imx: cleanup wait_for_completion handling
Date: Mon,  2 Feb 2015 03:30:35 -0500
Message-ID: <1422865837-10357-4-git-send-email-hofrat@osadl.org>
References: <1422865837-10357-1-git-send-email-hofrat@osadl.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422865837-10357-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

return type of wait_for_completion_timeout is unsigned long not int and
always returns >=0 , this patch adds a suitable return variable and
simplifies the return value checking as there is no < 0 case.

Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
---

The return type of wait_for_completion_timeout is unsigned long not
int. This patch resolves the type missmatch by adding an appropriately
type return variable as well as simplifying the return value checking.
If the return was not 0 it only can be positive so the > 0 check is
unnecessary.

This patch was only compile tested with imx_v6_v7_defconfig
(implies CONFIG_SPI_IMX=y)

Patch is against 3.19.0-rc6 -next-20150130

 drivers/spi/spi-imx.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 6a2ff75..5eaecbb 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -891,6 +891,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 {
 	struct dma_async_tx_descriptor *desc_tx = NULL, *desc_rx = NULL;
 	int ret;
+	unsigned long timeout;
 	u32 dma;
 	int left;
 	struct spi_master *master = spi_imx->bitbang.master;
@@ -938,17 +939,17 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	dma_async_issue_pending(master->dma_tx);
 	dma_async_issue_pending(master->dma_rx);
 	/* Wait SDMA to finish the data transfer.*/
-	ret = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
+	timeout = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
 						IMX_DMA_TIMEOUT);
-	if (!ret) {
+	if (!timeout) {
 		pr_warn("%s %s: I/O Error in DMA TX\n",
 			dev_driver_string(&master->dev),
 			dev_name(&master->dev));
 		dmaengine_terminate_all(master->dma_tx);
 	} else {
-		ret = wait_for_completion_timeout(&spi_imx->dma_rx_completion,
-				IMX_DMA_TIMEOUT);
-		if (!ret) {
+		timeout = wait_for_completion_timeout(
+				&spi_imx->dma_rx_completion, IMX_DMA_TIMEOUT);
+		if (!timeout) {
 			pr_warn("%s %s: I/O Error in DMA RX\n",
 				dev_driver_string(&master->dev),
 				dev_name(&master->dev));
@@ -963,9 +964,9 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	spi_imx->dma_finished = 1;
 	spi_imx->devtype_data->trigger(spi_imx);
 
-	if (!ret)
+	if (!timeout)
 		ret = -ETIMEDOUT;
-	else if (ret > 0)
+	else
 		ret = transfer->len;
 
 	return ret;
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
