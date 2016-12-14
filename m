From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-ath79: support multiple internal chip select lines" to the spi tree
Date: Wed, 14 Dec 2016 18:03:51 +0000
Message-ID: <E1cHDuB-0007EP-8p@debutante>
References: <20161209194853.71018-1-nbd@nbd.name>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: Felix Fietkau <nbd-Vt+b4OUoWG0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161209194853.71018-1-nbd-Vt+b4OUoWG0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-ath79: support multiple internal chip select lines

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 22c76326bff810d220fffdbaab949d09e2564067 Mon Sep 17 00:00:00 2001
From: Felix Fietkau <nbd-Vt+b4OUoWG0@public.gmane.org>
Date: Fri, 9 Dec 2016 20:48:52 +0100
Subject: [PATCH] spi: spi-ath79: support multiple internal chip select lines

Several devices with multiple flash chips use the internal chip select
lines. Don't assume that chip select 1 and above are GPIO lines.

Signed-off-by: Felix Fietkau <nbd-Vt+b4OUoWG0@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-ath79.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index f369174fbd88..3e9b928b563b 100644
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
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
