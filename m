From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Add missing error handling for CS GPIOs" to the spi tree
Date: Thu,  4 Apr 2019 13:04:48 +0700 (+07)
Message-ID: <20190404060448.72973441D3E@finisterre.ee.mobilebroadband>
References: <20190403144656.8257-1-geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403144656.8257-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Add missing error handling for CS GPIOs

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

>From 1723fdec5fcbc4de3d26bbb23a9e1704ee258955 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 3 Apr 2019 16:46:56 +0200
Subject: [PATCH] spi: Add missing error handling for CS GPIOs

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2be394d3bc59..7b6494bd8a9b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2197,6 +2197,8 @@ static int spi_get_gpio_descs(struct spi_controller *ctlr)
 		 */
 		cs[i] = devm_gpiod_get_index_optional(dev, "cs", i,
 						      GPIOD_OUT_LOW);
+		if (IS_ERR(cs[i]))
+			return PTR_ERR(cs[i]);
 
 		if (cs[i]) {
 			/*
-- 
2.20.1
