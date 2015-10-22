From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: move debug messages to pump_transfer()" to the spi tree
Date: Fri, 23 Oct 2015 08:57:23 +0900
Message-ID: <E1ZpPjX-00030m-6r@finisterre>
References: <1445521485-2029-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445521485-2029-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: move debug messages to pump_transfer()

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

>From d74c4b1c61ecc5ad8158ac649245fdfc9601c1b5 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Thu, 22 Oct 2015 16:44:39 +0300
Subject: [PATCH] spi: pxa2xx: move debug messages to pump_transfer()

The speed can be changed from transfer to transfer, that's why the messages
do not depict the actual values during ->setup(). Move debug messages from
->setup() to pump_transfers(). Get rid of leftovers as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 158967a..986a291 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -955,7 +955,18 @@ static void pump_transfers(unsigned long data)
 					     "pump_transfers: DMA burst size reduced to match bits_per_word\n");
 	}
 
+	/* NOTE:  PXA25x_SSP _could_ use external clocking ... */
 	cr0 = pxa2xx_configure_sscr0(drv_data, clk_div, bits);
+	if (!pxa25x_ssp_comp(drv_data))
+		dev_dbg(&message->spi->dev, "%u Hz actual, %s\n",
+			drv_data->master->max_speed_hz
+				/ (1 + ((cr0 & SSCR0_SCR(0xfff)) >> 8)),
+			chip->enable_dma ? "DMA" : "PIO");
+	else
+		dev_dbg(&message->spi->dev, "%u Hz actual, %s\n",
+			drv_data->master->max_speed_hz / 2
+				/ (1 + ((cr0 & SSCR0_SCR(0x0ff)) >> 8)),
+			chip->enable_dma ? "DMA" : "PIO");
 
 	message->state = RUNNING_STATE;
 
@@ -1099,9 +1110,7 @@ static int setup(struct spi_device *spi)
 	struct chip_data *chip;
 	const struct lpss_config *config;
 	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
-	unsigned int clk_div;
 	uint tx_thres, tx_hi_thres, rx_thres;
-	u32 cr0;
 
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
@@ -1192,8 +1201,6 @@ static int setup(struct spi_device *spi)
 		}
 	}
 
-	clk_div = pxa2xx_ssp_get_clk_div(drv_data, chip, spi->max_speed_hz);
-
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
 		chip->threshold = (QUARK_X1000_SSCR1_RxTresh(rx_thres)
@@ -1214,19 +1221,6 @@ static int setup(struct spi_device *spi)
 	if (spi->mode & SPI_LOOP)
 		chip->cr1 |= SSCR1_LBM;
 
-	/* NOTE:  PXA25x_SSP _could_ use external clocking ... */
-	cr0 = pxa2xx_configure_sscr0(drv_data, clk_div, spi->bits_per_word);
-	if (!pxa25x_ssp_comp(drv_data))
-		dev_dbg(&spi->dev, "%u Hz actual, %s\n",
-			drv_data->master->max_speed_hz
-				/ (1 + ((cr0 & SSCR0_SCR(0xfff)) >> 8)),
-			chip->enable_dma ? "DMA" : "PIO");
-	else
-		dev_dbg(&spi->dev, "%u Hz actual, %s\n",
-			drv_data->master->max_speed_hz / 2
-				/ (1 + ((cr0 & SSCR0_SCR(0x0ff)) >> 8)),
-			chip->enable_dma ? "DMA" : "PIO");
-
 	if (spi->bits_per_word <= 8) {
 		chip->n_bytes = 1;
 		chip->read = u8_reader;
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
