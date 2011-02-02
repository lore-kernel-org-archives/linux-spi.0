From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH] spi/pxa2xx pci: fix the release - remove race
Date: Thu, 3 Feb 2011 00:31:21 +0530
Message-ID: <20110202190121.GB28674@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

right now the platform device and its platform data is included in one big
struct which requires its custom ->release function. The problem with the
release function within the driver is that it might be called after the
driver was removed because someone was holding a reference to it and it
was not called right after platform_device_unregister(). So we also free
the platform device memory to which one might hold a reference.
This patch uses the normal pdev functions so this kind of race does not
occur.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
It seems to compile. I will check it on real hardware once I get back. I
will forward it mainline once I tested it or I get a tested-by tag :)

 drivers/spi/pxa2xx_spi_pci.c |   61 ++++++++++++++---------------------------
 1 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/drivers/spi/pxa2xx_spi_pci.c b/drivers/spi/pxa2xx_spi_pci.c
index 351d8a3..19752b0 100644
--- a/drivers/spi/pxa2xx_spi_pci.c
+++ b/drivers/spi/pxa2xx_spi_pci.c
@@ -7,10 +7,9 @@
 #include <linux/of_device.h>
 #include <linux/spi/pxa2xx_spi.h>
 
-struct awesome_struct {
+struct ce4100_info {
 	struct ssp_device ssp;
-	struct platform_device spi_pdev;
-	struct pxa2xx_spi_master spi_pdata;
+	struct platform_device *spi_pdev;
 };
 
 static DEFINE_MUTEX(ssp_lock);
@@ -51,23 +50,15 @@ void pxa_ssp_free(struct ssp_device *ssp)
 }
 EXPORT_SYMBOL_GPL(pxa_ssp_free);
 
-static void plat_dev_release(struct device *dev)
-{
-	struct awesome_struct *as = container_of(dev,
-			struct awesome_struct, spi_pdev.dev);
-
-	of_device_node_put(&as->spi_pdev.dev);
-}
-
 static int __devinit ce4100_spi_probe(struct pci_dev *dev,
 		const struct pci_device_id *ent)
 {
 	int ret;
 	resource_size_t phys_beg;
 	resource_size_t phys_len;
-	struct awesome_struct *spi_info;
+	struct ce4100_info *spi_info;
 	struct platform_device *pdev;
-	struct pxa2xx_spi_master *spi_pdata;
+	struct pxa2xx_spi_master spi_pdata;
 	struct ssp_device *ssp;
 
 	ret = pci_enable_device(dev);
@@ -84,33 +75,30 @@ static int __devinit ce4100_spi_probe(struct pci_dev *dev,
 		return ret;
 	}
 
+	pdev = platform_device_alloc("pxa2xx-spi", dev->devfn);
 	spi_info = kzalloc(sizeof(*spi_info), GFP_KERNEL);
-	if (!spi_info) {
+	if (!pdev || !spi_info ) {
 		ret = -ENOMEM;
-		goto err_kz;
+		goto err_nomem;
 	}
-	ssp = &spi_info->ssp;
-	pdev = &spi_info->spi_pdev;
-	spi_pdata =  &spi_info->spi_pdata;
+	memset(&spi_pdata, 0, sizeof(spi_pdata));
+	spi_pdata.num_chipselect = dev->devfn;
 
-	pdev->name = "pxa2xx-spi";
-	pdev->id = dev->devfn;
-	pdev->dev.parent = &dev->dev;
-	pdev->dev.platform_data = &spi_info->spi_pdata;
+	ret = platform_device_add_data(pdev, &spi_pdata, sizeof(spi_pdata));
+	if (ret)
+		goto err_nomem;
 
+	pdev->dev.parent = &dev->dev;
 #ifdef CONFIG_OF
 	pdev->dev.of_node = dev->dev.of_node;
 #endif
-	pdev->dev.release = plat_dev_release;
-
-	spi_pdata->num_chipselect = dev->devfn;
-
+	ssp = &spi_info->ssp;
 	ssp->phys_base = pci_resource_start(dev, 0);
 	ssp->mmio_base = ioremap(phys_beg, phys_len);
 	if (!ssp->mmio_base) {
 		dev_err(&pdev->dev, "failed to ioremap() registers\n");
 		ret = -EIO;
-		goto err_remap;
+		goto err_nomem;
 	}
 	ssp->irq = dev->irq;
 	ssp->port_id = pdev->id;
@@ -122,7 +110,7 @@ static int __devinit ce4100_spi_probe(struct pci_dev *dev,
 
 	pci_set_drvdata(dev, spi_info);
 
-	ret = platform_device_register(pdev);
+	ret = platform_device_add(pdev);
 	if (ret)
 		goto err_dev_add;
 
@@ -135,27 +123,21 @@ err_dev_add:
 	mutex_unlock(&ssp_lock);
 	iounmap(ssp->mmio_base);
 
-err_remap:
-	kfree(spi_info);
-
-err_kz:
+err_nomem:
 	release_mem_region(phys_beg, phys_len);
-
+	platform_device_put(pdev);
+	kfree(spi_info);
 	return ret;
 }
 
 static void __devexit ce4100_spi_remove(struct pci_dev *dev)
 {
-	struct awesome_struct *spi_info;
-	struct platform_device *pdev;
+	struct ce4100_info *spi_info;
 	struct ssp_device *ssp;
 
 	spi_info = pci_get_drvdata(dev);
-
 	ssp = &spi_info->ssp;
-	pdev = &spi_info->spi_pdev;
-
-	platform_device_unregister(pdev);
+	platform_device_unregister(spi_info->spi_pdev);
 
 	iounmap(ssp->mmio_base);
 	release_mem_region(pci_resource_start(dev, 0),
@@ -171,7 +153,6 @@ static void __devexit ce4100_spi_remove(struct pci_dev *dev)
 }
 
 static struct pci_device_id ce4100_spi_devices[] __devinitdata = {
-
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2e6a) },
 	{ },
 };
-- 
1.7.2.3

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
