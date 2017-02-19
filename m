From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-ti-qspi: Fix error handling" to the spi tree
Date: Sun, 19 Feb 2017 16:35:02 +0000
Message-ID: <E1cfURy-0004ra-Q2@finisterre>
References: <20170218094202.6454-1-christophe.jaillet@wanadoo.fr>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170218094202.6454-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-ti-qspi: Fix error handling

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

>From 30fb27239f987c53429f24297f5d46e28d0e16ed Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sat, 18 Feb 2017 10:42:02 +0100
Subject: [PATCH] spi: spi-ti-qspi: Fix error handling

'dma_request_chan_by_mask()' can not return NULL.
Try to keep the logic in 'no_dma:' by resetting 'qspi->rx_chan' in case
of error.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-ti-qspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index ec6fb09e2e17..0fefa6423ff4 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -714,9 +714,10 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_MEMCPY, mask);
 
 	qspi->rx_chan = dma_request_chan_by_mask(&mask);
-	if (!qspi->rx_chan) {
+	if (IS_ERR(qspi->rx_chan)) {
 		dev_err(qspi->dev,
 			"No Rx DMA available, trying mmap mode\n");
+		qspi->rx_chan = NULL;
 		ret = 0;
 		goto no_dma;
 	}
-- 
2.11.0
