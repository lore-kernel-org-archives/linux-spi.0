From: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>
Subject: [PATCH 1/3] spi: use to_spi_device
Date: Wed, 23 Dec 2015 00:18:41 +0800
Message-ID: <a196696aefe502e775a025cdb662c39cbdabf412.1450800897.git.geliangtang@163.com>
Cc: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use to_spi_device() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>
---
 drivers/spi/spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 19659c4..2ae1588 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -84,8 +84,7 @@ static ssize_t spi_device_##field##_show(struct device *dev,		\
 					 struct device_attribute *attr,	\
 					char *buf)			\
 {									\
-	struct spi_device *spi = container_of(dev,			\
-					      struct spi_device, dev);	\
+	struct spi_device *spi = to_spi_device(dev);			\
 	return spi_statistics_##field##_show(&spi->statistics, buf);	\
 }									\
 static struct device_attribute dev_attr_spi_device_##field = {		\
-- 
2.5.0


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
