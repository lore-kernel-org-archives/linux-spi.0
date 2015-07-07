From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spidev: add compatible value for LTC2488" to the spi tree
Date: Tue, 07 Jul 2015 14:58:43 +0100
Message-ID: <E1ZCTOV-0005l9-HT@finisterre>
References: <26052734d7c05f1dadc7d8e62a4db01e8f19a0f8.1435232279.git.jiri.prchal@aksignal.cz>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <26052734d7c05f1dadc7d8e62a4db01e8f19a0f8.1435232279.git.jiri.prchal-cKCO0sOKHLPtwjQa/ONI9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spidev: add compatible value for LTC2488

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

>From 6fec919b61b66e7f92646a7bd6fada9850f5cedc Mon Sep 17 00:00:00 2001
From: Jiri Prchal <jiri.prchal-cKCO0sOKHLPtwjQa/ONI9g@public.gmane.org>
Date: Thu, 25 Jun 2015 13:44:19 +0200
Subject: [PATCH] spi: spidev: add compatible value for LTC2488

Since spidev is no more allowed to use in DT and is really loudly warned about
it I'd like to add this compatible value.
(Geert Uytterhoeven wrote: "Add the compatible value for your device to the
spidev_dt_ids[] array in drivers/spi/spidev.c.")

Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index dd616ff..c7de641 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -693,6 +693,7 @@ static struct class *spidev_class;
 #ifdef CONFIG_OF
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "rohm,dh2228fv" },
+	{ .compatible = "lineartechnology,ltc2488" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
