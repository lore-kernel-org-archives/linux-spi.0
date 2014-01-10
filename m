From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH] spi: clps711x: Use devm_gpio_request()
Date: Fri, 10 Jan 2014 17:02:05 +0400
Message-ID: <1389358925-466-1-git-send-email-shc_work@mail.ru>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch replaces gpio_request() with devm_ API.
As a result this simplifies error path and eliminates "remove"
function.

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 drivers/spi/spi-clps711x.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index 6f03d7e..dafb243 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -1,7 +1,7 @@
 /*
  *  CLPS711X SPI bus driver
  *
- *  Copyright (C) 2012 Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
+ *  Copyright (C) 2012-2014 Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -198,7 +198,7 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 			ret = -EINVAL;
 			goto err_out;
 		}
-		if (gpio_request(hw->chipselect[i], DRIVER_NAME)) {
+		if (devm_gpio_request(&pdev->dev, hw->chipselect[i], NULL)) {
 			dev_err(&pdev->dev, "Can't get CS GPIO %i\n", i);
 			ret = -EINVAL;
 			goto err_out;
@@ -240,35 +240,17 @@ static int spi_clps711x_probe(struct platform_device *pdev)
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
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
