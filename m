From: "Alvaro G. M" <alvaro.gamez-DeCVIOs67l7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/1] spi: spidev: add compatible value for TI ADC322x family
Date: Mon, 30 May 2016 12:28:27 +0200
Message-ID: <1464604107-22961-1-git-send-email-alvaro.gamez@hazent.com>
Cc: "Alvaro G. M" <alvaro.gamez-DeCVIOs67l7QT0dZR+AlfA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Alvaro Gamez Machado <alvaro.gamez-DeCVIOs67l7QT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index e3c19f3..d54f91e 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -695,6 +695,7 @@ static struct class *spidev_class;
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "rohm,dh2228fv" },
 	{ .compatible = "lineartechnology,ltc2488" },
+	{ .compatible = "ti,adc322x" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
