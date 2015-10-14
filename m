From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 03/10] spi: dw: remove unneeded cr0 member of struct chip_data
Date: Wed, 14 Oct 2015 23:12:18 +0300
Message-ID: <1444853545-59868-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1444853545-59868-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444853545-59868-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Since we recalculate cr0 each time we start a transfer the chip_data->cr0
becomes redundant. Remove it and related pieces.

This is a follow up to commit 0ed36990a93b (spi: dw: Remove needless if
statements).

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 1799416..ad370b9 100644
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
2.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
