From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH 3/3] spi: clps711x: Use SPI-core "cs_gpios" property for storing GPIOs
Date: Sun,  2 Feb 2014 10:59:50 +0400
Message-ID: <1391324390-17547-3-git-send-email-shc_work@mail.ru>
References: <1391324390-17547-1-git-send-email-shc_work@mail.ru>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391324390-17547-1-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 drivers/spi/spi-clps711x.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index d9fa933..f973e97 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -33,17 +33,12 @@ struct spi_clps711x_data {
 	u8			*rx_buf;
 	unsigned int		bpw;
 	int			len;
-
-	int			chipselect[0];
 };
 
 static int spi_clps711x_setup(struct spi_device *spi)
 {
-	struct spi_clps711x_data *hw = spi_master_get_devdata(spi->master);
-
 	/* We are expect that SPI-device is not selected */
-	gpio_direction_output(hw->chipselect[spi->chip_select],
-			      !(spi->mode & SPI_CS_HIGH));
+	gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
 
 	return 0;
 }
@@ -84,7 +79,6 @@ static int spi_clps711x_transfer_one_message(struct spi_master *master,
 	struct spi_clps711x_data *hw = spi_master_get_devdata(master);
 	struct spi_device *spi = msg->spi;
 	struct spi_transfer *xfer;
-	int cs = hw->chipselect[spi->chip_select];
 
 	spi_clps711x_setup_mode(spi);
 
@@ -93,7 +87,7 @@ static int spi_clps711x_transfer_one_message(struct spi_master *master,
 
 		spi_clps711x_setup_xfer(spi, xfer);
 
-		gpio_set_value(cs, !!(spi->mode & SPI_CS_HIGH));
+		gpio_set_value(spi->cs_gpio, !!(spi->mode & SPI_CS_HIGH));
 
 		reinit_completion(&hw->done);
 
@@ -114,7 +108,7 @@ static int spi_clps711x_transfer_one_message(struct spi_master *master,
 
 		if (xfer->cs_change ||
 		    list_is_last(&xfer->transfer_list, &msg->transfers))
-			gpio_set_value(cs, !(spi->mode & SPI_CS_HIGH));
+			gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
 
 		msg->actual_length += xfer->len;
 	}
@@ -163,12 +157,15 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	master = spi_alloc_master(&pdev->dev,
-				  sizeof(struct spi_clps711x_data) +
-				  sizeof(int) * pdata->num_chipselect);
-	if (!master) {
-		dev_err(&pdev->dev, "SPI allocating memory error\n");
+	master = spi_alloc_master(&pdev->dev, sizeof(*hw));
+	if (!master)
 		return -ENOMEM;
+
+	master->cs_gpios = devm_kzalloc(&pdev->dev, sizeof(int) *
+					pdata->num_chipselect, GFP_KERNEL);
+	if (!master->cs_gpios) {
+		ret = -ENOMEM;
+		goto err_out;
 	}
 
 	master->bus_num = pdev->id;
@@ -181,13 +178,13 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 	hw = spi_master_get_devdata(master);
 
 	for (i = 0; i < master->num_chipselect; i++) {
-		hw->chipselect[i] = pdata->chipselect[i];
-		if (!gpio_is_valid(hw->chipselect[i])) {
+		master->cs_gpios[i] = pdata->chipselect[i];
+		if (!gpio_is_valid(master->cs_gpios[i])) {
 			dev_err(&pdev->dev, "Invalid CS GPIO %i\n", i);
 			ret = -EINVAL;
 			goto err_out;
 		}
-		if (devm_gpio_request(&pdev->dev, hw->chipselect[i], NULL)) {
+		if (devm_gpio_request(&pdev->dev, master->cs_gpios[i], NULL)) {
 			dev_err(&pdev->dev, "Can't get CS GPIO %i\n", i);
 			ret = -EINVAL;
 			goto err_out;
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
