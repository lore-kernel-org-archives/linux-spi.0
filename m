From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: clps711x: Enable driver compilation with COMPILE_TEST
Date: Wed, 26 Mar 2014 16:22:50 +0800
Message-ID: <1395822170.7555.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This helps increasing build testing coverage.
This driver uses SYSCON APIs, so it needs to depend on MFD_SYSCON.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 1ee6a54..78ca395 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -150,7 +150,8 @@ config SPI_BUTTERFLY
 
 config SPI_CLPS711X
 	tristate "CLPS711X host SPI controller"
-	depends on ARCH_CLPS711X
+	depends on MFD_SYSCON
+	depends on ARCH_CLPS711X || COMPILE_TEST
 	help
 	  This enables dedicated general purpose SPI/Microwire1-compatible
 	  master mode interface (SSI1) for CLPS711X-based CPUs.
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
