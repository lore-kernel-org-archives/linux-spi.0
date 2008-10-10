From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 1/9] S3C24XX: Default SPI pin
	configuration for SPI
Date: Fri, 10 Oct 2008 11:03:45 +0100
Message-ID: <20081010100404.402586503@fluff.org.uk>
References: <20081010100344.572052114@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-s3c24xx-spi-default-gpios.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add a set of default pin configuration routines for
setting up the SPI gpio configuration when using the
hardware SPI driver.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.27-rc6-quilt4/arch/arm/plat-s3c24xx/Kconfig
===================================================================
--- linux-2.6.27-rc6-quilt4.orig/arch/arm/plat-s3c24xx/Kconfig	2008-09-16 11:57:16.000000000 +0100
+++ linux-2.6.27-rc6-quilt4/arch/arm/plat-s3c24xx/Kconfig	2008-09-16 12:28:19.000000000 +0100
@@ -49,6 +49,22 @@ config S3C2410_DMA_DEBUG
 	  Enable debugging output for the DMA code. This option sends info
 	  to the kernel log, at priority KERN_DEBUG.
 
+# SPI default pin configuration code
+
+config S3C24XX_SPI_BUS0_GPE11_GPE12_GPE13
+	bool
+	help
+	  SPI GPIO configuration code for BUS0 when connected to
+	  GPE11, GPE12 and GPE13.
+
+config S3C24XX_SPI_BUS1_GPG5_GPG6_GPG7
+	bool
+	help
+	  SPI GPIO configuration code for BUS 1 when connected to
+	  GPG5, GPG6 and GPG7.
+
+# common code for s3c24xx based machines, such as the SMDKs.
+
 config MACH_SMDK
 	bool
 	help
Index: linux-2.6.27-rc6-quilt4/arch/arm/plat-s3c24xx/Makefile
===================================================================
--- linux-2.6.27-rc6-quilt4.orig/arch/arm/plat-s3c24xx/Makefile	2008-09-16 11:57:16.000000000 +0100
+++ linux-2.6.27-rc6-quilt4/arch/arm/plat-s3c24xx/Makefile	2008-09-16 12:29:00.000000000 +0100
@@ -31,4 +31,12 @@ obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_PM)		+= sleep.o
 obj-$(CONFIG_HAVE_PWM)		+= pwm.o
 obj-$(CONFIG_S3C2410_DMA)	+= dma.o
+
+# SPI gpio central GPIO functions
+
+obj-$(CONFIG_S3C24XX_SPI_BUS0_GPE11_GPE12_GPE13) += spi-bus0-gpe11_12_13.o
+obj-$(CONFIG_S3C24XX_SPI_BUS1_GPG5_GPG6_GPG7)    += spi-bus1-gpg5_6_7.o
+
+# machine common support
+
 obj-$(CONFIG_MACH_SMDK)		+= common-smdk.o
