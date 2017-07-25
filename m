From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v1 2/2] spi: imx: add SPI_NO_CS support
Date: Tue, 25 Jul 2017 09:57:09 +0200
Message-ID: <20170725075709.27438-2-o.rempel@pengutronix.de>
References: <20170725075709.27438-1-o.rempel@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170725075709.27438-1-o.rempel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

To run spi-loopback-tests on HW without modifications, we need to
disable Chip Select. This should avoid surprising side effects for SPI devices
by testing patterns.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
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
2.11.0
