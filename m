From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-ath79: use gpio_set_value_cansleep for GPIO chip select" to the spi tree
Date: Wed, 14 Dec 2016 18:03:47 +0000
Message-ID: <E1cHDu7-0007DS-Ak@debutante>
References: <20161209194853.71018-2-nbd@nbd.name>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: Felix Fietkau <nbd-Vt+b4OUoWG0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161209194853.71018-2-nbd-Vt+b4OUoWG0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-ath79: use gpio_set_value_cansleep for GPIO chip select

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

>From 91829a9a25cc931b76b01aa091a52e0edd649a72 Mon Sep 17 00:00:00 2001
From: Felix Fietkau <nbd-Vt+b4OUoWG0@public.gmane.org>
Date: Fri, 9 Dec 2016 20:48:53 +0100
Subject: [PATCH] spi: spi-ath79: use gpio_set_value_cansleep for GPIO chip
 select

Signed-off-by: Felix Fietkau <nbd-Vt+b4OUoWG0@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-ath79.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 3e9b928b563b..b89cee11f418 100644
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
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
