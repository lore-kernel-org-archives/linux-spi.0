From: Jeff Epler <jepler-ixP+gI44yfQ4d9/VWYMlNA@public.gmane.org>
Subject: [RFC 4/4] spidev-s3c64xx: allocate dma channel at startup
Date: Sun, 14 Sep 2014 09:45:08 -0500
Message-ID: <1410705908-20847-5-git-send-email-jepler@unpythonic.net>
References: <1410705908-20847-1-git-send-email-jepler@unpythonic.net>
To: linux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410705908-20847-1-git-send-email-jepler-ixP+gI44yfQ4d9/VWYMlNA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

it appears that acquire_dma introduces intolerable delays; the system
is fine with the dma channnels allocated all the time.
---
 drivers/spi/spi-s3c64xx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 92de1b5..e6a46c9 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -797,10 +797,6 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
 
-	/* Acquire DMA channels */
-	while (!acquire_dma(sdd))
-		msleep(10);
-
 	pm_runtime_get_sync(&sdd->pdev->dev);
 
 	return 0;
@@ -810,10 +806,6 @@ static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
 
-	/* Free DMA channels */
-	sdd->ops->release(sdd->rx_dma.ch, &s3c64xx_spi_dma_client);
-	sdd->ops->release(sdd->tx_dma.ch, &s3c64xx_spi_dma_client);
-
 	pm_runtime_put(&sdd->pdev->dev);
 
 	return 0;
@@ -1344,6 +1336,9 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 		goto err7;
 	}
 
+        // cannot fail(?)
+	acquire_dma(sdd);
+
 	writel(S3C64XX_SPI_INT_RX_OVERRUN_EN | S3C64XX_SPI_INT_RX_UNDERRUN_EN |
 	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
 	       sdd->regs + S3C64XX_SPI_INT_EN);
@@ -1396,6 +1391,10 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 
 	spi_unregister_master(master);
 
+	/* Free DMA channels */
+	sdd->ops->release(sdd->rx_dma.ch, &s3c64xx_spi_dma_client);
+	sdd->ops->release(sdd->tx_dma.ch, &s3c64xx_spi_dma_client);
+
 	writel(0, sdd->regs + S3C64XX_SPI_INT_EN);
 
 	free_irq(platform_get_irq(pdev, 0), sdd);
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
