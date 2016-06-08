From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH 1/4] SPI: imx: Using existing properties for chipselects
Date: Wed,  8 Jun 2016 20:02:06 +0300
Message-ID: <1465405329-5153-1-git-send-email-shc_work@mail.ru>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Patch reuse existing "chip_select" and "cs_gpio(s)" fields from SPI core.

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 drivers/spi/spi-imx.c | 124 +++++++++++++++++++++++---------------------------
 1 file changed, 58 insertions(+), 66 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 50769078..cbcfb8b 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -60,7 +60,6 @@ struct spi_imx_config {
 	unsigned int speed_hz;
 	unsigned int bpw;
 	unsigned int mode;
-	u8 cs;
 };
 
 enum spi_imx_devtype {
@@ -76,7 +75,7 @@ struct spi_imx_data;
 
 struct spi_imx_devtype_data {
 	void (*intctrl)(struct spi_imx_data *, int);
-	int (*config)(struct spi_imx_data *, struct spi_imx_config *);
+	int (*config)(struct spi_device *, struct spi_imx_config *);
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
 	void (*reset)(struct spi_imx_data *);
@@ -112,7 +111,6 @@ struct spi_imx_data {
 	struct completion dma_tx_completion;
 
 	const struct spi_imx_devtype_data *devtype_data;
-	int chipselect[0];
 };
 
 static inline int is_imx27_cspi(struct spi_imx_data *d)
@@ -334,9 +332,10 @@ static void __maybe_unused mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
-static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
-		struct spi_imx_config *config)
+static int __maybe_unused mx51_ecspi_config(struct spi_device *spi,
+					    struct spi_imx_config *config)
 {
+	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 	u32 ctrl = MX51_ECSPI_CTRL_ENABLE;
 	u32 clk = config->speed_hz, delay, reg;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
@@ -355,28 +354,28 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	spi_imx->spi_bus_clk = clk;
 
 	/* set chip select to use */
-	ctrl |= MX51_ECSPI_CTRL_CS(config->cs);
+	ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);
 
 	ctrl |= (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
 
-	cfg |= MX51_ECSPI_CONFIG_SBBCTRL(config->cs);
+	cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
 
 	if (config->mode & SPI_CPHA)
-		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
+		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
 	else
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
 
 	if (config->mode & SPI_CPOL) {
-		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
-		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
+		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(spi->chip_select);
+		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(spi->chip_select);
 	} else {
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKPOL(spi->chip_select);
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(spi->chip_select);
 	}
 	if (config->mode & SPI_CS_HIGH)
-		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
+		cfg |= MX51_ECSPI_CONFIG_SSBPOL(spi->chip_select);
 	else
-		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(config->cs);
+		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(spi->chip_select);
 
 	if (spi_imx->usedma)
 		ctrl |= MX51_ECSPI_CTRL_SMC;
@@ -480,11 +479,11 @@ static void __maybe_unused mx31_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
-static int __maybe_unused mx31_config(struct spi_imx_data *spi_imx,
-		struct spi_imx_config *config)
+static int __maybe_unused mx31_config(struct spi_device *spi,
+				      struct spi_imx_config *config)
 {
+	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
-	int cs = spi_imx->chipselect[config->cs];
 
 	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
 		MX31_CSPICTRL_DR_SHIFT;
@@ -502,8 +501,8 @@ static int __maybe_unused mx31_config(struct spi_imx_data *spi_imx,
 		reg |= MX31_CSPICTRL_POL;
 	if (config->mode & SPI_CS_HIGH)
 		reg |= MX31_CSPICTRL_SSPOL;
-	if (cs < 0)
-		reg |= (cs + 32) <<
+	if (spi->cs_gpio < 0)
+		reg |= (spi->cs_gpio + 32) <<
 			(is_imx35_cspi(spi_imx) ? MX35_CSPICTRL_CS_SHIFT :
 						  MX31_CSPICTRL_CS_SHIFT);
 
@@ -558,11 +557,11 @@ static void __maybe_unused mx21_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
-static int __maybe_unused mx21_config(struct spi_imx_data *spi_imx,
-		struct spi_imx_config *config)
+static int __maybe_unused mx21_config(struct spi_device *spi,
+				      struct spi_imx_config *config)
 {
+	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 	unsigned int reg = MX21_CSPICTRL_ENABLE | MX21_CSPICTRL_MASTER;
-	int cs = spi_imx->chipselect[config->cs];
 	unsigned int max = is_imx27_cspi(spi_imx) ? 16 : 18;
 
 	reg |= spi_imx_clkdiv_1(spi_imx->spi_clk, config->speed_hz, max) <<
@@ -575,8 +574,8 @@ static int __maybe_unused mx21_config(struct spi_imx_data *spi_imx,
 		reg |= MX21_CSPICTRL_POL;
 	if (config->mode & SPI_CS_HIGH)
 		reg |= MX21_CSPICTRL_SSPOL;
-	if (cs < 0)
-		reg |= (cs + 32) << MX21_CSPICTRL_CS_SHIFT;
+	if (spi->cs_gpio < 0)
+		reg |= (spi->cs_gpio + 32) << MX21_CSPICTRL_CS_SHIFT;
 
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 
@@ -625,9 +624,10 @@ static void __maybe_unused mx1_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
-static int __maybe_unused mx1_config(struct spi_imx_data *spi_imx,
-		struct spi_imx_config *config)
+static int __maybe_unused mx1_config(struct spi_device *spi,
+				     struct spi_imx_config *config)
 {
+	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 	unsigned int reg = MX1_CSPICTRL_ENABLE | MX1_CSPICTRL_MASTER;
 
 	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
@@ -747,15 +747,13 @@ MODULE_DEVICE_TABLE(of, spi_imx_dt_ids);
 
 static void spi_imx_chipselect(struct spi_device *spi, int is_active)
 {
-	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
-	int gpio = spi_imx->chipselect[spi->chip_select];
 	int active = is_active != BITBANG_CS_INACTIVE;
 	int dev_is_lowactive = !(spi->mode & SPI_CS_HIGH);
 
-	if (!gpio_is_valid(gpio))
+	if (!gpio_is_valid(spi->cs_gpio))
 		return;
 
-	gpio_set_value(gpio, dev_is_lowactive ^ active);
+	gpio_set_value(spi->cs_gpio, dev_is_lowactive ^ active);
 }
 
 static void spi_imx_push(struct spi_imx_data *spi_imx)
@@ -860,7 +858,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	config.bpw = t ? t->bits_per_word : spi->bits_per_word;
 	config.speed_hz  = t ? t->speed_hz : spi->max_speed_hz;
 	config.mode = spi->mode;
-	config.cs = spi->chip_select;
 
 	if (!config.speed_hz)
 		config.speed_hz = spi->max_speed_hz;
@@ -891,7 +888,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 			return ret;
 	}
 
-	spi_imx->devtype_data->config(spi_imx, &config);
+	spi_imx->devtype_data->config(spi, &config);
 
 	return 0;
 }
@@ -1080,14 +1077,12 @@ static int spi_imx_transfer(struct spi_device *spi,
 
 static int spi_imx_setup(struct spi_device *spi)
 {
-	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
-	int gpio = spi_imx->chipselect[spi->chip_select];
-
 	dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n", __func__,
 		 spi->mode, spi->bits_per_word, spi->max_speed_hz);
 
-	if (gpio_is_valid(gpio))
-		gpio_direction_output(gpio, spi->mode & SPI_CS_HIGH ? 0 : 1);
+	if (gpio_is_valid(spi->cs_gpio))
+		gpio_direction_output(spi->cs_gpio,
+				      spi->mode & SPI_CS_HIGH ? 0 : 1);
 
 	spi_imx_chipselect(spi, BITBANG_CS_INACTIVE);
 
@@ -1137,31 +1132,21 @@ static int spi_imx_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct spi_imx_data *spi_imx;
 	struct resource *res;
-	int i, ret, num_cs, irq;
+	int i, ret, irq;
 
 	if (!np && !mxc_platform_info) {
 		dev_err(&pdev->dev, "can't get the platform data\n");
 		return -EINVAL;
 	}
 
-	ret = of_property_read_u32(np, "fsl,spi-num-chipselects", &num_cs);
-	if (ret < 0) {
-		if (mxc_platform_info)
-			num_cs = mxc_platform_info->num_chipselect;
-		else
-			return ret;
-	}
-
-	master = spi_alloc_master(&pdev->dev,
-			sizeof(struct spi_imx_data) + sizeof(int) * num_cs);
+	master = spi_alloc_master(&pdev->dev, sizeof(struct spi_imx_data));
 	if (!master)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, master);
 
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-	master->bus_num = pdev->id;
-	master->num_chipselect = num_cs;
+	master->bus_num = np ? -1 : pdev->id;
 
 	spi_imx = spi_master_get_devdata(master);
 	spi_imx->bitbang.master = master;
@@ -1170,22 +1155,16 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->devtype_data = of_id ? of_id->data :
 		(struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
 
-	for (i = 0; i < master->num_chipselect; i++) {
-		int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
-		if (!gpio_is_valid(cs_gpio) && mxc_platform_info)
-			cs_gpio = mxc_platform_info->chipselect[i];
-
-		spi_imx->chipselect[i] = cs_gpio;
-		if (!gpio_is_valid(cs_gpio))
-			continue;
+	if (mxc_platform_info) {
+		master->num_chipselect = mxc_platform_info->num_chipselect;
+		master->cs_gpios = devm_kzalloc(&master->dev,
+			sizeof(int) * master->num_chipselect, GFP_KERNEL);
+		if (!master->cs_gpios)
+			return -ENOMEM;
 
-		ret = devm_gpio_request(&pdev->dev, spi_imx->chipselect[i],
-					DRIVER_NAME);
-		if (ret) {
-			dev_err(&pdev->dev, "can't get cs gpios\n");
-			goto out_master_put;
-		}
-	}
+		for (i = 0; i < master->num_chipselect; i++)
+			master->cs_gpios[i] = mxc_platform_info->chipselect[i];
+ 	}
 
 	spi_imx->bitbang.chipselect = spi_imx_chipselect;
 	spi_imx->bitbang.setup_transfer = spi_imx_setupxfer;
@@ -1267,6 +1246,19 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
+	for (i = 0; i < master->num_chipselect; i++) {
+		if (!gpio_is_valid(master->cs_gpios[i]))
+			continue;
+
+		ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
+					DRIVER_NAME);
+		if (ret) {
+			dev_err(&pdev->dev, "Can't get CS GPIO %i\n",
+				master->cs_gpios[i]);
+			goto out_clk_put;
+		}
+	}
+
 	dev_info(&pdev->dev, "probed\n");
 
 	clk_disable(spi_imx->clk_ipg);
-- 
2.4.9

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
