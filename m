From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Remove cr0 variable from struct chip_data" to the spi tree
Date: Thu, 17 Sep 2015 18:37:04 +0100
Message-ID: <E1Zcd7I-0006TZ-CD@finisterre>
References: <1442323588-29642-16-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442323588-29642-16-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Remove cr0 variable from struct chip_data

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

>From b69d42b5c44bcfc1c73fe185d4644487f1bd3193 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Tue, 15 Sep 2015 16:26:28 +0300
Subject: [PATCH] spi: pxa2xx: Remove cr0 variable from struct chip_data

There hasn't been need to carry chip->cr0 after SPI core started to
validate speed_hz and bits_per_word transfer parameters. That effectively
caused that pump_transfers() always recalculated it and practically
chip->cr0 is used locally in setup() for debug prints only.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 10 ++++------
 drivers/spi/spi-pxa2xx.h |  1 -
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index ebafd53..a25bc1d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1101,6 +1101,7 @@ static int setup(struct spi_device *spi)
 	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
 	unsigned int clk_div;
 	uint tx_thres, tx_hi_thres, rx_thres;
+	u32 cr0;
 
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
@@ -1193,8 +1194,6 @@ static int setup(struct spi_device *spi)
 
 	clk_div = pxa2xx_ssp_get_clk_div(drv_data, chip, spi->max_speed_hz);
 
-	chip->cr0 = pxa2xx_configure_sscr0(drv_data, clk_div,
-					   spi->bits_per_word);
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
 		chip->threshold = (QUARK_X1000_SSCR1_RxTresh(rx_thres)
@@ -1216,15 +1215,16 @@ static int setup(struct spi_device *spi)
 		chip->cr1 |= SSCR1_LBM;
 
 	/* NOTE:  PXA25x_SSP _could_ use external clocking ... */
+	cr0 = pxa2xx_configure_sscr0(drv_data, clk_div, spi->bits_per_word);
 	if (!pxa25x_ssp_comp(drv_data))
 		dev_dbg(&spi->dev, "%ld Hz actual, %s\n",
 			drv_data->max_clk_rate
-				/ (1 + ((chip->cr0 & SSCR0_SCR(0xfff)) >> 8)),
+				/ (1 + ((cr0 & SSCR0_SCR(0xfff)) >> 8)),
 			chip->enable_dma ? "DMA" : "PIO");
 	else
 		dev_dbg(&spi->dev, "%ld Hz actual, %s\n",
 			drv_data->max_clk_rate / 2
-				/ (1 + ((chip->cr0 & SSCR0_SCR(0x0ff)) >> 8)),
+				/ (1 + ((cr0 & SSCR0_SCR(0x0ff)) >> 8)),
 			chip->enable_dma ? "DMA" : "PIO");
 
 	if (spi->bits_per_word <= 8) {
@@ -1236,8 +1236,6 @@ static int setup(struct spi_device *spi)
 		chip->read = u16_reader;
 		chip->write = u16_writer;
 	} else if (spi->bits_per_word <= 32) {
-		if (!is_quark_x1000_ssp(drv_data))
-			chip->cr0 |= SSCR0_EDSS;
 		chip->n_bytes = 4;
 		chip->read = u32_reader;
 		chip->write = u32_writer;
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 0875e98..b91bda2 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -86,7 +86,6 @@ struct driver_data {
 };
 
 struct chip_data {
-	u32 cr0;
 	u32 cr1;
 	u32 dds_rate;
 	u32 psp;
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
