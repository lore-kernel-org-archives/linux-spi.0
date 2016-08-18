From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: introduce max_message_size hook in spi_master" to the spi tree
Date: Thu, 18 Aug 2016 11:17:45 +0100
Message-ID: <E1baKOP-0002Ab-9s@debutante>
References: <69c4ce26-7b41-222e-07b2-92818cedd05f@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <69c4ce26-7b41-222e-07b2-92818cedd05f-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: introduce max_message_size hook in spi_master

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

>From 5090cc6ae2f79ee779e5faf7c8a28edf42b7d738 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 17 Aug 2016 21:08:01 +0200
Subject: [PATCH] spi: introduce max_message_size hook in spi_master

Recently a maximum transfer size was was introduced in struct spi_master.
However there are also spi controllers with a maximum message size, e.g.
fsl-espi has a max message size of 64KB.
Introduce a hook max_message_size to deal with such limitations.

Also make sure that spi_max_transfer_size doesn't return greater values
than spi_max_message_size, even if hook max_transfer_size is not set.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 include/linux/spi/spi.h | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 072cb2aa2413..f2d3960cc3c3 100644
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
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
