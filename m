From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: altera: Remove the code to get unused platform_data
Date: Fri, 21 Mar 2014 11:21:58 +0800
Message-ID: <1395372118.18131.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The definition of struct altera_spi_platform_data does not exist in current
tree. So remove the code to get platform_data which is never used.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
I just google it and found:
There is a include/linux/spi/spi_altera.h in [PATCH v2] spi: New driver for Altera SPI.
https://lkml.org/lkml/2011/1/17/16

And it got removed in [PATCH v3] spi: New driver for Altera SPI.
https://lkml.org/lkml/2011/1/17/25
(It's based on Grant's comment to remove it: https://lkml.org/lkml/2011/1/17/20)

 drivers/spi/spi-altera.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index f83f626..5b5709a 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -199,7 +199,6 @@ static irqreturn_t altera_spi_irq(int irq, void *dev)
 
 static int altera_spi_probe(struct platform_device *pdev)
 {
-	struct altera_spi_platform_data *platp = dev_get_platdata(&pdev->dev);
 	struct altera_spi *hw;
 	struct spi_master *master;
 	struct resource *res;
@@ -214,6 +213,7 @@ static int altera_spi_probe(struct platform_device *pdev)
 	master->num_chipselect = 16;
 	master->mode_bits = SPI_CS_HIGH;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
+	master->dev.of_node = pdev->dev.of_node;
 
 	hw = spi_master_get_devdata(master);
 	platform_set_drvdata(pdev, hw);
@@ -245,9 +245,6 @@ static int altera_spi_probe(struct platform_device *pdev)
 		if (err)
 			goto exit;
 	}
-	/* find platform data */
-	if (!platp)
-		hw->bitbang.master->dev.of_node = pdev->dev.of_node;
 
 	/* register our spi controller */
 	err = spi_bitbang_start(&hw->bitbang);
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
