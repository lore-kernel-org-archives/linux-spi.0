From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: atmel: improve internal vs gpio chip-select choice" to the spi tree
Date: Fri, 08 Jan 2016 13:44:56 +0000
Message-ID: <E1aHXLc-0003NY-Kd@debutante>
References: <1452211907-16074-1-git-send-email-mans@mansr.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452211907-16074-1-git-send-email-mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: atmel: improve internal vs gpio chip-select choice

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

>From 3fe5e14919b7ef2792aed8cacd7d1ae3e30adcd2 Mon Sep 17 00:00:00 2001
From: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Date: Fri, 8 Jan 2016 00:11:47 +0000
Subject: [PATCH] spi: atmel: improve internal vs gpio chip-select choice

The driver currently chooses between internal chip-select or gpio
based on the existence of the cs-gpios DT property which fails on
non-DT systems and also enforces the same choice for all devices.

This patch makes the method per device instead of per controller
and fixes the selection on non-DT systems.  With these changes,
the chip-select method for each device is chosen according to the
following priority:

1. GPIO from device tree
2. GPIO from platform data
3. Internal chip-select

Tested on AVR32 ATSTK1000.

Signed-off-by: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index aebad36391c9..8be07fb67d4d 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -310,7 +310,6 @@ struct atmel_spi {
 
 	bool			use_dma;
 	bool			use_pdc;
-	bool			use_cs_gpios;
 	/* dmaengine data */
 	struct atmel_spi_dma	dma;
 
@@ -324,6 +323,7 @@ struct atmel_spi {
 struct atmel_spi_device {
 	unsigned int		npcs_pin;
 	u32			csr;
+	bool			use_cs_gpio;
 };
 
 #define BUFFER_SIZE		PAGE_SIZE
@@ -388,7 +388,7 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 		}
 
 		mr = spi_readl(as, MR);
-		if (as->use_cs_gpios)
+		if (asd->use_cs_gpio)
 			gpio_set_value(asd->npcs_pin, active);
 	} else {
 		u32 cpol = (spi->mode & SPI_CPOL) ? SPI_BIT(CPOL) : 0;
@@ -405,7 +405,7 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 
 		mr = spi_readl(as, MR);
 		mr = SPI_BFINS(PCS, ~(1 << spi->chip_select), mr);
-		if (as->use_cs_gpios && spi->chip_select != 0)
+		if (asd->use_cs_gpio && spi->chip_select != 0)
 			gpio_set_value(asd->npcs_pin, active);
 		spi_writel(as, MR, mr);
 	}
@@ -434,7 +434,7 @@ static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 			asd->npcs_pin, active ? " (low)" : "",
 			mr);
 
-	if (!as->use_cs_gpios)
+	if (!asd->use_cs_gpio)
 		spi_writel(as, CR, SPI_BIT(LASTXFER));
 	else if (atmel_spi_is_v2(as) || spi->chip_select != 0)
 		gpio_set_value(asd->npcs_pin, !active);
@@ -1221,8 +1221,6 @@ static int atmel_spi_setup(struct spi_device *spi)
 		csr |= SPI_BIT(CPOL);
 	if (!(spi->mode & SPI_CPHA))
 		csr |= SPI_BIT(NCPHA);
-	if (!as->use_cs_gpios)
-		csr |= SPI_BIT(CSAAT);
 
 	/* DLYBS is mostly irrelevant since we manage chipselect using GPIOs.
 	 *
@@ -1233,21 +1231,28 @@ static int atmel_spi_setup(struct spi_device *spi)
 	csr |= SPI_BF(DLYBS, 0);
 	csr |= SPI_BF(DLYBCT, 0);
 
-	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
-	npcs_pin = (unsigned long)spi->controller_data;
-
-	if (!as->use_cs_gpios)
-		npcs_pin = spi->chip_select;
-	else if (gpio_is_valid(spi->cs_gpio))
-		npcs_pin = spi->cs_gpio;
-
 	asd = spi->controller_state;
 	if (!asd) {
 		asd = kzalloc(sizeof(struct atmel_spi_device), GFP_KERNEL);
 		if (!asd)
 			return -ENOMEM;
 
-		if (as->use_cs_gpios) {
+		npcs_pin = (unsigned long)spi->controller_data;
+
+		if (gpio_is_valid(spi->cs_gpio)) {
+			/* GPIO from DT */
+			npcs_pin = spi->cs_gpio;
+			asd->use_cs_gpio = true;
+		} else if (npcs_pin && gpio_is_valid(npcs_pin)) {
+			/* GPIO from platform data */
+			asd->use_cs_gpio = true;
+		} else {
+			/* internal chip-select */
+			npcs_pin = spi->chip_select;
+			asd->use_cs_gpio = false;
+		}
+
+		if (asd->use_cs_gpio) {
 			ret = gpio_request(npcs_pin, dev_name(&spi->dev));
 			if (ret) {
 				kfree(asd);
@@ -1262,6 +1267,8 @@ static int atmel_spi_setup(struct spi_device *spi)
 		spi->controller_state = asd;
 	}
 
+	if (!asd->use_cs_gpio)
+		csr |= SPI_BIT(CSAAT);
 	asd->csr = csr;
 
 	dev_dbg(&spi->dev,
@@ -1569,13 +1576,6 @@ static int atmel_spi_probe(struct platform_device *pdev)
 
 	atmel_get_caps(as);
 
-	as->use_cs_gpios = true;
-	if (atmel_spi_is_v2(as) &&
-	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
-		as->use_cs_gpios = false;
-		master->num_chipselect = 4;
-	}
-
 	as->use_dma = false;
 	as->use_pdc = false;
 	if (as->caps.has_dma_support) {
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
