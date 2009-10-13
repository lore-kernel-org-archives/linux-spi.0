From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spidev: add proper section markers
Date: Tue, 13 Oct 2009 03:17:48 -0400
Message-ID: <1255418268-29575-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The driver already uses __devexit_p() in the structure, but looks like
actual __dev{init,exit} markings were forgotten.

The spidev_spi driver also needs renaming to include a "_driver" suffix
to avoid section mismatch warnings.

Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spidev.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 5d23983..f31467b 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -561,7 +561,7 @@ static struct class *spidev_class;
 
 /*-------------------------------------------------------------------------*/
 
-static int spidev_probe(struct spi_device *spi)
+static int __devinit spidev_probe(struct spi_device *spi)
 {
 	struct spidev_data	*spidev;
 	int			status;
@@ -610,7 +610,7 @@ static int spidev_probe(struct spi_device *spi)
 	return status;
 }
 
-static int spidev_remove(struct spi_device *spi)
+static int __devexit spidev_remove(struct spi_device *spi)
 {
 	struct spidev_data	*spidev = spi_get_drvdata(spi);
 
@@ -632,7 +632,7 @@ static int spidev_remove(struct spi_device *spi)
 	return 0;
 }
 
-static struct spi_driver spidev_spi = {
+static struct spi_driver spidev_spi_driver = {
 	.driver = {
 		.name =		"spidev",
 		.owner =	THIS_MODULE,
@@ -664,14 +664,14 @@ static int __init spidev_init(void)
 
 	spidev_class = class_create(THIS_MODULE, "spidev");
 	if (IS_ERR(spidev_class)) {
-		unregister_chrdev(SPIDEV_MAJOR, spidev_spi.driver.name);
+		unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
 		return PTR_ERR(spidev_class);
 	}
 
-	status = spi_register_driver(&spidev_spi);
+	status = spi_register_driver(&spidev_spi_driver);
 	if (status < 0) {
 		class_destroy(spidev_class);
-		unregister_chrdev(SPIDEV_MAJOR, spidev_spi.driver.name);
+		unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
 	}
 	return status;
 }
@@ -679,9 +679,9 @@ module_init(spidev_init);
 
 static void __exit spidev_exit(void)
 {
-	spi_unregister_driver(&spidev_spi);
+	spi_unregister_driver(&spidev_spi_driver);
 	class_destroy(spidev_class);
-	unregister_chrdev(SPIDEV_MAJOR, spidev_spi.driver.name);
+	unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
 }
 module_exit(spidev_exit);
 
-- 
1.6.5


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
