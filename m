From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] spi: introduce max message size flag in spi_master
Date: Sun, 7 Aug 2016 21:47:18 +0200
Message-ID: <6c95366c-7fcc-ef4c-033a-f9f6e152a669@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Recently a maximum transfer size was was introduced in struct spi_master.
However there are also spi controllers with a maximum message size, e.g.
fsl-espi has a max message size of 64KB.
As there are no (known) spi controller with differing size limits for
transfer and message, introduce a flag in spi_master to indicate that
the max transfer size is also the maximum message size.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 include/linux/spi/spi.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 072cb2a..cadb1de 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -312,6 +312,8 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @flags: other constraints relevant to this driver
  * @max_transfer_size: function that returns the max transfer size for
  *	a &spi_device; may be %NULL, so the default %SIZE_MAX will be used.
+ * @max_message_size_flag: indicates that max transfer size is also
+ *	max message size
  * @io_mutex: mutex for physical bus access
  * @bus_lock_spinlock: spinlock for SPI bus locking
  * @bus_lock_mutex: mutex for exclusion of multiple callers
@@ -446,6 +448,8 @@ struct spi_master {
 	 * the limit may depend on device transfer settings
 	 */
 	size_t (*max_transfer_size)(struct spi_device *spi);
+	/* flag indicating that max transfer size is also max message size */
+	bool			max_message_size_flag;
 
 	/* I/O mutex */
 	struct mutex		io_mutex;
-- 
2.9.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
