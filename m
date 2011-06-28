From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: [PATCH 5/5] mach-s3c2410: remove unused spi-gpio.h file
Date: Tue, 28 Jun 2011 14:49:17 +0200
Message-ID: <1309265357-15879-6-git-send-email-jacmet@sunsite.dk>
References: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1309265357-15879-1-git-send-email-jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Not used anymore as the spi_s3c24xx_gpio driver is gone (replaced by
the generic spi-gpio).

Signed-off-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
---
 arch/arm/mach-s3c2410/include/mach/spi-gpio.h |   28 -------------------------
 1 files changed, 0 insertions(+), 28 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2410/include/mach/spi-gpio.h

diff --git a/arch/arm/mach-s3c2410/include/mach/spi-gpio.h b/arch/arm/mach-s3c2410/include/mach/spi-gpio.h
deleted file mode 100644
index dcef228..0000000
--- a/arch/arm/mach-s3c2410/include/mach/spi-gpio.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/spi-gpio.h
- *
- * Copyright (c) 2006 Simtec Electronics
- *	Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
- *
- * S3C2410 - SPI Controller platform_device info
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_SPIGPIO_H
-#define __ASM_ARCH_SPIGPIO_H __FILE__
-
-struct s3c2410_spigpio_info {
-	unsigned long		 pin_clk;
-	unsigned long		 pin_mosi;
-	unsigned long		 pin_miso;
-
-	int			 num_chipselect;
-	int			 bus_num;
-
-	void (*chip_select)(struct s3c2410_spigpio_info *spi, int cs);
-};
-
-
-#endif /* __ASM_ARCH_SPIGPIO_H */
-- 
1.7.5.4


------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
