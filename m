From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 4/9] S3C24XX: AT2440EVB MMC
Date: Fri, 10 Oct 2008 11:03:48 +0100
Message-ID: <20081010100405.561617408@fluff.org.uk>
References: <20081010100344.572052114@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	Ramax Lo <ramaxlo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename=thirdparty/at2440evb-mmc.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add SD/MMC support for AT2440EVB board.

Signed-off-by: Ramax Lo <ramaxlo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

diff --git a/arch/arm/mach-s3c2440/mach-at2440evb.c b/arch/arm/mach-s3c2440/mach-at2440evb.c
index f5e3c7f..ce18bc3 100644
--- a/arch/arm/mach-s3c2440/mach-at2440evb.c
+++ b/arch/arm/mach-s3c2440/mach-at2440evb.c
@@ -45,6 +45,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
+#include <asm/plat-s3c24xx/mci.h>
 
 static struct map_desc at2440evb_iodesc[] __initdata = {
 	/* Nothing here */
@@ -162,6 +163,10 @@ static struct platform_device at2440evb_device_eth = {
 	},
 };
 
+static struct s3c24xx_mci_pdata at2440evb_mci_pdata = {
+	.gpio_detect	= S3C2410_GPG10,
+};
+
 static struct platform_device *at2440evb_devices[] __initdata = {
 	&s3c_device_usb,
 	&s3c_device_wdt,
@@ -169,12 +174,15 @@ static struct platform_device *at2440evb_devices[] __initdata = {
 	&s3c_device_i2c,
 	&s3c_device_rtc,
 	&s3c_device_nand,
+	&s3c_device_sdi,
 	&at2440evb_device_eth,
 };
 
 static void __init at2440evb_map_io(void)
 {
 	s3c_device_nand.dev.platform_data = &at2440evb_nand_info;
+	s3c_device_sdi.name = "s3c2440-sdi";
+	s3c_device_sdi.dev.platform_data = &at2440evb_mci_pdata;
 
 	s3c24xx_init_io(at2440evb_iodesc, ARRAY_SIZE(at2440evb_iodesc));
 	s3c24xx_init_clocks(16934400);
-- 
1.5.4.3

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
