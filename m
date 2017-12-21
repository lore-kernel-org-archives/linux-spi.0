From: Rasmus Villemoes <linux-qQsb+v5E8BnlAoU/VqSP6n9LOBIZ5rWg@public.gmane.org>
Subject: [PATCH] spi: pxa2xx: avoid redundant gpio_to_desc(desc_to_gpio()) round-trip
Date: Thu, 21 Dec 2017 01:37:31 +0100
Message-ID: <20171221003731.21633-1-linux@rasmusvillemoes.dk>
Cc: Rasmus Villemoes <linux-qQsb+v5E8BnlAoU/VqSP6n9LOBIZ5rWg@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

gpio_free(gpio) simply does gpiod_free(gpio_to_desc(gpio)), so it's
simpler and cleaner to use gpiod_free directly.

Signed-off-by: Rasmus Villemoes <linux-qQsb+v5E8BnlAoU/VqSP6n9LOBIZ5rWg@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 4cb515a3104c..c209dc1047b5 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1237,7 +1237,7 @@ static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 	 * different chip_info, release previously requested GPIO
 	 */
 	if (chip->gpiod_cs) {
-		gpio_free(desc_to_gpio(chip->gpiod_cs));
+		gpiod_free(chip->gpiod_cs);
 		chip->gpiod_cs = NULL;
 	}
 
@@ -1417,7 +1417,7 @@ static void cleanup(struct spi_device *spi)
 
 	if (drv_data->ssp_type != CE4100_SSP && !drv_data->cs_gpiods &&
 	    chip->gpiod_cs)
-		gpio_free(desc_to_gpio(chip->gpiod_cs));
+		gpiod_free(chip->gpiod_cs);
 
 	kfree(chip);
 }
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
