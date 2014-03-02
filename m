From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] spi: sun4i: Set bits_per_word_mask to only support 8
 bits word length
Date: Sun, 02 Mar 2014 22:25:10 +0800
Message-ID: <1393770310.4044.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This controller only supports 8 bits word length.
Set bits_per_word_mask so spi core will reject transfers that attempt to use
an unsupported bits_per_word value.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-sun4i.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 3f82705..d266a87 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -392,6 +392,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	master->transfer_one = sun4i_spi_transfer_one;
 	master->num_chipselect = 4;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
