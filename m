From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: davinci: Use of_match_ptr at appropriate place
Date: Thu, 06 Feb 2014 11:45:08 +0800
Message-ID: <1391658308.12574.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

It's pointless to use of_match_ptr within CONFIG_OF guard.
Use of_match_ptr around davinci_spi_of_match when setting .of_match_table.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-davinci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 04d69b6..50f7509 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -802,8 +802,7 @@ static int spi_davinci_get_pdata(struct platform_device *pdev,
 	pdata = &dspi->pdata;
 
 	pdata->version = SPI_VERSION_1;
-	match = of_match_device(of_match_ptr(davinci_spi_of_match),
-				&pdev->dev);
+	match = of_match_device(davinci_spi_of_match, &pdev->dev);
 	if (!match)
 		return -ENODEV;
 
@@ -824,7 +823,6 @@ static int spi_davinci_get_pdata(struct platform_device *pdev,
 	return 0;
 }
 #else
-#define davinci_spi_of_match NULL
 static struct davinci_spi_platform_data
 	*spi_davinci_get_pdata(struct platform_device *pdev,
 		struct davinci_spi *dspi)
@@ -1032,7 +1030,7 @@ static struct platform_driver davinci_spi_driver = {
 	.driver = {
 		.name = "spi_davinci",
 		.owner = THIS_MODULE,
-		.of_match_table = davinci_spi_of_match,
+		.of_match_table = of_match_ptr(davinci_spi_of_match),
 	},
 	.probe = davinci_spi_probe,
 	.remove = davinci_spi_remove,
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
