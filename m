From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: clps711x: Convert to devm_gpio_request()
Date: Sun, 12 Jan 2014 15:33:39 +0800
Message-ID: <1389512019.13361.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Also drop unneeded gpio_is_valid() call, the checking is done in the
implementation of gpio_request().
With this conversion, then we can also remove spi_clps711x_remove().

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-clps711x.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index 6f03d7e..45a7619 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -193,12 +193,8 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 
 	for (i = 0; i < master->num_chipselect; i++) {
 		hw->chipselect[i] = pdata->chipselect[i];
-		if (!gpio_is_valid(hw->chipselect[i])) {
-			dev_err(&pdev->dev, "Invalid CS GPIO %i\n", i);
-			ret = -EINVAL;
-			goto err_out;
-		}
-		if (gpio_request(hw->chipselect[i], DRIVER_NAME)) {
+		if (devm_gpio_request(&pdev->dev, hw->chipselect[i],
+				      DRIVER_NAME)) {
 			dev_err(&pdev->dev, "Can't get CS GPIO %i\n", i);
 			ret = -EINVAL;
 			goto err_out;
@@ -240,35 +236,17 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 	dev_err(&pdev->dev, "Failed to register master\n");
 
 err_out:
-	while (--i >= 0)
-		if (gpio_is_valid(hw->chipselect[i]))
-			gpio_free(hw->chipselect[i]);
-
 	spi_master_put(master);
 
 	return ret;
 }
 
-static int spi_clps711x_remove(struct platform_device *pdev)
-{
-	int i;
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct spi_clps711x_data *hw = spi_master_get_devdata(master);
-
-	for (i = 0; i < master->num_chipselect; i++)
-		if (gpio_is_valid(hw->chipselect[i]))
-			gpio_free(hw->chipselect[i]);
-
-	return 0;
-}
-
 static struct platform_driver clps711x_spi_driver = {
 	.driver	= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
 	},
 	.probe	= spi_clps711x_probe,
-	.remove	= spi_clps711x_remove,
 };
 module_platform_driver(clps711x_spi_driver);
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
