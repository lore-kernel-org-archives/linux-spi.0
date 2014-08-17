From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH 1/2] regmap: Add eplicit dependencies to catch "select" misuse
Date: Sun, 17 Aug 2014 12:08:57 +0200
Message-ID: <1408270138-29811-1-git-send-email-geert@linux-m68k.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add explicit dependencies for the various regmap modules, so Kconfig
will print a warning message when another module selects a regmap module
without fulfilling its dependencies.

Without this, it's much more difficult to find out which module did the
offending select.

Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/base/regmap/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 4251570610c9..8a3f51f7b1b9 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -11,12 +11,15 @@ config REGMAP
 
 config REGMAP_I2C
 	tristate
+	depends on I2C
 
 config REGMAP_SPI
 	tristate
+	depends on SPI
 
 config REGMAP_SPMI
 	tristate
+	depends on SPMI
 
 config REGMAP_MMIO
 	tristate
-- 
1.9.1
