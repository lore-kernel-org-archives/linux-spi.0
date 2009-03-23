From: =?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>
Subject: [patch 5/6] xtensa: enable s6000 spi host in s6105_defconfig
Date: Mon, 23 Mar 2009 16:34:21 +0100
Message-ID: <1237822462-32109-5-git-send-email-dg@emlix.com>
References: <1237822462-32109-1-git-send-email-dg@emlix.com>
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	=?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>
To: Chris Zankel <chris@zankel.net>,
	David Brownell <dbrownell@users.sourceforge.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758157AbZCWPdh@vger.kernel.org>
In-Reply-To: <1237822462-32109-1-git-send-email-dg@emlix.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

---
 arch/xtensa/configs/s6105_defconfig |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/arch/xtensa/configs/s6105_defconfig b/arch/xtensa/configs/s6105_defconfig
index e398710..02bab6e 100644
--- a/arch/xtensa/configs/s6105_defconfig
+++ b/arch/xtensa/configs/s6105_defconfig
@@ -260,6 +260,7 @@ CONFIG_MISC_DEVICES=y
 # EEPROM support
 #
 CONFIG_EEPROM_AT24=y
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_EEPROM_LEGACY is not set
 # CONFIG_EEPROM_93CX6 is not set
 CONFIG_HAVE_IDE=y
@@ -409,7 +410,22 @@ CONFIG_I2C_S6000=y
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
 # CONFIG_I2C_DEBUG_CHIP is not set
-# CONFIG_SPI is not set
+CONFIG_SPI=y
+# CONFIG_SPI_DEBUG is not set
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+# CONFIG_SPI_BITBANG is not set
+# CONFIG_SPI_GPIO is not set
+CONFIG_SPI_S6000=y
+
+#
+# SPI Protocol Masters
+#
+# CONFIG_SPI_SPIDEV is not set
+# CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
 CONFIG_GPIOLIB=y
 # CONFIG_DEBUG_GPIO is not set
@@ -433,6 +449,8 @@ CONFIG_GPIOLIB=y
 #
 # SPI GPIO expanders:
 #
+# CONFIG_GPIO_MAX7301 is not set
+# CONFIG_GPIO_MCP23S08 is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
-- 
1.6.2.107.ge47ee
