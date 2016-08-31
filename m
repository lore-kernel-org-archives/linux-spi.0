From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH 1/1] spi: sc18is602: Add reset control via gpio pin.
Date: Wed, 31 Aug 2016 15:31:38 +0800
Message-ID: <1472628698-10599-2-git-send-email-preid@electromag.com.au>
References: <1472628698-10599-1-git-send-email-preid@electromag.com.au>
Cc: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1472628698-10599-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This sc18is602 has a reset pin that may need to be deasserted.
Add optional binding to specifiy the reset pin via a gpio and deassert
during probe.

Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
---
 drivers/spi/spi-sc18is602.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 36af4d4..5666b5d 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -23,6 +23,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/platform_data/sc18is602.h>
+#include <linux/gpio/consumer.h>
 
 enum chips { sc18is602, sc18is602b, sc18is603 };
 
@@ -50,6 +51,8 @@ struct sc18is602 {
 	u8			buffer[SC18IS602_BUFSIZ + 1];
 	int			tlen;	/* Data queued for tx in buffer */
 	int			rindex;	/* Receive data index in buffer */
+
+	struct gpio_desc	*reset;
 };
 
 static int sc18is602_wait_ready(struct sc18is602 *hw, int len)
@@ -257,6 +260,12 @@ static int sc18is602_probe(struct i2c_client *client,
 	hw = spi_master_get_devdata(master);
 	i2c_set_clientdata(client, hw);
 
+	/* assert reset and then release */
+	hw->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(hw->reset))
+		return PTR_ERR(hw->reset);
+	gpiod_set_value(hw->reset, 0);
+
 	hw->master = master;
 	hw->client = client;
 	hw->dev = dev;
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
