From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 08/12] spi: gpio: Drop mflags argument from spi_gpio_request()
Date: Tue,  2 Apr 2019 21:01:29 -0700
Message-ID: <20190403040133.1459-9-andrew.smirnov@gmail.com>
References: <20190403040133.1459-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403040133.1459-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The logic of setting mflags in spi_gpio_request() is very simple and
there isn't much benefit in having it in that function. Move all of
that code outside into spi_gpio_probe() in order to simplify things.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 8feb036aaf36..84ca803f6f69 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -290,25 +290,15 @@ static void spi_gpio_cleanup(struct spi_device *spi)
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
@@ -382,7 +372,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	struct device			*dev = &pdev->dev;
 	struct spi_bitbang		*bb;
 	const struct of_device_id	*of_id;
-	u16 master_flags = 0;
 
 	of_id = of_match_device(spi_gpio_dt_ids, &pdev->dev);
 
@@ -404,14 +393,23 @@ static int spi_gpio_probe(struct platform_device *pdev)
 
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
@@ -421,7 +419,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	bb->chipselect = spi_gpio_chipselect;
 	bb->set_line_direction = spi_gpio_set_direction;
 
-	if (master_flags & SPI_MASTER_NO_TX) {
+	if (master->flags & SPI_MASTER_NO_TX) {
 		bb->txrx_word[SPI_MODE_0] = spi_gpio_spec_txrx_word_mode0;
 		bb->txrx_word[SPI_MODE_1] = spi_gpio_spec_txrx_word_mode1;
 		bb->txrx_word[SPI_MODE_2] = spi_gpio_spec_txrx_word_mode2;
-- 
2.20.1
