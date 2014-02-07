From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] spi/s3c64xx: Remove code no longer needed as a result of S3C_DMA removal
Date: Fri,  7 Feb 2014 13:11:32 +0000
Message-ID: <1391778692-20129-2-git-send-email-broonie@kernel.org>
References: <1391778692-20129-1-git-send-email-broonie@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391778692-20129-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Remove functions that only had an effect when using S3C_DMA and inline
dmaengine_terminate_all() since it's pointless to have a function which
expands to a single function call.

Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c | 39 ++-------------------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 18ec7e65a319..9ad5e3e76b96 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -277,17 +277,6 @@ static void s3c64xx_spi_dmacb(void *data)
 	spin_unlock_irqrestore(&sdd->lock, flags);
 }
 
-static int s3c64xx_spi_map_mssg(struct s3c64xx_spi_driver_data *sdd,
-						struct spi_message *msg)
-{
-	return 0;
-}
-
-static void s3c64xx_spi_unmap_mssg(struct s3c64xx_spi_driver_data *sdd,
-						struct spi_message *msg)
-{
-}
-
 static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 			struct sg_table *sgt)
 {
@@ -387,12 +376,6 @@ static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
 	return 0;
 }
 
-static void s3c64xx_spi_dma_stop(struct s3c64xx_spi_driver_data *sdd,
-				 struct s3c64xx_spi_dma_data *dma)
-{
-	dmaengine_terminate_all(dma->ch);
-}
-
 static bool s3c64xx_spi_can_dma(struct spi_master *master,
 				struct spi_device *spi,
 				struct spi_transfer *xfer)
@@ -691,13 +674,6 @@ static int s3c64xx_spi_prepare_message(struct spi_master *master,
 		s3c64xx_spi_config(sdd);
 	}
 
-	/* Map all the transfers if needed */
-	if (s3c64xx_spi_map_mssg(sdd, msg)) {
-		dev_err(&spi->dev,
-			"Xfer: Unable to map message buffers!\n");
-		return -ENOMEM;
-	}
-
 	/* Configure feedback delay */
 	writel(cs->fb_delay & 0x3, sdd->regs + S3C64XX_SPI_FB_CLK);
 
@@ -769,10 +745,10 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 		if (use_dma) {
 			if (xfer->tx_buf != NULL
 			    && (sdd->state & TXBUSY))
-				s3c64xx_spi_dma_stop(sdd, &sdd->tx_dma);
+				dmaengine_terminate_all(sdd->tx_dma.ch);
 			if (xfer->rx_buf != NULL
 			    && (sdd->state & RXBUSY))
-				s3c64xx_spi_dma_stop(sdd, &sdd->rx_dma);
+				dmaengine_terminate_all(sdd->rx_dma.ch);
 		}
 	} else {
 		flush_fifo(sdd);
@@ -781,16 +757,6 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	return status;
 }
 
-static int s3c64xx_spi_unprepare_message(struct spi_master *master,
-					    struct spi_message *msg)
-{
-	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
-
-	s3c64xx_spi_unmap_mssg(sdd, msg);
-
-	return 0;
-}
-
 static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
 				struct spi_device *spi)
 {
@@ -1164,7 +1130,6 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	master->prepare_transfer_hardware = s3c64xx_spi_prepare_transfer;
 	master->prepare_message = s3c64xx_spi_prepare_message;
 	master->transfer_one = s3c64xx_spi_transfer_one;
-	master->unprepare_message = s3c64xx_spi_unprepare_message;
 	master->unprepare_transfer_hardware = s3c64xx_spi_unprepare_transfer;
 	master->num_chipselect = sci->num_cs;
 	master->dma_alignment = 8;
-- 
1.9.rc1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
