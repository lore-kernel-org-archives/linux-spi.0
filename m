From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] spi: Allow building SPI_BCM63XX_HSSPI on ARM-based SoCs
Date: Fri, 19 Oct 2018 11:12:32 -0700
Message-ID: <20181019181233.10227-1-f.fainelli@gmail.com>
Cc: jonas.gorski@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

ARM-based 63xx DSL platforms have the spi-bcm63xx-hsspi controller
present, allow using this driver there as well.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 671d078349cc..5bc8bdcf46ee 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -129,7 +129,7 @@ config SPI_BCM63XX
 
 config SPI_BCM63XX_HSSPI
 	tristate "Broadcom BCM63XX HS SPI controller driver"
-	depends on BCM63XX || COMPILE_TEST
+	depends on BCM63XX || ARCH_BCM_63XX || COMPILE_TEST
 	help
 	  This enables support for the High Speed SPI controller present on
 	  newer Broadcom BCM63XX SoCs.
-- 
2.17.1
