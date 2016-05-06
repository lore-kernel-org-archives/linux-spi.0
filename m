From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pic32-sqi: Remove pic32_sqi_setup and pic32_sqi_cleanup" to the spi tree
Date: Fri, 06 May 2016 18:19:09 +0100
Message-ID: <E1ayjPB-0006z2-Mc@debutante>
References: <1461481160.19798.1.camel@ingics.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461481160.19798.1.camel-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pic32-sqi: Remove pic32_sqi_setup and pic32_sqi_cleanup

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

>From 191ec113487e7e7adc4b890c290f63e9155264ad Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Date: Sun, 24 Apr 2016 14:59:20 +0800
Subject: [PATCH] spi: pic32-sqi: Remove pic32_sqi_setup and pic32_sqi_cleanup

Current code does not use ctldata at all, so remove spi_set_ctldata call.

spi_setup() will set spi->bits_per_word = 8 if it was not set, so remove
!spi->max_speed_hz checking.

The spi core allows absent of spi->max_speed_hz setting, if it was not set
spi_setup() assigns spi->master->max_speed_hz to it.

spi core allows spi->max_speed_hz > spi->master->max_speed_hz, in this case
spi core will limit the transfer speed to ensure xfer->speed_hz won't
greater than spi->master->max_speed_hz so remove checking if
spi->max_speed_hz is higher than spi->master->max_speed_hz.

As a result, both pic32_sqi_setup() and pic32_sqi_cleanup() can be removed.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pic32-sqi.c | 41 -----------------------------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 74b9e684b10d..ca3c8d94b290 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -460,45 +460,6 @@ static int pic32_sqi_unprepare_hardware(struct spi_master *master)
 	return 0;
 }
 
-/* This may be called twice for each spi dev */
-static int pic32_sqi_setup(struct spi_device *spi)
-{
-	struct pic32_sqi *sqi;
-
-	if (spi_get_ctldata(spi)) {
-		dev_err(&spi->dev, "is already associated\n");
-		return -EBUSY;
-	}
-
-	/* check word size */
-	if (!spi->bits_per_word) {
-		dev_err(&spi->dev, "No bits_per_word defined\n");
-		return -EINVAL;
-	}
-
-	/* check maximum SPI clk rate */
-	if (!spi->max_speed_hz) {
-		dev_err(&spi->dev, "No max speed HZ parameter\n");
-		return -EINVAL;
-	}
-
-	if (spi->master->max_speed_hz < spi->max_speed_hz) {
-		dev_err(&spi->dev, "max speed %u HZ is too high\n",
-			spi->max_speed_hz);
-		return -EINVAL;
-	}
-
-	sqi = spi_master_get_devdata(spi->master);
-	spi_set_ctldata(spi, (void *)sqi);
-
-	return 0;
-}
-
-static void pic32_sqi_cleanup(struct spi_device *spi)
-{
-	spi_set_ctldata(spi, (void *)NULL);
-}
-
 static int ring_desc_ring_alloc(struct pic32_sqi *sqi)
 {
 	struct ring_desc *rdesc;
@@ -700,8 +661,6 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	master->mode_bits	= SPI_MODE_3 | SPI_MODE_0 | SPI_TX_DUAL |
 				  SPI_RX_DUAL | SPI_TX_QUAD | SPI_RX_QUAD;
 	master->flags		= SPI_MASTER_HALF_DUPLEX;
-	master->setup		= pic32_sqi_setup;
-	master->cleanup		= pic32_sqi_cleanup;
 	master->can_dma		= pic32_sqi_can_dma;
 	master->bits_per_word_mask	= SPI_BPW_RANGE_MASK(8, 32);
 	master->transfer_one_message	= pic32_sqi_one_message;
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
