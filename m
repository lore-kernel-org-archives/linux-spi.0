From: Sifan Naeem <sifan.naeem@imgtec.com>
Subject: [PATCH] spi: img-spfi: fix multiple calls to request gpio
Date: Wed, 29 Jul 2015 11:44:10 +0100
Message-ID: <1438166650-5302-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi@vger.kernel.org>, <abrestic@chromium.org>,
	<stable@vger.kernel.org>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Sifan Naeem <sifan.naeem@imgtec.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

spfi_setup may be called many times by the spi framework, but
gpio_request_one can only be called once without freeing, repeatedly
calling gpio_request_one will cause an error to be thrown, which
causes the request to spi_setup to be marked as failed.

We can have a per-spi_device flag that indicates whether or not the
gpio has been requested. If the gpio has already been requested use
gpio_direction_output to set the direction of the gpio.

Fixes: 8c2c8c03cdcb ("spi: img-spfi: Control CS lines with GPIO")
Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
Cc: <stable@vger.kernel.org> # 4.1+
---
 drivers/spi/spi-img-spfi.c |   50 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index f27d9d5531b5..5dc57ee293e1 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -105,6 +105,10 @@ struct img_spfi {
 	bool rx_dma_busy;
 };
 
+struct img_spfi_device_data {
+    bool gpio_requested;
+};
+
 static inline u32 spfi_readl(struct img_spfi *spfi, u32 reg)
 {
 	return readl(spfi->regs + reg);
@@ -441,20 +445,48 @@ static int img_spfi_unprepare(struct spi_master *master,
 static int img_spfi_setup(struct spi_device *spi)
 {
 	int ret;
-
-	ret = gpio_request_one(spi->cs_gpio, (spi->mode & SPI_CS_HIGH) ?
-			       GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
-			       dev_name(&spi->dev));
-	if (ret)
-		dev_err(&spi->dev, "can't request chipselect gpio %d\n",
-				spi->cs_gpio);
-
+	struct img_spfi_device_data *spfi_data = spi_get_ctldata(spi);
+
+	if (!spfi_data) {
+		spfi_data = kzalloc(sizeof(*spfi_data), GFP_KERNEL);
+		if (!spfi_data)
+			return -ENOMEM;
+		spfi_data->gpio_requested = false;
+		spi_set_ctldata(spi, spfi_data);
+	}
+	if (!spfi_data->gpio_requested) {
+		ret = gpio_request_one(spi->cs_gpio, (spi->mode & SPI_CS_HIGH) ?
+					   GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
+					   dev_name(&spi->dev));
+		if (ret)
+			dev_err(&spi->dev, "can't request chipselect gpio %d\n",
+					spi->cs_gpio);
+		else
+			spfi_data->gpio_requested = true;
+	} else {
+		if (gpio_is_valid(spi->cs_gpio)) {
+			int mode = ((spi->mode & SPI_CS_HIGH) ?
+					 GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH);
+
+			ret = gpio_direction_output(spi->cs_gpio, mode);
+			if (ret)
+				dev_err(&spi->dev, "chipselect gpio %d setup failed (%d)\n",
+					spi->cs_gpio, ret);
+		}
+	}
 	return ret;
 }
 
 static void img_spfi_cleanup(struct spi_device *spi)
 {
-	gpio_free(spi->cs_gpio);
+	struct img_spfi_device_data *spfi_data = spi_get_ctldata(spi);
+
+	if (spfi_data) {
+		if (spfi_data->gpio_requested)
+			gpio_free(spi->cs_gpio);
+		kfree(spfi_data);
+		spi_set_ctldata(spi, NULL);
+	}
 }
 
 static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
-- 
1.7.9.5
