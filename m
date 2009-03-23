From: =?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>
Subject: [patch 6/6] xtensa: enable spi mmc host in s6105_defconfig
Date: Mon, 23 Mar 2009 16:34:22 +0100
Message-ID: <1237822462-32109-6-git-send-email-dg@emlix.com>
References: <1237822462-32109-1-git-send-email-dg@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	=?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>
To: Chris Zankel <chris@zankel.net>,
	David Brownell <dbrownell@users.sourceforge.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758934AbZCWPev@vger.kernel.org>
In-Reply-To: <1237822462-32109-1-git-send-email-dg@emlix.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Daniel Gl=C3=B6ckner <dg@emlix.com>
---
 arch/xtensa/configs/s6105_defconfig |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/configs/s6105_defconfig b/arch/xtensa/configs/=
s6105_defconfig
index 02bab6e..c5ea056 100644
--- a/arch/xtensa/configs/s6105_defconfig
+++ b/arch/xtensa/configs/s6105_defconfig
@@ -509,7 +509,23 @@ CONFIG_SSB_POSSIBLE=3Dy
 # CONFIG_DISPLAY_SUPPORT is not set
 # CONFIG_SOUND is not set
 # CONFIG_USB_SUPPORT is not set
-# CONFIG_MMC is not set
+CONFIG_MMC=3Dy
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
+
+#
+# MMC/SD/SDIO Card Drivers
+#
+CONFIG_MMC_BLOCK=3Dy
+# CONFIG_MMC_BLOCK_BOUNCE is not set
+# CONFIG_SDIO_UART is not set
+# CONFIG_MMC_TEST is not set
+
+#
+# MMC/SD/SDIO Host Controller Drivers
+#
+# CONFIG_MMC_SDHCI is not set
+CONFIG_MMC_SPI=3Dy
 # CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
 # CONFIG_ACCESSIBILITY is not set
@@ -646,9 +662,9 @@ CONFIG_GENERIC_FIND_LAST_BIT=3Dy
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_T10DIF is not set
-# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC_ITU_T=3Dy
 # CONFIG_CRC32 is not set
-# CONFIG_CRC7 is not set
+CONFIG_CRC7=3Dy
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=3Dy
 CONFIG_HAS_IOMEM=3Dy
--=20
1.6.2.107.ge47ee
