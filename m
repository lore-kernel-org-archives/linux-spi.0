From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: s3c24xx: Convert to use devm_kzalloc
Date: Mon, 31 Mar 2014 11:37:29 +0800
Message-ID: <1396237049.12196.1.camel@phoenix>
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

Simplify the cleanup code.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-s3c24xx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index bed2338..6db14e5 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -183,7 +183,9 @@ static int s3c24xx_spi_setup(struct spi_device *spi)
 
 	/* allocate settings on the first call */
 	if (!cs) {
-		cs = kzalloc(sizeof(struct s3c24xx_spi_devstate), GFP_KERNEL);
+		cs = devm_kzalloc(&spi->dev,
+				  sizeof(struct s3c24xx_spi_devstate),
+				  GFP_KERNEL);
 		if (!cs) {
 			dev_err(&spi->dev, "no memory for controller state\n");
 			return -ENOMEM;
@@ -209,11 +211,6 @@ static int s3c24xx_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static void s3c24xx_spi_cleanup(struct spi_device *spi)
-{
-	kfree(spi->controller_state);
-}
-
 static inline unsigned int hw_txbyte(struct s3c24xx_spi *hw, int count)
 {
 	return hw->tx ? hw->tx[count] : 0;
@@ -543,7 +540,6 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
 	hw->bitbang.txrx_bufs      = s3c24xx_spi_txrx;
 
 	hw->master->setup  = s3c24xx_spi_setup;
-	hw->master->cleanup = s3c24xx_spi_cleanup;
 
 	dev_dbg(hw->dev, "bitbang at %p\n", &hw->bitbang);
 
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
