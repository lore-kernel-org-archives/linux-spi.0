From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: rockchip: fix probe deferral handling" to the spi tree
Date: Thu, 31 Mar 2016 12:09:14 -0700
Message-ID: <E1alhxy-00069s-R5@finisterre>
References: <1459393901-18758-1-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
	Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459393901-18758-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: rockchip: fix probe deferral handling

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

>From e4c0e06f949b9493cafe952c3029576b47c2a7c4 Mon Sep 17 00:00:00 2001
From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Date: Thu, 31 Mar 2016 11:11:41 +0800
Subject: [PATCH] spi: rockchip: fix probe deferral handling

Use dma_request_chan instead of dma_request_slave_channel,
in this case we can check EPROBE_DEFER without static
warning.

Reported-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Reviewed-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-rockchip.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index bfeb0d4c7ee0..9713b811a2cd 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -723,23 +723,27 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->transfer_one = rockchip_spi_transfer_one;
 	master->handle_err = rockchip_spi_handle_err;
 
-	rs->dma_tx.ch = dma_request_slave_channel(rs->dev, "tx");
-	if (IS_ERR_OR_NULL(rs->dma_tx.ch)) {
+	rs->dma_tx.ch = dma_request_chan(rs->dev, "tx");
+	if (IS_ERR(rs->dma_tx.ch)) {
 		/* Check tx to see if we need defer probing driver */
 		if (PTR_ERR(rs->dma_tx.ch) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
 			goto err_get_fifo_len;
 		}
 		dev_warn(rs->dev, "Failed to request TX DMA channel\n");
+		rs->dma_tx.ch = NULL;
 	}
 
-	rs->dma_rx.ch = dma_request_slave_channel(rs->dev, "rx");
-	if (!rs->dma_rx.ch) {
-		if (rs->dma_tx.ch) {
+	rs->dma_rx.ch = dma_request_chan(rs->dev, "rx");
+	if (IS_ERR(rs->dma_rx.ch)) {
+		if (PTR_ERR(rs->dma_rx.ch) == -EPROBE_DEFER) {
 			dma_release_channel(rs->dma_tx.ch);
 			rs->dma_tx.ch = NULL;
+			ret = -EPROBE_DEFER;
+			goto err_get_fifo_len;
 		}
 		dev_warn(rs->dev, "Failed to request RX DMA channel\n");
+		rs->dma_rx.ch = NULL;
 	}
 
 	if (rs->dma_tx.ch && rs->dma_rx.ch) {
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
