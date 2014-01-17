From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: sc18is602: Convert to use bits_per_word_mask
Date: Fri, 17 Jan 2014 18:00:42 +0800
Message-ID: <1389952842.6412.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Since commit 543bb25 "spi: add ability to validate xfer->bits_per_word in SPI
core", the driver can set bits_per_word_mask for the master then the SPI core
will reject transfers that attempt to use an unsupported bits_per_word value.
So we can remove the bits_per_word checking in sc18is602_check_transfer() and
let SPI core handle the checking.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-sc18is602.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index c1a01d1..c981d21 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -183,18 +183,11 @@ static int sc18is602_setup_transfer(struct sc18is602 *hw, u32 hz, u8 mode)
 static int sc18is602_check_transfer(struct spi_device *spi,
 				    struct spi_transfer *t, int tlen)
 {
-	int bpw;
 	uint32_t hz;
 
 	if (t && t->len + tlen > SC18IS602_BUFSIZ)
 		return -EINVAL;
 
-	bpw = spi->bits_per_word;
-	if (t && t->bits_per_word)
-		bpw = t->bits_per_word;
-	if (bpw != 8)
-		return -EINVAL;
-
 	hz = spi->max_speed_hz;
 	if (t && t->speed_hz)
 		hz = t->speed_hz;
@@ -315,6 +308,7 @@ static int sc18is602_probe(struct i2c_client *client,
 	}
 	master->bus_num = client->adapter->nr;
 	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST;
+	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->setup = sc18is602_setup;
 	master->transfer_one_message = sc18is602_transfer_one;
 	master->dev.of_node = np;
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
