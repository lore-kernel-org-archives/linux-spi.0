From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: drop fallback to PIO" to the spi tree
Date: Wed, 24 Feb 2016 17:43:18 +0900
Message-ID: <E1aYV2U-00035l-RZ@finisterre>
References: <1456219438-21205-2-git-send-email-s.hauer@pengutronix.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456219438-21205-2-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: drop fallback to PIO

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

>From 99f1cf1c0c2ccdfa251a55cd28e3004963bf6e1a Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Date: Tue, 23 Feb 2016 10:23:50 +0100
Subject: [PATCH] spi: imx: drop fallback to PIO

At the moment the driver decides to fallback to PIO mode the buffers
are already mapped for DMA. It's a bug to access them with the CPU
afterwards, so we cannot just fallback to PIO mode.
It should not be necessary anyway, since we only use DMA when we
verified that it's possible in the fist place, so when prep_slave_sg
fails it's a bug, either in the SDMA driver or in the can_dma
implementation.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 6497fc9c2735..a61b1b140523 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -945,7 +945,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 					tx->sgl, tx->nents, DMA_MEM_TO_DEV,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc_tx)
-			goto tx_nodma;
+			return -EINVAL;
 
 		desc_tx->callback = spi_imx_dma_tx_callback;
 		desc_tx->callback_param = (void *)spi_imx;
@@ -956,8 +956,10 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 		desc_rx = dmaengine_prep_slave_sg(master->dma_rx,
 					rx->sgl, rx->nents, DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		if (!desc_rx)
-			goto rx_nodma;
+		if (!desc_rx) {
+			dmaengine_terminate_all(master->dma_tx);
+			return -EINVAL;
+		}
 
 		desc_rx->callback = spi_imx_dma_rx_callback;
 		desc_rx->callback_param = (void *)spi_imx;
@@ -1010,12 +1012,6 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 		ret = transfer->len;
 
 	return ret;
-
-rx_nodma:
-	dmaengine_terminate_all(master->dma_tx);
-tx_nodma:
-	dev_warn_once(spi_imx->dev, "DMA not available, falling back to PIO\n");
-	return -EAGAIN;
 }
 
 static int spi_imx_pio_transfer(struct spi_device *spi,
@@ -1042,15 +1038,12 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 static int spi_imx_transfer(struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
-	int ret;
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 
 	if (spi_imx->bitbang.master->can_dma &&
 	    spi_imx_can_dma(spi_imx->bitbang.master, spi, transfer)) {
 		spi_imx->usedma = true;
-		ret = spi_imx_dma_transfer(spi_imx, transfer);
-		if (ret != -EAGAIN)
-			return ret;
+		return spi_imx_dma_transfer(spi_imx, transfer);
 	}
 	spi_imx->usedma = false;
 
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
