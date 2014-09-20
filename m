From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH 1/3] spi: clps711x: Migrate to the new clk subsystem
Date: Sat, 20 Sep 2014 11:05:09 +0400
Message-ID: <1411196710-4961-1-git-send-email-shc_work@mail.ru>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Currently clps711x arch have a fully functional CLK driver.
This patch migrates clps711x-spi driver to use the new CLK subsystem.

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 drivers/spi/spi-clps711x.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index ce538da..181cf22 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -30,7 +30,6 @@
 struct spi_clps711x_data {
 	void __iomem		*syncio;
 	struct regmap		*syscon;
-	struct regmap		*syscon1;
 	struct clk		*spi_clk;
 
 	u8			*tx_buf;
@@ -47,27 +46,6 @@ static int spi_clps711x_setup(struct spi_device *spi)
 	return 0;
 }
 
-static void spi_clps711x_setup_xfer(struct spi_device *spi,
-				    struct spi_transfer *xfer)
-{
-	struct spi_master *master = spi->master;
-	struct spi_clps711x_data *hw = spi_master_get_devdata(master);
-
-	/* Setup SPI frequency divider */
-	if (xfer->speed_hz >= master->max_speed_hz)
-		regmap_update_bits(hw->syscon1, SYSCON_OFFSET,
-				   SYSCON1_ADCKSEL_MASK, SYSCON1_ADCKSEL(3));
-	else if (xfer->speed_hz >= (master->max_speed_hz / 2))
-		regmap_update_bits(hw->syscon1, SYSCON_OFFSET,
-				   SYSCON1_ADCKSEL_MASK, SYSCON1_ADCKSEL(2));
-	else if (xfer->speed_hz >= (master->max_speed_hz / 8))
-		regmap_update_bits(hw->syscon1, SYSCON_OFFSET,
-				   SYSCON1_ADCKSEL_MASK, SYSCON1_ADCKSEL(1));
-	else
-		regmap_update_bits(hw->syscon1, SYSCON_OFFSET,
-				   SYSCON1_ADCKSEL_MASK, SYSCON1_ADCKSEL(0));
-}
-
 static int spi_clps711x_prepare_message(struct spi_master *master,
 					struct spi_message *msg)
 {
@@ -87,7 +65,7 @@ static int spi_clps711x_transfer_one(struct spi_master *master,
 	struct spi_clps711x_data *hw = spi_master_get_devdata(master);
 	u8 data;
 
-	spi_clps711x_setup_xfer(spi, xfer);
+	clk_set_rate(hw->spi_clk, xfer->speed_hz ? : spi->max_speed_hz);
 
 	hw->len = xfer->len;
 	hw->bpw = xfer->bits_per_word;
@@ -176,13 +154,11 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 		}
 	}
 
-	hw->spi_clk = devm_clk_get(&pdev->dev, "spi");
+	hw->spi_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(hw->spi_clk)) {
-		dev_err(&pdev->dev, "Can't get clocks\n");
 		ret = PTR_ERR(hw->spi_clk);
 		goto err_out;
 	}
-	master->max_speed_hz = clk_get_rate(hw->spi_clk);
 
 	hw->syscon = syscon_regmap_lookup_by_pdevname("syscon.3");
 	if (IS_ERR(hw->syscon)) {
@@ -190,12 +166,6 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
-	hw->syscon1 = syscon_regmap_lookup_by_pdevname("syscon.1");
-	if (IS_ERR(hw->syscon1)) {
-		ret = PTR_ERR(hw->syscon1);
-		goto err_out;
-	}
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	hw->syncio = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(hw->syncio)) {
-- 
1.8.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
