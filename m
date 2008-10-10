From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 9/9] JIVE: fix spi gpio implementation
Date: Fri, 10 Oct 2008 11:03:53 +0100
Message-ID: <20081010100407.356863996@fluff.org.uk>
References: <20081010100344.572052114@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename=simtec/simtec-jive-fix-gpio-spi.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Fix the name of the driver, as well as the fact we are not
passing the number of chipselects to the driver.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.27-rc7-quilt2/arch/arm/mach-s3c2412/mach-jive.c
===================================================================
--- linux-2.6.27-rc7-quilt2.orig/arch/arm/mach-s3c2412/mach-jive.c	2008-09-23 15:01:44.000000000 +0100
+++ linux-2.6.27-rc7-quilt2/arch/arm/mach-s3c2412/mach-jive.c	2008-09-23 15:01:47.000000000 +0100
@@ -402,11 +402,12 @@ static struct s3c2410_spigpio_info jive_
 	.bus_num	= 1,
 	.pin_clk	= S3C2410_GPG8,
 	.pin_mosi	= S3C2410_GPB8,
+	.num_chipselect	= 1,
 	.chip_select	= jive_lcd_spi_chipselect,
 };
 
 static struct platform_device jive_device_lcdspi = {
-	.name		= "s3c24xx-spi-gpio",
+	.name		= "spi_s3c24xx_gpio",
 	.id		= 1,
 	.num_resources  = 0,
 	.dev.platform_data = &jive_lcd_spi,
@@ -423,11 +424,12 @@ static struct s3c2410_spigpio_info jive_
 	.bus_num	= 2,
 	.pin_clk	= S3C2410_GPB4,
 	.pin_mosi	= S3C2410_GPB9,
+	.num_chipselect	= 1,
 	.chip_select	= jive_wm8750_chipselect,
 };
 
 static struct platform_device jive_device_wm8750 = {
-	.name		= "s3c24xx-spi-gpio",
+	.name		= "spi_s3c24xx_gpio",
 	.id		= 2,
 	.num_resources  = 0,
 	.dev.platform_data = &jive_wm8750_spi,

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
