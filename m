From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: derive struct chip_data from struct drv_data" to the spi tree
Date: Fri, 23 Oct 2015 08:57:21 +0900
Message-ID: <E1ZpPjV-00030J-Qi@finisterre>
References: <1445521485-2029-2-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445521485-2029-2-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: derive struct chip_data from struct drv_data

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

>From d2c2f6a47633a36bc8db8c802f7c284da36a7a53 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Thu, 22 Oct 2015 16:44:40 +0300
Subject: [PATCH] spi: pxa2xx: derive struct chip_data from struct drv_data

Since we call pxa2xx_ssp_get_clk_div() from pump_transfers() we may derive
pointer to struct chip_data from struct drv_data like it's done in the rest
of the functions. This will make it less errorprone.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 986a291..4fddc2a 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -814,8 +814,9 @@ static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
 }
 
 static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
-					   struct chip_data *chip, int rate)
+					   int rate)
 {
+	struct chip_data *chip = drv_data->cur_chip;
 	unsigned int clk_div;
 
 	switch (drv_data->ssp_type) {
@@ -921,7 +922,7 @@ static void pump_transfers(unsigned long data)
 	bits = transfer->bits_per_word;
 	speed = transfer->speed_hz;
 
-	clk_div = pxa2xx_ssp_get_clk_div(drv_data, chip, speed);
+	clk_div = pxa2xx_ssp_get_clk_div(drv_data, speed);
 
 	if (bits <= 8) {
 		drv_data->n_bytes = 1;
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
