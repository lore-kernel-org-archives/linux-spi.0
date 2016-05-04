From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: rockchip: potential NULL dereference on error" to the spi tree
Date: Wed, 04 May 2016 14:56:56 +0100
Message-ID: <E1axxIO-0001hK-3n@debutante>
References: <20160504062546.GG22064@mwanda>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160504062546.GG22064@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: rockchip: potential NULL dereference on error

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

>From 5de7ed0c980c4bcfd8ea5c0b84a61b76df7d6c08 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 4 May 2016 09:25:46 +0300
Subject: [PATCH] spi: rockchip: potential NULL dereference on error

We were calling dma_release_channel(rs->dma_tx.ch) when "rs->dma_tx.ch"
is potentially NULL.  There is actually a call to that in the unwind
code at the bottom of the function so we can just re-arrange this a bit
and remove the call.  Also there is no need to set rs->dma_tx.ch to
NULL on this error path.

Fixes: e4c0e06f949b ('spi: rockchip: fix probe deferral handling')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 6c6c0013ec7a..cd89682065b9 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -744,10 +744,8 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	rs->dma_rx.ch = dma_request_chan(rs->dev, "rx");
 	if (IS_ERR(rs->dma_rx.ch)) {
 		if (PTR_ERR(rs->dma_rx.ch) == -EPROBE_DEFER) {
-			dma_release_channel(rs->dma_tx.ch);
-			rs->dma_tx.ch = NULL;
 			ret = -EPROBE_DEFER;
-			goto err_get_fifo_len;
+			goto err_free_dma_tx;
 		}
 		dev_warn(rs->dev, "Failed to request RX DMA channel\n");
 		rs->dma_rx.ch = NULL;
@@ -775,10 +773,11 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 err_register_master:
 	pm_runtime_disable(&pdev->dev);
-	if (rs->dma_tx.ch)
-		dma_release_channel(rs->dma_tx.ch);
 	if (rs->dma_rx.ch)
 		dma_release_channel(rs->dma_rx.ch);
+err_free_dma_tx:
+	if (rs->dma_tx.ch)
+		dma_release_channel(rs->dma_tx.ch);
 err_get_fifo_len:
 	clk_disable_unprepare(rs->spiclk);
 err_spiclk_enable:
-- 
2.8.1
