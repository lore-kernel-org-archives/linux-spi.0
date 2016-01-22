From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: fix spi resource leak with dma transfer" to the spi tree
Date: Fri, 22 Jan 2016 18:27:10 +0000
Message-ID: <E1aMgQQ-0004Io-Hc@debutante>
References: <1453103041-23197-1-git-send-email-pandy.gao@nxp.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453103041-23197-1-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: fix spi resource leak with dma transfer

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

>From f8efca2f1783050368c71e978ee32d3aa692637b Mon Sep 17 00:00:00 2001
From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Date: Mon, 18 Jan 2016 15:44:01 +0800
Subject: [PATCH] spi: imx: fix spi resource leak with dma transfer

In spi_imx_dma_transfer(), when desc_rx = dmaengine_prep_slave_sg()
fails, the context goes to label no_dma and then return. However,
the memory allocated for desc_tx has not been freed yet, which leads
to resource leak.

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Reviewed-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index d98c33cb64f9..6a4ff27f4357 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -929,7 +929,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 					tx->sgl, tx->nents, DMA_MEM_TO_DEV,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc_tx)
-			goto no_dma;
+			goto tx_nodma;
 
 		desc_tx->callback = spi_imx_dma_tx_callback;
 		desc_tx->callback_param = (void *)spi_imx;
@@ -941,7 +941,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 					rx->sgl, rx->nents, DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc_rx)
-			goto no_dma;
+			goto rx_nodma;
 
 		desc_rx->callback = spi_imx_dma_rx_callback;
 		desc_rx->callback_param = (void *)spi_imx;
@@ -1008,7 +1008,9 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 
 	return ret;
 
-no_dma:
+rx_nodma:
+	dmaengine_terminate_all(master->dma_tx);
+tx_nodma:
 	pr_warn_once("%s %s: DMA not available, falling back to PIO\n",
 		     dev_driver_string(&master->dev),
 		     dev_name(&master->dev));
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
