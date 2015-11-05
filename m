From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [RFC PATCH 3/7] spi: tegra: remove redundant "depends on RESET_CONTROLLER"
Date: Thu,  5 Nov 2015 20:15:24 +0900
Message-ID: <1446722128-11961-4-git-send-email-yamada.masahiro@socionext.com>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

ARCH_TEGRA selects RESET_CONTROLLER.
The dependency "depends on RESET_CONTROLLER" is already met.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/spi/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 604ffab..d853306 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -549,7 +549,7 @@ config SPI_MXS
 config SPI_TEGRA114
 	tristate "NVIDIA Tegra114 SPI Controller"
 	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
-	depends on RESET_CONTROLLER && HAS_DMA
+	depends on HAS_DMA
 	help
 	  SPI driver for NVIDIA Tegra114 SPI Controller interface. This controller
 	  is different than the older SoCs SPI controller and also register interface
@@ -558,7 +558,6 @@ config SPI_TEGRA114
 config SPI_TEGRA20_SFLASH
 	tristate "Nvidia Tegra20 Serial flash Controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
-	depends on RESET_CONTROLLER
 	help
 	  SPI driver for Nvidia Tegra20 Serial flash Controller interface.
 	  The main usecase of this controller is to use spi flash as boot
@@ -567,7 +566,7 @@ config SPI_TEGRA20_SFLASH
 config SPI_TEGRA20_SLINK
 	tristate "Nvidia Tegra20/Tegra30 SLINK Controller"
 	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
-	depends on RESET_CONTROLLER && HAS_DMA
+	depends on HAS_DMA
 	help
 	  SPI driver for Nvidia Tegra20/Tegra30 SLINK Controller interface.
 
-- 
1.9.1
