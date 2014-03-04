From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: clps711x: Provide label argument for devm_gpio_request
Date: Tue, 04 Mar 2014 12:59:53 +0800
Message-ID: <1393909193.18753.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The label argument was removed by commit 989847967cd762
spi: clps711x: Use devm_gpio_request(), add it back.
This makes it easier to know the gpio usage in /sys/kernel/debug/gpio.

Also remove unnecessary gpio_is_valid() checking, devm_gpio_request() returns
error if the requested gpio is invalid.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-clps711x.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index 3900c31..2b60935 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -158,14 +158,10 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 
 	for (i = 0; i < master->num_chipselect; i++) {
 		master->cs_gpios[i] = pdata->chipselect[i];
-		if (!gpio_is_valid(master->cs_gpios[i])) {
-			dev_err(&pdev->dev, "Invalid CS GPIO %i\n", i);
-			ret = -EINVAL;
-			goto err_out;
-		}
-		if (devm_gpio_request(&pdev->dev, master->cs_gpios[i], NULL)) {
+		ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
+					DRIVER_NAME);
+		if (ret) {
 			dev_err(&pdev->dev, "Can't get CS GPIO %i\n", i);
-			ret = -EINVAL;
 			goto err_out;
 		}
 	}
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
