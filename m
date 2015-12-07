From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: terminate RX DMA transaction in case of TX DMA timeout" to the spi tree
Date: Mon, 07 Dec 2015 19:54:17 +0000
Message-ID: <E1a61rV-0003cr-OU@debutante>
References: <1449334629-4715-2-git-send-email-anton.bondarenko.sama@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449334629-4715-2-git-send-email-anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: terminate RX DMA transaction in case of TX DMA timeout

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

>From e47b33c0765400d38ebaf57908f00abab2488f74 Mon Sep 17 00:00:00 2001
From: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sat, 5 Dec 2015 17:56:59 +0100
Subject: [PATCH] spi: imx: terminate RX DMA transaction in case of TX DMA
 timeout

Not only TX DMA should be terminated, but RX DMA also. It's required
to avoid accidential DMA memory writes from RX DMA channel and properly
terminate transaction.

Signed-off-by: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e7e4f0c0f14d..d6dc66542811 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -968,6 +968,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 			dev_driver_string(&master->dev),
 			dev_name(&master->dev));
 		dmaengine_terminate_all(master->dma_tx);
+		dmaengine_terminate_all(master->dma_rx);
 	} else {
 		timeout = wait_for_completion_timeout(
 				&spi_imx->dma_rx_completion, IMX_DMA_TIMEOUT);
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
