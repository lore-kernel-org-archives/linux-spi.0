From: Jiri Prchal <jiri.prchal-cKCO0sOKHLPtwjQa/ONI9g@public.gmane.org>
Subject: [PATCH] spi: spidev: add compatible value for LTC2488
Date: Thu, 25 Jun 2015 13:44:19 +0200
Message-ID: <26052734d7c05f1dadc7d8e62a4db01e8f19a0f8.1435232279.git.jiri.prchal@aksignal.cz>
Cc: Jiri Prchal <jiri.prchal-cKCO0sOKHLPtwjQa/ONI9g@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Since spidev is no more allowed to use in DT and is really loudly warned about
it I'd like to add this compatible value.
(Geert Uytterhoeven wrote: "Add the compatible value for your device to the
spidev_dt_ids[] array in drivers/spi/spidev.c.")
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 92c909e..9b7c77d 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -706,6 +706,7 @@ static struct class *spidev_class;
 #ifdef CONFIG_OF
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "rohm,dh2228fv" },
+	{ .compatible = "lineartechnology,ltc2488" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
