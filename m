From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: altera: Use bits_per_word_mask
Date: Wed, 05 Mar 2014 13:37:00 +0800
Message-ID: <1393997820.19790.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This driver does not work for bits_per_word greater than 16.
Set bits_per_word_mask so spi core will reject transfers that attempt to use
an unsupported bits_per_word value.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-altera.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index 1928b83..f83f626 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -213,6 +213,7 @@ static int altera_spi_probe(struct platform_device *pdev)
 	master->bus_num = pdev->id;
 	master->num_chipselect = 16;
 	master->mode_bits = SPI_CS_HIGH;
+	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
 
 	hw = spi_master_get_devdata(master);
 	platform_set_drvdata(pdev, hw);
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
