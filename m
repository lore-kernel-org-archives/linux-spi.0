From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: drop unncessary dma_is_inited variable" to the spi tree
Date: Fri, 26 Feb 2016 11:47:59 +0900
Message-ID: <E1aZ8Rj-0006aL-WC@finisterre>
References: <1455715739-25161-8-git-send-email-s.hauer@pengutronix.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455715739-25161-8-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: drop unncessary dma_is_inited variable

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

>From 882f329f31cb7317811fe084e0b0642954649bf5 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Date: Wed, 24 Feb 2016 09:20:28 +0100
Subject: [PATCH] spi: imx: drop unncessary dma_is_inited variable

There's no need for an extra dma_is_inited variable when we can
equally well check for the existence of a DMA channel.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index ec033043734a..567a2426e314 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -102,7 +102,6 @@ struct spi_imx_data {
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
 
 	/* DMA */
-	unsigned int dma_is_inited;
 	unsigned int dma_finished;
 	bool usedma;
 	u32 wml;
@@ -205,7 +204,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 
-	if (spi_imx->dma_is_inited && transfer->len >= spi_imx->wml &&
+	if (master->dma_rx && transfer->len >= spi_imx->wml &&
 	    (transfer->len % spi_imx->wml) == 0)
 		return true;
 	return false;
@@ -827,8 +826,6 @@ static void spi_imx_sdma_exit(struct spi_imx_data *spi_imx)
 		dma_release_channel(master->dma_tx);
 		master->dma_tx = NULL;
 	}
-
-	spi_imx->dma_is_inited = 0;
 }
 
 static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
@@ -888,7 +885,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	master->max_dma_len = MAX_SDMA_BD_BYTES;
 	spi_imx->bitbang.master->flags = SPI_MASTER_MUST_RX |
 					 SPI_MASTER_MUST_TX;
-	spi_imx->dma_is_inited = 1;
 
 	return 0;
 err:
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
