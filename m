From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 5/9] AT2440EVB: LCD frame buffer support.
Date: Fri, 10 Oct 2008 11:03:49 +0100
Message-ID: <20081010100405.879116394@fluff.org.uk>
References: <20081010100344.572052114@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	Ramax Lo <ramaxlo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename=thirdparty/at2440evb-lcd.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add LCD frame buffer support for AT2440EVB board.

Signed-off-by: Ramax Lo <ramaxlo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

diff --git a/arch/arm/mach-s3c2440/mach-at2440evb.c b/arch/arm/mach-s3c2440/mach-at2440evb.c
index aab014f..595fec5 100644
--- a/arch/arm/mach-s3c2440/mach-at2440evb.c
+++ b/arch/arm/mach-s3c2440/mach-at2440evb.c
@@ -28,6 +28,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/fb.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
@@ -167,6 +168,39 @@ static struct s3c24xx_mci_pdata at2440evb_mci_pdata = {
 	.gpio_detect	= S3C2410_GPG10,
 };
 
+/* 7" LCD panel */
+
+static struct s3c2410fb_display at2440evb_lcd_cfg __initdata = {
+
+	.lcdcon5	= S3C2410_LCDCON5_FRM565 |
+			  S3C2410_LCDCON5_INVVLINE |
+			  S3C2410_LCDCON5_INVVFRAME |
+			  S3C2410_LCDCON5_PWREN |
+			  S3C2410_LCDCON5_HWSWP,
+
+	.type		= S3C2410_LCDCON1_TFT,
+
+	.width		= 800,
+	.height		= 480,
+
+	.pixclock	= 33333, /* HCLK 60 MHz, divisor 2 */
+	.xres		= 800,
+	.yres		= 480,
+	.bpp		= 16,
+	.left_margin	= 88,
+	.right_margin	= 40,
+	.hsync_len	= 128,
+	.upper_margin	= 32,
+	.lower_margin	= 11,
+	.vsync_len	= 2,
+};
+
+static struct s3c2410fb_mach_info at2440evb_fb_info __initdata = {
+	.displays	= &at2440evb_lcd_cfg,
+	.num_displays	= 1,
+	.default_display = 0,
+};
+
 static struct platform_device *at2440evb_devices[] __initdata = {
 	&s3c_device_usb,
 	&s3c_device_wdt,
@@ -175,6 +209,7 @@ static struct platform_device *at2440evb_devices[] __initdata = {
 	&s3c_device_rtc,
 	&s3c_device_nand,
 	&s3c_device_sdi,
+	&s3c_device_lcd,
 	&at2440evb_device_eth,
 };
 
@@ -191,6 +226,7 @@ static void __init at2440evb_map_io(void)
 
 static void __init at2440evb_init(void)
 {
+	s3c24xx_fb_set_platdata(&at2440evb_fb_info);
 	platform_add_devices(at2440evb_devices, ARRAY_SIZE(at2440evb_devices));
 }
 
-- 
1.5.4.3


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
