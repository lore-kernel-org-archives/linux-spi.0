From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: sc18is602: Move checking chip_select for SC18IS602 to
 sc18is602_setup
Date: Tue, 11 Feb 2014 20:54:17 +0800
Message-ID: <1392123257.1351.9.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

So it will be checked when spi device is added onto the spi bus.
spi_add_device() calls spi_setup() which then calls spi->master->setup().
No need to check it every time sc18is602_transfer_one() is called.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-sc18is602.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index b3ac776..7fba10b 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -205,12 +205,6 @@ static int sc18is602_transfer_one(struct spi_master *master,
 	struct spi_transfer *t;
 	int status = 0;
 
-	/* SC18IS602 does not support CS2 */
-	if (hw->id == sc18is602 && spi->chip_select == 2) {
-		status = -ENXIO;
-		goto error;
-	}
-
 	hw->tlen = 0;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		u32 hz = t->speed_hz ? : spi->max_speed_hz;
@@ -238,13 +232,23 @@ static int sc18is602_transfer_one(struct spi_master *master,
 		if (t->delay_usecs)
 			udelay(t->delay_usecs);
 	}
-error:
 	m->status = status;
 	spi_finalize_current_message(master);
 
 	return status;
 }
 
+static int sc18is602_setup(struct spi_device *spi)
+{
+	struct sc18is602 *hw = spi_master_get_devdata(spi->master);
+
+	/* SC18IS602 does not support CS2 */
+	if (hw->id == sc18is602 && spi->chip_select == 2)
+		return -ENXIO;
+
+	return 0;
+}
+
 static int sc18is602_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
@@ -298,6 +302,7 @@ static int sc18is602_probe(struct i2c_client *client,
 	master->bus_num = client->adapter->nr;
 	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	master->setup = sc18is602_setup;
 	master->transfer_one_message = sc18is602_transfer_one;
 	master->dev.of_node = np;
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
