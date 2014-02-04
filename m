From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH RFT] spi: orion: Let spi core handle checking transfer speed
Date: Tue, 04 Feb 2014 11:05:50 +0800
Message-ID: <1391483150.4695.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Since commit a2fd4f9fa3b9 'spi: Support transfer speed checking in the core',
the SPI core validates the desired speed of a given transfer against the
minimum and maximum speeds supported by the controller.
So we can remove the same code in this driver and let spi core handle checking
the desired speed of a given transfer.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-orion.c | 39 ++-------------------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index a362425..d432b1c 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -42,8 +42,6 @@
 struct orion_spi {
 	struct spi_master	*master;
 	void __iomem		*base;
-	unsigned int		max_speed;
-	unsigned int		min_speed;
 	struct clk              *clk;
 };
 
@@ -320,16 +318,6 @@ static int orion_spi_transfer_one_message(struct spi_master *master,
 			goto msg_done;
 		}
 
-		if (t->speed_hz && t->speed_hz < orion_spi->min_speed) {
-			dev_err(&spi->dev,
-				"message rejected : "
-				"device min speed (%d Hz) exceeds "
-				"required transfer speed (%d Hz)\n",
-				orion_spi->min_speed, t->speed_hz);
-			status = -EIO;
-			goto msg_done;
-		}
-
 		if (par_override || t->speed_hz || t->bits_per_word) {
 			par_override = 1;
 			status = orion_spi_setup_transfer(spi, t);
@@ -374,28 +362,6 @@ static int orion_spi_reset(struct orion_spi *orion_spi)
 	return 0;
 }
 
-static int orion_spi_setup(struct spi_device *spi)
-{
-	struct orion_spi *orion_spi;
-
-	orion_spi = spi_master_get_devdata(spi->master);
-
-	if ((spi->max_speed_hz == 0)
-			|| (spi->max_speed_hz > orion_spi->max_speed))
-		spi->max_speed_hz = orion_spi->max_speed;
-
-	if (spi->max_speed_hz < orion_spi->min_speed) {
-		dev_err(&spi->dev, "setup: requested speed too low %d Hz\n",
-			spi->max_speed_hz);
-		return -EINVAL;
-	}
-
-	/*
-	 * baudrate & width will be set orion_spi_setup_transfer
-	 */
-	return 0;
-}
-
 static int orion_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
@@ -424,7 +390,6 @@ static int orion_spi_probe(struct platform_device *pdev)
 	/* we support only mode 0, and no options */
 	master->mode_bits = SPI_CPHA | SPI_CPOL;
 
-	master->setup = orion_spi_setup;
 	master->transfer_one_message = orion_spi_transfer_one_message;
 	master->num_chipselect = ORION_NUM_CHIPSELECTS;
 
@@ -442,8 +407,8 @@ static int orion_spi_probe(struct platform_device *pdev)
 	clk_prepare(spi->clk);
 	clk_enable(spi->clk);
 	tclk_hz = clk_get_rate(spi->clk);
-	spi->max_speed = DIV_ROUND_UP(tclk_hz, 4);
-	spi->min_speed = DIV_ROUND_UP(tclk_hz, 30);
+	master->max_speed_hz = DIV_ROUND_UP(tclk_hz, 4);
+	master->min_speed_hz = DIV_ROUND_UP(tclk_hz, 30);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	spi->base = devm_ioremap_resource(&pdev->dev, r);
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
