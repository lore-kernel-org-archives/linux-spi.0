From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] spi: Allow compile test of bcm2835aux if !GPIOLIB
Date: Sun,  7 Feb 2016 15:12:29 +0100
Message-ID: <1454854349-20780-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
To: Mark Brown <broonie@kernel.org>,
	Martin Sperl <kernel@martin.sperl.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
functionality only, can still be compiled if GPIOLIB is not enabled.

Relax the dependency of SPI_BCM2835AUX on GPIOLIB if COMPILE_TEST is
enabled.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/spi/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 77064160dd762c26..4e08d42a9fa1b2c4 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -90,8 +90,7 @@ config SPI_BCM2835
 
 config SPI_BCM2835AUX
 	tristate "BCM2835 SPI auxiliary controller"
-	depends on ARCH_BCM2835 || COMPILE_TEST
-	depends on GPIOLIB
+	depends on (ARCH_BCM2835 && GPIOLIB) || COMPILE_TEST
 	help
 	  This selects a driver for the Broadcom BCM2835 SPI aux master.
 
-- 
1.9.1

