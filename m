From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] spi: coldfire-qspi: Remove unused dev field from struct
 mcfqspi
Date: Fri, 14 Feb 2014 09:54:25 +0800
Message-ID: <1392342865.22981.2.camel@phoenix>
References: <1392342780.22981.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392342780.22981.0.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Also remove unused *res variable in mcfqspi_remove().

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-coldfire-qspi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index 8e4f1c9c..0fcec3b 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -77,8 +77,6 @@ struct mcfqspi {
 	struct mcfqspi_cs_control *cs_control;
 
 	wait_queue_head_t waitq;
-
-	struct device *dev;
 };
 
 static void mcfqspi_wr_qmr(struct mcfqspi *mcfqspi, u16 val)
@@ -430,7 +428,6 @@ static int mcfqspi_probe(struct platform_device *pdev)
 	}
 
 	init_waitqueue_head(&mcfqspi->waitq);
-	mcfqspi->dev = &pdev->dev;
 
 	master->mode_bits = SPI_CS_HIGH | SPI_CPOL | SPI_CPHA;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 16);
@@ -445,7 +442,7 @@ static int mcfqspi_probe(struct platform_device *pdev)
 		dev_dbg(&pdev->dev, "spi_register_master failed\n");
 		goto fail2;
 	}
-	pm_runtime_enable(mcfqspi->dev);
+	pm_runtime_enable(&pdev->dev);
 
 	dev_info(&pdev->dev, "Coldfire QSPI bus driver\n");
 
@@ -467,9 +464,8 @@ static int mcfqspi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	pm_runtime_disable(mcfqspi->dev);
+	pm_runtime_disable(&pdev->dev);
 	/* disable the hardware (set the baud rate to 0) */
 	mcfqspi_wr_qmr(mcfqspi, MCFQSPI_QMR_MSTR);
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
