From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/5] Blackfin SPI: fix resources leakage
Date: Thu, 17 Sep 2009 19:47:49 -0400
Message-ID: <1253231273-16423-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>

Re-order setup() a bit so we don't leak memory/dma/gpio resources upon
errors.

Signed-off-by: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   99 +++++++++++++++++++++++++--------------------
 1 files changed, 55 insertions(+), 44 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 73e24ef..8ec4969 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -1005,18 +1005,19 @@ static u16 ssel[][MAX_SPI_SSEL] = {
 /* first setup for new devices */
 static int bfin_spi_setup(struct spi_device *spi)
 {
-	struct bfin5xx_spi_chip *chip_info = NULL;
-	struct chip_data *chip;
+	struct bfin5xx_spi_chip *chip_info;
+	struct chip_data *chip = NULL;
 	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
-	int ret;
+	int ret = -EINVAL;
 
 	if (spi->bits_per_word != 8 && spi->bits_per_word != 16)
-		return -EINVAL;
+		goto error;
 
 	/* Only alloc (or use chip_info) on first setup */
+	chip_info = NULL;
 	chip = spi_get_ctldata(spi);
 	if (chip == NULL) {
-		chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
+		chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 		if (!chip)
 			return -ENOMEM;
 
@@ -1035,7 +1036,7 @@ static int bfin_spi_setup(struct spi_device *spi)
 		if (chip_info->ctl_reg & (SPE|MSTR|CPOL|CPHA|LSBF|SIZE)) {
 			dev_err(&spi->dev, "do not set bits in ctl_reg "
 				"that the SPI framework manages\n");
-			return -EINVAL;
+			goto error;
 		}
 
 		chip->enable_dma = chip_info->enable_dma != 0
@@ -1059,26 +1060,6 @@ static int bfin_spi_setup(struct spi_device *spi)
 	chip->ctl_reg |= MSTR;
 
 	/*
-	 * if any one SPI chip is registered and wants DMA, request the
-	 * DMA channel for it
-	 */
-	if (chip->enable_dma && !drv_data->dma_requested) {
-		/* register dma irq handler */
-		if (request_dma(drv_data->dma_channel, "BFIN_SPI_DMA") < 0) {
-			dev_dbg(&spi->dev,
-				"Unable to request BlackFin SPI DMA channel\n");
-			return -ENODEV;
-		}
-		if (set_dma_callback(drv_data->dma_channel,
-		    bfin_spi_dma_irq_handler, drv_data) < 0) {
-			dev_dbg(&spi->dev, "Unable to set dma callback\n");
-			return -EPERM;
-		}
-		dma_disable_irq(drv_data->dma_channel);
-		drv_data->dma_requested = 1;
-	}
-
-	/*
 	 * Notice: for blackfin, the speed_hz is the value of register
 	 * SPI_BAUD, not the real baudrate
 	 */
@@ -1086,16 +1067,6 @@ static int bfin_spi_setup(struct spi_device *spi)
 	chip->flag = 1 << (spi->chip_select);
 	chip->chip_select_num = spi->chip_select;
 
-	if (chip->chip_select_num == 0) {
-		ret = gpio_request(chip->cs_gpio, spi->modalias);
-		if (ret) {
-			if (drv_data->dma_requested)
-				free_dma(drv_data->dma_channel);
-			return ret;
-		}
-		gpio_direction_output(chip->cs_gpio, 1);
-	}
-
 	switch (chip->bits_per_word) {
 	case 8:
 		chip->n_bytes = 1;
@@ -1122,9 +1093,37 @@ static int bfin_spi_setup(struct spi_device *spi)
 	default:
 		dev_err(&spi->dev, "%d bits_per_word is not supported\n",
 				chip->bits_per_word);
-		if (chip_info)
-			kfree(chip);
-		return -ENODEV;
+		goto error;
+	}
+
+	/*
+	 * if any one SPI chip is registered and wants DMA, request the
+	 * DMA channel for it
+	 */
+	if (chip->enable_dma && !drv_data->dma_requested) {
+		/* register dma irq handler */
+		ret = request_dma(drv_data->dma_channel, "BFIN_SPI_DMA");
+		if (ret) {
+			dev_dbg(&spi->dev,
+				"Unable to request BlackFin SPI DMA channel\n");
+			goto error;
+		}
+		drv_data->dma_requested = 1;
+
+		ret = set_dma_callback(drv_data->dma_channel,
+			bfin_spi_dma_irq_handler, drv_data);
+		if (ret) {
+			dev_dbg(&spi->dev, "Unable to set dma callback\n");
+			goto error;
+		}
+		dma_disable_irq(drv_data->dma_channel);
+	}
+
+	if (chip->chip_select_num == 0) {
+		ret = gpio_request(chip->cs_gpio, spi->modalias);
+		if (ret)
+			goto error;
+		gpio_direction_output(chip->cs_gpio, 1);
 	}
 
 	dev_dbg(&spi->dev, "setup spi chip %s, width is %d, dma is %d\n",
@@ -1135,14 +1134,26 @@ static int bfin_spi_setup(struct spi_device *spi)
 	spi_set_ctldata(spi, chip);
 
 	dev_dbg(&spi->dev, "chip select number is %d\n", chip->chip_select_num);
-	if ((chip->chip_select_num > 0)
-		&& (chip->chip_select_num <= spi->master->num_chipselect))
-		peripheral_request(ssel[spi->master->bus_num]
-			[chip->chip_select_num-1], spi->modalias);
+	if (chip->chip_select_num > 0 &&
+	    chip->chip_select_num <= spi->master->num_chipselect) {
+		ret = peripheral_request(ssel[spi->master->bus_num]
+		                         [chip->chip_select_num-1], spi->modalias);
+		if (ret)
+			goto error;
+	}
 
 	bfin_spi_cs_deactive(drv_data, chip);
+	ret = 0;
 
-	return 0;
+ error:
+	if (ret) {
+		kfree(chip);
+		if (drv_data->dma_requested)
+			free_dma(drv_data->dma_channel);
+		drv_data->dma_requested = 0;
+	}
+
+	return ret;
 }
 
 /*
-- 
1.6.5.rc1
