From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Remove if statement that is always true in pump_transfers()" to the spi tree
Date: Thu, 17 Sep 2015 18:37:05 +0100
Message-ID: <E1Zcd7J-0006U2-Cu@finisterre>
References: <1442323588-29642-15-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442323588-29642-15-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Remove if statement that is always true in pump_transfers()

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

>From 196b0e2cf2373f43d7b0e8c1a63e9d528c06e1df Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Tue, 15 Sep 2015 16:26:27 +0300
Subject: [PATCH] spi: pxa2xx: Remove if statement that is always true in
 pump_transfers()

This is continuation to previous commit by separating unindentation from
variable removal done in previous commit. As said SPI core have validated
both the speed_hz and bits_per_word and the if statement here evaluates
always to true.

Remove the test and unindent the code block accordingly. While at it remove
also needless "cr0 = chip->cr0" as cr0 will be overwritten anyway and fix
block comment style.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 76 +++++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index dc6f3f1..ebafd53 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -918,47 +918,45 @@ static void pump_transfers(unsigned long data)
 	drv_data->read = drv_data->rx ? chip->read : null_reader;
 
 	/* Change speed and bit per word on a per transfer */
-	cr0 = chip->cr0;
-	if (transfer->speed_hz || transfer->bits_per_word) {
-
-		bits = transfer->bits_per_word;
-		speed = transfer->speed_hz;
-
-		clk_div = pxa2xx_ssp_get_clk_div(drv_data, chip, speed);
-
-		if (bits <= 8) {
-			drv_data->n_bytes = 1;
-			drv_data->read = drv_data->read != null_reader ?
-						u8_reader : null_reader;
-			drv_data->write = drv_data->write != null_writer ?
-						u8_writer : null_writer;
-		} else if (bits <= 16) {
-			drv_data->n_bytes = 2;
-			drv_data->read = drv_data->read != null_reader ?
-						u16_reader : null_reader;
-			drv_data->write = drv_data->write != null_writer ?
-						u16_writer : null_writer;
-		} else if (bits <= 32) {
-			drv_data->n_bytes = 4;
-			drv_data->read = drv_data->read != null_reader ?
-						u32_reader : null_reader;
-			drv_data->write = drv_data->write != null_writer ?
-						u32_writer : null_writer;
-		}
-		/* if bits/word is changed in dma mode, then must check the
-		 * thresholds and burst also */
-		if (chip->enable_dma) {
-			if (pxa2xx_spi_set_dma_burst_and_threshold(chip,
-							message->spi,
-							bits, &dma_burst,
-							&dma_thresh))
-				dev_warn_ratelimited(&message->spi->dev,
-						     "pump_transfers: DMA burst size reduced to match bits_per_word\n");
-		}
-
-		cr0 = pxa2xx_configure_sscr0(drv_data, clk_div, bits);
+	bits = transfer->bits_per_word;
+	speed = transfer->speed_hz;
+
+	clk_div = pxa2xx_ssp_get_clk_div(drv_data, chip, speed);
+
+	if (bits <= 8) {
+		drv_data->n_bytes = 1;
+		drv_data->read = drv_data->read != null_reader ?
+					u8_reader : null_reader;
+		drv_data->write = drv_data->write != null_writer ?
+					u8_writer : null_writer;
+	} else if (bits <= 16) {
+		drv_data->n_bytes = 2;
+		drv_data->read = drv_data->read != null_reader ?
+					u16_reader : null_reader;
+		drv_data->write = drv_data->write != null_writer ?
+					u16_writer : null_writer;
+	} else if (bits <= 32) {
+		drv_data->n_bytes = 4;
+		drv_data->read = drv_data->read != null_reader ?
+					u32_reader : null_reader;
+		drv_data->write = drv_data->write != null_writer ?
+					u32_writer : null_writer;
+	}
+	/*
+	 * if bits/word is changed in dma mode, then must check the
+	 * thresholds and burst also
+	 */
+	if (chip->enable_dma) {
+		if (pxa2xx_spi_set_dma_burst_and_threshold(chip,
+						message->spi,
+						bits, &dma_burst,
+						&dma_thresh))
+			dev_warn_ratelimited(&message->spi->dev,
+					     "pump_transfers: DMA burst size reduced to match bits_per_word\n");
 	}
 
+	cr0 = pxa2xx_configure_sscr0(drv_data, clk_div, bits);
+
 	message->state = RUNNING_STATE;
 
 	drv_data->dma_mapped = 0;
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
