From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi/topcliff-pch: Delete an unnecessary return statement in two functions" to the spi tree
Date: Tue, 17 Jan 2017 18:45:51 +0000
Message-ID: <E1cTYlT-0000Ka-Qs@debutante>
References: <64b7bf49-57fc-32a9-17e4-1b26b99bff13@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <64b7bf49-57fc-32a9-17e4-1b26b99bff13@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi/topcliff-pch: Delete an unnecessary return statement in two functions

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

>From 6ceb3b27b1edd1112f1879cc1f149d39a3da2dc2 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 15:57:03 +0100
Subject: [PATCH] spi/topcliff-pch: Delete an unnecessary return statement in
 two functions

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such statements here.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index fcb991034c3d..250452a6eead 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -915,7 +915,6 @@ static void pch_spi_release_dma(struct pch_spi_data *data)
 		dma_release_channel(dma->chan_rx);
 		dma->chan_rx = NULL;
 	}
-	return;
 }
 
 static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
@@ -1292,7 +1291,6 @@ static void pch_free_dma_buf(struct pch_spi_board_data *board_dat,
 	if (dma->rx_buf_dma)
 		dma_free_coherent(&board_dat->pdev->dev, PCH_BUF_SIZE,
 				  dma->rx_buf_virt, dma->rx_buf_dma);
-	return;
 }
 
 static void pch_alloc_dma_buf(struct pch_spi_board_data *board_dat,
-- 
2.11.0
