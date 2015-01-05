From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: st-ssc4: Remove duplicate code to test unsupported
 mode bits
Date: Mon, 05 Jan 2015 22:49:36 +0800
Message-ID: <1420469376.6880.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi_setup() will test unsupported mode bits before calling spi->master->setup.
Thus remove duplicate code to test unsupported mode bits in spi_st_setup().

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-st-ssc4.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index 8f8770a..2faeaa7 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -217,12 +217,6 @@ static int spi_st_setup(struct spi_device *spi)
 	int cs = spi->cs_gpio;
 	int ret;
 
-	if (spi->mode & ~MODEBITS) {
-		dev_err(&spi->dev, "unsupported mode bits 0x%x\n",
-			spi->mode & ~MODEBITS);
-		return -EINVAL;
-	}
-
 	if (!hz)  {
 		dev_err(&spi->dev, "max_speed_hz unspecified\n");
 		return -EINVAL;
-- 
1.9.1



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
