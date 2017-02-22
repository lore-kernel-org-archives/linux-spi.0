From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: [PATCH] spi: sc18is602: Add OF device ID table
Date: Wed, 22 Feb 2017 15:14:20 -0300
Message-ID: <20170222181420.25420-1-javier@osg.samsung.com>
Cc: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
---

 drivers/spi/spi-sc18is602.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index f63714ffb62f..52cf0e9189c2 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -21,6 +21,7 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
+#include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/platform_data/sc18is602.h>
 #include <linux/gpio/consumer.h>
@@ -271,7 +272,10 @@ static int sc18is602_probe(struct i2c_client *client,
 	hw->dev = dev;
 	hw->ctrl = 0xff;
 
-	hw->id = id->driver_data;
+	if (client->dev.of_node)
+		hw->id = (enum chips)of_device_get_match_data(&client->dev);
+	else
+		hw->id = id->driver_data;
 
 	switch (hw->id) {
 	case sc18is602:
@@ -323,9 +327,27 @@ static const struct i2c_device_id sc18is602_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, sc18is602_id);
 
+static const struct of_device_id sc18is602_of_match[] = {
+	{
+		.compatible = "nxp,sc18is602",
+		.data = (void *)sc18is602
+	},
+	{
+		.compatible = "nxp,sc18is602b",
+		.data = (void *)sc18is602b
+	},
+	{
+		.compatible = "nxp,sc18is603",
+		.data = (void *)sc18is603
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sc18is602_of_match);
+
 static struct i2c_driver sc18is602_driver = {
 	.driver = {
 		.name = "sc18is602",
+		.of_match_table = of_match_ptr(sc18is602_of_match),
 	},
 	.probe = sc18is602_probe,
 	.id_table = sc18is602_id,
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
