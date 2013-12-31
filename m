From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] spi: s3c24xx: Remove reference to plat/fiq.h
Date: Tue, 31 Dec 2013 14:00:39 +0530
Message-ID: <1388478639-25279-1-git-send-email-sachin.kamat@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, broonie@kernel.org,
	kgene.kim@samsung.com, sachin.kamat@linaro.org, patches@linaro.org
To: linux-spi@vger.kernel.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

fiq.h contains only a function declaration and is not used by anyone
else. Move the declaration to the driver header file and remove the
unnecessary platform dependency from the driver.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/plat-samsung/include/plat/fiq.h |   13 -------------
 drivers/spi/spi-s3c24xx.c                |    2 --
 include/linux/spi/s3c24xx.h              |    2 ++
 3 files changed, 2 insertions(+), 15 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/fiq.h

diff --git a/arch/arm/plat-samsung/include/plat/fiq.h b/arch/arm/plat-samsung/include/plat/fiq.h
deleted file mode 100644
index 535d06a35628..000000000000
--- a/arch/arm/plat-samsung/include/plat/fiq.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/fiq.h
- *
- * Copyright (c) 2009 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Header file for S3C24XX CPU FIQ support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-extern int s3c24xx_set_fiq(unsigned int irq, bool on);
diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index 2ccb28d57ba9..746424aa5353 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -29,7 +29,6 @@
 
 #include <plat/regs-spi.h>
 
-#include <plat/fiq.h>
 #include <asm/fiq.h>
 
 #include "spi-s3c24xx-fiq.h"
@@ -84,7 +83,6 @@ struct s3c24xx_spi {
 	struct s3c2410_spi_info *pdata;
 };
 
-
 #define SPCON_DEFAULT (S3C2410_SPCON_MSTR | S3C2410_SPCON_SMOD_INT)
 #define SPPIN_DEFAULT (S3C2410_SPPIN_KEEP)
 
diff --git a/include/linux/spi/s3c24xx.h b/include/linux/spi/s3c24xx.h
index c23b923e493b..ca271c06c591 100644
--- a/include/linux/spi/s3c24xx.h
+++ b/include/linux/spi/s3c24xx.h
@@ -23,4 +23,6 @@ struct s3c2410_spi_info {
 	void (*set_cs)(struct s3c2410_spi_info *spi, int cs, int pol);
 };
 
+extern int s3c24xx_set_fiq(unsigned int irq, bool on);
+
 #endif /* __LINUX_SPI_S3C24XX_H */
-- 
1.7.9.5
