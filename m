From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 04/12] spi: gpio: Simplify SPI_MASTER_NO_TX check in spi_gpio_probe()
Date: Tue,  2 Apr 2019 21:01:25 -0700
Message-ID: <20190403040133.1459-5-andrew.smirnov@gmail.com>
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

Swap branches of the if statement in order to simplify it's logical
condition being checked. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index ca97b861c625..137f47e271dc 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -440,16 +440,16 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	bb->chipselect = spi_gpio_chipselect;
 	bb->set_line_direction = spi_gpio_set_direction;
 
-	if ((master_flags & SPI_MASTER_NO_TX) == 0) {
-		bb->txrx_word[SPI_MODE_0] = spi_gpio_txrx_word_mode0;
-		bb->txrx_word[SPI_MODE_1] = spi_gpio_txrx_word_mode1;
-		bb->txrx_word[SPI_MODE_2] = spi_gpio_txrx_word_mode2;
-		bb->txrx_word[SPI_MODE_3] = spi_gpio_txrx_word_mode3;
-	} else {
+	if (master_flags & SPI_MASTER_NO_TX) {
 		bb->txrx_word[SPI_MODE_0] = spi_gpio_spec_txrx_word_mode0;
 		bb->txrx_word[SPI_MODE_1] = spi_gpio_spec_txrx_word_mode1;
 		bb->txrx_word[SPI_MODE_2] = spi_gpio_spec_txrx_word_mode2;
 		bb->txrx_word[SPI_MODE_3] = spi_gpio_spec_txrx_word_mode3;
+	} else {
+		bb->txrx_word[SPI_MODE_0] = spi_gpio_txrx_word_mode0;
+		bb->txrx_word[SPI_MODE_1] = spi_gpio_txrx_word_mode1;
+		bb->txrx_word[SPI_MODE_2] = spi_gpio_txrx_word_mode2;
+		bb->txrx_word[SPI_MODE_3] = spi_gpio_txrx_word_mode3;
 	}
 	bb->setup_transfer = spi_bitbang_setup_transfer;
 
-- 
2.20.1
