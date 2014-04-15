From: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: cadence: Add dependency on ARCH_ZYNQ
Date: Tue, 15 Apr 2014 10:19:52 +0530
Message-ID: <1397537392-3709-1-git-send-email-harinik@xilinx.com>
Cc: michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add dependency on ARCH_ZYNQ in Kconfig.
This is to fix the build error.

Signed-off-by: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b0f091b..0db219b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -150,6 +150,7 @@ config SPI_BUTTERFLY
 
 config SPI_CADENCE
 	tristate "Cadence SPI controller"
+	depends on ARCH_ZYNQ
 	depends on SPI_MASTER
 	help
 	  This selects the Cadence SPI controller master driver
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
