From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] spi: spi-topcliff-pch: Remove some dead code
Date: Fri, 18 Nov 2016 23:49:27 +0100
Message-ID: <20161118224927.12889-1-christophe.jaillet@wanadoo.fr>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Since commit 0d35773979b9 ("spi: spi-topcliff-pch: Remove deprecated
create_singlethread_workqueue"), 'retval' is no more used in this function.

So some now dead code can be removed.
Also axe a debug message which looks useless now.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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
2.9.3
