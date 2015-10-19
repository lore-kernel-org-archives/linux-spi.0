From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dw: remove unneeded cr0 member of struct chip_data" to the spi tree
Date: Mon, 19 Oct 2015 20:43:30 +0100
Message-ID: <E1ZoGLC-0002MD-Lu@debutante>
References: <1444853545-59868-4-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444853545-59868-4-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dw: remove unneeded cr0 member of struct chip_data

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

>From 4adb1f8f880081ee9921ebd399786387e0cd6f52 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Wed, 14 Oct 2015 23:12:18 +0300
Subject: [PATCH] spi: dw: remove unneeded cr0 member of struct chip_data

Since we recalculate cr0 each time we start a transfer the chip_data->cr0
becomes redundant. Remove it and related pieces.

This is a follow up to commit 0ed36990a93b (spi: dw: Remove needless if
statements).

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-dw.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 749a831f26ce..c769c2a5da16 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -30,7 +30,6 @@
 
 /* Slave spi_dev related */
 struct chip_data {
-	u16 cr0;
 	u8 cs;			/* chip select pin */
 	u8 n_bytes;		/* current is a 1/2/4 byte op */
 	u8 tmode;		/* TR/TO/RO/EEPROM */
@@ -291,7 +290,7 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	u16 txlevel = 0;
 	u16 clk_div = 0;
 	u32 speed = 0;
-	u32 cr0 = 0;
+	u32 cr0;
 	int ret;
 
 	dws->dma_mapped = 0;
@@ -306,8 +305,6 @@ static int dw_spi_transfer_one(struct spi_master *master,
 
 	spi_enable_chip(dws, 0);
 
-	cr0 = chip->cr0;
-
 	/* Handle per transfer options for bpw and speed */
 	speed = chip->speed_hz;
 	if ((transfer->speed_hz != speed) || !chip->clk_div) {
@@ -328,6 +325,7 @@ static int dw_spi_transfer_one(struct spi_master *master,
 		dws->n_bytes = 2;
 		dws->dma_width = 2;
 	}
+	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
 	cr0 = (transfer->bits_per_word - 1)
 		| (chip->type << SPI_FRF_OFFSET)
 		| (spi->mode << SPI_MODE_OFFSET)
@@ -449,14 +447,6 @@ static int dw_spi_setup(struct spi_device *spi)
 	chip->bits_per_word = spi->bits_per_word;
 
 	chip->tmode = 0; /* Tx & Rx */
-	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
-	chip->cr0 = (chip->bits_per_word - 1)
-			| (chip->type << SPI_FRF_OFFSET)
-			| (spi->mode  << SPI_MODE_OFFSET)
-			| (chip->tmode << SPI_TMOD_OFFSET);
-
-	if (spi->mode & SPI_LOOP)
-		chip->cr0 |= 1 << SPI_SRL_OFFSET;
 
 	if (gpio_is_valid(spi->cs_gpio)) {
 		ret = gpio_direction_output(spi->cs_gpio,
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
