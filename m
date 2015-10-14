From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/1] spi: core: propagate return code of __spi_validate_bits_per_word()
Date: Wed, 14 Oct 2015 22:43:07 +0300
Message-ID: <1444851787-38604-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Propagate the actual return code of __spi_validate_bits_per_word() in
spi_setup().

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 58db324..e900164 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2017,7 +2017,7 @@ static int __spi_validate_bits_per_word(struct spi_master *master, u8 bits_per_w
 int spi_setup(struct spi_device *spi)
 {
 	unsigned	bad_bits, ugly_bits;
-	int		status = 0;
+	int		status;
 
 	/* check mode to prevent that DUAL and QUAD set at the same time
 	 */
@@ -2054,8 +2054,9 @@ int spi_setup(struct spi_device *spi)
 	if (!spi->bits_per_word)
 		spi->bits_per_word = 8;
 
-	if (__spi_validate_bits_per_word(spi->master, spi->bits_per_word))
-		return -EINVAL;
+	status = __spi_validate_bits_per_word(spi->master, spi->bits_per_word);
+	if (status)
+		return status;
 
 	if (!spi->max_speed_hz)
 		spi->max_speed_hz = spi->master->max_speed_hz;
-- 
2.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
