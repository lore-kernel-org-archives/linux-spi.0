From: Felix Fietkau <nbd-Vt+b4OUoWG0@public.gmane.org>
Subject: [PATCH 2/2] spi: spi-ath79: use gpio_set_value_cansleep for GPIO chip select
Date: Fri,  9 Dec 2016 20:48:53 +0100
Message-ID: <20161209194853.71018-2-nbd@nbd.name>
References: <20161209194853.71018-1-nbd@nbd.name>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161209194853.71018-1-nbd-Vt+b4OUoWG0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Felix Fietkau <nbd-Vt+b4OUoWG0@public.gmane.org>
---
 drivers/spi/spi-ath79.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index d51c99a..2517e1e 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -80,7 +80,7 @@ static void ath79_spi_chipselect(struct spi_device *spi, int is_active)
 
 	if (gpio_is_valid(spi->cs_gpio)) {
 		/* SPI is normally active-low */
-		gpio_set_value(spi->cs_gpio, cs_high);
+		gpio_set_value_cansleep(spi->cs_gpio, cs_high);
 	} else {
 		u32 cs_bit = AR71XX_SPI_IOC_CS(spi->chip_select);
 
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
