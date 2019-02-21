From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-gpio: fix SPI_CS_HIGH capability" to the spi tree
Date: Thu, 21 Feb 2019 19:13:29 +0000 (GMT)
Message-ID: <20190221191329.DC1791122744@debutante.sirena.org.uk>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-gpio: fix SPI_CS_HIGH capability

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

>From b89fefda7d4e3a649129584d855be233c7465264 Mon Sep 17 00:00:00 2001
From: Russell King <rmk+kernel@armlinux.org.uk>
Date: Thu, 21 Feb 2019 15:59:58 +0000
Subject: [PATCH] spi: spi-gpio: fix SPI_CS_HIGH capability

spi-gpio is capable of dealing with active-high chip-selects.
Unfortunately, commit 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE
support") broke this by setting master->mode_bits, which overrides
the setting in the spi-bitbang code.  Fix this.

[Fixed a trivial conflict with SPI_3WIRE_HIZ support -- broonie]

Fixes: 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE support")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index a4aee26028cd..53b35c56a557 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -428,7 +428,8 @@ static int spi_gpio_probe(struct platform_device *pdev)
 		return status;
 
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-	master->mode_bits = SPI_3WIRE | SPI_3WIRE_HIZ | SPI_CPHA | SPI_CPOL;
+	master->mode_bits = SPI_3WIRE | SPI_3WIRE_HIZ | SPI_CPHA | SPI_CPOL |
+			    SPI_CS_HIGH;
 	master->flags = master_flags;
 	master->bus_num = pdev->id;
 	/* The master needs to think there is a chipselect even if not connected */
@@ -455,7 +456,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 		spi_gpio->bitbang.txrx_word[SPI_MODE_3] = spi_gpio_spec_txrx_word_mode3;
 	}
 	spi_gpio->bitbang.setup_transfer = spi_bitbang_setup_transfer;
-	spi_gpio->bitbang.flags = SPI_CS_HIGH;
 
 	status = spi_bitbang_start(&spi_gpio->bitbang);
 	if (status)
-- 
2.20.1
