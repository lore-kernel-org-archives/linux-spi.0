From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/4] spi: spi-xcomm: Use devm_spi_register_master()
Date: Wed, 04 Dec 2013 14:15:23 +0900
Message-ID: <003001cef0af$d5c84ce0$8158e6a0$%han@samsung.com>
References: <002d01cef0af$5a21f140$0e65d3c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Lars-Peter Clausen' <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
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
 drivers/spi/spi-xcomm.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index 4258c71..24c40b1 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -231,22 +231,13 @@ static int spi_xcomm_probe(struct i2c_client *i2c,
 	master->dev.of_node = i2c->dev.of_node;
 	i2c_set_clientdata(i2c, master);
 
-	ret = spi_register_master(master);
+	ret = devm_spi_register_master(&i2c->dev, master);
 	if (ret < 0)
 		spi_master_put(master);
 
 	return ret;
 }
 
-static int spi_xcomm_remove(struct i2c_client *i2c)
-{
-	struct spi_master *master = i2c_get_clientdata(i2c);
-
-	spi_unregister_master(master);
-
-	return 0;
-}
-
 static const struct i2c_device_id spi_xcomm_ids[] = {
 	{ "spi-xcomm" },
 	{ },
@@ -259,7 +250,6 @@ static struct i2c_driver spi_xcomm_driver = {
 	},
 	.id_table	= spi_xcomm_ids,
 	.probe		= spi_xcomm_probe,
-	.remove		= spi_xcomm_remove,
 };
 module_i2c_driver(spi_xcomm_driver);
 
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
