From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: atmel: Improve and fix GPIO CS usage" to the spi tree
Date: Fri, 18 Oct 2019 19:07:07 +0100 (BST)
Message-ID: <20191018180707.E63F92743273@ypsilon.sirena.org.uk>
References: <20191017141846.7523-7-gregory.clement@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191017141846.7523-7-gregory.clement@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: atmel: Improve and fix GPIO CS usage

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

>From 57e3137710443a3227a54c425b9c606425678c8f Mon Sep 17 00:00:00 2001
From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Thu, 17 Oct 2019 16:18:45 +0200
Subject: [PATCH] spi: atmel: Improve and fix GPIO CS usage

In the previous implementation of this driver, the index of the GPIO
used as CS was linked to the offset of the CS register used to
configure the transfer.

With this new implementation the first CS register not used by
internal CS is associated to all the GPIO CS. It allows to not be
anymore limited to have only 4 CS managed, now it is possible to have
in the same time until 3 internal CS and no more limit for the CS
GPIO.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/r/20191017141846.7523-7-gregory.clement@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 74 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 1ff5b20eabf7..ac5e2ddf9e1b 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -280,6 +280,8 @@ struct atmel_spi {
 	bool			cs_active;
 
 	u32			fifo_size;
+	u8			native_cs_free;
+	u8			native_cs_for_gpio;
 };
 
 /* Controller-specific per-slave state */
@@ -324,23 +326,29 @@ static bool atmel_spi_is_v2(struct atmel_spi *as)
 static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 {
 	struct atmel_spi_device *asd = spi->controller_state;
+	int chip_select;
 	u32 mr;
 
+	if (spi->cs_gpiod)
+		chip_select = as->native_cs_for_gpio;
+	else
+		chip_select = spi->chip_select;
+
 	if (atmel_spi_is_v2(as)) {
-		spi_writel(as, CSR0 + 4 * spi->chip_select, asd->csr);
+		spi_writel(as, CSR0 + 4 * chip_select, asd->csr);
 		/* For the low SPI version, there is a issue that PDC transfer
 		 * on CS1,2,3 needs SPI_CSR0.BITS config as SPI_CSR1,2,3.BITS
 		 */
 		spi_writel(as, CSR0, asd->csr);
 		if (as->caps.has_wdrbt) {
 			spi_writel(as, MR,
-					SPI_BF(PCS, ~(0x01 << spi->chip_select))
+					SPI_BF(PCS, ~(0x01 << chip_select))
 					| SPI_BIT(WDRBT)
 					| SPI_BIT(MODFDIS)
 					| SPI_BIT(MSTR));
 		} else {
 			spi_writel(as, MR,
-					SPI_BF(PCS, ~(0x01 << spi->chip_select))
+					SPI_BF(PCS, ~(0x01 << chip_select))
 					| SPI_BIT(MODFDIS)
 					| SPI_BIT(MSTR));
 		}
@@ -362,7 +370,7 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 		}
 
 		mr = spi_readl(as, MR);
-		mr = SPI_BFINS(PCS, ~(1 << spi->chip_select), mr);
+		mr = SPI_BFINS(PCS, ~(1 << chip_select), mr);
 		if (spi->cs_gpiod && spi->chip_select != 0)
 			gpiod_set_value(spi->cs_gpiod, 1);
 		spi_writel(as, MR, mr);
@@ -373,13 +381,19 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 
 static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 {
+	int chip_select;
 	u32 mr;
 
+	if (spi->cs_gpiod)
+		chip_select = as->native_cs_for_gpio;
+	else
+		chip_select = spi->chip_select;
+
 	/* only deactivate *this* device; sometimes transfers to
 	 * another device may be active when this routine is called.
 	 */
 	mr = spi_readl(as, MR);
-	if (~SPI_BFEXT(PCS, mr) & (1 << spi->chip_select)) {
+	if (~SPI_BFEXT(PCS, mr) & (1 << chip_select)) {
 		mr = SPI_BFINS(PCS, 0xf, mr);
 		spi_writel(as, MR, mr);
 	}
@@ -815,6 +829,12 @@ static int atmel_spi_set_xfer_speed(struct atmel_spi *as,
 {
 	u32			scbr, csr;
 	unsigned long		bus_hz;
+	int chip_select;
+
+	if (spi->cs_gpiod)
+		chip_select = as->native_cs_for_gpio;
+	else
+		chip_select = spi->chip_select;
 
 	/* v1 chips start out at half the peripheral bus speed. */
 	bus_hz = as->spi_clk;
@@ -843,9 +863,9 @@ static int atmel_spi_set_xfer_speed(struct atmel_spi *as,
 			xfer->speed_hz, scbr, bus_hz);
 		return -EINVAL;
 	}
-	csr = spi_readl(as, CSR0 + 4 * spi->chip_select);
+	csr = spi_readl(as, CSR0 + 4 * chip_select);
 	csr = SPI_BFINS(SCBR, scbr, csr);
-	spi_writel(as, CSR0 + 4 * spi->chip_select, csr);
+	spi_writel(as, CSR0 + 4 * chip_select, csr);
 
 	return 0;
 }
@@ -1162,12 +1182,32 @@ static int atmel_word_delay_csr(struct spi_device *spi, struct atmel_spi *as)
 	return (as->spi_clk / 1000000 * value) >> 5;
 }
 
+static void initialize_native_cs_for_gpio(struct atmel_spi *as)
+{
+	int i;
+	struct spi_master *master = platform_get_drvdata(as->pdev);
+
+	if (!as->native_cs_free)
+		return; /* already initialized */
+
+	if (!master->cs_gpiods)
+		return; /* No CS GPIO */
+
+	for (i = 0; i < 4; i++)
+		if (master->cs_gpiods[i])
+			as->native_cs_free |= BIT(i);
+
+	if (as->native_cs_free)
+		as->native_cs_for_gpio = ffs(as->native_cs_free);
+}
+
 static int atmel_spi_setup(struct spi_device *spi)
 {
 	struct atmel_spi	*as;
 	struct atmel_spi_device	*asd;
 	u32			csr;
 	unsigned int		bits = spi->bits_per_word;
+	int chip_select;
 	int			word_delay_csr;
 
 	as = spi_master_get_devdata(spi->master);
@@ -1178,6 +1218,24 @@ static int atmel_spi_setup(struct spi_device *spi)
 		return -EINVAL;
 	}
 
+	/* Setup() is called during spi_register_controller(aka
+	 * spi_register_master) but after all membmers of the cs_gpiod
+	 * array have been filled, so we can looked for which native
+	 * CS will be free for using with GPIO
+	 */
+	initialize_native_cs_for_gpio(as);
+
+	if (spi->cs_gpiod && as->native_cs_free) {
+		dev_err(&spi->dev,
+			"No native CS available to support this GPIO CS\n");
+		return -EBUSY;
+	}
+
+	if (spi->cs_gpiod)
+		chip_select = as->native_cs_for_gpio;
+	else
+		chip_select = spi->chip_select;
+
 	csr = SPI_BF(BITS, bits - 8);
 	if (spi->mode & SPI_CPOL)
 		csr |= SPI_BIT(CPOL);
@@ -1213,7 +1271,7 @@ static int atmel_spi_setup(struct spi_device *spi)
 		bits, spi->mode, spi->chip_select, csr);
 
 	if (!atmel_spi_is_v2(as))
-		spi_writel(as, CSR0 + 4 * spi->chip_select, csr);
+		spi_writel(as, CSR0 + 4 * chip_select, csr);
 
 	return 0;
 }
-- 
2.20.1
