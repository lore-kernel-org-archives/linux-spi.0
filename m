From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH RFT] spi: sc18is602: Convert to let spi core validate
 transfer speed
Date: Fri, 28 Feb 2014 18:39:33 +0800
Message-ID: <1393583973.18537.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Set master->max_speed_hz and master->min_speed_hz then spi core will handle
checking transfer speed. So we can remove the same checking in this driver.

This patch also remove testing if hz is 0 because spi->max_speed_hz will be
default set to master->min_speed_hz if it was not set. So the transfer speed
will never set to 0.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-sc18is602.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 7fba10b..237f2e7 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -183,17 +183,9 @@ static int sc18is602_setup_transfer(struct sc18is602 *hw, u32 hz, u8 mode)
 static int sc18is602_check_transfer(struct spi_device *spi,
 				    struct spi_transfer *t, int tlen)
 {
-	uint32_t hz;
-
 	if (t && t->len + tlen > SC18IS602_BUFSIZ)
 		return -EINVAL;
 
-	hz = spi->max_speed_hz;
-	if (t && t->speed_hz)
-		hz = t->speed_hz;
-	if (hz == 0)
-		return -EINVAL;
-
 	return 0;
 }
 
@@ -207,14 +199,13 @@ static int sc18is602_transfer_one(struct spi_master *master,
 
 	hw->tlen = 0;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		u32 hz = t->speed_hz ? : spi->max_speed_hz;
 		bool do_transfer;
 
 		status = sc18is602_check_transfer(spi, t, hw->tlen);
 		if (status < 0)
 			break;
 
-		status = sc18is602_setup_transfer(hw, hz, spi->mode);
+		status = sc18is602_setup_transfer(hw, t->speed_hz, spi->mode);
 		if (status < 0)
 			break;
 
@@ -305,6 +296,8 @@ static int sc18is602_probe(struct i2c_client *client,
 	master->setup = sc18is602_setup;
 	master->transfer_one_message = sc18is602_transfer_one;
 	master->dev.of_node = np;
+	master->min_speed_hz = hw->freq / 128;
+	master->max_speed_hz = hw->freq / 4;
 
 	error = devm_spi_register_master(dev, master);
 	if (error)
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
