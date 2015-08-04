From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: img-spfi: fix multiple calls to request gpio" to the spi tree
Date: Tue, 04 Aug 2015 18:48:20 +0100
Message-ID: <E1ZMgK4-0007yQ-3e@finisterre>
References: <1438167326-5666-1-git-send-email-sifan.naeem@imgtec.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438167326-5666-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: img-spfi: fix multiple calls to request gpio

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b03ba9e314c12b2127243145b5c1f41b2408de62 Mon Sep 17 00:00:00 2001
From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Date: Wed, 29 Jul 2015 11:55:26 +0100
Subject: [PATCH] spi: img-spfi: fix multiple calls to request gpio

spfi_setup may be called many times by the spi framework, but
gpio_request_one can only be called once without freeing, repeatedly
calling gpio_request_one will cause an error to be thrown, which
causes the request to spi_setup to be marked as failed.

We can have a per-spi_device flag that indicates whether or not the
gpio has been requested. If the gpio has already been requested use
gpio_direction_output to set the direction of the gpio.

Fixes: 8c2c8c03cdcb ("spi: img-spfi: Control CS lines with GPIO")
Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/spi/spi-img-spfi.c | 49 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 83b9741..1ba9056 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -104,6 +104,10 @@ struct img_spfi {
 	bool rx_dma_busy;
 };
 
+struct img_spfi_device_data {
+	bool gpio_requested;
+};
+
 static inline u32 spfi_readl(struct img_spfi *spfi, u32 reg)
 {
 	return readl(spfi->regs + reg);
@@ -440,20 +444,49 @@ static int img_spfi_unprepare(struct spi_master *master,
 static int img_spfi_setup(struct spi_device *spi)
 {
 	int ret;
-
-	ret = gpio_request_one(spi->cs_gpio, (spi->mode & SPI_CS_HIGH) ?
-			       GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
-			       dev_name(&spi->dev));
-	if (ret)
-		dev_err(&spi->dev, "can't request chipselect gpio %d\n",
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
+		ret = gpio_request_one(spi->cs_gpio,
+				       (spi->mode & SPI_CS_HIGH) ?
+				       GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
+				       dev_name(&spi->dev));
+		if (ret)
+			dev_err(&spi->dev, "can't request chipselect gpio %d\n",
 				spi->cs_gpio);
-
+		else
+			spfi_data->gpio_requested = true;
+	} else {
+		if (gpio_is_valid(spi->cs_gpio)) {
+			int mode = ((spi->mode & SPI_CS_HIGH) ?
+				    GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH);
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
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
