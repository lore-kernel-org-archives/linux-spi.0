From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi: pxa2xx: Use gpiod_put() not gpiod_free()
Date: Fri, 22 Dec 2017 16:17:55 +0000
Message-ID: <20171222161755.2742-1-broonie@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>,
        Rasmus Villemoes <linux-qQsb+v5E8BnlAoU/VqSP6n9LOBIZ5rWg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

gpiod_free() is an internal function for gpiolib, gpiod_put() is the
correct external function.

Reported-by: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Suggested-by: Rasmus Villemoes <linux-qQsb+v5E8BnlAoU/VqSP6n9LOBIZ5rWg@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index c209dc1047b5..b0822d1dba29 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1237,7 +1237,7 @@ static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 	 * different chip_info, release previously requested GPIO
 	 */
 	if (chip->gpiod_cs) {
-		gpiod_free(chip->gpiod_cs);
+		gpiod_put(chip->gpiod_cs);
 		chip->gpiod_cs = NULL;
 	}
 
@@ -1417,7 +1417,7 @@ static void cleanup(struct spi_device *spi)
 
 	if (drv_data->ssp_type != CE4100_SSP && !drv_data->cs_gpiods &&
 	    chip->gpiod_cs)
-		gpiod_free(chip->gpiod_cs);
+		gpiod_put(chip->gpiod_cs);
 
 	kfree(chip);
 }
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
