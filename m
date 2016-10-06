From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spidev: Add device to spidev device tree compatibility list" to the spi tree
Date: Thu, 06 Oct 2016 18:03:31 +0200
Message-ID: <E1bsB8t-0001to-IB@finisterre>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabien Lahoudere <fabien.lahoudere-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spidev: Add device to spidev device tree compatibility list

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

>From 1edc5d4f777f43ab5b10c6c3d160990d1da33126 Mon Sep 17 00:00:00 2001
From: Fabien Lahoudere <fabien.lahoudere-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Date: Thu, 6 Oct 2016 16:44:27 +0200
Subject: [PATCH] spi: spidev: Add device to spidev device tree compatibility
 list

Entries are needed in the spidev ID list to configure configure it from a
device tree. Add entry for the following device:
- "ge,achc" :  GE Healthcare USB Management Controller

The USB Management Controller does not expose USB to the host, but acts as
an offload engine, communicating with specific USB based data acquisition
devices which are connected to it, extracting the required data and
providing it to the host via other methods. SPI is used as an out-of-band
configuration channel.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 2e05046f866b..9e2e099baf8c 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -696,6 +696,7 @@ static struct class *spidev_class;
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "rohm,dh2228fv" },
 	{ .compatible = "lineartechnology,ltc2488" },
+	{ .compatible = "ge,achc" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
