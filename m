From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH] spi: sh-msiof: Fix warnings due to improper casts
Date: Wed, 27 Nov 2013 01:39:15 +0100
Message-ID: <1385512755-11765-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Cast pointers to unsigned long instead of unsigned int. This fixes
warnings on platforms where pointers have a different size than int.

Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index c74298c..35930e9 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -421,7 +421,7 @@ static void sh_msiof_spi_chipselect(struct spi_device *spi, int is_on)
 	}
 
 	/* use spi->controller data for CS (same strategy as spi_gpio) */
-	gpio_set_value((unsigned)spi->controller_data, value);
+	gpio_set_value((unsigned long)spi->controller_data, value);
 
 	if (is_on == BITBANG_CS_INACTIVE) {
 		if (test_and_clear_bit(0, &p->flags)) {
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
