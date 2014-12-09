From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi/falcon: Remove hardware prepare and unprepare functions
Date: Tue,  9 Dec 2014 22:20:15 +0000
Message-ID: <1418163615-2442-1-git-send-email-broonie@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>,
	John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

They are completely empty and therefore serve no function.

Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-falcon.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index 912b9037e9cf..286b2c81fc6b 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -353,16 +353,6 @@ static int falcon_sflash_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int falcon_sflash_prepare_xfer(struct spi_master *master)
-{
-	return 0;
-}
-
-static int falcon_sflash_unprepare_xfer(struct spi_master *master)
-{
-	return 0;
-}
-
 static int falcon_sflash_xfer_one(struct spi_master *master,
 					struct spi_message *m)
 {
@@ -420,9 +410,7 @@ static int falcon_sflash_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_MODE_3;
 	master->flags = SPI_MASTER_HALF_DUPLEX;
 	master->setup = falcon_sflash_setup;
-	master->prepare_transfer_hardware = falcon_sflash_prepare_xfer;
 	master->transfer_one_message = falcon_sflash_xfer_one;
-	master->unprepare_transfer_hardware = falcon_sflash_unprepare_xfer;
 	master->dev.of_node = pdev->dev.of_node;
 
 	ret = devm_spi_register_master(&pdev->dev, master);
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
