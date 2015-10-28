From: Yuan Yao <yao.yuan@freescale.com>
Subject: [PATCH] spi: Add DSPI support for layerscape family
Date: Wed, 28 Oct 2015 17:41:59 +0800
Message-ID: <1446025319-44125-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

LS1043a and LS2080A in the Layerscape family also support DSPI, make
DSPI selectable for these hardwares.

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4887f31..bb41bd5 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -304,7 +304,7 @@ config SPI_FSL_SPI
 config SPI_FSL_DSPI
 	tristate "Freescale DSPI controller"
 	select REGMAP_MMIO
-	depends on SOC_VF610 || SOC_LS1021A || COMPILE_TEST
+	depends on SOC_VF610 || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
 	help
 	  This enables support for the Freescale DSPI controller in master
 	  mode. VF610 platform uses the controller.
-- 
2.1.0.27.g96db324
