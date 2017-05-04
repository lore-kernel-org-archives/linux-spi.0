From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] spi: core: Replace S_IRUGO permissions by 0444
Date: Thu,  4 May 2017 16:29:56 +0200
Message-ID: <1493908196-13001-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Octal permissions are preferred over symbolic permissions.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7bb733d91519bc24..6f87fec409b5f6fd 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -80,7 +80,7 @@ static ssize_t spi_master_##field##_show(struct device *dev,		\
 	return spi_statistics_##field##_show(&master->statistics, buf);	\
 }									\
 static struct device_attribute dev_attr_spi_master_##field = {		\
-	.attr = { .name = file, .mode = S_IRUGO },			\
+	.attr = { .name = file, .mode = 0444 },				\
 	.show = spi_master_##field##_show,				\
 };									\
 static ssize_t spi_device_##field##_show(struct device *dev,		\
@@ -91,7 +91,7 @@ static ssize_t spi_device_##field##_show(struct device *dev,		\
 	return spi_statistics_##field##_show(&spi->statistics, buf);	\
 }									\
 static struct device_attribute dev_attr_spi_device_##field = {		\
-	.attr = { .name = file, .mode = S_IRUGO },			\
+	.attr = { .name = file, .mode = 0444 },				\
 	.show = spi_device_##field##_show,				\
 }
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
