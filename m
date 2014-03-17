From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH] spi: sc18is602: Don't be that restrictive with the maximum transfer speed
Date: Sun, 16 Mar 2014 18:47:50 -0700
Message-ID: <1395020870-18107-1-git-send-email-linux@roeck-us.net>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
	Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Commit 09e99bca8 (spi: sc18is602: Convert to let spi core validate
transfer speed) made the maximum transfer speed much more restrictive
than before. The transfer speed used to be adjusted to 1/4 of the chip
clock rate if a higher transfer speed was requested. Now such transfers are
simply rejected. With default settings, this causes, for example, a transfer
request at 2 mbps to be rejected because the maximum speed with the default
chip clock is 1.843 mbps.

This is unnecessarily restrictive and causes unnecessary failures. Loosen
the limit to accept transfers up to 50% of the clock rate and adjust
the speed as needed when setting up the actualt transfer.

Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
This patch applies to the tip of linux-next.

 drivers/spi/spi-sc18is602.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 237f2e7..f0e55aa 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -297,7 +297,7 @@ static int sc18is602_probe(struct i2c_client *client,
 	master->transfer_one_message = sc18is602_transfer_one;
 	master->dev.of_node = np;
 	master->min_speed_hz = hw->freq / 128;
-	master->max_speed_hz = hw->freq / 4;
+	master->max_speed_hz = hw->freq / 2;
 
 	error = devm_spi_register_master(dev, master);
 	if (error)
-- 
1.7.9.7

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
