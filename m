From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 03/12] spi: gpio: Add local struct spi_bitbang pointer in spi_gpio_probe()
Date: Tue,  2 Apr 2019 21:01:24 -0700
Message-ID: <20190403040133.1459-4-andrew.smirnov@gmail.com>
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

Use a local "struct spi_bitbang *bb" in spi_gpio_probe() for
brevity. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 2869af5ff936..ca97b861c625 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -380,6 +380,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	struct spi_gpio			*spi_gpio;
 	struct spi_gpio_platform_data	*pdata;
 	struct device			*dev = &pdev->dev;
+	struct spi_bitbang		*bb;
 	u16 master_flags = 0;
 	bool use_of = 0;
 
@@ -434,23 +435,23 @@ static int spi_gpio_probe(struct platform_device *pdev)
 #ifdef CONFIG_OF
 	master->dev.of_node = dev->of_node;
 #endif
-
-	spi_gpio->bitbang.master = master;
-	spi_gpio->bitbang.chipselect = spi_gpio_chipselect;
-	spi_gpio->bitbang.set_line_direction = spi_gpio_set_direction;
+	bb = &spi_gpio->bitbang;
+	bb->master = master;
+	bb->chipselect = spi_gpio_chipselect;
+	bb->set_line_direction = spi_gpio_set_direction;
 
 	if ((master_flags & SPI_MASTER_NO_TX) == 0) {
-		spi_gpio->bitbang.txrx_word[SPI_MODE_0] = spi_gpio_txrx_word_mode0;
-		spi_gpio->bitbang.txrx_word[SPI_MODE_1] = spi_gpio_txrx_word_mode1;
-		spi_gpio->bitbang.txrx_word[SPI_MODE_2] = spi_gpio_txrx_word_mode2;
-		spi_gpio->bitbang.txrx_word[SPI_MODE_3] = spi_gpio_txrx_word_mode3;
+		bb->txrx_word[SPI_MODE_0] = spi_gpio_txrx_word_mode0;
+		bb->txrx_word[SPI_MODE_1] = spi_gpio_txrx_word_mode1;
+		bb->txrx_word[SPI_MODE_2] = spi_gpio_txrx_word_mode2;
+		bb->txrx_word[SPI_MODE_3] = spi_gpio_txrx_word_mode3;
 	} else {
-		spi_gpio->bitbang.txrx_word[SPI_MODE_0] = spi_gpio_spec_txrx_word_mode0;
-		spi_gpio->bitbang.txrx_word[SPI_MODE_1] = spi_gpio_spec_txrx_word_mode1;
-		spi_gpio->bitbang.txrx_word[SPI_MODE_2] = spi_gpio_spec_txrx_word_mode2;
-		spi_gpio->bitbang.txrx_word[SPI_MODE_3] = spi_gpio_spec_txrx_word_mode3;
+		bb->txrx_word[SPI_MODE_0] = spi_gpio_spec_txrx_word_mode0;
+		bb->txrx_word[SPI_MODE_1] = spi_gpio_spec_txrx_word_mode1;
+		bb->txrx_word[SPI_MODE_2] = spi_gpio_spec_txrx_word_mode2;
+		bb->txrx_word[SPI_MODE_3] = spi_gpio_spec_txrx_word_mode3;
 	}
-	spi_gpio->bitbang.setup_transfer = spi_bitbang_setup_transfer;
+	bb->setup_transfer = spi_bitbang_setup_transfer;
 
 	status = spi_bitbang_start(&spi_gpio->bitbang);
 	if (status)
-- 
2.20.1
