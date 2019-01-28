From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 112/304] spi: fix spi-at91-usart.c build errors when PINCTRL is not set
Date: Mon, 28 Jan 2019 10:40:29 -0500
Message-ID: <20190128154341.47195-112-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Radu Pirea <radu.pirea@microchip.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit c2b142cc3939e932d4fa2210c2a5155df5736590 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-at91-usart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index a924657642fa..08bcbd1f9aa2 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 
 #include <linux/spi/spi.h>
-- 
2.19.1
