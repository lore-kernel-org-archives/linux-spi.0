From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: gpio: Drop mflags argument from spi_gpio_request()" to the spi tree
Date: Fri,  5 Apr 2019 10:26:34 +0700 (+07)
Message-ID: <20190405032635.0E2FC441D3C@finisterre.ee.mobilebroadband>
References: <20190403040133.1459-9-andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403040133.1459-9-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: gpio: Drop mflags argument from spi_gpio_request()

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

>From 5c8283c172c1597eb7c30b25f186de3ec6ee6cb5 Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 2 Apr 2019 21:01:29 -0700
Subject: [PATCH] spi: gpio: Drop mflags argument from spi_gpio_request()

The logic of setting mflags in spi_gpio_request() is very simple and
there isn't much benefit in having it in that function. Move all of
that code outside into spi_gpio_probe() in order to simplify things.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 3d05c6a71706..4b2a80abf36e 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -289,25 +289,15 @@ static void spi_gpio_cleanup(struct spi_device *spi)
  * floating signals.  (A weak pulldown would save power too, but many
  * drivers expect to see all-ones data as the no slave "response".)
  */
-static int spi_gpio_request(struct device *dev,
-			    struct spi_gpio *spi_gpio,
-			    u16 *mflags)
+static int spi_gpio_request(struct device *dev, struct spi_gpio *spi_gpio)
 {
 	spi_gpio->mosi = devm_gpiod_get_optional(dev, "mosi", GPIOD_OUT_LOW);
 	if (IS_ERR(spi_gpio->mosi))
 		return PTR_ERR(spi_gpio->mosi);
-	if (!spi_gpio->mosi)
-		/* HW configuration without MOSI pin */
-		*mflags |= SPI_MASTER_NO_TX;
 
 	spi_gpio->miso = devm_gpiod_get_optional(dev, "miso", GPIOD_IN);
 	if (IS_ERR(spi_gpio->miso))
 		return PTR_ERR(spi_gpio->miso);
-	/*
-	 * No setting SPI_MASTER_NO_RX here - if there is only a MOSI
-	 * pin connected the host can still do RX by changing the
-	 * direction of the line.
-	 */
 
 	spi_gpio->sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_LOW);
 	if (IS_ERR(spi_gpio->sck))
@@ -381,7 +371,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	struct device			*dev = &pdev->dev;
 	struct spi_bitbang		*bb;
 	const struct of_device_id	*of_id;
-	u16 master_flags = 0;
 
 	of_id = of_match_device(spi_gpio_dt_ids, &pdev->dev);
 
@@ -403,14 +392,23 @@ static int spi_gpio_probe(struct platform_device *pdev)
 
 	spi_gpio->pdev = pdev;
 
-	status = spi_gpio_request(dev, spi_gpio, &master_flags);
+	status = spi_gpio_request(dev, spi_gpio);
 	if (status)
 		return status;
 
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	master->mode_bits = SPI_3WIRE | SPI_3WIRE_HIZ | SPI_CPHA | SPI_CPOL |
 			    SPI_CS_HIGH;
-	master->flags = master_flags;
+	if (!spi_gpio->mosi) {
+		/* HW configuration without MOSI pin
+		 *
+		 * No setting SPI_MASTER_NO_RX here - if there is only
+		 * a MOSI pin connected the host can still do RX by
+		 * changing the direction of the line.
+		 */
+		master->flags = SPI_MASTER_NO_TX;
+	}
+
 	master->bus_num = pdev->id;
 	master->setup = spi_gpio_setup;
 	master->cleanup = spi_gpio_cleanup;
@@ -420,7 +418,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	bb->chipselect = spi_gpio_chipselect;
 	bb->set_line_direction = spi_gpio_set_direction;
 
-	if (master_flags & SPI_MASTER_NO_TX) {
+	if (master->flags & SPI_MASTER_NO_TX) {
 		bb->txrx_word[SPI_MODE_0] = spi_gpio_spec_txrx_word_mode0;
 		bb->txrx_word[SPI_MODE_1] = spi_gpio_spec_txrx_word_mode1;
 		bb->txrx_word[SPI_MODE_2] = spi_gpio_spec_txrx_word_mode2;
-- 
2.20.1
