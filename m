From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.25-rc8] spi: fix platform driver
	hotplug/coldplug
Date: Wed, 9 Apr 2008 14:34:02 -0700
Message-ID: <200804091434.02943.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
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

From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>

Since 43cc71eed1250755986da4c0f9898f9a635cb3bf, the platform
modalias is prefixed with "platform:". Add MODULE_ALIAS() to the
hotpluggable SPI platform drivers, to allow module auto loading.

[ dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org: more drivers; registration fixes ]

Signed-off-by: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/atmel_spi.c        |    1 +
 drivers/spi/au1550_spi.c       |    3 +++
 drivers/spi/mpc52xx_psc_spi.c  |    3 +++
 drivers/spi/omap2_mcspi.c      |    3 +++
 drivers/spi/omap_uwire.c       |    4 +++-
 drivers/spi/pxa2xx_spi.c       |    2 +-
 drivers/spi/spi_bfin5xx.c      |    2 +-
 drivers/spi/spi_imx.c          |    4 +++-
 drivers/spi/spi_mpc83xx.c      |    5 +++--
 drivers/spi/spi_s3c24xx.c      |    2 +-
 drivers/spi/spi_s3c24xx_gpio.c |    2 ++
 drivers/spi/spi_sh_sci.c       |    1 +
 drivers/spi/spi_txx9.c         |    3 +++
 drivers/spi/xilinx_spi.c       |    3 +++
 14 files changed, 31 insertions(+), 7 deletions(-)

--- g26.orig/drivers/spi/atmel_spi.c	2008-04-09 14:05:47.000000000 -0700
+++ g26/drivers/spi/atmel_spi.c	2008-04-09 14:08:22.000000000 -0700
@@ -863,3 +863,4 @@ module_exit(atmel_spi_exit);
 MODULE_DESCRIPTION("Atmel AT32/AT91 SPI Controller driver");
 MODULE_AUTHOR("Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:atmel_spi");
