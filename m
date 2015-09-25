From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Set the max_speed_hz of the master" to the spi tree
Date: Fri, 25 Sep 2015 09:55:44 -0700
Message-ID: <E1ZfWHg-0001Y4-NQ@finisterre>
References: <1443166038-31658-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443166038-31658-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Set the max_speed_hz of the master

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

>From 0eca7cf2696506006463b9d67bb6110c82d3e064 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Fri, 25 Sep 2015 10:27:17 +0300
Subject: [PATCH] spi: pxa2xx: Set the max_speed_hz of the master

Carry input clock of the controller in max_speed_hz of struct spi_master
instead of in own driver data. They mean the same thing and more over now
the max_speed_hz is not even set here.

As an added bonus this allows SPI core to validate that transfer speed is
not beyond the maximum input clock. This is not a problem in spi-pxa2xx as
the driver doesn't use transfer speed parameter directly but via input
clock divider calculation which will top at divide by one. However it's
better to validate speed before passing it here.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 12 ++++++------
 drivers/spi/spi-pxa2xx.h |  3 ---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index a25bc1d..0e075db 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -802,7 +802,7 @@ static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
 
 static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
 {
-	unsigned long ssp_clk = drv_data->max_clk_rate;
+	unsigned long ssp_clk = drv_data->master->max_speed_hz;
 	const struct ssp_device *ssp = drv_data->ssp;
 
 	rate = min_t(int, ssp_clk, rate);
@@ -1217,13 +1217,13 @@ static int setup(struct spi_device *spi)
 	/* NOTE:  PXA25x_SSP _could_ use external clocking ... */
 	cr0 = pxa2xx_configure_sscr0(drv_data, clk_div, spi->bits_per_word);
 	if (!pxa25x_ssp_comp(drv_data))
-		dev_dbg(&spi->dev, "%ld Hz actual, %s\n",
-			drv_data->max_clk_rate
+		dev_dbg(&spi->dev, "%u Hz actual, %s\n",
+			drv_data->master->max_speed_hz
 				/ (1 + ((cr0 & SSCR0_SCR(0xfff)) >> 8)),
 			chip->enable_dma ? "DMA" : "PIO");
 	else
-		dev_dbg(&spi->dev, "%ld Hz actual, %s\n",
-			drv_data->max_clk_rate / 2
+		dev_dbg(&spi->dev, "%u Hz actual, %s\n",
+			drv_data->master->max_speed_hz / 2
 				/ (1 + ((cr0 & SSCR0_SCR(0x0ff)) >> 8)),
 			chip->enable_dma ? "DMA" : "PIO");
 
@@ -1473,7 +1473,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	/* Enable SOC clock */
 	clk_prepare_enable(ssp->clk);
 
-	drv_data->max_clk_rate = clk_get_rate(ssp->clk);
+	master->max_speed_hz = clk_get_rate(ssp->clk);
 
 	/* Load default SSP configuration */
 	pxa2xx_spi_write(drv_data, SSCR0, 0);
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index b91bda2..fd7a7bc 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -46,9 +46,6 @@ struct driver_data {
 	u32 clear_sr;
 	u32 mask_sr;
 
-	/* Maximun clock rate */
-	unsigned long max_clk_rate;
-
 	/* Message Transfer pump */
 	struct tasklet_struct pump_transfers;
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
