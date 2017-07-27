From: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: [RFC PATCH v2 12/12] wip: convert struct spi_device to gpio_desc
Date: Fri, 28 Jul 2017 10:03:22 +1200
Message-ID: <20170727220322.26654-13-chris.packham@alliedtelesis.co.nz>
References: <20170727220322.26654-1-chris.packham@alliedtelesis.co.nz>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170727220322.26654-1-chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

---
 drivers/spi/spi-ath79.c       | 26 +++-----------------------
 drivers/spi/spi-atmel.c       |  4 ++--
 drivers/spi/spi-bcm2835.c     |  8 ++++----
 drivers/spi/spi-cadence.c     | 29 ++---------------------------
 drivers/spi/spi-clps711x.c    | 13 +------------
 drivers/spi/spi-davinci.c     | 10 ++++------
 drivers/spi/spi-dw.c          |  7 -------
 drivers/spi/spi-fsl-spi.c     | 29 +++++------------------------
 drivers/spi/spi-img-spfi.c    | 25 +------------------------
 drivers/spi/spi-lantiq-ssc.c  |  2 +-
 drivers/spi/spi-mpc512x-psc.c | 20 +++-----------------
 drivers/spi/spi-mt65xx.c      |  3 ---
 drivers/spi/spi-omap2-mcspi.c | 17 ++---------------
 drivers/spi/spi-orion.c       |  2 +-
 drivers/spi/spi-pic32.c       | 11 +----------
 drivers/spi/spi-s3c64xx.c     | 16 ++--------------
 drivers/spi/spi-st-ssc4.c     | 29 +----------------------------
 drivers/spi/spi.c             | 10 +++-------
 include/linux/spi/spi.h       |  2 +-
 19 files changed, 37 insertions(+), 226 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 0719bd484891..33a768206ab9 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -78,9 +78,9 @@ static void ath79_spi_chipselect(struct spi_device *spi, int is_active)
 		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
 	}
 
