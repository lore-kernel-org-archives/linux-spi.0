From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fix parent-device reference leak" to the spi tree
Date: Wed, 16 Dec 2015 13:27:06 +0000
Message-ID: <E1a9C6k-0003R5-JJ@debutante>
References: <1450106179-27623-1-git-send-email-johan@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450106179-27623-1-git-send-email-johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fix parent-device reference leak

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

>From 157f38f993919b648187ba341bfb05d0e91ad2f6 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Date: Mon, 14 Dec 2015 16:16:19 +0100
Subject: [PATCH] spi: fix parent-device reference leak

Fix parent-device reference leak due to SPI-core taking an unnecessary
reference to the parent when allocating the master structure, a
reference that was never released.

Note that driver core takes its own reference to the parent when the
master device is registered.

Fixes: 49dce689ad4e ("spi doesn't need class_device")
Signed-off-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e2415be209d5..7bf25274ad78 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1704,7 +1704,7 @@ struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
 	master->bus_num = -1;
 	master->num_chipselect = 1;
 	master->dev.class = &spi_master_class;
-	master->dev.parent = get_device(dev);
+	master->dev.parent = dev;
 	spi_master_set_devdata(master, &master[1]);
 
 	return master;
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
