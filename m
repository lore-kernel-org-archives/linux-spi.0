From: Alban Bedel <albeu@free.fr>
Subject: [PATCH 2/6] spi: ath79: Simplify ath79_spi_chipselect()
Date: Wed, 16 Jan 2019 19:55:45 +0100
Message-ID: <20190116185549.23295-2-albeu@free.fr>
References: <20190116185549.23295-1-albeu@free.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Alban Bedel <albeu@free.fr>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116185549.23295-1-albeu@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

First of all this callback was slightly misused to setup the clock
polarity at the beginning of a transfer. Beside being at the wrong
place, it is also useless as only SPI mode 1 is supported. Instead
just make sure the base value used for IOC is suitable to start a
transfer by clearing the clock and data bits during the controller
setup.

This also remove the last direct usage of the GPIO API, so we can
remove the direct dependency on GPIOLIB.

Signed-off-by: Alban Bedel <albeu@free.fr>
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
2.19.1
