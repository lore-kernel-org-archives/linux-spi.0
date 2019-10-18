From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: atmel: Remove useless private field" to the spi tree
Date: Fri, 18 Oct 2019 19:07:08 +0100 (BST)
Message-ID: <20191018180708.500EB2743259@ypsilon.sirena.org.uk>
References: <20191017141846.7523-5-gregory.clement@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191017141846.7523-5-gregory.clement@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: atmel: Remove useless private field

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

>From 60086e23e64f7b3b60d957471cfd10948e25648e Mon Sep 17 00:00:00 2001
From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Thu, 17 Oct 2019 16:18:43 +0200
Subject: [PATCH] spi: atmel: Remove useless private field

Since the conversion to GPIO descriptor, the GPIO used as chip select,
can be directly access from the spi_device struct. So there is no need
to keep the field npcs_pin.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/r/20191017141846.7523-5-gregory.clement@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index b511df6a4846..19600de40422 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -284,7 +284,6 @@ struct atmel_spi {
 
 /* Controller-specific per-slave state */
 struct atmel_spi_device {
-	struct gpio_desc	*npcs_pin;
 	u32			csr;
 };
 
@@ -347,8 +346,8 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 		}
 
 		mr = spi_readl(as, MR);
-		if (asd->npcs_pin)
-			gpiod_set_value(asd->npcs_pin, 1);
+		if (spi->cs_gpiod)
+			gpiod_set_value(spi->cs_gpiod, 1);
 	} else {
 		u32 cpol = (spi->mode & SPI_CPOL) ? SPI_BIT(CPOL) : 0;
 		int i;
@@ -364,8 +363,8 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 
 		mr = spi_readl(as, MR);
 		mr = SPI_BFINS(PCS, ~(1 << spi->chip_select), mr);
-		if (asd->npcs_pin && spi->chip_select != 0)
-			gpiod_set_value(asd->npcs_pin, 1);
+		if (spi->cs_gpiod && spi->chip_select != 0)
+			gpiod_set_value(spi->cs_gpiod, 1);
 		spi_writel(as, MR, mr);
 	}
 
@@ -374,7 +373,6 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 
 static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 {
-	struct atmel_spi_device *asd = spi->controller_state;
 	u32 mr;
 
 	/* only deactivate *this* device; sometimes transfers to
@@ -388,10 +386,10 @@ static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 
 	dev_dbg(&spi->dev, "DEactivate NPCS, mr %08x\n", mr);
 
-	if (!asd->npcs_pin)
+	if (!spi->cs_gpiod)
 		spi_writel(as, CR, SPI_BIT(LASTXFER));
 	else if (atmel_spi_is_v2(as) || spi->chip_select != 0)
-		gpiod_set_value(asd->npcs_pin, 0);
+		gpiod_set_value(spi->cs_gpiod, 0);
 }
 
 static void atmel_spi_lock(struct atmel_spi *as) __acquires(&as->lock)
@@ -1205,9 +1203,6 @@ static int atmel_spi_setup(struct spi_device *spi)
 		if (!asd)
 			return -ENOMEM;
 
-		if (spi->cs_gpiod)
-			asd->npcs_pin = spi->cs_gpiod;
-
 		spi->controller_state = asd;
 	}
 
-- 
2.20.1
