From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/1] spi: core: use gpio_is_valid() helper
Date: Tue, 20 Oct 2015 12:28:29 +0300
Message-ID: <1445333309-15436-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Check if GPIO pin is valid by API helper function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e900164..33836ee8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -668,7 +668,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 	if (spi->mode & SPI_CS_HIGH)
 		enable = !enable;
 
-	if (spi->cs_gpio >= 0)
+	if (gpio_is_valid(spi->cs_gpio))
 		gpio_set_value(spi->cs_gpio, !enable);
 	else if (spi->master->set_cs)
 		spi->master->set_cs(spi, !enable);
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
