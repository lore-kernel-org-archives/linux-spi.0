From: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: Convert to DEFINE_PCI_DEVICE_TABLE
Date: Thu, 15 Dec 2011 08:11:25 +0800
Message-ID: <1323907885.7773.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant, Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sebastian
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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

Convert static struct pci_device_id *[] to static DEFINE_PCI_DEVICE_TABLE
tables.

Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-dw-pci.c       |    2 +-
 drivers/spi/spi-pxa2xx-pci.c   |    2 +-
 drivers/spi/spi-topcliff-pch.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index f64250e..14f7cc9 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -149,7 +149,7 @@ static int spi_resume(struct pci_dev *pdev)
 #define spi_resume	NULL
 #endif
 
-static const struct pci_device_id pci_ids[] __devinitdata = {
+static DEFINE_PCI_DEVICE_TABLE(pci_ids) = {
 	/* Intel MID platform SPI controller 0 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0800) },
 	{},
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 8caa07d..3fb44af 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -151,7 +151,7 @@ static void __devexit ce4100_spi_remove(struct pci_dev *dev)
 	kfree(spi_info);
 }
 
-static struct pci_device_id ce4100_spi_devices[] __devinitdata = {
+static DEFINE_PCI_DEVICE_TABLE(ce4100_spi_devices) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2e6a) },
 	{ },
 };
diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 99ec279..17274a5 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -214,7 +214,7 @@ struct pch_pd_dev_save {
 	struct pch_spi_board_data *board_dat;
 };
 
-static struct pci_device_id pch_spi_pcidev_id[] = {
+static DEFINE_PCI_DEVICE_TABLE(pch_spi_pcidev_id) = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_GE_SPI),    1, },
 	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_SPI), 2, },
 	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_SPI), 1, },
-- 
1.7.5.4




------------------------------------------------------------------------------
10 Tips for Better Server Consolidation
Server virtualization is being driven by many needs.  
But none more important than the need to reduce IT complexity 
while improving strategic productivity.  Learn More! 
http://www.accelacomm.com/jaw/sdnl/114/51507609/
