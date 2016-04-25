From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: core: add hook flash_read_supported to spi_master" to the spi tree
Date: Mon, 25 Apr 2016 18:57:05 +0100
Message-ID: <E1aukkr-0007oh-4e@debutante>
References: <571BDF4C.1000102@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <571BDF4C.1000102-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: core: add hook flash_read_supported to spi_master

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

>From 7ba2f2757d84eae533679306f03c93c118437a87 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sat, 23 Apr 2016 22:47:08 +0200
Subject: [PATCH] spi: core: add hook flash_read_supported to spi_master

If hook spi_flash_read is implemented the fast flash read feature
is enabled for all devices attached to the respective master.

In most cases there is just one flash chip, however there are also
devices with more than one flash chip, namely some WiFi routers.
Then the fast flash read feature can be used for the first chip only.
OpenWRT implemented an own handling of this case, using controller_data
element of spi_device to hold the information whether fast flash read
can be used for a device.

This patch adds hook flash_read_supported to spi_master which is
used to extend spi_flash_read_supported() by checking whether the
fast flash read feature can be used for a specific spi_device.

If the hook is not implemented the default behavior is to allow
fast flash read for all devices (if spi_flash_read is implemented).

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 include/linux/spi/spi.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 857a9a1d82b5..1f03483f61e5 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -372,6 +372,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @unprepare_message: undo any work done by prepare_message().
  * @spi_flash_read: to support spi-controller hardwares that provide
  *                  accelerated interface to read from flash devices.
+ * @flash_read_supported: spi device supports flash read
  * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
  *	number. Any individual value may be -ENOENT for CS lines that
  *	are not GPIOs (driven by the SPI controller itself).
@@ -529,6 +530,7 @@ struct spi_master {
 				 struct spi_message *message);
 	int (*spi_flash_read)(struct  spi_device *spi,
 			      struct spi_flash_read_message *msg);
+	bool (*flash_read_supported)(struct spi_device *spi);
 
 	/*
 	 * These hooks are for drivers that use a generic implementation
@@ -1158,7 +1160,9 @@ struct spi_flash_read_message {
 /* SPI core interface for flash read support */
 static inline bool spi_flash_read_supported(struct spi_device *spi)
 {
-	return spi->master->spi_flash_read ? true : false;
+	return spi->master->spi_flash_read &&
+	       (!spi->master->flash_read_supported ||
+	       spi->master->flash_read_supported(spi));
 }
 
 int spi_flash_read(struct spi_device *spi,
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
