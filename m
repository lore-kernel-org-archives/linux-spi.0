From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: core: add hook flash_read_supported to spi_master
Date: Sat, 23 Apr 2016 22:47:08 +0200
Message-ID: <571BDF4C.1000102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

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
---
 include/linux/spi/spi.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 857a9a1..1f03483 100644
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
2.8.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
