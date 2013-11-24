From: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] spi: spi-gpio: Use 'cansleep' variants to access GPIO
Date: Sun, 24 Nov 2013 09:37:01 -0300
Message-ID: <1385296621-23638-1-git-send-email-ezequiel.garcia@free-electrons.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The GPIO chip in use could be of any kind, and therefore might sleep
when accesing the GPIO lines. Take account of this by using cansleep
instead, which is the most generic case.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/spi/spi-gpio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 3fb09f9..7beeb29 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -115,17 +115,17 @@ spi_to_pdata(const struct spi_device *spi)
 
 static inline void setsck(const struct spi_device *spi, int is_on)
 {
-	gpio_set_value(SPI_SCK_GPIO, is_on);
+	gpio_set_value_cansleep(SPI_SCK_GPIO, is_on);
 }
 
 static inline void setmosi(const struct spi_device *spi, int is_on)
 {
-	gpio_set_value(SPI_MOSI_GPIO, is_on);
+	gpio_set_value_cansleep(SPI_MOSI_GPIO, is_on);
 }
 
 static inline int getmiso(const struct spi_device *spi)
 {
-	return !!gpio_get_value(SPI_MISO_GPIO);
+	return !!gpio_get_value_cansleep(SPI_MISO_GPIO);
 }
 
 #undef pdata
@@ -229,7 +229,7 @@ static void spi_gpio_chipselect(struct spi_device *spi, int is_active)
 
 	if (cs != SPI_GPIO_NO_CHIPSELECT) {
 		/* SPI is normally active-low */
-		gpio_set_value(cs, (spi->mode & SPI_CS_HIGH) ? is_active : !is_active);
+		gpio_set_value_cansleep(cs, (spi->mode & SPI_CS_HIGH) ? is_active : !is_active);
 	}
 }
 
-- 
1.8.1.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
