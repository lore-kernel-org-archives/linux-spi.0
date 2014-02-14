From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/1] spi/s3c64xx: Trivial cleanup in header file
Date: Fri, 14 Feb 2014 12:26:17 +0530
Message-ID: <1392360977-21183-1-git-send-email-sachin.kamat@linaro.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Commit 436d42c61c3e ("ARM: samsung: move platform_data definitions")
moved the files to the current location but forgot to remove the pointer
to its previous location. Clean it up. While at it also change the header
file protection macros appropriately.

Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 include/linux/platform_data/spi-s3c64xx.h |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
index 8447f634c7f5..d3889b98a1a1 100644
--- a/include/linux/platform_data/spi-s3c64xx.h
+++ b/include/linux/platform_data/spi-s3c64xx.h
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
- *
+/*
  * Copyright (C) 2009 Samsung Electronics Ltd.
  *	Jaswinder Singh <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
  *
@@ -8,8 +7,8 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef __S3C64XX_PLAT_SPI_H
-#define __S3C64XX_PLAT_SPI_H
+#ifndef __SPI_S3C64XX_H
+#define __SPI_S3C64XX_H
 
 #include <linux/dmaengine.h>
 
@@ -68,4 +67,4 @@ extern int s3c64xx_spi2_cfg_gpio(void);
 extern struct s3c64xx_spi_info s3c64xx_spi0_pdata;
 extern struct s3c64xx_spi_info s3c64xx_spi1_pdata;
 extern struct s3c64xx_spi_info s3c64xx_spi2_pdata;
-#endif /* __S3C64XX_PLAT_SPI_H */
+#endif /*__SPI_S3C64XX_H */
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
