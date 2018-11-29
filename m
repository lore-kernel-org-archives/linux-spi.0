From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PTCH -next] spi: fix spi-at91-usart.c build errors when PINCTRL is
 not set
Date: Thu, 29 Nov 2018 14:34:15 -0800
Message-ID: <744804c8-49c4-d0b6-d58c-2d573765f28b@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Radu Pirea <radu.pirea@microchip.com>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

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
---
 drivers/spi/spi-at91-usart.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20181129.orig/drivers/spi/spi-at91-usart.c
+++ linux-next-20181129/drivers/spi/spi-at91-usart.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
