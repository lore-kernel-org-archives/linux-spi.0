From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1] spi: core: Propagate error code of add_uevent_var()
Date: Wed, 26 Jul 2017 16:14:00 +0300
Message-ID: <20170726131400.71301-1-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

add_uevent_var() can fail, let caller know about this.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0725c78b0de6..ec69293d26be 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -321,8 +321,7 @@ static int spi_uevent(struct device *dev, struct kobj_uevent_env *env)
 	if (rc != -ENODEV)
 		return rc;
 
-	add_uevent_var(env, "MODALIAS=%s%s", SPI_MODULE_PREFIX, spi->modalias);
-	return 0;
+	return add_uevent_var(env, "MODALIAS=%s%s", SPI_MODULE_PREFIX, spi->modalias);
 }
 
 struct bus_type spi_bus_type = {
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
