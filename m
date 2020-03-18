From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mxs: Drop GPIO includes" to the spi tree
Date: Wed, 18 Mar 2020 19:08:06 +0000
Message-ID: <applied-20200317092457.264055-1-linus.walleij@linaro.org>
References: <20200317092457.264055-1-linus.walleij@linaro.org>
Cc: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200317092457.264055-1-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mxs: Drop GPIO includes

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7

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

>From 85dadb718cc23492ef6edbc9af6c765a0c0aca66 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Date: Tue, 17 Mar 2020 10:24:57 +0100
Subject: [PATCH] spi: mxs: Drop GPIO includes

This driver is not using any symbols from the GPIO .h files
so drop them.

It was however implicitly using <linux/pinctrl/consumer.h>
so include that instead.

Cc: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Link: https://lore.kernel.org/r/20200317092457.264055-1-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mxs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index dce85ee07cd0..918918a9e049 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -22,7 +22,6 @@
 #include <linux/ioport.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -32,7 +31,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/completion.h>
-#include <linux/gpio.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/module.h>
-- 
2.20.1
