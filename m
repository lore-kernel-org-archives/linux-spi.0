From: Felix Fietkau <nbd-Vt+b4OUoWG0@public.gmane.org>
Subject: [PATCH 1/2] spi: spi-ath79: support multiple internal chip select lines
Date: Fri,  9 Dec 2016 20:48:52 +0100
Message-ID: <20161209194853.71018-1-nbd@nbd.name>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Several devices with multiple flash chips use the internal chip select
lines. Don't assume that chip select 1 and above are GPIO lines.

Signed-off-by: Felix Fietkau <nbd-Vt+b4OUoWG0@public.gmane.org>
---
 drivers/spi/spi-ath79.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 6165bf2..d51c99a 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -78,14 +78,16 @@ static void ath79_spi_chipselect(struct spi_device *spi, int is_active)
 		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
 	}
 
-	if (spi->chip_select) {
+	if (gpio_is_valid(spi->cs_gpio)) {
 		/* SPI is normally active-low */
 		gpio_set_value(spi->cs_gpio, cs_high);
 	} else {
+		u32 cs_bit = AR71XX_SPI_IOC_CS(spi->chip_select);
+
 		if (cs_high)
-			sp->ioc_base |= AR71XX_SPI_IOC_CS0;
+			sp->ioc_base |= cs_bit;
 		else
-			sp->ioc_base &= ~AR71XX_SPI_IOC_CS0;
+			sp->ioc_base &= ~cs_bit;
 
 		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
 	}
@@ -118,11 +120,8 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
 	struct ath79_spi *sp = ath79_spidev_to_sp(spi);
 	int status;
 
-	if (spi->chip_select && !gpio_is_valid(spi->cs_gpio))
-		return -EINVAL;
-
 	status = 0;
-	if (spi->chip_select) {
+	if (gpio_is_valid(spi->cs_gpio)) {
 		unsigned long flags;
 
 		flags = GPIOF_DIR_OUT;
@@ -134,10 +133,12 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
 		status = gpio_request_one(spi->cs_gpio, flags,
 					  dev_name(&spi->dev));
 	} else {
+		u32 cs_bit = AR71XX_SPI_IOC_CS(spi->chip_select);
+
 		if (spi->mode & SPI_CS_HIGH)
-			sp->ioc_base &= ~AR71XX_SPI_IOC_CS0;
+			sp->ioc_base &= ~cs_bit;
 		else
-			sp->ioc_base |= AR71XX_SPI_IOC_CS0;
+			sp->ioc_base |= cs_bit;
 
 		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
 	}
@@ -147,7 +148,7 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
 
 static void ath79_spi_cleanup_cs(struct spi_device *spi)
 {
-	if (spi->chip_select) {
+	if (gpio_is_valid(spi->cs_gpio)) {
 		gpio_free(spi->cs_gpio);
 	}
 }
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
