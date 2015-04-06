From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/5] spi: img-spfi: Limit bit clock to 1/4th of input clock
Date: Mon,  6 Apr 2015 14:29:03 -0700
Message-ID: <1428355747-16822-1-git-send-email-abrestic@chromium.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Although the SPFI BITCLK divider supports a value of up to 255, only
values up to 128 are usable.  This results in a maximum possible bit
clock rate of 1/4th the input clock rate.

Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/spi/spi-img-spfi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index e649bc7..7d18bec 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -405,10 +405,10 @@ static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
 
 	/*
 	 * output = spfi_clk * (BITCLK / 512), where BITCLK must be a
-	 * power of 2 up to 256 (where 255 == 256 since BITCLK is 8 bits)
+	 * power of 2 up to 128
 	 */
-	div = DIV_ROUND_UP(master->max_speed_hz, xfer->speed_hz);
-	div = clamp(512 / (1 << get_count_order(div)), 1, 255);
+	div = DIV_ROUND_UP(clk_get_rate(spfi->spfi_clk), xfer->speed_hz);
+	div = clamp(512 / (1 << get_count_order(div)), 1, 128);
 
 	val = spfi_readl(spfi, SPFI_DEVICE_PARAMETER(spi->chip_select));
 	val &= ~(SPFI_DEVICE_PARAMETER_BITCLK_MASK <<
@@ -594,8 +594,8 @@ static int img_spfi_probe(struct platform_device *pdev)
 	master->num_chipselect = 5;
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(8);
-	master->max_speed_hz = clk_get_rate(spfi->spfi_clk);
-	master->min_speed_hz = master->max_speed_hz / 512;
+	master->max_speed_hz = clk_get_rate(spfi->spfi_clk) / 4;
+	master->min_speed_hz = clk_get_rate(spfi->spfi_clk) / 512;
 
 	master->set_cs = img_spfi_set_cs;
 	master->transfer_one = img_spfi_transfer_one;
-- 
2.2.0.rc0.207.ga3a616c

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
