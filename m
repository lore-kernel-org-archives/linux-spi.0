From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/3] spi: introduce max_message_size hook in spi_master
Date: Wed, 17 Aug 2016 21:08:01 +0200
Message-ID: <69c4ce26-7b41-222e-07b2-92818cedd05f@gmail.com>
References: <6c95366c-7fcc-ef4c-033a-f9f6e152a669@gmail.com>
 <20160816164204.GV9347@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160816164204.GV9347-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Recently a maximum transfer size was was introduced in struct spi_master.
However there are also spi controllers with a maximum message size, e.g.
fsl-espi has a max message size of 64KB.
Introduce a hook max_message_size to deal with such limitations.

Also make sure that spi_max_transfer_size doesn't return greater values
than spi_max_message_size, even if hook max_transfer_size is not set.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- replace the flag with a hook that allows to define a message size
  limit independednt of a potential transfer size limit
---
 include/linux/spi/spi.h | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 072cb2a..f2d3960 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -312,6 +312,8 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @flags: other constraints relevant to this driver
  * @max_transfer_size: function that returns the max transfer size for
  *	a &spi_device; may be %NULL, so the default %SIZE_MAX will be used.
+ * @max_message_size: function that returns the max message size for
+ *	a &spi_device; may be %NULL, so the default %SIZE_MAX will be used.
  * @io_mutex: mutex for physical bus access
  * @bus_lock_spinlock: spinlock for SPI bus locking
  * @bus_lock_mutex: mutex for exclusion of multiple callers
@@ -442,10 +444,11 @@ struct spi_master {
 #define SPI_MASTER_MUST_TX      BIT(4)		/* requires tx */
 
 	/*
-	 * on some hardware transfer size may be constrained
+	 * on some hardware transfer / message size may be constrained
 	 * the limit may depend on device transfer settings
 	 */
 	size_t (*max_transfer_size)(struct spi_device *spi);
+	size_t (*max_message_size)(struct spi_device *spi);
 
 	/* I/O mutex */
 	struct mutex		io_mutex;
@@ -905,12 +908,26 @@ extern int spi_async_locked(struct spi_device *spi,
 			    struct spi_message *message);
 
 static inline size_t
-spi_max_transfer_size(struct spi_device *spi)
+spi_max_message_size(struct spi_device *spi)
 {
 	struct spi_master *master = spi->master;
-	if (!master->max_transfer_size)
+	if (!master->max_message_size)
 		return SIZE_MAX;
-	return master->max_transfer_size(spi);
+	return master->max_message_size(spi);
+}
+
+static inline size_t
+spi_max_transfer_size(struct spi_device *spi)
+{
+	struct spi_master *master = spi->master;
+	size_t tr_max = SIZE_MAX;
+	size_t msg_max = spi_max_message_size(spi);
+
+	if (master->max_transfer_size)
+		tr_max = master->max_transfer_size(spi);
+
+	/* transfer size limit must not be greater than messsage size limit */
+	return min(tr_max, msg_max);
 }
 
 /*---------------------------------------------------------------------------*/
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
