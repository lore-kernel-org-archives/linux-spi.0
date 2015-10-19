From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dw: remove bits_per_word member of struct chip_data" to the spi tree
Date: Mon, 19 Oct 2015 20:43:29 +0100
Message-ID: <E1ZoGLB-0002Lk-Nn@debutante>
References: <1444853545-59868-6-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444853545-59868-6-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dw: remove bits_per_word member of struct chip_data

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

>From 863cb2f72e636c8721482fd88e256facb59c5737 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Wed, 14 Oct 2015 23:12:20 +0300
Subject: [PATCH] spi: dw: remove bits_per_word member of struct chip_data

There is no need to carry over spi->bits_per_word and Co from ->setup() in
struct chip_data since ->transfer_one() will anyway take the transfer
parameters from struct spi_transfer. This is since SPI core validates both
bits_per_word transfer parameter and defaults to spi->bits_per_word in case
that per transfer parameter is not set.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-dw.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index c769c2a5da16..c8f7f161213d 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -31,17 +31,14 @@
 /* Slave spi_dev related */
 struct chip_data {
 	u8 cs;			/* chip select pin */
-	u8 n_bytes;		/* current is a 1/2/4 byte op */
 	u8 tmode;		/* TR/TO/RO/EEPROM */
 	u8 type;		/* SPI/SSP/MicroWire */
 
 	u8 poll_mode;		/* 1 means use poll mode */
 
-	u32 dma_width;
 	u32 rx_threshold;
 	u32 tx_threshold;
 	u8 enable_dma;
-	u8 bits_per_word;
 	u16 clk_div;		/* baud rate divider */
 	u32 speed_hz;		/* baud rate */
 	void (*cs_control)(u32 command);
@@ -294,8 +291,6 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	int ret;
 
 	dws->dma_mapped = 0;
-	dws->n_bytes = chip->n_bytes;
-	dws->dma_width = chip->dma_width;
 
 	dws->tx = (void *)transfer->tx_buf;
 	dws->tx_end = dws->tx + transfer->len;
@@ -324,6 +319,8 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	} else if (transfer->bits_per_word == 16) {
 		dws->n_bytes = 2;
 		dws->dma_width = 2;
+	} else {
+		return -EINVAL;
 	}
 	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
 	cr0 = (transfer->bits_per_word - 1)
@@ -437,15 +434,6 @@ static int dw_spi_setup(struct spi_device *spi)
 		chip->tx_threshold = 0;
 	}
 
-	if (spi->bits_per_word == 8) {
-		chip->n_bytes = 1;
-		chip->dma_width = 1;
-	} else if (spi->bits_per_word == 16) {
-		chip->n_bytes = 2;
-		chip->dma_width = 2;
-	}
-	chip->bits_per_word = spi->bits_per_word;
-
 	chip->tmode = 0; /* Tx & Rx */
 
 	if (gpio_is_valid(spi->cs_gpio)) {
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
