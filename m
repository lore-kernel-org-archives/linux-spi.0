From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: ath79: Simplify ath79_spi_chipselect()" to the spi tree
Date: Thu, 17 Jan 2019 12:40:18 +0000 (GMT)
Message-ID: <20190117124018.6B9621126FE2@debutante.sirena.org.uk>
References: <20190116185549.23295-2-albeu@free.fr>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Alban Bedel <albeu@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116185549.23295-2-albeu@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: ath79: Simplify ath79_spi_chipselect()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 797622d7a3ab5192ff575288bdbec15c3a006280 Mon Sep 17 00:00:00 2001
From: Alban Bedel <albeu@free.fr>
Date: Wed, 16 Jan 2019 19:55:45 +0100
Subject: [PATCH] spi: ath79: Simplify ath79_spi_chipselect()

First of all this callback was slightly misused to setup the clock
polarity at the beginning of a transfer. Beside being at the wrong
place, it is also useless as only SPI mode 1 is supported. Instead
just make sure the base value used for IOC is suitable to start a
transfer by clearing the clock and data bits during the controller
setup.

This also remove the last direct usage of the GPIO API, so we can
remove the direct dependency on GPIOLIB.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig     |  2 +-
 drivers/spi/spi-ath79.c | 40 +++++++++-------------------------------
 2 files changed, 10 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index dc67eda1788a..128892c7e21e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -63,7 +63,7 @@ config SPI_ALTERA
 
 config SPI_ATH79
 	tristate "Atheros AR71XX/AR724X/AR913X SPI controller driver"
-	depends on ATH79 && GPIOLIB
+	depends on ATH79
 	select SPI_BITBANG
 	help
 	  This enables support for the SPI controller present on the
diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index ed1068ac055f..edf695a359f4 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -21,7 +21,6 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/bitops.h>
-#include <linux/gpio/consumer.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 
@@ -67,38 +66,14 @@ static void ath79_spi_chipselect(struct spi_device *spi, int is_active)
 {
 	struct ath79_spi *sp = ath79_spidev_to_sp(spi);
 	int cs_high = (spi->mode & SPI_CS_HIGH) ? is_active : !is_active;
+	u32 cs_bit = AR71XX_SPI_IOC_CS(spi->chip_select);
 
-	if (is_active) {
-		/* set initial clock polarity */
-		if (spi->mode & SPI_CPOL)
-			sp->ioc_base |= AR71XX_SPI_IOC_CLK;
-		else
-			sp->ioc_base &= ~AR71XX_SPI_IOC_CLK;
-
-		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
-	}
-
-	if (spi->cs_gpiod) {
-		/*
-		 * SPI chipselect is normally active-low, but
-		 * inversion semantics are handled by gpiolib.
-		 *
-		 * FIXME: is this ever used? The driver doesn't
-		 * set SPI_MASTER_GPIO_SS so this callback should not
-		 * get called if a CS GPIO is found by the SPI core.
-		 */
-		gpiod_set_value_cansleep(spi->cs_gpiod, is_active);
-	} else {
-		u32 cs_bit = AR71XX_SPI_IOC_CS(spi->chip_select);
-
-		if (cs_high)
-			sp->ioc_base |= cs_bit;
-		else
-			sp->ioc_base &= ~cs_bit;
-
-		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
-	}
+	if (cs_high)
+		sp->ioc_base |= cs_bit;
+	else
+		sp->ioc_base &= ~cs_bit;
 
+	ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
 }
 
 static void ath79_spi_enable(struct ath79_spi *sp)
@@ -110,6 +85,9 @@ static void ath79_spi_enable(struct ath79_spi *sp)
 	sp->reg_ctrl = ath79_spi_rr(sp, AR71XX_SPI_REG_CTRL);
 	sp->ioc_base = ath79_spi_rr(sp, AR71XX_SPI_REG_IOC);
 
+	/* clear clk and mosi in the base state */
+	sp->ioc_base &= ~(AR71XX_SPI_IOC_DO | AR71XX_SPI_IOC_CLK);
+
 	/* TODO: setup speed? */
 	ath79_spi_wr(sp, AR71XX_SPI_REG_CTRL, 0x43);
 }
-- 
2.20.1
