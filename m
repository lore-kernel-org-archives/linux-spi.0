From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: clps711x: Convert to use master->max_speed_hz
Date: Wed, 26 Mar 2014 23:44:18 +0800
Message-ID: <1395848658.11134.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Set highest transfer speed to master->max_speed_hz and then we can remove
hw->max_speed.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-clps711x.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index d623500..4cd62f6 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -32,7 +32,6 @@ struct spi_clps711x_data {
 	struct regmap		*syscon;
 	struct regmap		*syscon1;
 	struct clk		*spi_clk;
-	u32			max_speed_hz;
 
 	u8			*tx_buf;
 	u8			*rx_buf;
@@ -51,16 +50,17 @@ static int spi_clps711x_setup(struct spi_device *spi)
 static void spi_clps711x_setup_xfer(struct spi_device *spi,
 				    struct spi_transfer *xfer)
 {
-	struct spi_clps711x_data *hw = spi_master_get_devdata(spi->master);
+	struct spi_master *master = spi->master;
+	struct spi_clps711x_data *hw = spi_master_get_devdata(master);
 
 	/* Setup SPI frequency divider */
-	if (!xfer->speed_hz || (xfer->speed_hz >= hw->max_speed_hz))
+	if (xfer->speed_hz >= master->max_speed_hz)
 		regmap_update_bits(hw->syscon1, SYSCON_OFFSET,
 				   SYSCON1_ADCKSEL_MASK, SYSCON1_ADCKSEL(3));
-	else if (xfer->speed_hz >= (hw->max_speed_hz / 2))
+	else if (xfer->speed_hz >= (master->max_speed_hz / 2))
 		regmap_update_bits(hw->syscon1, SYSCON_OFFSET,
 				   SYSCON1_ADCKSEL_MASK, SYSCON1_ADCKSEL(2));
-	else if (xfer->speed_hz >= (hw->max_speed_hz / 8))
+	else if (xfer->speed_hz >= (master->max_speed_hz / 8))
 		regmap_update_bits(hw->syscon1, SYSCON_OFFSET,
 				   SYSCON1_ADCKSEL_MASK, SYSCON1_ADCKSEL(1));
 	else
@@ -182,7 +182,7 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 		ret = PTR_ERR(hw->spi_clk);
 		goto err_out;
 	}
-	hw->max_speed_hz = clk_get_rate(hw->spi_clk);
+	master->max_speed_hz = clk_get_rate(hw->spi_clk);
 
 	platform_set_drvdata(pdev, master);
 
@@ -220,7 +220,7 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 	if (!ret) {
 		dev_info(&pdev->dev,
 			 "SPI bus driver initialized. Master clock %u Hz\n",
-			 hw->max_speed_hz);
+			 master->max_speed_hz);
 		return 0;
 	}
 
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
