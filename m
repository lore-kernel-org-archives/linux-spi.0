From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: sc18is602: Change gpiod_set_value to gpiod_set_value_cansleep" to the spi tree
Date: Thu, 29 Sep 2016 11:04:36 -0700
Message-ID: <E1bpfhE-0006gb-Ug@finisterre>
References: <1475116862-11697-1-git-send-email-preid@electromag.com.au>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1475116862-11697-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: sc18is602: Change gpiod_set_value to gpiod_set_value_cansleep

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

>From 76cce7e3a582e3a86becaa086f24277829e1e0f5 Mon Sep 17 00:00:00 2001
From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Date: Thu, 29 Sep 2016 10:41:02 +0800
Subject: [PATCH] spi: sc18is602: Change gpiod_set_value to
 gpiod_set_value_cansleep

To avoid warning when using i2c gpio expander change call to the
cansleep variant. There should be no issue with sleeping in the
drivers probe function.

Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-sc18is602.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 5666b5d20b87..f63714ffb62f 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -264,7 +264,7 @@ static int sc18is602_probe(struct i2c_client *client,
 	hw->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(hw->reset))
 		return PTR_ERR(hw->reset);
-	gpiod_set_value(hw->reset, 0);
+	gpiod_set_value_cansleep(hw->reset, 0);
 
 	hw->master = master;
 	hw->client = client;
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
