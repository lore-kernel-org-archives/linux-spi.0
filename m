From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Use gpiod_put() not gpiod_free()" to the spi tree
Date: Wed, 27 Dec 2017 10:40:18 +0000 (GMT)
Message-ID: <20171227104018.DE07944006B@finisterre.ee.mobilebroadband>
References: <20171222161755.2742-1-broonie@kernel.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>,
        Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>,
        Rasmus Villemoes <linux-qQsb+v5E8BnlAoU/VqSP6n9LOBIZ5rWg@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171222161755.2742-1-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Use gpiod_put() not gpiod_free()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From a885eebc1b062c6a6a925db85828108779fb0e62 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Date: Fri, 22 Dec 2017 16:15:36 +0000
Subject: [PATCH] spi: pxa2xx: Use gpiod_put() not gpiod_free()

gpiod_free() is an internal function for gpiolib, gpiod_put() is the
correct external function.

Reported-by: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Suggested-by: Rasmus Villemoes <linux-qQsb+v5E8BnlAoU/VqSP6n9LOBIZ5rWg@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index c209dc1047b5..b0822d1dba29 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1237,7 +1237,7 @@ static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 	 * different chip_info, release previously requested GPIO
 	 */
 	if (chip->gpiod_cs) {
-		gpiod_free(chip->gpiod_cs);
+		gpiod_put(chip->gpiod_cs);
 		chip->gpiod_cs = NULL;
 	}
 
@@ -1417,7 +1417,7 @@ static void cleanup(struct spi_device *spi)
 
 	if (drv_data->ssp_type != CE4100_SSP && !drv_data->cs_gpiods &&
 	    chip->gpiod_cs)
-		gpiod_free(chip->gpiod_cs);
+		gpiod_put(chip->gpiod_cs);
 
 	kfree(chip);
 }
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
