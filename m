From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi/ateml: Fix pointer to int conversion warnings on 64 bit builds
Date: Fri,  1 Aug 2014 17:44:18 +0100
Message-ID: <1406911458-12311-1-git-send-email-broonie@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org,
	Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

On 64 bit systems integers are generally still 32 bit but long values and
pointers are usually 64 bit. GCC warns when casting a 64 bit pointer into
a 32 bit integer so cast to a long instead in order to avoid warnings.

Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 1fb90dd..113c83f 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1012,7 +1012,7 @@ static int atmel_spi_setup(struct spi_device *spi)
 	csr |= SPI_BF(DLYBCT, 0);
 
 	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
-	npcs_pin = (unsigned int)spi->controller_data;
+	npcs_pin = (unsigned long)spi->controller_data;
 
 	if (gpio_is_valid(spi->cs_gpio))
 		npcs_pin = spi->cs_gpio;
@@ -1247,7 +1247,7 @@ msg_done:
 static void atmel_spi_cleanup(struct spi_device *spi)
 {
 	struct atmel_spi_device	*asd = spi->controller_state;
-	unsigned		gpio = (unsigned) spi->controller_data;
+	unsigned		gpio = (unsigned long) spi->controller_data;
 
 	if (!asd)
 		return;
-- 
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
