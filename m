From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: Add missing error handling for CS GPIOs
Date: Wed,  3 Apr 2019 16:46:56 +0200
Message-ID: <20190403144656.8257-1-geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

While devm_gpiod_get_index_optional() returns NULL if the GPIO is not
present (i.e. -ENOENT), it may still return other error codes, like
-EPROBE_DEFER.  Currently these are not handled, leading to
unrecoverable failures later in case of probe deferral:

    gpiod_set_consumer_name: invalid GPIO (errorpointer)
    gpiod_direction_output: invalid GPIO (errorpointer)
    gpiod_set_value_cansleep: invalid GPIO (errorpointer)
    gpiod_set_value_cansleep: invalid GPIO (errorpointer)
    gpiod_set_value_cansleep: invalid GPIO (errorpointer)

Detect and propagate errors to fix this.

Fixes: f3186dd876697e69 ("spi: Optionally use GPIO descriptors for CS GPIOs")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index bd2a424672df266c..2ad20c735b61c4aa 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2199,6 +2199,8 @@ static int spi_get_gpio_descs(struct spi_controller *ctlr)
 		 */
 		cs[i] = devm_gpiod_get_index_optional(dev, "cs", i,
 						      GPIOD_OUT_LOW);
+		if (IS_ERR(cs[i]))
+			return PTR_ERR(cs[i]);
 
 		if (cs[i]) {
 			/*
-- 
2.17.1
