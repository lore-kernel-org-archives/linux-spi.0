From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: rockchip: migrate to dmaengine_terminate_async" to the spi tree
Date: Thu, 10 Mar 2016 10:39:36 +0700
Message-ID: <E1adrRo-0007eH-76@finisterre>
References: <1457511083-2175-1-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457511083-2175-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: rockchip: migrate to dmaengine_terminate_async

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

>From 557b7ea34b9a10a5e13f4d7fd58ac965d801e3bd Mon Sep 17 00:00:00 2001
From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Date: Wed, 9 Mar 2016 16:11:23 +0800
Subject: [PATCH] spi: rockchip: migrate to dmaengine_terminate_async

dmaengine_terminate_all is deprecated, let's use
dmaengine_terminate_async for interrupt handling.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index aa8528e9840c..b6b8a0bb5b2f 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -322,12 +322,12 @@ static void rockchip_spi_handle_err(struct spi_master *master,
 	 */
 	if (rs->use_dma) {
 		if (rs->state & RXBUSY) {
-			dmaengine_terminate_all(rs->dma_rx.ch);
+			dmaengine_terminate_async(rs->dma_rx.ch);
 			flush_fifo(rs);
 		}
 
 		if (rs->state & TXBUSY)
-			dmaengine_terminate_all(rs->dma_tx.ch);
+			dmaengine_terminate_async(rs->dma_tx.ch);
 	}
 
 	spin_unlock_irqrestore(&rs->lock, flags);
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
