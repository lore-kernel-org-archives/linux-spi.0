From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: RfC: Handle SPI controller limitations like maximum message length
Date: Wed, 18 Nov 2015 22:19:29 +0100
Message-ID: <564CEB61.2000601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There have been few discussions in the past about how to handle SPI controller
limitations like max message length. However they don't seem to have resulted
in accepted patches yet.
I also stumbled across this topic because I own a device using Freescale's
ESPI which has a 64K message size limitation.

At least one agreed fact is that silently assembling chunks in protocol
drivers is not the preferred approach.

Maybe a better approach would be to introduce a new member of spi_master
dealing with controller limitations.
My issue is just the message size limitation but most likely there are more
and different limitations in other controllers.

I'd introduce a struct spi_controller_restrictions and add a member to spi_master
pointing to such a struct. Then a controller driver could do something like this:

static const struct spi_controller_restrictions fsl_espi_restrictions = {
	.max_msg_size	= 0xffff,
};

master->restrictions = &fsl_espi_restrictions;

I also add an example how a protocol driver could use this extension.
Appreciate any comment.


diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 269e8af..8a27c66 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -276,6 +276,17 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
 			spi_unregister_driver)
 
 /**
+ * struct spi_controller_restrictions - restrictions of the controller
+ * @max_msg_size: maximum length of a SPI message
+ * SPI controllers can have different restrictions like a maximum
+ * supported message size.
+ * This struct most likely is going to be extended over time.
+ */
+struct spi_controller_restrictions {
+	size_t max_msg_size;
+};
+
+/**
  * struct spi_master - interface to SPI master controller
  * @dev: device interface to this driver
  * @list: link with the global spi_master list
@@ -295,6 +306,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @min_speed_hz: Lowest supported transfer speed
  * @max_speed_hz: Highest supported transfer speed
  * @flags: other constraints relevant to this driver
+ * @restrictions: controller restrictions like max supported message size
  * @bus_lock_spinlock: spinlock for SPI bus locking
  * @bus_lock_mutex: mutex for SPI bus locking
  * @bus_lock_flag: indicates that the SPI bus is locked for exclusive use
@@ -417,6 +429,9 @@ struct spi_master {
 #define SPI_MASTER_MUST_RX      BIT(3)		/* requires rx */
 #define SPI_MASTER_MUST_TX      BIT(4)		/* requires tx */
 
+	/* collection of restrictions like max supported message size */
+	struct spi_controller_restrictions *restrictions;
+
 	/* lock and mutex for SPI bus locking */
 	spinlock_t		bus_lock_spinlock;
 	struct mutex		bus_lock_mutex;
-- 
2.6.2




---
 drivers/mtd/devices/m25p80.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index f10daa8..0e46fb1f 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -115,11 +115,7 @@ static inline unsigned int m25p80_rx_nbits(struct spi_nor *nor)
 	}
 }
 
-/*
- * Read an address range from the nor chip.  The address range
- * may be any size provided it is within the physical boundaries.
- */
-static int m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
+static int _m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 			size_t *retlen, u_char *buf)
 {
 	struct m25p *flash = nor->priv;
@@ -160,6 +156,41 @@ static int m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 	return ret;
 }
 
+/*
+ * Read an address range from the nor chip.  The address range
+ * may be any size provided it is within the physical boundaries.
+ */
+static int m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
+			size_t *retlen, u_char *buf)
+{
+	struct m25p *flash = nor->priv;
+	struct spi_controller_restrictions *restrictions =
+		flash->spi->master->restrictions;
+	size_t cmd_len, xfer_len, max_len;
+	int ret = 0;
+
+	/* convert the dummy cycles to the number of bytes */
+	cmd_len = m25p_cmdsz(nor) + nor->read_dummy / 8;
+
+	max_len = (restrictions && restrictions->max_msg_size) ?
+		  restrictions->max_msg_size : SIZE_MAX;
+
+	if (unlikely(max_len < cmd_len))
+		return -EINVAL;
+
+	max_len -= cmd_len;
+
+	while (len) {
+		xfer_len = min(len, max_len);
+		ret = _m25p80_read(nor, from, xfer_len, retlen, buf);
+		if (ret < 0)
+			break;
+		from += xfer_len;
+		len -= xfer_len;
+	}
+
+	return ret;
+}
+
 static int m25p80_erase(struct spi_nor *nor, loff_t offset)
 {
 	struct m25p *flash = nor->priv;
-- 
2.6.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
