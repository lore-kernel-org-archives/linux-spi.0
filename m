From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dw: Remove needless if statements" to the spi tree
Date: Thu, 17 Sep 2015 18:37:09 +0100
Message-ID: <E1Zcd7N-0006W2-Dj@finisterre>
References: <1442323588-29642-11-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442323588-29642-11-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dw: Remove needless if statements

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

>From 0ed36990a93b23c4873c77cdc1423429e40ed469 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Tue, 15 Sep 2015 16:26:23 +0300
Subject: [PATCH] spi: dw: Remove needless if statements

SPI core validates both bits_per_word and speed_hz transfer parameters and
defaults to spi->bits_per_word and spi->max_speed_hz in case these per
transfer parameters are not set. This allows to remove related if
statements as they evaluate always to true and reduce indentation.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-dw.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 4fbfcdc..2b5d736 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -309,34 +309,29 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	cr0 = chip->cr0;
 
 	/* Handle per transfer options for bpw and speed */
-	if (transfer->speed_hz) {
-		speed = chip->speed_hz;
+	speed = chip->speed_hz;
+	if ((transfer->speed_hz != speed) || !chip->clk_div) {
+		speed = transfer->speed_hz;
 
-		if ((transfer->speed_hz != speed) || !chip->clk_div) {
-			speed = transfer->speed_hz;
+		/* clk_div doesn't support odd number */
+		clk_div = (dws->max_freq / speed + 1) & 0xfffe;
 
-			/* clk_div doesn't support odd number */
-			clk_div = (dws->max_freq / speed + 1) & 0xfffe;
+		chip->speed_hz = speed;
+		chip->clk_div = clk_div;
 
-			chip->speed_hz = speed;
-			chip->clk_div = clk_div;
-
-			spi_set_clk(dws, chip->clk_div);
-		}
+		spi_set_clk(dws, chip->clk_div);
 	}
-	if (transfer->bits_per_word) {
-		if (transfer->bits_per_word == 8) {
-			dws->n_bytes = 1;
-			dws->dma_width = 1;
-		} else if (transfer->bits_per_word == 16) {
-			dws->n_bytes = 2;
-			dws->dma_width = 2;
-		}
-		cr0 = (transfer->bits_per_word - 1)
-			| (chip->type << SPI_FRF_OFFSET)
-			| (spi->mode << SPI_MODE_OFFSET)
-			| (chip->tmode << SPI_TMOD_OFFSET);
+	if (transfer->bits_per_word == 8) {
+		dws->n_bytes = 1;
+		dws->dma_width = 1;
+	} else if (transfer->bits_per_word == 16) {
+		dws->n_bytes = 2;
+		dws->dma_width = 2;
 	}
+	cr0 = (transfer->bits_per_word - 1)
+		| (chip->type << SPI_FRF_OFFSET)
+		| (spi->mode << SPI_MODE_OFFSET)
+		| (chip->tmode << SPI_TMOD_OFFSET);
 
 	/*
 	 * Adjust transfer mode if necessary. Requires platform dependent
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
