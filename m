From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: xtensa-xtfpga: Enable driver compilation with
 COMPILE_TEST
Date: Thu, 20 Mar 2014 18:08:04 +0800
Message-ID: <1395310084.10512.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This helps increasing build testing coverage.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b35aa8e..1ee6a54 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -540,7 +540,7 @@ config SPI_XILINX
 
 config SPI_XTENSA_XTFPGA
 	tristate "Xtensa SPI controller for xtfpga"
-	depends on XTENSA && XTENSA_PLATFORM_XTFPGA
+	depends on (XTENSA && XTENSA_PLATFORM_XTFPGA) || COMPILE_TEST
 	select SPI_BITBANG
 	help
 	  SPI driver for xtfpga SPI master controller.
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
