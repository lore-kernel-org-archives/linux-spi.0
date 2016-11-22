From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-topcliff-pch: Remove some dead code" to the spi tree
Date: Tue, 22 Nov 2016 17:27:01 +0000
Message-ID: <E1c9EqT-00060I-CX@debutante>
References: <20161118224927.12889-1-christophe.jaillet@wanadoo.fr>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161118224927.12889-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-topcliff-pch: Remove some dead code

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

>From 9677e7dd1c799d1720d242d0aa0aee8490637eae Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Fri, 18 Nov 2016 23:49:27 +0100
Subject: [PATCH] spi: spi-topcliff-pch: Remove some dead code

Since commit 0d35773979b9 ("spi: spi-topcliff-pch: Remove deprecated
create_singlethread_workqueue"), 'retval' is no more used in this function.

So some now dead code can be removed.
Also axe a debug message which looks useless now.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index c54ee6674471..fcb991034c3d 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1268,11 +1268,8 @@ static void pch_spi_free_resources(struct pch_spi_board_data *board_dat,
 static int pch_spi_get_resources(struct pch_spi_board_data *board_dat,
 				 struct pch_spi_data *data)
 {
-	int retval = 0;
-
 	dev_dbg(&board_dat->pdev->dev, "%s ENTRY\n", __func__);
 
-
 	/* reset PCH SPI h/w */
 	pch_spi_reset(data->master);
 	dev_dbg(&board_dat->pdev->dev,
@@ -1280,15 +1277,7 @@ static int pch_spi_get_resources(struct pch_spi_board_data *board_dat,
 
 	dev_dbg(&board_dat->pdev->dev, "%s data->irq_reg_sts=true\n", __func__);
 
-	if (retval != 0) {
-		dev_err(&board_dat->pdev->dev,
-			"%s FAIL:invoking pch_spi_free_resources\n", __func__);
-		pch_spi_free_resources(board_dat, data);
-	}
-
-	dev_dbg(&board_dat->pdev->dev, "%s Return=%d\n", __func__, retval);
-
-	return retval;
+	return 0;
 }
 
 static void pch_free_dma_buf(struct pch_spi_board_data *board_dat,
-- 
2.10.2
