From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: [PATCH] spi: Add struct spi_master max_transfer_size member to kernel-doc
Date: Mon,  8 Feb 2016 18:10:48 -0300
Message-ID: <1454965848-5120-1-git-send-email-javier@osg.samsung.com>
Cc: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Commit 4acad4aae10d ("spi: expose master transfer size limitation.") added
a parameter to specify the SPI controller maximum transfer size limitation
but did not update the kernel-doc so building the docs leads to a warning:

.//include/linux/spi/spi.h:540: warning: No description found for parameter 'max_transfer_size'

Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>

---

 include/linux/spi/spi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 53be3a4c60cb..093be7d50597 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -303,6 +303,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @min_speed_hz: Lowest supported transfer speed
  * @max_speed_hz: Highest supported transfer speed
  * @flags: other constraints relevant to this driver
+ * @max_transfer_size: specifies SPI controller maximum transfer size limit
  * @bus_lock_spinlock: spinlock for SPI bus locking
  * @bus_lock_mutex: mutex for SPI bus locking
  * @bus_lock_flag: indicates that the SPI bus is locked for exclusive use
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