--- g26.orig/drivers/spi/au1550_spi.c	2008-04-09 14:10:03.000000000 -0700
+++ g26/drivers/spi/au1550_spi.c	2008-04-09 14:11:22.000000000 -0700
@@ -958,6 +958,9 @@ static int __exit au1550_spi_remove(stru
 	return 0;
 }
 
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:au1550-spi");
+
 static struct platform_driver au1550_spi_drv = {
 	.remove = __exit_p(au1550_spi_remove),
 	.driver = {
--- g26.orig/drivers/spi/mpc52xx_psc_spi.c	2008-04-09 14:10:03.000000000 -0700
+++ g26/drivers/spi/mpc52xx_psc_spi.c	2008-04-09 14:12:19.000000000 -0700
@@ -500,6 +500,9 @@ static int __exit mpc52xx_psc_spi_remove
 	return mpc52xx_psc_spi_do_remove(&dev->dev);
 }
 
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:mpc52xx-psc-spi");
+
 static struct platform_driver mpc52xx_psc_spi_platform_driver = {
 	.remove = __exit_p(mpc52xx_psc_spi_remove),
 	.driver = {
--- g26.orig/drivers/spi/omap2_mcspi.c	2008-04-09 14:05:47.000000000 -0700
+++ g26/drivers/spi/omap2_mcspi.c	2008-04-09 14:28:40.000000000 -0700
@@ -1084,6 +1084,9 @@ static int __exit omap2_mcspi_remove(str
 	return 0;
 }
 
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:omap2_mcspi");
+
 static struct platform_driver omap2_mcspi_driver = {
 	.driver = {
 		.name =		"omap2_mcspi",
--- g26.orig/drivers/spi/omap_uwire.c	2008-04-09 14:05:47.000000000 -0700
+++ g26/drivers/spi/omap_uwire.c	2008-04-09 14:25:29.000000000 -0700
@@ -537,10 +537,12 @@ static int __exit uwire_remove(struct pl
 	return status;
 }
 
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:omap_uwire");
+
 static struct platform_driver uwire_driver = {
 	.driver = {
 		.name		= "omap_uwire",
-		.bus		= &platform_bus_type,
 		.owner		= THIS_MODULE,
 	},
 	.remove		= __exit_p(uwire_remove),
--- g26.orig/drivers/spi/pxa2xx_spi.c	2008-04-09 14:05:47.000000000 -0700
+++ g26/drivers/spi/pxa2xx_spi.c	2008-04-09 14:26:50.000000000 -0700
@@ -44,6 +44,7 @@
 MODULE_AUTHOR("Stephen Street");
 MODULE_DESCRIPTION("PXA2xx SSP SPI Controller");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:pxa2xx-spi");
 
 #define MAX_BUSES 3
 
@@ -1585,7 +1586,6 @@ static int pxa2xx_spi_resume(struct plat
 static struct platform_driver driver = {
 	.driver = {
 		.name = "pxa2xx-spi",
-		.bus = &platform_bus_type,
 		.owner = THIS_MODULE,
 	},
 	.remove = pxa2xx_spi_remove,
--- g26.orig/drivers/spi/spi_bfin5xx.c	2008-04-09 14:05:48.000000000 -0700
+++ g26/drivers/spi/spi_bfin5xx.c	2008-04-09 14:08:22.000000000 -0700
@@ -1396,7 +1396,7 @@ static int bfin5xx_spi_resume(struct pla
 #define bfin5xx_spi_resume NULL
 #endif				/* CONFIG_PM */
 
-MODULE_ALIAS("bfin-spi-master");	/* for platform bus hotplug */
+MODULE_ALIAS("platform:bfin-spi");
 static struct platform_driver bfin5xx_spi_driver = {
 	.driver	= {
 		.name	= DRV_NAME,
--- g26.orig/drivers/spi/spi_imx.c	2008-04-09 14:10:03.000000000 -0700
+++ g26/drivers/spi/spi_imx.c	2008-04-09 14:14:54.000000000 -0700
@@ -1727,10 +1727,12 @@ static int spi_imx_resume(struct platfor
 #define spi_imx_resume NULL
 #endif /* CONFIG_PM */
 
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:spi_imx");
+
 static struct platform_driver driver = {
 	.driver = {
 		.name = "spi_imx",
-		.bus = &platform_bus_type,
 		.owner = THIS_MODULE,
 	},
 	.remove = __exit_p(spi_imx_remove),
--- g26.orig/drivers/spi/spi_mpc83xx.c	2008-04-09 14:05:47.000000000 -0700
+++ g26/drivers/spi/spi_mpc83xx.c	2008-04-09 14:17:40.000000000 -0700
@@ -523,11 +523,12 @@ static int __exit mpc83xx_spi_remove(str
 	return 0;
 }
 
-MODULE_ALIAS("mpc83xx_spi");			/* for platform bus hotplug */
+MODULE_ALIAS("platform:mpc83xx_spi");
 static struct platform_driver mpc83xx_spi_driver = {
 	.remove = __exit_p(mpc83xx_spi_remove),
 	.driver = {
-		   .name = "mpc83xx_spi",
+		.name = "mpc83xx_spi",
+		.owner = THIS_MODULE,
 	},
 };
 
--- g26.orig/drivers/spi/spi_s3c24xx.c	2008-04-09 14:05:47.000000000 -0700
+++ g26/drivers/spi/spi_s3c24xx.c	2008-04-09 14:08:22.000000000 -0700
@@ -415,7 +415,7 @@ static int s3c24xx_spi_resume(struct pla
 #define s3c24xx_spi_resume  NULL
 #endif
 
-MODULE_ALIAS("s3c2410_spi");			/* for platform bus hotplug */
+MODULE_ALIAS("platform:s3c2410-spi");
 static struct platform_driver s3c24xx_spidrv = {
 	.remove		= __exit_p(s3c24xx_spi_remove),
 	.suspend	= s3c24xx_spi_suspend,
--- g26.orig/drivers/spi/spi_s3c24xx_gpio.c	2008-04-09 14:10:03.000000000 -0700
+++ g26/drivers/spi/spi_s3c24xx_gpio.c	2008-04-09 14:15:28.000000000 -0700
@@ -168,6 +168,8 @@ static int s3c2410_spigpio_remove(struct
 #define s3c2410_spigpio_suspend NULL
 #define s3c2410_spigpio_resume NULL
 
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:spi_s3c24xx_gpio");
 
 static struct platform_driver s3c2410_spigpio_drv = {
 	.probe		= s3c2410_spigpio_probe,
--- g26.orig/drivers/spi/spi_sh_sci.c	2008-04-09 14:05:47.000000000 -0700
+++ g26/drivers/spi/spi_sh_sci.c	2008-04-09 14:08:22.000000000 -0700
@@ -203,3 +203,4 @@ module_exit(sh_sci_spi_exit);
 MODULE_DESCRIPTION("SH SCI SPI Driver");
 MODULE_AUTHOR("Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:spi_sh_sci");
--- g26.orig/drivers/spi/spi_txx9.c	2008-04-09 14:10:03.000000000 -0700
+++ g26/drivers/spi/spi_txx9.c	2008-04-09 14:15:46.000000000 -0700
@@ -450,6 +450,9 @@ static int __exit txx9spi_remove(struct 
 	return 0;
 }
 
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:spi_txx9");
+
 static struct platform_driver txx9spi_driver = {
 	.remove = __exit_p(txx9spi_remove),
 	.driver = {
--- g26.orig/drivers/spi/xilinx_spi.c	2008-04-09 14:10:03.000000000 -0700
+++ g26/drivers/spi/xilinx_spi.c	2008-04-09 14:16:18.000000000 -0700
@@ -408,6 +408,9 @@ static int __devexit xilinx_spi_remove(s
 	return 0;
 }
 
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:" XILINX_SPI_NAME);
+
 static struct platform_driver xilinx_spi_driver = {
 	.probe	= xilinx_spi_probe,
 	.remove	= __devexit_p(xilinx_spi_remove),

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
