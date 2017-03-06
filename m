From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sc18is602: Add OF device ID table" to the spi tree
Date: Mon, 06 Mar 2017 11:47:11 +0100
Message-ID: <E1ckqAZ-0002bo-Es@finisterre>
References: <20170222181420.25420-1-javier@osg.samsung.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170222181420.25420-1-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sc18is602: Add OF device ID table

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 68c97b92c0a0dfdc134564f1f1c04b1c8ed27bba Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Wed, 22 Feb 2017 15:14:20 -0300
Subject: [PATCH] spi: sc18is602: Add OF device ID table

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.11.0
