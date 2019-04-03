From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: spi-gpio: Remove spi->controller_data comment
Date: Wed,  3 Apr 2019 16:46:02 +0200
Message-ID: <20190403144602.8098-1-geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The conversion from GPIO numbers to GPIO descriptors removed the use of
spi->controller_data, but forgot to update a comment referring to it.

Fixes: 9b00bc7b901ff672 ("spi: spi-gpio: Rewrite to use GPIO descriptors")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 53b35c56a557ae8a..f22db00b51e453b8 100644
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
2.17.1
