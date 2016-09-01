From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: sc18is602: Add reset control via gpio pin." to the spi tree
Date: Thu, 01 Sep 2016 21:35:52 +0100
Message-ID: <E1bfYiG-00034f-0h@debutante>
References: <1472628698-10599-2-git-send-email-preid@electromag.com.au>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1472628698-10599-2-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: sc18is602: Add reset control via gpio pin.

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

>From f99008013e199e6b88ef26c98ecb042c94c7450c Mon Sep 17 00:00:00 2001
From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Date: Wed, 31 Aug 2016 15:31:38 +0800
Subject: [PATCH] spi: sc18is602: Add reset control via gpio pin.

This sc18is602 has a reset pin that may need to be deasserted.
Add optional binding to specifiy the reset pin via a gpio and deassert
during probe.

Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-sc18is602.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 36af4d48a700..5666b5d20b87 100644
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
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
