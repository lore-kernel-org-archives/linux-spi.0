From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: fix spi-at91-usart.c build errors when PINCTRL is not set" to the spi tree
Date: Mon,  3 Dec 2018 12:07:28 +0000 (GMT)
Message-ID: <20181203120728.55B4F440080@finisterre.ee.mobilebroadband>
References: <744804c8-49c4-d0b6-d58c-2d573765f28b@infradead.org>
Cc: Radu Pirea <radu.pirea@microchip.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>,
        linux-spi@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <744804c8-49c4-d0b6-d58c-2d573765f28b@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: fix spi-at91-usart.c build errors when PINCTRL is not set

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

>From c2b142cc3939e932d4fa2210c2a5155df5736590 Mon Sep 17 00:00:00 2001
From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 29 Nov 2018 14:34:15 -0800
Subject: [PATCH] spi: fix spi-at91-usart.c build errors when PINCTRL is not
 set

Fix build errors when CONFIG_PINCTRL is not enabled.
The header file <linux/pinctrl/consumer.h> handles both CONFIG_PINCTRL
enabled and disabled cases.

  CC [M]  drivers/spi/spi-at91-usart.o
../drivers/spi/spi-at91-usart.c: In function 'at91_usart_spi_runtime_suspend':
../drivers/spi/spi-at91-usart.c:409:2: error: implicit declaration of function 'pinctrl_pm_select_sleep_state' [-Werror=implicit-function-declaration]
  pinctrl_pm_select_sleep_state(dev);
../drivers/spi/spi-at91-usart.c: In function 'at91_usart_spi_runtime_resume':
../drivers/spi/spi-at91-usart.c:419:2: error: implicit declaration of function 'pinctrl_pm_select_default_state' [-Werror=implicit-function-declaration]
  pinctrl_pm_select_default_state(dev);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Radu Pirea <radu.pirea@microchip.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-at91-usart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 0b07c746453d..a694d702e574 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
-- 
2.20.0.rc1
