From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] spi: Fix Kconfig indentation
Date: Wed, 20 Nov 2019 21:39:16 +0800
Message-ID: <20191120133916.13595-1-krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/spi/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 6c0c1f55bd71..870f7797b56b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -144,7 +144,7 @@ config SPI_BCM63XX
 	tristate "Broadcom BCM63xx SPI controller"
 	depends on BCM63XX || COMPILE_TEST
 	help
-          Enable support for the SPI controller on the Broadcom BCM63xx SoCs.
+	  Enable support for the SPI controller on the Broadcom BCM63xx SoCs.
 
 config SPI_BCM63XX_HSSPI
 	tristate "Broadcom BCM63XX HS SPI controller driver"
@@ -235,11 +235,11 @@ config SPI_DLN2
        tristate "Diolan DLN-2 USB SPI adapter"
        depends on MFD_DLN2
        help
-         If you say yes to this option, support will be included for Diolan
-         DLN2, a USB to SPI interface.
+	 If you say yes to this option, support will be included for Diolan
+	 DLN2, a USB to SPI interface.
 
-         This driver can also be built as a module.  If so, the module
-         will be called spi-dln2.
+	 This driver can also be built as a module.  If so, the module
+	 will be called spi-dln2.
 
 config SPI_EFM32
 	tristate "EFM32 SPI controller"
@@ -748,10 +748,10 @@ config SPI_SYNQUACER
 	  It also supports the new dual-bit and quad-bit SPI protocol.
 
 config SPI_MXIC
-        tristate "Macronix MX25F0A SPI controller"
-        depends on SPI_MASTER
-        help
-          This selects the Macronix MX25F0A SPI controller driver.
+	tristate "Macronix MX25F0A SPI controller"
+	depends on SPI_MASTER
+	help
+	  This selects the Macronix MX25F0A SPI controller driver.
 
 config SPI_MXS
 	tristate "Freescale MXS SPI controller"
-- 
2.17.1
