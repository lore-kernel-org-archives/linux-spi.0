From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] spi: use module_pci_driver
Date: Wed, 04 Apr 2012 22:29:32 +0800
Message-ID: <1333549772.5856.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Eric Miao <eric.y.miao@gmail.com>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	spi-devel-general@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch converts the drivers in drivers/spi/* to use module_pci_driver()
macro which makes the code smaller and a bit simpler.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/spi/spi-dw-pci.c     |   13 +------------
 drivers/spi/spi-pxa2xx-pci.c |   12 +-----------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 14f7cc9..ff81abb 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -164,18 +164,7 @@ static struct pci_driver dw_spi_driver = {
 	.resume	=	spi_resume,
 };
 
-static int __init mrst_spi_init(void)
-{
-	return pci_register_driver(&dw_spi_driver);
-}
-
-static void __exit mrst_spi_exit(void)
-{
-	pci_unregister_driver(&dw_spi_driver);
-}
-
-module_init(mrst_spi_init);
-module_exit(mrst_spi_exit);
+module_pci_driver(dw_spi_driver);
 
 MODULE_AUTHOR("Feng Tang <feng.tang@intel.com>");
 MODULE_DESCRIPTION("PCI interface driver for DW SPI Core");
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 3fb44af..9f6ba34 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -164,17 +164,7 @@ static struct pci_driver ce4100_spi_driver = {
 	.remove         = __devexit_p(ce4100_spi_remove),
 };
 
-static int __init ce4100_spi_init(void)
-{
-	return pci_register_driver(&ce4100_spi_driver);
-}
-module_init(ce4100_spi_init);
-
-static void __exit ce4100_spi_exit(void)
-{
-	pci_unregister_driver(&ce4100_spi_driver);
-}
-module_exit(ce4100_spi_exit);
+module_pci_driver(ce4100_spi_driver);
 
 MODULE_DESCRIPTION("CE4100 PCI-SPI glue code for PXA's driver");
 MODULE_LICENSE("GPL v2");
-- 
1.7.5.4
