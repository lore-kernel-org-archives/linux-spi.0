From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH 1/1] spi: sc18is602: Change gpiod_set_value to gpiod_set_value_cansleep
Date: Thu, 29 Sep 2016 10:41:02 +0800
Message-ID: <1475116862-11697-1-git-send-email-preid@electromag.com.au>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

To avoid warning when using i2c gpio expander change call to the
cansleep variant. There should be no issue with sleeping in the
drivers probe function.

Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
---
 drivers/spi/spi-sc18is602.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 5666b5d..f63714f 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -264,7 +264,7 @@ static int sc18is602_probe(struct i2c_client *client,
 	hw->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(hw->reset))
 		return PTR_ERR(hw->reset);
-	gpiod_set_value(hw->reset, 0);
+	gpiod_set_value_cansleep(hw->reset, 0);
 
 	hw->master = master;
 	hw->client = client;
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
