From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH] spi: Remove erroneous __exit and __exit_p() references in
	drivers
Date: Tue,  5 Feb 2013 13:58:01 +0000
Message-ID: <1360072681-7965-1-git-send-email-grant.likely@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Some of the spi driver module remove hooks were annotated with __exit
and referenced with __exit_p(). Presumably these were supposed to be
__devexit and __devexit_p() since __exit for a remove hook has never
been correct. They also got missed during the big __devexit purge since
they didn't match the pattern. Remove then now to be rid of it.

Reported-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
[Arnd set a patch cleaning up one, and then I found more]
Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
---
 drivers/spi/spi-atmel.c      |    2 +-
 drivers/spi/spi-au1550.c     |    4 ++--
 drivers/spi/spi-omap-100k.c  |    4 ++--
 drivers/spi/spi-omap-uwire.c |    4 ++--
 drivers/spi/spi-orion.c      |    4 ++--
 drivers/spi/spi-ppc4xx.c     |    4 ++--
 drivers/spi/spi-txx9.c       |    4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index ab34497..656d137 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1088,7 +1088,7 @@ static struct platform_driver atmel_spi_driver = {
 	.suspend	= atmel_spi_suspend,
 	.resume		= atmel_spi_resume,
 	.probe		= atmel_spi_probe,
-	.remove		= __exit_p(atmel_spi_remove),
+	.remove		= atmel_spi_remove,
 };
 module_platform_driver(atmel_spi_driver);
 
diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index 4de66d1c..363ff6b 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -968,7 +968,7 @@ err_nomem:
 	return err;
 }
 
-static int __exit au1550_spi_remove(struct platform_device *pdev)
+static int au1550_spi_remove(struct platform_device *pdev)
 {
 	struct au1550_spi *hw = platform_get_drvdata(pdev);
 
@@ -997,7 +997,7 @@ static int __exit au1550_spi_remove(struct platform_device *pdev)
 MODULE_ALIAS("platform:au1550-spi");
 
 static struct platform_driver au1550_spi_drv = {
-	.remove = __exit_p(au1550_spi_remove),
+	.remove = au1550_spi_remove,
 	.driver = {
 		.name = "au1550-spi",
 		.owner = THIS_MODULE,
diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 3aef7fa..d31e203 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -560,7 +560,7 @@ err1:
 	return status;
 }
 
-static int __exit omap1_spi100k_remove(struct platform_device *pdev)
+static int omap1_spi100k_remove(struct platform_device *pdev)
 {
 	struct spi_master       *master;
 	struct omap1_spi100k    *spi100k;
@@ -604,7 +604,7 @@ static struct platform_driver omap1_spi100k_driver = {
 		.name		= "omap1_spi100k",
 		.owner		= THIS_MODULE,
 	},
-	.remove		= __exit_p(omap1_spi100k_remove),
+	.remove		= omap1_spi100k_remove,
 };
 
 
diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 0a94d9d..b8f2535 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -536,7 +536,7 @@ static int __init uwire_probe(struct platform_device *pdev)
 	return status;
 }
 
-static int __exit uwire_remove(struct platform_device *pdev)
+static int uwire_remove(struct platform_device *pdev)
 {
 	struct uwire_spi	*uwire = dev_get_drvdata(&pdev->dev);
 	int			status;
@@ -557,7 +557,7 @@ static struct platform_driver uwire_driver = {
 		.name		= "omap_uwire",
 		.owner		= THIS_MODULE,
 	},
-	.remove		= __exit_p(uwire_remove),
+	.remove		= uwire_remove,
 	// suspend ... unuse ck
 	// resume ... use ck
 };
diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index b7e7182..4a548e8 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -479,7 +479,7 @@ out:
 }
 
 
-static int __exit orion_spi_remove(struct platform_device *pdev)
+static int orion_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct resource *r;
@@ -513,7 +513,7 @@ static struct platform_driver orion_spi_driver = {
 		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(orion_spi_of_match_table),
 	},
-	.remove		= __exit_p(orion_spi_remove),
+	.remove		= orion_spi_remove,
 };
 
 static int __init orion_spi_init(void)
diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 7a85f22..027b474 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -560,7 +560,7 @@ free_master:
 	return ret;
 }
 
-static int __exit spi_ppc4xx_of_remove(struct platform_device *op)
+static int spi_ppc4xx_of_remove(struct platform_device *op)
 {
 	struct spi_master *master = dev_get_drvdata(&op->dev);
 	struct ppc4xx_spi *hw = spi_master_get_devdata(master);
@@ -583,7 +583,7 @@ MODULE_DEVICE_TABLE(of, spi_ppc4xx_of_match);
 
 static struct platform_driver spi_ppc4xx_of_driver = {
 	.probe = spi_ppc4xx_of_probe,
-	.remove = __exit_p(spi_ppc4xx_of_remove),
+	.remove = spi_ppc4xx_of_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index 550b5f4..671a164 100644
--- a/drivers/spi/spi-txx9.c
+++ b/drivers/spi/spi-txx9.c
@@ -430,7 +430,7 @@ exit:
 	return ret;
 }
 
-static int __exit txx9spi_remove(struct platform_device *dev)
+static int txx9spi_remove(struct platform_device *dev)
 {
 	struct spi_master *master = spi_master_get(platform_get_drvdata(dev));
 	struct txx9spi *c = spi_master_get_devdata(master);
@@ -448,7 +448,7 @@ static int __exit txx9spi_remove(struct platform_device *dev)
 MODULE_ALIAS("platform:spi_txx9");
 
 static struct platform_driver txx9spi_driver = {
-	.remove = __exit_p(txx9spi_remove),
+	.remove = txx9spi_remove,
 	.driver = {
 		.name = "spi_txx9",
 		.owner = THIS_MODULE,
-- 
1.7.10.4


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
