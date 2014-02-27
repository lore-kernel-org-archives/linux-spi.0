From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: sh-hspi: Remove hspi_cleanup function
Date: Thu, 27 Feb 2014 10:27:30 +0800
Message-ID: <1393468050.25819.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

hspi_cleanup() is doing nothing except print a non-useful debug message,
so remove it.  Also remove unused hspi2info macro.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-sh-hspi.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 3c5d3b8..48becd2 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -46,8 +46,6 @@
 /* SPSR */
 #define RXFL	(1 << 2)
 
-#define hspi2info(h)	(h->dev->platform_data)
-
 struct hspi_priv {
 	void __iomem *addr;
 	struct spi_master *master;
@@ -230,14 +228,6 @@ static int hspi_transfer_one_message(struct spi_master *master,
 	return ret;
 }
 
-static void hspi_cleanup(struct spi_device *spi)
-{
-	struct hspi_priv *hspi = spi_master_get_devdata(spi->master);
-	struct device *dev = hspi->dev;
-
-	dev_dbg(dev, "%s cleanup\n", spi->modalias);
-}
-
 static int hspi_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -284,7 +274,6 @@ static int hspi_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	master->bus_num		= pdev->id;
-	master->cleanup		= hspi_cleanup;
 	master->mode_bits	= SPI_CPOL | SPI_CPHA;
 	master->dev.of_node	= pdev->dev.of_node;
 	master->auto_runtime_pm = true;
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
