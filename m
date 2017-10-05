From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] [SUBMITTED 20171005] spi: spreadtrum adi: add hwspinlock dependency
Date: Thu,  5 Oct 2017 22:39:37 +0200
Message-ID: <20171005203949.3227075-1-arnd@arndb.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

With CONFIG_HWSPINLOCK=m, the new driver fails to link as a built-in driver:

drivers/spi/spi-sprd-adi.o: In function `sprd_adi_remove':
spi-sprd-adi.c:(.text+0x18): undefined reference to `hwspin_lock_free'
drivers/spi/spi-sprd-adi.o: In function `sprd_adi_probe':
spi-sprd-adi.c:(.text+0xfc): undefined reference to `of_hwspin_lock_get_id'
spi-sprd-adi.c:(.text+0x108): undefined reference to `hwspin_lock_request_specific'
spi-sprd-adi.c:(.text+0x268): undefined reference to `hwspin_lock_free'

This adds a hard Kconfig dependency on HWSPINLOCK for the !COMPILE_TEST
case, and allows compile-testing with HWSPINLOCK completely disabled,
which will then rely on the existing stub API.

Fixes: 7e2903cb91df ("spi: Add ADI driver for Spreadtrum platform")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2d9601e3a6ae..ed532ac2eebe 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -625,6 +625,7 @@ config SPI_SIRF
 config SPI_SPRD_ADI
 	tristate "Spreadtrum ADI controller"
 	depends on ARCH_SPRD || COMPILE_TEST
+	depends on HWSPINLOCK || (COMPILE_TEST && !HWSPINLOCK)
 	help
 	  ADI driver based on SPI for Spreadtrum SoCs.
 
-- 
2.9.0
