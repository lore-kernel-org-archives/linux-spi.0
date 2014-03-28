From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: mpc52xx: Convert to use bits_per_word_mask
Date: Fri, 28 Mar 2014 23:37:54 +0800
Message-ID: <1396021074.13764.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This controller only supports 8-bit word length.
Set bits_per_word_mask so spi core will reject transfers that attempt to use
an unsupported bits_per_word value.
Also remove the duplicate code to test spi->mode, it is done by spi core.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-mpc52xx.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index bd404c2..aac2a5d 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -356,17 +356,6 @@ static void mpc52xx_spi_wq(struct work_struct *work)
  * spi_master ops
  */
 
-static int mpc52xx_spi_setup(struct spi_device *spi)
-{
-	if (spi->bits_per_word % 8)
-		return -EINVAL;
-
-	if (spi->mode & ~(SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST))
-		return -EINVAL;
-
-	return 0;
-}
-
 static int mpc52xx_spi_transfer(struct spi_device *spi, struct spi_message *m)
 {
 	struct mpc52xx_spi *ms = spi_master_get_devdata(spi->master);
@@ -429,9 +418,9 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 		goto err_alloc;
 	}
 
-	master->setup = mpc52xx_spi_setup;
 	master->transfer = mpc52xx_spi_transfer;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
+	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->dev.of_node = op->dev.of_node;
 
 	platform_set_drvdata(op, master);
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
