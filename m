From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Remove two variables from struct chip_data" to the spi tree
Date: Thu, 17 Sep 2015 18:37:06 +0100
Message-ID: <E1Zcd7K-0006Ud-DT@finisterre>
References: <1442323588-29642-14-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442323588-29642-14-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Remove two variables from struct chip_data

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

>From 4f1474b3b786305d77c93c232f65d40018043e9f Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Tue, 15 Sep 2015 16:26:26 +0300
Subject: [PATCH] spi: pxa2xx: Remove two variables from struct chip_data

There is no need to carry spi->max_speed_hz and spi->bits_per_word from
setup() in "struct chip_data" since pump_transfers() will anyway take the
transfer parameters from "struct spi_transfer". This is since SPI core
validates both bits_per_word and speed_hz transfer parameters and defaults
to spi->bits_per_word and spi->max_speed_hz in case these per transfer
parameters are not set.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 12 ++----------
 drivers/spi/spi-pxa2xx.h |  2 --
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index fdd79197..dc6f3f1 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -921,14 +921,8 @@ static void pump_transfers(unsigned long data)
 	cr0 = chip->cr0;
 	if (transfer->speed_hz || transfer->bits_per_word) {
 
-		bits = chip->bits_per_word;
-		speed = chip->speed_hz;
-
-		if (transfer->speed_hz)
-			speed = transfer->speed_hz;
-
-		if (transfer->bits_per_word)
-			bits = transfer->bits_per_word;
+		bits = transfer->bits_per_word;
+		speed = transfer->speed_hz;
 
 		clk_div = pxa2xx_ssp_get_clk_div(drv_data, chip, speed);
 
@@ -1200,7 +1194,6 @@ static int setup(struct spi_device *spi)
 	}
 
 	clk_div = pxa2xx_ssp_get_clk_div(drv_data, chip, spi->max_speed_hz);
-	chip->speed_hz = spi->max_speed_hz;
 
 	chip->cr0 = pxa2xx_configure_sscr0(drv_data, clk_div,
 					   spi->bits_per_word);
@@ -1251,7 +1244,6 @@ static int setup(struct spi_device *spi)
 		chip->read = u32_reader;
 		chip->write = u32_writer;
 	}
-	chip->bits_per_word = spi->bits_per_word;
 
 	spi_set_ctldata(spi, chip);
 
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 0a9b639..0875e98 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -98,8 +98,6 @@ struct chip_data {
 	u16 lpss_rx_threshold;
 	u16 lpss_tx_threshold;
 	u8 enable_dma;
-	u8 bits_per_word;
-	u32 speed_hz;
 	union {
 		int gpio_cs;
 		unsigned int frm;
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
