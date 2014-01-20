From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: sc18is602: Remove sc18is602_setup() because it is done
 by spi core
Date: Mon, 20 Jan 2014 23:18:45 +0800
Message-ID: <1390231125.11756.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The checking for spi->mode is done in the implementation of spi_setup().
Calling sc18is602_check_transfer(spi, NULL, 0) is pointless because
the code is equivent to checking if spi->max_speed_hz is 0.
Note, sc18is602_check_transfer actually allows spi->max_speed_hz is 0
if t->speed_hz is set. So return error in sc18is602_setup() when
spi->max_speed_hz is 0 does not make sense.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-sc18is602.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 121c2e1..b3ac776 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -245,14 +245,6 @@ error:
 	return status;
 }
 
-static int sc18is602_setup(struct spi_device *spi)
-{
-	if (spi->mode & ~(SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST))
-		return -EINVAL;
-
-	return sc18is602_check_transfer(spi, NULL, 0);
-}
-
 static int sc18is602_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
@@ -306,7 +298,6 @@ static int sc18is602_probe(struct i2c_client *client,
 	master->bus_num = client->adapter->nr;
 	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->setup = sc18is602_setup;
 	master->transfer_one_message = sc18is602_transfer_one;
 	master->dev.of_node = np;
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
