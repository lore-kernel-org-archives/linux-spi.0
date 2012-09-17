From: <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH RESEND] spi/designware: Add device tree bindings
Date: Mon, 17 Sep 2012 11:00:01 -0600
Message-ID: <1347901201-10931-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Dinh,
	Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Paul,
	Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
To: <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
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

From: Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>

Add device tree bindings for designware spi modules,
specifically, spi-dw-mmio and spi-dw-pci.

Signed-off-by: Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Cc: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Resend to a bigger audience.
---
 Documentation/devicetree/bindings/spi/spi-dw.txt |   20 +++++++++++++++
 drivers/spi/spi-dw-mmio.c                        |   24 +++++++++++++++---
 drivers/spi/spi-dw-pci.c                         |   29 +++++++++++++++++++---
 3 files changed, 66 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-dw.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-dw.txt b/Documentation/devicetree/bindings/spi/spi-dw.txt
new file mode 100644
index 0000000..10a6e9d
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-dw.txt
@@ -0,0 +1,20 @@
+DesignWare SPI device
+
+Required properties:
+- compatible : should be "snps,dw-spi-mmio" or "snps,dw-spi-pci"
+- reg : offset and length of the register set for the device
+- interrupts: The interrupt number to the cpu. The interrupt specifier format
+  depends on the interrupt controller.
+- num-chipselect: Contains the number of the chipselect
+- bus-num: Bus number
+
+Example:
+		spi: spi@fff00000 {
+				compatible = "snps,dw-spi-mmio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0xfff00000 0x1000>;
+				interrupts = <0 154 4>;
+				num-chipselect = <4>;
+				bus-num = <0>;
+		};
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index db2f1ba..555c47a 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -16,6 +16,7 @@
 #include <linux/spi/spi.h>
 #include <linux/scatterlist.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #include "spi-dw.h"
 
@@ -31,7 +32,7 @@ static int __devinit dw_spi_mmio_probe(struct platform_device *pdev)
 	struct dw_spi_mmio *dwsmmio;
 	struct dw_spi *dws;
 	struct resource *mem, *ioarea;
-	int ret;
+	int ret, num_cs, bus_num;
 
 	dwsmmio = kzalloc(sizeof(struct dw_spi_mmio), GFP_KERNEL);
 	if (!dwsmmio) {
@@ -78,9 +79,19 @@ static int __devinit dw_spi_mmio_probe(struct platform_device *pdev)
 	}
 	clk_enable(dwsmmio->clk);
 
+	ret = of_property_read_u32(pdev->dev.of_node, "num-chipselect", &num_cs);
+	if (ret < 0)
+		dws->num_cs = 4;
+	else
+		dws->num_cs = num_cs;
+
+	ret = of_property_read_u32(pdev->dev.of_node, "bus-num", &bus_num);
+	if (ret < 0)
+		dws->bus_num = 0;
+	else
+		dws->bus_num = bus_num;
+
 	dws->parent_dev = &pdev->dev;
-	dws->bus_num = 0;
-	dws->num_cs = 4;
 	dws->max_freq = clk_get_rate(dwsmmio->clk);
 
 	ret = dw_spi_add_host(dws);
@@ -127,12 +138,19 @@ static int __devexit dw_spi_mmio_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct of_device_id dw_spi_mmio_of_match[] __devinitdata = {
+		{ .compatible = "snps,dw-spi-mmio", },
+		{ /* sentinel */}
+};
+MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
+
 static struct platform_driver dw_spi_mmio_driver = {
 	.probe		= dw_spi_mmio_probe,
 	.remove		= __devexit_p(dw_spi_mmio_remove),
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = dw_spi_mmio_of_match,
 	},
 };
 module_platform_driver(dw_spi_mmio_driver);
diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index ff81abb..d6d9d77 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #include "spi-dw.h"
 
@@ -38,7 +39,7 @@ static int __devinit spi_pci_probe(struct pci_dev *pdev,
 	struct dw_spi_pci *dwpci;
 	struct dw_spi *dws;
 	int pci_bar = 0;
-	int ret;
+	int ret, num_cs, bus_num;
 
 	printk(KERN_INFO "DW: found PCI SPI controller(ID: %04x:%04x)\n",
 		pdev->vendor, pdev->device);
@@ -71,9 +72,19 @@ static int __devinit spi_pci_probe(struct pci_dev *pdev,
 		goto err_release_reg;
 	}
 
+	ret = of_property_read_u32(pdev->dev.of_node, "num-chipselect", &num_cs);
+	if (ret < 0)
+		dws->num_cs = 4;
+	else
+		dws->num_cs = num_cs;
+
+	ret = of_property_read_u32(pdev->dev.of_node, "bus-num", &bus_num);
+	if (ret < 0)
+		dws->bus_num = 0;
+	else
+		dws->bus_num = bus_num;
+
 	dws->parent_dev = &pdev->dev;
-	dws->bus_num = 0;
-	dws->num_cs = 4;
 	dws->irq = pdev->irq;
 
 	/*
@@ -155,13 +166,23 @@ static DEFINE_PCI_DEVICE_TABLE(pci_ids) = {
 	{},
 };
 
+static struct of_device_id dw_spi_pci_of_match[] __devinitdata = {
+		{ .compatible = "snps,dw-spi-pci", },
+		{ /* sentinel */}
+};
+MODULE_DEVICE_TABLE(of, dw_spi_pci_of_match);
+
 static struct pci_driver dw_spi_driver = {
-	.name =		DRIVER_NAME,
 	.id_table =	pci_ids,
 	.probe =	spi_pci_probe,
 	.remove =	__devexit_p(spi_pci_remove),
 	.suspend =	spi_suspend,
 	.resume	=	spi_resume,
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+		.of_match_table = dw_spi_pci_of_match,
+	},
 };
 
 module_pci_driver(dw_spi_driver);
-- 
1.7.9.5



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
