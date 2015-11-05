From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [RFC PATCH 2/7] spi: sunxi: remove redundant "depends on RESET_CONTROLLER"
Date: Thu,  5 Nov 2015 20:15:23 +0900
Message-ID: <1446722128-11961-3-git-send-email-yamada.masahiro@socionext.com>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

ARCH_SUNXI selects RESET_CONTROLLER.
The dependency "depends on RESET_CONTROLLER" is already met.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/spi/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4887f31..604ffab 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -536,7 +536,6 @@ config SPI_SUN4I
 config SPI_SUN6I
 	tristate "Allwinner A31 SPI controller"
 	depends on ARCH_SUNXI || COMPILE_TEST
-	depends on RESET_CONTROLLER
 	help
 	  This enables using the SPI controller on the Allwinner A31 SoCs.
 
-- 
1.9.1
