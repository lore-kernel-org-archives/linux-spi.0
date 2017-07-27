From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1] spi: pxa2xx: Don't touch CS pin until we have a transfer pending
Date: Thu, 27 Jul 2017 18:49:33 +0300
Message-ID: <20170727154933.14143-1-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

GPIO descriptors, when being requested, may configure pin at the same
time. In case of SPI chip select we shouldn't do any assumptions of the
state of pin since we don't know yet what chip is connected there and if
it uses high or low active state. So, leave the state of pin as is until
transfer will start.

Fixes: 99f499cd6504 ("spi: pxa2xx: Add support for GPIO descriptor chip selects")
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
  Note, while it has Fixes tag, it relies on 676a4e3bab44 to be reverted for newest kernel.
  Revert had been sent earlier today.

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
