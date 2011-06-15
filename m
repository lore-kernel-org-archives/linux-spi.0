From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 5/5] spi_dw_pci: Add runtime power management
Date: Wed, 15 Jun 2011 10:23:08 -0700
Message-ID: <1308158588-17249-6-git-send-email-dirk.brandewie@gmail.com>
References: <1308158588-17249-1-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kristen Carlson Accardi <kristen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1308158588-17249-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This patch adds runtime power management to the PCI variant of the
designware SPI host controller driver.

Signed-off-by: Kristen Carlson Accardi <kristen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-dw-pci.c |   59 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/spi/spi-dw.c     |    4 ++-
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index eb35fa5..d661c2a 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
 
 #include "spi-dw.h"
@@ -91,6 +92,11 @@ static int __devinit spi_pci_probe(struct pci_dev *pdev,
 
 	/* PCI hook and SPI hook use the same drv data */
 	pci_set_drvdata(pdev, dwpci);
+
+	pm_suspend_ignore_children(&pdev->dev, true);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
+
 	return 0;
 
 err_unmap:
@@ -110,6 +116,9 @@ static void __devexit spi_pci_remove(struct pci_dev *pdev)
 
 	pci_set_drvdata(pdev, NULL);
 	spi_dw_remove_host(&dwpci->dws);
+	pm_runtime_forbid(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+
 	iounmap(dwpci->dws.regs);
 	pci_release_region(pdev, 0);
 	kfree(dwpci);
@@ -143,16 +152,61 @@ static int spi_resume(struct pci_dev *pdev)
 		return ret;
 	return spi_dw_resume_host(&dwpci->dws);
 }
+
+static int spi_dw_pci_runtime_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct dw_spi_pci *dwpci = pci_get_drvdata(pdev);
+	int ret;
+
+	dev_dbg(dev, "PCI runtime suspend called\n");
+
+	ret = spi_dw_stop_queue(&dwpci->dws);
+	if (ret == 0)
+		spi_dw_enable(&dwpci->dws);
+
+	return ret;
+}
+
+static int spi_dw_pci_runtime_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct dw_spi_pci *dwpci = pci_get_drvdata(pdev);
+
+	dev_dbg(dev, "pci_runtime_resume called\n");
+	return spi_dw_resume_host(&dwpci->dws);
+}
+
+static int spi_dw_pci_runtime_idle(struct device *dev)
+{
+	int err;
+
+	dev_dbg(dev, "pci_runtime_idle called\n");
+
+	err = pm_schedule_suspend(dev, 500);
+	if (err != 0)
+		return 0;
+	return -EBUSY;
+}
+
 #else
 #define spi_suspend	NULL
 #define spi_resume	NULL
+#define spi_dw_pci_runtime_suspend NULL
+#define spi_dw_pci_runtime_resume NULL
+#define spi_dw_pci_runtime_idle NULL
 #endif
 
 static const struct pci_device_id pci_ids[] __devinitdata = {
-	/* Intel MID platform SPI controller 0 */
+	/* Intel Moorestown platform SPI controller 0 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0800) },
 	{},
 };
+static const struct dev_pm_ops dw_spi_pm_ops = {
+	.runtime_suspend = spi_dw_pci_runtime_suspend,
+	.runtime_resume = spi_dw_pci_runtime_resume,
+	.runtime_idle = spi_dw_pci_runtime_idle,
+};
 
 static struct pci_driver dw_spi_driver = {
 	.name =		DRIVER_NAME,
@@ -161,6 +215,9 @@ static struct pci_driver dw_spi_driver = {
 	.remove =	__devexit_p(spi_pci_remove),
 	.suspend =	spi_suspend,
 	.resume	=	spi_resume,
+	.driver	=	{
+		.pm	= &dw_spi_pm_ops,
+	}, 
 };
 
 static int __init mrst_spi_init(void)
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 20f94fa..1210460 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -22,6 +22,7 @@
 #include <linux/highmem.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
 
 #include "spi-dw.h"
@@ -438,7 +439,7 @@ static void pump_messages(struct work_struct *work)
 	struct slave_cfg *controller;
 	int err = 0;
 
-
+	pm_runtime_get_sync(dws->parent_dev);
 	message = get_message(dws);
 
 	while (message && dws->run != QUEUE_STOPPED) {
@@ -473,6 +474,7 @@ static void pump_messages(struct work_struct *work)
 	}
 	if (dws->run == QUEUE_STOPPED)
 		drain_message_queue(dws);
+	pm_runtime_put_sync(dws->parent_dev);
 }
 
 /* spi_device use this to queue in their spi_msg */
-- 
1.7.3.4


------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
