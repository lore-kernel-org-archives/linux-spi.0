From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: rockchip: check requesting dma channel with EPROBE_DEFER" to the spi tree
Date: Thu, 10 Mar 2016 10:39:34 +0700
Message-ID: <E1adrRm-0007do-Iq@finisterre>
References: <1457511092-2216-1-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457511092-2216-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: rockchip: check requesting dma channel with EPROBE_DEFER

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

>From 61cadcf46cfdb9f7eec70527968c2b91e9823786 Mon Sep 17 00:00:00 2001
From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Date: Wed, 9 Mar 2016 16:11:32 +0800
Subject: [PATCH] spi: rockchip: check requesting dma channel with EPROBE_DEFER

Let's defer probing the driver if the return value of
dma_request_slave_channel is ERR_PTR(-EPROBE_DEFER) instead
of disabling dma capability directly.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-rockchip.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index b6b8a0bb5b2f..795fd191faa7 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -730,8 +730,14 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->handle_err = rockchip_spi_handle_err;
 
 	rs->dma_tx.ch = dma_request_slave_channel(rs->dev, "tx");
-	if (!rs->dma_tx.ch)
+	if (IS_ERR_OR_NULL(rs->dma_tx.ch)) {
+		/* Check tx to see if we need defer probing driver */
+		if (PTR_ERR(rs->dma_tx.ch) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto err_get_fifo_len;
+		}
 		dev_warn(rs->dev, "Failed to request TX DMA channel\n");
+	}
 
 	rs->dma_rx.ch = dma_request_slave_channel(rs->dev, "rx");
 	if (!rs->dma_rx.ch) {
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
