From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 3/5] spi: Added way to check for pm support for flash devices
Date: Fri,  3 Feb 2017 18:31:14 -0500
Message-ID: <1486164676-12912-4-git-send-email-kdasu.kdev@gmail.com>
References: <1486164676-12912-1-git-send-email-kdasu.kdev@gmail.com>
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
        marex-ynQEQJNshbs@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1486164676-12912-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Device drivers can check if the master controller driver has to support
flash pm. The controller driver indicates this using flash_pm_supported()
spi master interface.

Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 include/linux/spi/spi.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 75c6bd0..b5fbc1b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -539,6 +539,7 @@ struct spi_master {
 	int (*spi_flash_read)(struct  spi_device *spi,
 			      struct spi_flash_read_message *msg);
 	bool (*flash_read_supported)(struct spi_device *spi);
+	bool (*flash_pm_supported)(struct spi_device *spi);
 
 	/*
 	 * These hooks are for drivers that use a generic implementation
@@ -1185,6 +1186,13 @@ static inline bool spi_flash_read_supported(struct spi_device *spi)
 	       spi->master->flash_read_supported(spi));
 }
 
+/* SPI core interface to indicate flash pm support */
+static inline bool spi_flash_pm_supported(struct spi_device *spi)
+{
+	return (spi->master->flash_pm_supported &&
+		spi->master->flash_pm_supported(spi));
+}
+
 int spi_flash_read(struct spi_device *spi,
 		   struct spi_flash_read_message *msg);
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
