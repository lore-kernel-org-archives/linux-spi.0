From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.23-rc3-git] SPI driver
	hotplug/coldplug fixes
Date: Wed, 22 Aug 2007 13:15:11 -0700
Message-ID: <200708221315.12184.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org, ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org,
	akonovalov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org, a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Update various SPI drivers so they properly support

  - coldplug through "modprobe $(cat /sys/devices/.../modalias)"

  - hotplug through "modprobe $(MODALIAS)"

The basic rule for platform, SPI, and (new style) I2C drivers is just
to make sure that modprobing the driver name works.  In this case, all
the relevant drivers are platform drivers, and this patch either

  (a)	Changes the driver name, if no in-tree code would break;
	this is simpler and thus preferable in the long term.

  (b)	Adds MODULE_ALIAS directives, when in-tree platforms declare
	devices using the current driver name; less desirable.

Most systems will link SPI controller drivers statically, but
there's no point in being needlessly broken.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
Build-tested for the ARM drivers.

 drivers/spi/spi_bfin5xx.c      |    3 ++-
 drivers/spi/spi_imx.c          |    2 +-
 drivers/spi/spi_mpc83xx.c      |    1 +
 drivers/spi/spi_s3c24xx.c      |    1 +
 drivers/spi/spi_s3c24xx_gpio.c |    2 +-
 drivers/spi/spi_txx9.c         |    1 +
 drivers/spi/xilinx_spi.c       |    2 +-
 7 files changed, 8 insertions(+), 4 deletions(-)

--- g26.orig/drivers/spi/spi_bfin5xx.c	2007-08-11 11:48:08.000000000 -0700
+++ g26/drivers/spi/spi_bfin5xx.c	2007-08-11 11:49:49.000000000 -0700
@@ -1303,8 +1303,9 @@ static int bfin5xx_spi_resume(struct pla
 #define bfin5xx_spi_resume NULL
 #endif				/* CONFIG_PM */
 
+MODULE_ALIAS("bfin-spi-master");	/* for platform bus hotplug */
 static struct platform_driver bfin5xx_spi_driver = {
-	.driver 	= {
+	.driver	= {
 		.name	= "bfin-spi-master",
 		.owner	= THIS_MODULE,
 	},
--- g26.orig/drivers/spi/spi_imx.c	2007-08-11 11:48:08.000000000 -0700
+++ g26/drivers/spi/spi_imx.c	2007-08-11 12:06:12.000000000 -0700
@@ -1735,7 +1735,7 @@ static int spi_imx_resume(struct platfor
 
 static struct platform_driver driver = {
 	.driver = {
-		.name = "imx-spi",
+		.name = "spi_imx",
 		.bus = &platform_bus_type,
 		.owner = THIS_MODULE,
 	},
--- g26.orig/drivers/spi/spi_mpc83xx.c	2007-08-11 11:48:09.000000000 -0700
+++ g26/drivers/spi/spi_mpc83xx.c	2007-08-11 11:50:27.000000000 -0700
@@ -530,6 +530,7 @@ static int __devexit mpc83xx_spi_remove(
 	return 0;
 }
 
+MODULE_ALIAS("mpc83xx_spi");			/* for platform bus hotplug */
 static struct platform_driver mpc83xx_spi_driver = {
 	.probe = mpc83xx_spi_probe,
 	.remove = __devexit_p(mpc83xx_spi_remove),
--- g26.orig/drivers/spi/spi_s3c24xx.c	2007-08-11 11:48:09.000000000 -0700
+++ g26/drivers/spi/spi_s3c24xx.c	2007-08-11 11:51:00.000000000 -0700
@@ -427,6 +427,7 @@ static int s3c24xx_spi_resume(struct pla
 #define s3c24xx_spi_resume  NULL
 #endif
 
+MODULE_ALIAS("s3c2410_spi");			/* for platform bus hotplug */
 static struct platform_driver s3c24xx_spidrv = {
 	.probe		= s3c24xx_spi_probe,
 	.remove		= s3c24xx_spi_remove,
--- g26.orig/drivers/spi/spi_s3c24xx_gpio.c	2007-08-11 11:48:09.000000000 -0700
+++ g26/drivers/spi/spi_s3c24xx_gpio.c	2007-08-11 12:10:21.000000000 -0700
@@ -180,7 +180,7 @@ static struct platform_driver s3c2410_sp
         .suspend	= s3c2410_spigpio_suspend,
         .resume		= s3c2410_spigpio_resume,
         .driver		= {
-		.name	= "s3c24xx-spi-gpio",
+		.name	= "spi_s3c24xx_gpio",
 		.owner	= THIS_MODULE,
         },
 };
--- g26.orig/drivers/spi/spi_txx9.c	2007-08-11 11:48:09.000000000 -0700
+++ g26/drivers/spi/spi_txx9.c	2007-08-11 11:51:45.000000000 -0700
@@ -450,6 +450,7 @@ static int __exit txx9spi_remove(struct 
 	return 0;
 }
 
+MODULE_ALIAS("txx9spi");			/* for platform bus hotplug */
 static struct platform_driver txx9spi_driver = {
 	.remove = __exit_p(txx9spi_remove),
 	.driver = {
--- g26.orig/drivers/spi/xilinx_spi.c	2007-08-11 11:48:09.000000000 -0700
+++ g26/drivers/spi/xilinx_spi.c	2007-08-11 12:13:19.000000000 -0700
@@ -21,7 +21,7 @@
 
 #include <syslib/virtex_devices.h>
 
-#define XILINX_SPI_NAME "xspi"
+#define XILINX_SPI_NAME "xilinx_spi"
 
 /* Register definitions as per "OPB Serial Peripheral Interface (SPI) (v1.00e)
  * Product Specification", DS464

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
