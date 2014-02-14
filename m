From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: s3c24xx: Convert to let spi core validate bits_per_word
Date: Fri, 14 Feb 2014 20:38:16 +0800
Message-ID: <1392381496.31961.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Set bits_per_word_mask so spi core will reject transfers that attempt to use
an unsupported bits_per_word value.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-s3c24xx.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index c20df45..a275445 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -122,25 +122,15 @@ static int s3c24xx_spi_update_state(struct spi_device *spi,
 {
 	struct s3c24xx_spi *hw = to_hw(spi);
 	struct s3c24xx_spi_devstate *cs = spi->controller_state;
-	unsigned int bpw;
 	unsigned int hz;
 	unsigned int div;
 	unsigned long clk;
 
-	bpw = t ? t->bits_per_word : spi->bits_per_word;
 	hz  = t ? t->speed_hz : spi->max_speed_hz;
 
-	if (!bpw)
-		bpw = 8;
-
 	if (!hz)
 		hz = spi->max_speed_hz;
 
-	if (bpw != 8) {
-		dev_err(&spi->dev, "invalid bits-per-word (%d)\n", bpw);
-		return -EINVAL;
-	}
-
 	if (spi->mode != cs->mode) {
 		u8 spcon = SPCON_DEFAULT | S3C2410_SPCON_ENSCK;
 
@@ -543,6 +533,7 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
 
 	master->num_chipselect = hw->pdata->num_cs;
 	master->bus_num = pdata->bus_num;
+	master->bits_per_word_mask = SPI_BPW_MASK(8);
 
 	/* setup the state for the bitbang driver */
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
