From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Don't touch CS pin until we have a transfer pending" to the spi tree
Date: Fri, 28 Jul 2017 13:38:16 +0100
Message-ID: <E1db4X2-0004yD-6b@finisterre>
References: <20170727154933.14143-1-andriy.shevchenko@linux.intel.com>
Cc: Mika Westeberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170727154933.14143-1-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Don't touch CS pin until we have a transfer pending

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

>From d35f2dc9a2a84f4985d8b16b47040fd6291788ad Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Thu, 27 Jul 2017 18:49:33 +0300
Subject: [PATCH] spi: pxa2xx: Don't touch CS pin until we have a transfer
 pending

GPIO descriptors, when being requested, may configure pin at the same
time. In case of SPI chip select we shouldn't do any assumptions of the
state of pin since we don't know yet what chip is connected there and if
it uses high or low active state. So, leave the state of pin as is until
transfer will start.

Fixes: 99f499cd6504 ("spi: pxa2xx: Add support for GPIO descriptor chip selects")
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Mika Westeberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 38d053682892..6e5af88b7c6f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1769,8 +1769,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		for (i = 0; i < master->num_chipselect; i++) {
 			struct gpio_desc *gpiod;
 
-			gpiod = devm_gpiod_get_index(dev, "cs", i,
-						     GPIOD_OUT_HIGH);
+			gpiod = devm_gpiod_get_index(dev, "cs", i, GPIOD_ASIS);
 			if (IS_ERR(gpiod)) {
 				/* Means use native chip select */
 				if (PTR_ERR(gpiod) == -ENOENT)
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
