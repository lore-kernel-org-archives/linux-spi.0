From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 8/9] S3C24XX: Add extra GPIOs via Kconfig
Date: Fri, 10 Oct 2008 11:03:52 +0100
Message-ID: <20081010100406.963134761@fluff.org.uk>
References: <20081010100344.572052114@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-s3c24xx-gpiolib-add-extra-gpios.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add Kconfig entries to allow more GPIO space to
be specified depending on the machine(s) selected.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.26-rc9-quilt2/arch/arm/mach-s3c2440/Kconfig
===================================================================
--- linux-2.6.26-rc9-quilt2.orig/arch/arm/mach-s3c2440/Kconfig	2008-07-10 15:06:32.000000000 +0100
+++ linux-2.6.26-rc9-quilt2/arch/arm/mach-s3c2440/Kconfig	2008-07-10 16:01:32.000000000 +0100
@@ -30,6 +30,7 @@ config MACH_ANUBIS
 	select CPU_S3C2440
 	select PM_SIMTEC if PM
 	select HAVE_PATA_PLATFORM
+	select S3C24XX_GPIO_EXTRA64
 	help
 	  Say Y here if you are using the Simtec Electronics ANUBIS
 	  development system
@@ -38,6 +39,7 @@ config MACH_OSIRIS
 	bool "Simtec IM2440D20 (OSIRIS) module"
 	select CPU_S3C2440
 	select PM_SIMTEC if PM
+	select S3C24XX_GPIO_EXTRA128
 	help
 	  Say Y here if you are using the Simtec IM2440D20 module, also
 	  known as the Osiris.
Index: linux-2.6.26-rc9-quilt2/arch/arm/plat-s3c24xx/Kconfig
===================================================================
--- linux-2.6.26-rc9-quilt2.orig/arch/arm/plat-s3c24xx/Kconfig	2008-07-10 15:04:53.000000000 +0100
+++ linux-2.6.26-rc9-quilt2/arch/arm/plat-s3c24xx/Kconfig	2008-07-10 16:01:55.000000000 +0100
@@ -28,6 +28,27 @@ config S3C24XX_PWM
 	  Support for exporting the PWM timer blocks via the pwm device
 	  system.
 
+
+# gpio configurations
+
+config S3C24XX_GPIO_EXTRA
+	int
+	default 128 if S3C24XX_GPIO_EXTRA128
+	default 64 if S3C24XX_GPIO_EXTRA64
+	default 0
+
+config S3C24XX_GPIO_EXTRA64
+	bool
+	help
+	  Add an extra 64 gpio numbers to the available GPIO pool. This is
+	  available for boards that need extra gpios for external devices.
+
+config S3C24XX_GPIO_EXTRA128
+	bool
+	help
+	  Add an extra 128 gpio numbers to the available GPIO pool. This is
+	  available for boards that need extra gpios for external devices.
+
 config PM_SIMTEC
 	bool
 	help
Index: linux-2.6.26-rc9-quilt2/arch/arm/mach-s3c2410/include/mach/gpio.h
===================================================================
--- linux-2.6.26-rc9-quilt2.orig/arch/arm/mach-s3c2410/include/mach/gpio.h	2008-07-10 15:03:23.000000000 +0100
+++ linux-2.6.26-rc9-quilt2/arch/arm/mach-s3c2410/include/mach/gpio.h	2008-07-10 15:06:56.000000000 +0100
@@ -15,4 +15,10 @@
 #define gpio_set_value	__gpio_set_value
 #define gpio_cansleep	__gpio_cansleep
 
+/* some boards require extra gpio capacity to support external
+ * devices that need GPIO.
+ */
+
+#define ARCH_NR_GPIOS	(256 + CONFIG_S3C24XX_GPIO_EXTRA)
+
 #include <asm-generic/gpio.h>

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
