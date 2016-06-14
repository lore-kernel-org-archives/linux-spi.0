From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "SPI: imx: Remove unnecessary field "mode" from struct spi_imx_config" to the spi tree
Date: Tue, 14 Jun 2016 10:19:18 +0100
Message-ID: <E1bCkVC-00061r-HT@finisterre>
References: <1465405329-5153-2-git-send-email-shc_work@mail.ru>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465405329-5153-2-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   SPI: imx: Remove unnecessary field "mode" from struct spi_imx_config

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

>From 66b285c337d7de456cad50fee85d5c55ca8e81f1 Mon Sep 17 00:00:00 2001
From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Date: Wed, 8 Jun 2016 20:02:07 +0300
Subject: [PATCH] SPI: imx: Remove unnecessary field "mode" from struct
 spi_imx_config

SPI mode can be obtained directly from spi-device, there is no
need to keep a copy.

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index cbcfb8b70b21..0aa38c23e064 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -59,7 +59,6 @@
 struct spi_imx_config {
 	unsigned int speed_hz;
 	unsigned int bpw;
-	unsigned int mode;
 };
 
 enum spi_imx_devtype {
@@ -360,19 +359,19 @@ static int __maybe_unused mx51_ecspi_config(struct spi_device *spi,
 
 	cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
 
-	if (config->mode & SPI_CPHA)
+	if (spi->mode & SPI_CPHA)
 		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
 	else
 		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
 
-	if (config->mode & SPI_CPOL) {
+	if (spi->mode & SPI_CPOL) {
 		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(spi->chip_select);
 		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(spi->chip_select);
 	} else {
 		cfg &= ~MX51_ECSPI_CONFIG_SCLKPOL(spi->chip_select);
 		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(spi->chip_select);
 	}
-	if (config->mode & SPI_CS_HIGH)
+	if (spi->mode & SPI_CS_HIGH)
 		cfg |= MX51_ECSPI_CONFIG_SSBPOL(spi->chip_select);
 	else
 		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(spi->chip_select);
@@ -384,7 +383,7 @@ static int __maybe_unused mx51_ecspi_config(struct spi_device *spi,
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 
 	reg = readl(spi_imx->base + MX51_ECSPI_TESTREG);
-	if (config->mode & SPI_LOOP)
+	if (spi->mode & SPI_LOOP)
 		reg |= MX51_ECSPI_TESTREG_LBC;
 	else
 		reg &= ~MX51_ECSPI_TESTREG_LBC;
@@ -495,11 +494,11 @@ static int __maybe_unused mx31_config(struct spi_device *spi,
 		reg |= (config->bpw - 1) << MX31_CSPICTRL_BC_SHIFT;
 	}
 
-	if (config->mode & SPI_CPHA)
+	if (spi->mode & SPI_CPHA)
 		reg |= MX31_CSPICTRL_PHA;
-	if (config->mode & SPI_CPOL)
+	if (spi->mode & SPI_CPOL)
 		reg |= MX31_CSPICTRL_POL;
-	if (config->mode & SPI_CS_HIGH)
+	if (spi->mode & SPI_CS_HIGH)
 		reg |= MX31_CSPICTRL_SSPOL;
 	if (spi->cs_gpio < 0)
 		reg |= (spi->cs_gpio + 32) <<
@@ -568,11 +567,11 @@ static int __maybe_unused mx21_config(struct spi_device *spi,
 		MX21_CSPICTRL_DR_SHIFT;
 	reg |= config->bpw - 1;
 
-	if (config->mode & SPI_CPHA)
+	if (spi->mode & SPI_CPHA)
 		reg |= MX21_CSPICTRL_PHA;
-	if (config->mode & SPI_CPOL)
+	if (spi->mode & SPI_CPOL)
 		reg |= MX21_CSPICTRL_POL;
-	if (config->mode & SPI_CS_HIGH)
+	if (spi->mode & SPI_CS_HIGH)
 		reg |= MX21_CSPICTRL_SSPOL;
 	if (spi->cs_gpio < 0)
 		reg |= (spi->cs_gpio + 32) << MX21_CSPICTRL_CS_SHIFT;
@@ -634,9 +633,9 @@ static int __maybe_unused mx1_config(struct spi_device *spi,
 		MX1_CSPICTRL_DR_SHIFT;
 	reg |= config->bpw - 1;
 
-	if (config->mode & SPI_CPHA)
+	if (spi->mode & SPI_CPHA)
 		reg |= MX1_CSPICTRL_PHA;
-	if (config->mode & SPI_CPOL)
+	if (spi->mode & SPI_CPOL)
 		reg |= MX1_CSPICTRL_POL;
 
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
@@ -857,7 +856,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 
 	config.bpw = t ? t->bits_per_word : spi->bits_per_word;
 	config.speed_hz  = t ? t->speed_hz : spi->max_speed_hz;
-	config.mode = spi->mode;
 
 	if (!config.speed_hz)
 		config.speed_hz = spi->max_speed_hz;
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
