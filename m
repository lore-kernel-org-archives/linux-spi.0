From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: sh-msiof: remove redundant pointer dev" to the spi tree
Date: Fri, 03 Nov 2017 18:50:46 +0000
Message-ID: <E1eAh3G-0005rO-5K@debutante>
References: <20171103135829.8697-1-colin.king@canonical.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171103135829.8697-1-colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: sh-msiof: remove redundant pointer dev

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 6ae6678344af52cf1c05475ff3ec2f43b8b532ef Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Date: Fri, 3 Nov 2017 13:58:29 +0000
Subject: [PATCH] spi: sh-msiof: remove redundant pointer dev

The pointer dev is assigned but never read, hence it is redundant
and can be removed. Cleans up clang warning:

drivers/spi/spi-sh-msiof.c:1198:2: warning: Value stored to 'dev'
is never read

Signed-off-by: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 2c5ea4c57508..66043611e86d 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1190,12 +1190,10 @@ static int sh_msiof_request_dma(struct sh_msiof_spi_priv *p)
 static void sh_msiof_release_dma(struct sh_msiof_spi_priv *p)
 {
 	struct spi_master *master = p->master;
-	struct device *dev;
 
 	if (!master->dma_tx)
 		return;
 
-	dev = &p->pdev->dev;
 	dma_unmap_single(master->dma_rx->device->dev, p->rx_dma_addr,
 			 PAGE_SIZE, DMA_FROM_DEVICE);
 	dma_unmap_single(master->dma_tx->device->dev, p->tx_dma_addr,
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
