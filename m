From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/5] spi: spi-gpio: Delete references to non-GENERIC_BITBANG
Date: Mon,  1 Jan 2018 14:37:49 +0100
Message-ID: <20180101133749.29567-6-linus.walleij@linaro.org>
References: <20180101133749.29567-1-linus.walleij@linaro.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180101133749.29567-1-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The non-generic bitbang was a feature where a platform could optimize
SPI bit-banging by inlining the routines to hammer GPIO lines into
the GPIO bitbanging driver as direct register writes using a custom
set of GPIO library calls.

It does not work with multiplatform concepts, violates everything
about how GPIO is made generic and is just generally a bad idea,
even on legacy system. Also there is no single user in the entire
kernel (for good reasons).

Delete the remnants of this optimization.

Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-gpio.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index c12e588e54e7..437b1cd4da71 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -54,34 +54,8 @@ struct spi_gpio {
 
 /*----------------------------------------------------------------------*/
 
-/*
- * Because the overhead of going through four GPIO procedure calls
- * per transferred bit can make performance a problem, this code
- * is set up so that you can use it in either of two ways:
- *
- *   - The slow generic way:  set up platform_data to hold the GPIO
- *     numbers used for MISO/MOSI/SCK, and issue procedure calls for
- *     each of them.  This driver can handle several such busses.
- *
- *   - The quicker inlined way:  only helps with platform GPIO code
- *     that inlines operations for constant GPIOs.  This can give
- *     you tight (fast!) inner loops, but each such bus needs a
- *     new driver.  You'll define a new C file, with Makefile and
- *     Kconfig support; the C code can be a total of six lines:
- *
- *		#define DRIVER_NAME	"myboard_spi2"
- *		#define	SPI_MISO_GPIO	119
- *		#define	SPI_MOSI_GPIO	120
- *		#define	SPI_SCK_GPIO	121
- *		#define	SPI_N_CHIPSEL	4
- *		#include "spi-gpio.c"
- */
-
 #ifndef DRIVER_NAME
 #define DRIVER_NAME	"spi_gpio"
-
-#define GENERIC_BITBANG	/* vs tight inlines */
-
 #endif
 
 /*----------------------------------------------------------------------*/
@@ -363,10 +337,8 @@ static int spi_gpio_probe(struct platform_device *pdev)
 		use_of = 1;
 
 	pdata = dev_get_platdata(&pdev->dev);
-#ifdef GENERIC_BITBANG
 	if (!pdata || (!use_of && !pdata->num_chipselect))
 		return -ENODEV;
-#endif
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*spi_gpio) +
 				  (sizeof(struct gpio_desc *) * pdata->num_chipselect));
-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
