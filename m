From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: gpio: Add local struct spi_bitbang pointer in spi_gpio_probe()" to the spi tree
Date: Wed,  3 Apr 2019 05:42:30 +0100 (BST)
Message-ID: <20190403044230.649A6440082@finisterre.ee.mobilebroadband>
References: <20190403040133.1459-4-andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403040133.1459-4-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: gpio: Add local struct spi_bitbang pointer in spi_gpio_probe()

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

>From 15dd0e9e002ad39d93a0ff6935bc619d42ce3551 Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 2 Apr 2019 21:01:24 -0700
Subject: [PATCH] spi: gpio: Add local struct spi_bitbang pointer in
 spi_gpio_probe()

Use a local "struct spi_bitbang *bb" in spi_gpio_probe() for
brevity. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
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
