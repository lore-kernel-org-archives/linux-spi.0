From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 34/47] spi: remove blackfin related host drivers
Date: Wed, 14 Mar 2018 16:35:47 +0100
Message-ID: <20180314153603.3127932-35-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The blackfin architecture is getting removed, so these
won't be needed any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/Kconfig          |   19 -
 drivers/spi/Makefile         |    3 -
 drivers/spi/spi-adi-v3.c     |  984 ----------------------------
 drivers/spi/spi-bfin-sport.c |  919 --------------------------
 drivers/spi/spi-bfin5xx.c    | 1462 ------------------------------------------
 5 files changed, 3387 deletions(-)
 delete mode 100644 drivers/spi/spi-adi-v3.c
 delete mode 100644 drivers/spi/spi-bfin-sport.c
 delete mode 100644 drivers/spi/spi-bfin5xx.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 6fb0347a24f2..9b0d9ae740d1 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -115,25 +115,6 @@ config SPI_BCM2835AUX
 	  "universal SPI master", and the regular SPI controller.
 	  This driver is for the universal/auxiliary SPI controller.
 
-config SPI_BFIN5XX
-	tristate "SPI controller driver for ADI Blackfin5xx"
-	depends on BLACKFIN && !BF60x
-	help
-	  This is the SPI controller master driver for Blackfin 5xx processor.
-
-config SPI_ADI_V3
-	tristate "SPI controller v3 for ADI"
-	depends on BF60x
-	help
-	  This is the SPI controller v3 master driver
-	  found on Blackfin 60x processor.
-
-config SPI_BFIN_SPORT
-	tristate "SPI bus via Blackfin SPORT"
-	depends on BLACKFIN
-	help
-	  Enable support for a SPI bus via the Blackfin SPORT peripheral.
-
 config SPI_BCM53XX
 	tristate "Broadcom BCM53xx SPI controller"
 	depends on ARCH_BCM_5301X
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 34c5f2832ddf..b935f10eb961 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -24,9 +24,6 @@ obj-$(CONFIG_SPI_BCM53XX)		+= spi-bcm53xx.o
 obj-$(CONFIG_SPI_BCM63XX)		+= spi-bcm63xx.o
 obj-$(CONFIG_SPI_BCM63XX_HSSPI)		+= spi-bcm63xx-hsspi.o
 obj-$(CONFIG_SPI_BCM_QSPI)		+= spi-iproc-qspi.o spi-brcmstb-qspi.o spi-bcm-qspi.o
-obj-$(CONFIG_SPI_BFIN5XX)		+= spi-bfin5xx.o
-obj-$(CONFIG_SPI_ADI_V3)                += spi-adi-v3.o
-obj-$(CONFIG_SPI_BFIN_SPORT)		+= spi-bfin-sport.o
 obj-$(CONFIG_SPI_BITBANG)		+= spi-bitbang.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi-butterfly.o
 obj-$(CONFIG_SPI_CADENCE)		+= spi-cadence.o
diff --git a/drivers/spi/spi-adi-v3.c b/drivers/spi/spi-adi-v3.c
deleted file mode 100644
index a16b25dcd1e6..000000000000
diff --git a/drivers/spi/spi-bfin-sport.c b/drivers/spi/spi-bfin-sport.c
deleted file mode 100644
index 01d0ba9c5942..000000000000
diff --git a/drivers/spi/spi-bfin5xx.c b/drivers/spi/spi-bfin5xx.c
deleted file mode 100644
index 249c7a3677c9..000000000000
-- 
2.9.0
