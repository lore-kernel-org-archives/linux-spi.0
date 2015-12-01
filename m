From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/2] spi: core: add max_msg_size to spi_master
Date: Tue, 1 Dec 2015 19:55:23 +0100
Message-ID: <565DED1B.90903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add a member to spi_master allowing to better handle
SPI chips with a message size HW limit.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2: add accessor

 include/linux/spi/spi.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index cce80e6..a8abd24 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -302,6 +302,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	and it's up to the individual driver to perform any validation.
  * @min_speed_hz: Lowest supported transfer speed
  * @max_speed_hz: Highest supported transfer speed
+ * @max_msg_size: maximum supported message size
  * @flags: other constraints relevant to this driver
  * @bus_lock_spinlock: spinlock for SPI bus locking
  * @bus_lock_mutex: mutex for SPI bus locking
@@ -417,6 +418,9 @@ struct spi_master {
 	u32			min_speed_hz;
 	u32			max_speed_hz;
 
+	/* maximum message size */
+	size_t			max_msg_size;
+
 	/* other constraints relevant to this driver */
 	u16			flags;
 #define SPI_MASTER_HALF_DUPLEX	BIT(0)		/* can't do full duplex */
@@ -556,6 +560,11 @@ static inline void spi_master_put(struct spi_master *master)
 		put_device(&master->dev);
 }
 
+static inline size_t spi_master_get_max_msg_size(struct spi_master *master)
+{
+	return master->max_msg_size;
+}
+
 /* PM calls that need to be issued by the driver */
 extern int spi_master_suspend(struct spi_master *master);
 extern int spi_master_resume(struct spi_master *master);
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
