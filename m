From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/4] spi: sc18is602: Use devm_spi_register_master()
Date: Wed, 04 Dec 2013 14:14:30 +0900
Message-ID: <002f01cef0af$b618e170$224aa450$%han@samsung.com>
References: <002d01cef0af$5a21f140$0e65d3c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Guenter Roeck' <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <002d01cef0af$5a21f140$0e65d3c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use devm_spi_register_master() to make cleanup paths simpler,
and remove unnecessary remove().

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-sc18is602.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 9eda21d..c1a01d1 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -319,7 +319,7 @@ static int sc18is602_probe(struct i2c_client *client,
 	master->transfer_one_message = sc18is602_transfer_one;
 	master->dev.of_node = np;
 
-	error = spi_register_master(master);
+	error = devm_spi_register_master(dev, master);
 	if (error)
 		goto error_reg;
 
@@ -330,16 +330,6 @@ error_reg:
 	return error;
 }
 
-static int sc18is602_remove(struct i2c_client *client)
-{
-	struct sc18is602 *hw = i2c_get_clientdata(client);
-	struct spi_master *master = hw->master;
-
-	spi_unregister_master(master);
-
-	return 0;
-}
-
 static const struct i2c_device_id sc18is602_id[] = {
 	{ "sc18is602", sc18is602 },
 	{ "sc18is602b", sc18is602b },
@@ -353,7 +343,6 @@ static struct i2c_driver sc18is602_driver = {
 		.name = "sc18is602",
 	},
 	.probe = sc18is602_probe,
-	.remove = sc18is602_remove,
 	.id_table = sc18is602_id,
 };
 
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
