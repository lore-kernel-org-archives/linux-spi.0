From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: imx: add SPI_NO_CS support" to the spi tree
Date: Wed, 26 Jul 2017 15:18:03 +0100
Message-ID: <E1daN8V-0003sL-FR@debutante>
References: <20170725075709.27438-2-o.rempel@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Oleksij Rempel <o.rempel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170725075709.27438-2-o.rempel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: imx: add SPI_NO_CS support

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

>From ab2f357223eb8fa6acc96bfa002053b6f1f92341 Mon Sep 17 00:00:00 2001
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Tue, 25 Jul 2017 09:57:09 +0200
Subject: [PATCH] spi: imx: add SPI_NO_CS support

To run spi-loopback-tests on HW without modifications, we need to
disable Chip Select. This should avoid surprising side effects for SPI devices
by testing patterns.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 424dd013451e..930e47597db3 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -813,6 +813,9 @@ static void spi_imx_chipselect(struct spi_device *spi, int is_active)
 	int active = is_active != BITBANG_CS_INACTIVE;
 	int dev_is_lowactive = !(spi->mode & SPI_CS_HIGH);
 
+	if (spi->mode & SPI_NO_CS)
+		return;
+
 	if (!gpio_is_valid(spi->cs_gpio))
 		return;
 
@@ -1139,6 +1142,9 @@ static int spi_imx_setup(struct spi_device *spi)
 	dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n", __func__,
 		 spi->mode, spi->bits_per_word, spi->max_speed_hz);
 
+	if (spi->mode & SPI_NO_CS)
+		return 0;
+
 	if (gpio_is_valid(spi->cs_gpio))
 		gpio_direction_output(spi->cs_gpio,
 				      spi->mode & SPI_CS_HIGH ? 0 : 1);
@@ -1238,7 +1244,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master->cleanup = spi_imx_cleanup;
 	spi_imx->bitbang.master->prepare_message = spi_imx_prepare_message;
 	spi_imx->bitbang.master->unprepare_message = spi_imx_unprepare_message;
-	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
+					     | SPI_NO_CS;
 	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
 	    is_imx53_ecspi(spi_imx))
 		spi_imx->bitbang.master->mode_bits |= SPI_LOOP | SPI_READY;
-- 
2.13.2
