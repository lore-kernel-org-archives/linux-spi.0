From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: sh-hspi: Convert to let spi core validate bits_per_word
Date: Wed, 12 Feb 2014 22:09:52 +0800
Message-ID: <1392214192.11101.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Set bits_per_word_mask so spi core will reject transfers that attempt to use
an unsupported bits_per_word value.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-sh-hspi.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 82d2f92..dbd2c44 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -230,21 +230,6 @@ static int hspi_transfer_one_message(struct spi_master *master,
 	return ret;
 }
 
-static int hspi_setup(struct spi_device *spi)
-{
-	struct hspi_priv *hspi = spi_master_get_devdata(spi->master);
-	struct device *dev = hspi->dev;
-
-	if (8 != spi->bits_per_word) {
-		dev_err(dev, "bits_per_word should be 8\n");
-		return -EIO;
-	}
-
-	dev_dbg(dev, "%s setup\n", spi->modalias);
-
-	return 0;
-}
-
 static void hspi_cleanup(struct spi_device *spi)
 {
 	struct hspi_priv *hspi = spi_master_get_devdata(spi->master);
@@ -300,12 +285,13 @@ static int hspi_probe(struct platform_device *pdev)
 
 	master->num_chipselect	= 1;
 	master->bus_num		= pdev->id;
-	master->setup		= hspi_setup;
 	master->cleanup		= hspi_cleanup;
 	master->mode_bits	= SPI_CPOL | SPI_CPHA;
 	master->dev.of_node	= pdev->dev.of_node;
 	master->auto_runtime_pm = true;
 	master->transfer_one_message		= hspi_transfer_one_message;
+	master->bits_per_word_mask = SPI_BPW_MASK(8);
+
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_master error.\n");
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
