From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi/sunxi: Add missing dependency on RESET_CONTROLLER
Date: Thu,  6 Feb 2014 19:56:04 +0000
Message-ID: <1391716564-30175-1-git-send-email-broonie@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 7cfe0eed8dfa..0ec46415145d 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -449,6 +449,7 @@ config SPI_SIRF
 config SPI_SUN6I
 	tristate "Allwinner A31 SPI controller"
 	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on RESET_CONTROLLER
 	help
 	  This enables using the SPI controller on the Allwinner A31 SoCs.
 
-- 
1.9.rc1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