-	if (gpio_is_valid(spi->cs_gpio)) {
+	if (spi->cs_gpio) {
 		/* SPI is normally active-low */
-		gpio_set_value_cansleep(spi->cs_gpio, cs_high);
+		gpiod_set_value_cansleep(spi->cs_gpio, cs_high);
 	} else {
 		u32 cs_bit = AR71XX_SPI_IOC_CS(spi->chip_select);
 
@@ -121,18 +121,7 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
 	int status;
 
 	status = 0;
-	if (gpio_is_valid(spi->cs_gpio)) {
-		unsigned long flags;
-
-		flags = GPIOF_DIR_OUT;
-		if (spi->mode & SPI_CS_HIGH)
-			flags |= GPIOF_INIT_LOW;
-		else
-			flags |= GPIOF_INIT_HIGH;
-
-		status = gpio_request_one(spi->cs_gpio, flags,
-					  dev_name(&spi->dev));
-	} else {
+	if (!spi->cs_gpio) {
 		u32 cs_bit = AR71XX_SPI_IOC_CS(spi->chip_select);
 
 		if (spi->mode & SPI_CS_HIGH)
@@ -146,12 +135,6 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
 	return status;
 }
 
-static void ath79_spi_cleanup_cs(struct spi_device *spi)
-{
-	if (gpio_is_valid(spi->cs_gpio))
-		gpio_free(spi->cs_gpio);
-}
-
 static int ath79_spi_setup(struct spi_device *spi)
 {
 	int status = 0;
@@ -163,15 +146,12 @@ static int ath79_spi_setup(struct spi_device *spi)
 	}
 
 	status = spi_bitbang_setup(spi);
-	if (status && !spi->controller_state)
-		ath79_spi_cleanup_cs(spi);
 
 	return status;
 }
 
 static void ath79_spi_cleanup(struct spi_device *spi)
 {
-	ath79_spi_cleanup_cs(spi);
 	spi_bitbang_cleanup(spi);
 }
 
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f95da364c283..15f2e02a02d4 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1179,8 +1179,8 @@ static int atmel_spi_setup(struct spi_device *spi)
 
 	if (!as->use_cs_gpios)
 		npcs_pin = spi->chip_select;
-	else if (gpio_is_valid(spi->cs_gpio))
-		npcs_pin = spi->cs_gpio;
+	else if (spi->cs_gpio)
+		npcs_pin = desc_to_gpio(spi->cs_gpio);
 
 	asd = spi->controller_state;
 	if (!asd) {
diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index f35cc10772f6..f09dc8eb4fc0 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -179,7 +179,7 @@ static int bcm2835_spi_transfer_one_irq(struct spi_master *master,
 	 * with gpio-cs this does not happen, so it is implemented
 	 * only for this case
 	 */
-	if (gpio_is_valid(spi->cs_gpio)) {
+	if (spi->cs_gpio) {
 		/* enable HW block, but without interrupts enabled
 		 * this would triggern an immediate interrupt
 		 */
@@ -358,7 +358,7 @@ static bool bcm2835_spi_can_dma(struct spi_master *master,
 				struct spi_transfer *tfr)
 {
 	/* only run for gpio_cs */
-	if (!gpio_is_valid(spi->cs_gpio))
+	if (!spi->cs_gpio)
 		return false;
 
 	/* we start DMA efforts only on bigger transfers */
@@ -564,7 +564,7 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	 * we can not run this in bcm2835_spi_set_cs, as it does
 	 * not get called for cs_gpio cases, so we need to do it here
 	 */
-	if (gpio_is_valid(spi->cs_gpio) || (spi->mode & SPI_NO_CS))
+	if (spi->cs_gpio || (spi->mode & SPI_NO_CS))
 		cs |= BCM2835_SPI_CS_CS_10 | BCM2835_SPI_CS_CS_01;
 
 	/* set transmit buffers and length */
@@ -693,7 +693,7 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	 */
 	if (spi->mode & SPI_NO_CS)
 		return 0;
-	if (gpio_is_valid(spi->cs_gpio))
+	if (spi->cs_gpio)
 		return 0;
 	if (spi->chip_select > 1) {
 		/* error in the case of native CS requested with CS > 1
diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index f0b5c7b91f37..bac0ae3aad72 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -468,7 +468,7 @@ static int cdns_spi_setup(struct spi_device *spi)
 	struct cdns_spi_device_data *cdns_spi_data = spi_get_ctldata(spi);
 
 	/* this is a pin managed by the controller, leave it alone */
-	if (spi->cs_gpio == -ENOENT)
+	if (!spi->cs_gpio)
 		return 0;
 
 	/* this seems to be the first time we're here */
@@ -476,33 +476,10 @@ static int cdns_spi_setup(struct spi_device *spi)
 		cdns_spi_data = kzalloc(sizeof(*cdns_spi_data), GFP_KERNEL);
 		if (!cdns_spi_data)
 			return -ENOMEM;
-		cdns_spi_data->gpio_requested = false;
+		cdns_spi_data->gpio_requested = true;
 		spi_set_ctldata(spi, cdns_spi_data);
 	}
 
-	/* if we haven't done so, grab the gpio */
-	if (!cdns_spi_data->gpio_requested && gpio_is_valid(spi->cs_gpio)) {
-		ret = gpio_request_one(spi->cs_gpio,
-				       (spi->mode & SPI_CS_HIGH) ?
-				       GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
-				       dev_name(&spi->dev));
-		if (ret)
-			dev_err(&spi->dev, "can't request chipselect gpio %d\n",
-				spi->cs_gpio);
-		else
-			cdns_spi_data->gpio_requested = true;
-	} else {
-		if (gpio_is_valid(spi->cs_gpio)) {
-			int mode = ((spi->mode & SPI_CS_HIGH) ?
-				    GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH);
-
-			ret = gpio_direction_output(spi->cs_gpio, mode);
-			if (ret)
-				dev_err(&spi->dev, "chipselect gpio %d setup failed (%d)\n",
-					spi->cs_gpio, ret);
-		}
-	}
-
 	return ret;
 }
 
@@ -511,8 +488,6 @@ static void cdns_spi_cleanup(struct spi_device *spi)
 	struct cdns_spi_device_data *cdns_spi_data = spi_get_ctldata(spi);
 
 	if (cdns_spi_data) {
-		if (cdns_spi_data->gpio_requested)
-			gpio_free(spi->cs_gpio);
 		kfree(cdns_spi_data);
 		spi_set_ctldata(spi, NULL);
 	}
diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index 18193df2eba8..6ed4f24c8d89 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -38,19 +38,8 @@ struct spi_clps711x_data {
 
 static int spi_clps711x_setup(struct spi_device *spi)
 {
-	if (!spi->controller_state) {
-		int ret;
-
-		ret = devm_gpio_request(&spi->master->dev, spi->cs_gpio,
-					dev_name(&spi->master->dev));
-		if (ret)
-			return ret;
-
+	if (!spi->controller_state)
 		spi->controller_state = spi;
-	}
-
-	/* We are expect that SPI-device is not selected */
-	gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
 
 	return 0;
 }
diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 6ddb6ef1fda4..26c6037d00b2 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -224,11 +224,11 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 	 * Board specific chip select logic decides the polarity and cs
 	 * line for the controller
 	 */
-	if (spi->cs_gpio >= 0) {
+	if (spi->cs_gpio) {
 		if (value == BITBANG_CS_ACTIVE)
-			gpio_set_value(spi->cs_gpio, spi->mode & SPI_CS_HIGH);
+			gpiod_set_value(spi->cs_gpio, spi->mode & SPI_CS_HIGH);
 		else
-			gpio_set_value(spi->cs_gpio,
+			gpiod_set_value(spi->cs_gpio,
 				!(spi->mode & SPI_CS_HIGH));
 	} else {
 		if (value == BITBANG_CS_ACTIVE) {
@@ -430,9 +430,7 @@ static int davinci_spi_setup(struct spi_device *spi)
 	pdata = &dspi->pdata;
 
 	if (!(spi->mode & SPI_NO_CS)) {
-		if (np && (master->cs_gpios != NULL) && (spi->cs_gpio >= 0)) {
-			retval = gpio_direction_output(
-				      spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
+		if (np && (master->cs_gpios != NULL) && (spi->cs_gpio)) {
 			internal_cs = false;
 		} else if (pdata->chip_sel &&
 			   spi->chip_select < pdata->num_chipselect &&
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index b217c22ff72f..2ddf8d4f8ca8 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -429,13 +429,6 @@ static int dw_spi_setup(struct spi_device *spi)
 
 	chip->tmode = SPI_TMOD_TR;
 
-	if (gpio_is_valid(spi->cs_gpio)) {
-		ret = gpio_direction_output(spi->cs_gpio,
-				!(spi->mode & SPI_CS_HIGH));
-		if (ret)
-			return ret;
-	}
-
 	return 0;
 }
 
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 8f2e97857e8b..08fc26e9d30f 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -461,26 +461,10 @@ static int fsl_spi_setup(struct spi_device *spi)
 	}
 
 	if (mpc8xxx_spi->type == TYPE_GRLIB) {
-		if (gpio_is_valid(spi->cs_gpio)) {
-			int desel;
-
-			retval = gpio_request(spi->cs_gpio,
-					      dev_name(&spi->dev));
-			if (retval)
-				return retval;
-
-			desel = !(spi->mode & SPI_CS_HIGH);
-			retval = gpio_direction_output(spi->cs_gpio, desel);
-			if (retval) {
-				gpio_free(spi->cs_gpio);
-				return retval;
-			}
-		} else if (spi->cs_gpio != -ENOENT) {
-			if (spi->cs_gpio < 0)
-				return spi->cs_gpio;
+		if (!spi->cs_gpio)
 			return -EINVAL;
-		}
-		/* When spi->cs_gpio == -ENOENT, a hole in the phandle list
+
+		/* When spi->cs_gpio == NULL, a hole in the phandle list
 		 * indicates to use native chipselect if present, or allow for
 		 * an always selected chip
 		 */
@@ -497,9 +481,6 @@ static void fsl_spi_cleanup(struct spi_device *spi)
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
 	struct spi_mpc8xxx_cs *cs = spi_get_ctldata(spi);
 
-	if (mpc8xxx_spi->type == TYPE_GRLIB && gpio_is_valid(spi->cs_gpio))
-		gpio_free(spi->cs_gpio);
-
 	kfree(cs);
 	spi_set_ctldata(spi, NULL);
 }
@@ -565,8 +546,8 @@ static void fsl_spi_grlib_cs_control(struct spi_device *spi, bool on)
 	u32 slvsel;
 	u16 cs = spi->chip_select;
 
-	if (gpio_is_valid(spi->cs_gpio)) {
-		gpio_set_value(spi->cs_gpio, on);
+	if (spi->cs_gpio) {
+		gpiod_set_value(spi->cs_gpio, on);
 	} else if (cs < mpc8xxx_spi->native_chipselects) {
 		slvsel = mpc8xxx_spi_read_reg(&reg_base->slvsel);
 		slvsel = on ? (slvsel | (1 << cs)) : (slvsel & ~(1 << cs));
diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 7a37090dabbe..4148993b3280 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -451,30 +451,9 @@ static int img_spfi_setup(struct spi_device *spi)
 		spfi_data = kzalloc(sizeof(*spfi_data), GFP_KERNEL);
 		if (!spfi_data)
 			return -ENOMEM;
-		spfi_data->gpio_requested = false;
 		spi_set_ctldata(spi, spfi_data);
 	}
-	if (!spfi_data->gpio_requested) {
-		ret = gpio_request_one(spi->cs_gpio,
-				       (spi->mode & SPI_CS_HIGH) ?
-				       GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
-				       dev_name(&spi->dev));
-		if (ret)
-			dev_err(&spi->dev, "can't request chipselect gpio %d\n",
-				spi->cs_gpio);
-		else
-			spfi_data->gpio_requested = true;
-	} else {
-		if (gpio_is_valid(spi->cs_gpio)) {
-			int mode = ((spi->mode & SPI_CS_HIGH) ?
-				    GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH);
-
-			ret = gpio_direction_output(spi->cs_gpio, mode);
-			if (ret)
-				dev_err(&spi->dev, "chipselect gpio %d setup failed (%d)\n",
-					spi->cs_gpio, ret);
-		}
-	}
+
 	return ret;
 }
 
@@ -483,8 +462,6 @@ static void img_spfi_cleanup(struct spi_device *spi)
 	struct img_spfi_device_data *spfi_data = spi_get_ctldata(spi);
 
 	if (spfi_data) {
-		if (spfi_data->gpio_requested)
-			gpio_free(spi->cs_gpio);
 		kfree(spfi_data);
 		spi_set_ctldata(spi, NULL);
 	}
diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index d5976615d924..06cf27a23127 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -394,7 +394,7 @@ static int lantiq_ssc_setup(struct spi_device *spidev)
 	u32 gpocon;
 
 	/* GPIOs are used for CS */
-	if (gpio_is_valid(spidev->cs_gpio))
+	if (spidev->cs_gpio)
 		return 0;
 
 	dev_dbg(spi->dev, "using internal chipselect %u\n", cs);
diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index c3ec46cd9f91..c114c5f54d42 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -132,7 +132,7 @@ static void mpc512x_psc_spi_activate_cs(struct spi_device *spi)
 	out_be32(psc_addr(mps, ccr), ccr);
 	mps->bits_per_word = cs->bits_per_word;
 
-	if (mps->cs_control && gpio_is_valid(spi->cs_gpio))
+	if (mps->cs_control && spi->cs_gpio)
 		mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 1 : 0);
 }
 
@@ -140,7 +140,7 @@ static void mpc512x_psc_spi_deactivate_cs(struct spi_device *spi)
 {
 	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
 
-	if (mps->cs_control && gpio_is_valid(spi->cs_gpio))
+	if (mps->cs_control && spi->cs_gpio)
 		mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
 
 }
@@ -378,18 +378,6 @@ static int mpc512x_psc_spi_setup(struct spi_device *spi)
 		if (!cs)
 			return -ENOMEM;
 
-		if (gpio_is_valid(spi->cs_gpio)) {
-			ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
-			if (ret) {
-				dev_err(&spi->dev, "can't get CS gpio: %d\n",
-					ret);
-				kfree(cs);
-				return ret;
-			}
-			gpio_direction_output(spi->cs_gpio,
-					spi->mode & SPI_CS_HIGH ? 0 : 1);
-		}
-
 		spi->controller_state = cs;
 	}
 
@@ -401,8 +389,6 @@ static int mpc512x_psc_spi_setup(struct spi_device *spi)
 
 static void mpc512x_psc_spi_cleanup(struct spi_device *spi)
 {
-	if (gpio_is_valid(spi->cs_gpio))
-		gpio_free(spi->cs_gpio);
 	kfree(spi->controller_state);
 }
 
@@ -483,7 +469,7 @@ static irqreturn_t mpc512x_psc_spi_isr(int irq, void *dev_id)
 
 static void mpc512x_spi_cs_control(struct spi_device *spi, bool onoff)
 {
-	gpio_set_value(spi->cs_gpio, onoff);
+	gpiod_set_value(spi->cs_gpio, onoff);
 }
 
 static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 91a498e25cbb..a0d34b5def2d 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -474,9 +474,6 @@ static int mtk_spi_setup(struct spi_device *spi)
 	if (!spi->controller_data)
 		spi->controller_data = (void *)&mtk_default_chip_info;
 
-	if (mdata->dev_comp->need_pad_sel && gpio_is_valid(spi->cs_gpio))
-		gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
-
 	return 0;
 }
 
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index e048268d8ba2..f80b0d70209c 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1045,16 +1045,6 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 		spi->controller_state = cs;
 		/* Link this to context save list */
 		list_add_tail(&cs->node, &ctx->cs);
-
-		if (gpio_is_valid(spi->cs_gpio)) {
-			ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
-			if (ret) {
-				dev_err(&spi->dev, "failed to request gpio\n");
-				return ret;
-			}
-			gpio_direction_output(spi->cs_gpio,
-					 !(spi->mode & SPI_CS_HIGH));
-		}
 	}
 
 	if (!mcspi_dma->dma_rx || !mcspi_dma->dma_tx) {
@@ -1103,9 +1093,6 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 			mcspi_dma->dma_tx = NULL;
 		}
 	}
-
-	if (gpio_is_valid(spi->cs_gpio))
-		gpio_free(spi->cs_gpio);
 }
 
 static int omap2_mcspi_transfer_one(struct spi_master *master,
@@ -1145,7 +1132,7 @@ static int omap2_mcspi_transfer_one(struct spi_master *master,
 
 	omap2_mcspi_set_enable(spi, 0);
 
-	if (gpio_is_valid(spi->cs_gpio))
+	if (spi->cs_gpio)
 		omap2_mcspi_set_cs(spi, spi->mode & SPI_CS_HIGH);
 
 	if (par_override ||
@@ -1234,7 +1221,7 @@ static int omap2_mcspi_transfer_one(struct spi_master *master,
 
 	omap2_mcspi_set_enable(spi, 0);
 
-	if (gpio_is_valid(spi->cs_gpio))
+	if (spi->cs_gpio)
 		omap2_mcspi_set_cs(spi, !(spi->mode & SPI_CS_HIGH));
 
 	if (mcspi->fifo_depth > 0 && t)
diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 4b6dd73b80da..020d3ec21450 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -323,7 +323,7 @@ static void orion_spi_set_cs(struct spi_device *spi, bool enable)
 	struct orion_spi *orion_spi;
 	int cs;
 
-	if (gpio_is_valid(spi->cs_gpio))
+	if (spi->cs_gpio)
 		cs = 0;
 	else
 		cs = spi->chip_select;
diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index f8a45af1fa9f..01bb9e7920e4 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -600,20 +600,12 @@ static int pic32_spi_setup(struct spi_device *spi)
 	 * unreliable/erroneous SPI transactions.
 	 * To avoid that we will always handle /CS by toggling GPIO.
 	 */
-	if (!gpio_is_valid(spi->cs_gpio))
+	if (!spi->cs_gpio)
 		return -EINVAL;
 
-	gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
-
 	return 0;
 }
 
-static void pic32_spi_cleanup(struct spi_device *spi)
-{
-	/* de-activate cs-gpio */
-	gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
-}
-
 static void pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
 {
 	struct spi_master *master = pic32s->master;
@@ -779,7 +771,6 @@ static int pic32_spi_probe(struct platform_device *pdev)
 	master->num_chipselect	= 1; /* single chip-select */
 	master->max_speed_hz	= clk_get_rate(pic32s->clk);
 	master->setup		= pic32_spi_setup;
-	master->cleanup		= pic32_spi_cleanup;
 	master->flags		= SPI_MASTER_MUST_TX | SPI_MASTER_MUST_RX;
 	master->bits_per_word_mask	= SPI_BPW_MASK(8) | SPI_BPW_MASK(16) |
 					  SPI_BPW_MASK(32);
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b392cca8fa4f..1bc48a1338fc 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -761,7 +761,7 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 		spi->controller_data = cs;
 	} else if (cs) {
 		/* On non-DT platforms the SPI core will set spi->cs_gpio
-		 * to -ENOENT. The GPIO pin used to drive the chip select
+		 * to NULL. The GPIO pin used to drive the chip select
 		 * is defined by using platform data so spi->cs_gpio value
 		 * has to be override to have the proper GPIO pin number.
 		 */
@@ -773,20 +773,8 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	if (!spi_get_ctldata(spi)) {
-		if (gpio_is_valid(spi->cs_gpio)) {
-			err = gpio_request_one(spi->cs_gpio, GPIOF_OUT_INIT_HIGH,
-					       dev_name(&spi->dev));
-			if (err) {
-				dev_err(&spi->dev,
-					"Failed to get /CS gpio [%d]: %d\n",
-					spi->cs_gpio, err);
-				goto err_gpio_req;
-			}
-		}
-
+	if (!spi_get_ctldata(spi))
 		spi_set_ctldata(spi, cs);
-	}
 
 	sci = sdd->cntrlr_info;
 
diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index a4e43fc19ece..72d9b24ccf04 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -173,11 +173,6 @@ static int spi_st_transfer_one(struct spi_master *master,
 	return t->len;
 }
 
-static void spi_st_cleanup(struct spi_device *spi)
-{
-	gpio_free(spi->cs_gpio);
-}
-
 /* the spi->mode bits understood by this driver: */
 #define MODEBITS  (SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_LOOP | SPI_CS_HIGH)
 static int spi_st_setup(struct spi_device *spi)
@@ -185,7 +180,6 @@ static int spi_st_setup(struct spi_device *spi)
 	struct spi_st *spi_st = spi_master_get_devdata(spi->master);
 	u32 spi_st_clk, sscbrg, var;
 	u32 hz = spi->max_speed_hz;
-	int cs = spi->cs_gpio;
 	int ret;
 
 	if (!hz)  {
@@ -193,21 +187,6 @@ static int spi_st_setup(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	if (!gpio_is_valid(cs)) {
-		dev_err(&spi->dev, "%d is not a valid gpio\n", cs);
-		return -EINVAL;
-	}
-
-	ret = gpio_request(cs, dev_name(&spi->dev));
-	if (ret) {
-		dev_err(&spi->dev, "could not request gpio:%d\n", cs);
-		return ret;
-	}
-
-	ret = gpio_direction_output(cs, spi->mode & SPI_CS_HIGH);
-	if (ret)
-		goto out_free_gpio;
-
 	spi_st_clk = clk_get_rate(spi_st->clk);
 
 	/* Set SSC_BRF */
@@ -215,8 +194,7 @@ static int spi_st_setup(struct spi_device *spi)
 	if (sscbrg < 0x07 || sscbrg > BIT(16)) {
 		dev_err(&spi->dev,
 			"baudrate %d outside valid range %d\n", sscbrg, hz);
-		ret = -EINVAL;
-		goto out_free_gpio;
+		return -EINVAL;
 	}
 
 	spi_st->baud = spi_st_clk / (2 * sscbrg);
@@ -265,10 +243,6 @@ static int spi_st_setup(struct spi_device *spi)
 	readl_relaxed(spi_st->base + SSC_RBUF);
 
 	return 0;
-
-out_free_gpio:
-	gpio_free(cs);
-	return ret;
 }
 
 /* Interrupt fired when TX shift register becomes empty */
@@ -312,7 +286,6 @@ static int spi_st_probe(struct platform_device *pdev)
 	master->dev.of_node		= np;
 	master->mode_bits		= MODEBITS;
 	master->setup			= spi_st_setup;
-	master->cleanup			= spi_st_cleanup;
 	master->transfer_one		= spi_st_transfer_one;
 	master->bits_per_word_mask	= SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
 	master->auto_runtime_pm		= true;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3860f0c84e1a..cfd1b251354e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -459,7 +459,6 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
 	spi->dev.parent = &ctlr->dev;
 	spi->dev.bus = &spi_bus_type;
 	spi->dev.release = spidev_release;
-	spi->cs_gpio = -ENOENT;
 
 	spin_lock_init(&spi->statistics.lock);
 
@@ -532,7 +531,7 @@ int spi_add_device(struct spi_device *spi)
 	}
 
 	if (ctlr->cs_gpios)
-		spi->cs_gpio = desc_to_gpio(ctlr->cs_gpios[spi->chip_select]);
+		spi->cs_gpio = ctlr->cs_gpios[spi->chip_select];
 	else
 		spi->cs_gpio = -ENOENT;
 
@@ -727,11 +726,8 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 	if (spi->mode & SPI_CS_HIGH)
 		enable = !enable;
 
-	if (gpio_is_valid(spi->cs_gpio)) {
-		struct gpio_desc *gpio = gpio_to_desc(spi->cs_gpio);
-
-		if (gpio)
-			gpiod_set_value(gpio, !enable);
+	if (spi->cs_gpio) {
+		gpiod_set_value(spi->cs_gpio, !enable);
 		/* Some SPI masters need both GPIO CS & slave_select */
 		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
 		    spi->controller->set_cs)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7e170db7bc9d..e97a14637988 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -167,7 +167,7 @@ struct spi_device {
 	void			*controller_state;
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
-	int			cs_gpio;	/* chip select gpio */
+	struct gpio_desc	*cs_gpio;	/* chip select gpio */
 
 	/* the statistics */
 	struct spi_statistics	statistics;
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