Index: linux-2.6.27-rc6-quilt4/arch/arm/plat-s3c24xx/spi-bus0-gpe11_12_13.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.27-rc6-quilt4/arch/arm/plat-s3c24xx/spi-bus0-gpe11_12_13.c	2008-09-16 12:27:15.000000000 +0100
@@ -0,0 +1,37 @@
+/* linux/arch/arm/plat-s3c24xx/spi-bus0-gpe11_12_13.c
+ *
+ * Copyright (c) 2008 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
+ *
+ * S3C24XX SPI - gpio configuration for bus 0 on gpe11,12,13
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+*/
+
+#include <linux/kernel.h>
+
+#include <mach/hardware.h>
+
+#include <mach/spi.h>
+#include <mach/regs-gpio.h>
+
+void s3c24xx_spi_gpiocfg_bus0_gpe11_12_13(struct s3c2410_spi_info *spi,
+					  int enable)
+{
+	if (enable) {
+		s3c2410_gpio_cfgpin(S3C2410_GPE13, S3C2410_GPE13_SPICLK0);
+		s3c2410_gpio_cfgpin(S3C2410_GPE12, S3C2410_GPE12_SPIMOSI0);
+		s3c2410_gpio_cfgpin(S3C2410_GPE11, S3C2410_GPE11_SPIMISO0);
+		s3c2410_gpio_pullup(S3C2410_GPE11, 0);
+		s3c2410_gpio_pullup(S3C2410_GPE13, 0);
+	} else {
+		s3c2410_gpio_cfgpin(S3C2410_GPE13, S3C2410_GPIO_INPUT);
+		s3c2410_gpio_cfgpin(S3C2410_GPE11, S3C2410_GPIO_INPUT);
+		s3c2410_gpio_pullup(S3C2410_GPE11, 1);
+		s3c2410_gpio_pullup(S3C2410_GPE12, 1);
+		s3c2410_gpio_pullup(S3C2410_GPE13, 1);
+	}
+}
Index: linux-2.6.27-rc6-quilt4/arch/arm/mach-s3c2410/include/mach/spi.h
===================================================================
--- linux-2.6.27-rc6-quilt4.orig/arch/arm/mach-s3c2410/include/mach/spi.h	2008-09-16 12:27:07.000000000 +0100
+++ linux-2.6.27-rc6-quilt4/arch/arm/mach-s3c2410/include/mach/spi.h	2008-09-16 12:27:15.000000000 +0100
@@ -22,5 +22,12 @@ struct s3c2410_spi_info {
 	void (*set_cs)(struct s3c2410_spi_info *spi, int cs, int pol);
 };
 
+/* Standard setup / suspend routines for SPI GPIO pins. */
+
+extern void s3c24xx_spi_gpiocfg_bus0_gpe11_12_13(struct s3c2410_spi_info *spi,
+						 int enable);
+
+extern void s3c24xx_spi_gpiocfg_bus1_gpg5_6_7(struct s3c2410_spi_info *spi,
+					      int enable);
 
 #endif /* __ASM_ARCH_SPI_H */
Index: linux-2.6.27-rc6-quilt4/arch/arm/plat-s3c24xx/spi-bus1-gpg5_6_7.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.27-rc6-quilt4/arch/arm/plat-s3c24xx/spi-bus1-gpg5_6_7.c	2008-09-16 12:27:15.000000000 +0100
@@ -0,0 +1,37 @@
+/* linux/arch/arm/plat-s3c24xx/spi-bus0-gpg5_6_7.c
+ *
+ * Copyright (c) 2008 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
+ *
+ * S3C24XX SPI - gpio configuration for bus 1 on gpg5,6,7
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+*/
+
+#include <linux/kernel.h>
+
+#include <mach/hardware.h>
+
+#include <mach/spi.h>
+#include <mach/regs-gpio.h>
+
+void s3c24xx_spi_gpiocfg_bus1_gpg5_6_7(struct s3c2410_spi_info *spi,
+				       int enable)
+{
+	if (enable) {
+		s3c2410_gpio_cfgpin(S3C2410_GPG7, S3C2410_GPG7_SPICLK1);
+		s3c2410_gpio_cfgpin(S3C2410_GPG6, S3C2410_GPG6_SPIMOSI1);
+		s3c2410_gpio_cfgpin(S3C2410_GPG5, S3C2410_GPG5_SPIMISO1);
+		s3c2410_gpio_pullup(S3C2410_GPG5, 0);
+		s3c2410_gpio_pullup(S3C2410_GPG6, 0);
+	} else {
+		s3c2410_gpio_cfgpin(S3C2410_GPG7, S3C2410_GPIO_INPUT);
+		s3c2410_gpio_cfgpin(S3C2410_GPG5, S3C2410_GPIO_INPUT);
+		s3c2410_gpio_pullup(S3C2410_GPG5, 1);
+		s3c2410_gpio_pullup(S3C2410_GPG6, 1);
+		s3c2410_gpio_pullup(S3C2410_GPG7, 1);
+	}
+}

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
