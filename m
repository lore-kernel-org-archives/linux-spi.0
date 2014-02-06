From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: davinci: Remove unneeded NULL checking for dspi and
 dspi->bitbang.master
Date: Thu, 06 Feb 2014 10:52:21 +0800
Message-ID: <1391655141.12574.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi_master_get_devdata() never returns NULL when spi_alloc_master() success,
so remove NULL test for dspi.
We have ensured master is not NULL before assigning it to dspi->bitbang.master.
So also remove NULL test for dspi->bitbang.master.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-davinci.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 5e7389f..04d69b6 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -864,10 +864,6 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 
 	dspi = spi_master_get_devdata(master);
-	if (dspi == NULL) {
-		ret = -ENOENT;
-		goto free_master;
-	}
 
 	if (dev_get_platdata(&pdev->dev)) {
 		pdata = dev_get_platdata(&pdev->dev);
@@ -908,10 +904,6 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		goto free_master;
 
 	dspi->bitbang.master = master;
-	if (dspi->bitbang.master == NULL) {
-		ret = -ENODEV;
-		goto free_master;
-	}
 
 	dspi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dspi->clk)) {
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
