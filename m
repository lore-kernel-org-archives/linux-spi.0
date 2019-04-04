From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-gpio: Remove spi->controller_data comment" to the spi tree
Date: Thu,  4 Apr 2019 13:04:51 +0700 (+07)
Message-ID: <20190404060451.937F4441D3C@finisterre.ee.mobilebroadband>
References: <20190403144602.8098-1-geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403144602.8098-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-gpio: Remove spi->controller_data comment

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

>From 807195f2103f8662f8c0f9baf71dd7bc1a6b745b Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 3 Apr 2019 16:46:02 +0200
Subject: [PATCH] spi: spi-gpio: Remove spi->controller_data comment

The conversion from GPIO numbers to GPIO descriptors removed the use of
spi->controller_data, but forgot to update a comment referring to it.

Fixes: 9b00bc7b901ff672 ("spi: spi-gpio: Rewrite to use GPIO descriptors")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 3e98c1a0ba6d..e89348d95817 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -35,7 +35,6 @@
  * platform_device->driver_data ... points to spi_gpio
  *
  * spi->controller_state ... reserved for bitbang framework code
- * spi->controller_data ... holds chipselect GPIO
  *
  * spi->master->dev.driver_data ... points to spi_gpio->bitbang
  */
-- 
2.20.1
