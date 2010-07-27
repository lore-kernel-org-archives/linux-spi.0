From: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH] of/spi: call of_register_spi_devices() from spi core code
Date: Tue, 27 Jul 2010 15:39:27 +0200
Message-ID: <1280237967-2460-1-git-send-email-agust@denx.de>
References: <AANLkTik9GYDGi3jnMdPdyOa6sFv4bo_+4b-RWMq7nW6x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <AANLkTik9GYDGi3jnMdPdyOa6sFv4bo_+4b-RWMq7nW6x-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Move of_register_spi_devices() call from some drivers to
spi_register_master(). Also change the function to use
the struct device_node pointer from master spi device
instead of passing it as function argument.

Since xilinx_spi_of.c and spi_ppc4xx.c drivers do not use
spi_register_master(), they still call of_register_spi_devices()
directly. Maybe these drivers should be reworked later.

Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
---
 drivers/of/of_spi.c           |    7 +++----
 drivers/spi/mpc52xx_psc_spi.c |    9 +--------
 drivers/spi/mpc52xx_spi.c     |    2 --
 drivers/spi/spi.c             |    5 +++++
 drivers/spi/spi_mpc8xxx.c     |    3 ---
 drivers/spi/spi_ppc4xx.c      |    3 ++-
 drivers/spi/xilinx_spi.c      |    1 +
 drivers/spi/xilinx_spi_of.c   |    2 +-
 include/linux/of_spi.h        |   11 ++++++++---
 9 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/of/of_spi.c b/drivers/of/of_spi.c
index d504f1d..76a0529 100644
--- a/drivers/of/of_spi.c
+++ b/drivers/of/of_spi.c
@@ -15,12 +15,11 @@
 /**
  * of_register_spi_devices - Register child devices onto the SPI bus
  * @master:	Pointer to spi_master device
- * @np:		parent node of SPI device nodes
  *
- * Registers an spi_device for each child node of 'np' which has a 'reg'
+ * Registers an spi_device for each child node of master node which has a 'reg'
  * property.
  */
-void of_register_spi_devices(struct spi_master *master, struct device_node *np)
+void of_register_spi_devices(struct spi_master *master)
 {
 	struct spi_device *spi;
 	struct device_node *nc;
@@ -28,7 +27,7 @@ void of_register_spi_devices(struct spi_master *master, struct device_node *np)
 	int rc;
 	int len;
 
-	for_each_child_of_node(np, nc) {
+	for_each_child_of_node(master->dev.of_node, nc) {
 		/* Alloc an spi_device */
 		spi = spi_alloc_device(master);
 		if (!spi) {
diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 7104cb7..a6eb5d4 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -17,7 +17,6 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/of_platform.h>
-#include <linux/of_spi.h>
 #include <linux/workqueue.h>
 #include <linux/completion.h>
 #include <linux/io.h>
@@ -470,7 +469,6 @@ static int __init mpc52xx_psc_spi_of_probe(struct of_device *op,
 	const u32 *regaddr_p;
 	u64 regaddr64, size64;
 	s16 id = -1;
-	int rc;
 
 	regaddr_p = of_get_address(op->dev.of_node, 0, &size64, NULL);
 	if (!regaddr_p) {
@@ -491,13 +489,8 @@ static int __init mpc52xx_psc_spi_of_probe(struct of_device *op,
 		id = *psc_nump + 1;
 	}
 
-	rc = mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
+	return mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
 				irq_of_parse_and_map(op->dev.of_node, 0), id);
-	if (rc == 0)
-		of_register_spi_devices(dev_get_drvdata(&op->dev),
-					op->dev.of_node);
-
-	return rc;
 }
 
 static int __exit mpc52xx_psc_spi_of_remove(struct of_device *op)
diff --git a/drivers/spi/mpc52xx_spi.c b/drivers/spi/mpc52xx_spi.c
index b1a76bf..18e1c86 100644
--- a/drivers/spi/mpc52xx_spi.c
+++ b/drivers/spi/mpc52xx_spi.c
@@ -18,7 +18,6 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
-#include <linux/of_spi.h>
 #include <linux/io.h>
 #include <linux/of_gpio.h>
 #include <linux/slab.h>
@@ -512,7 +511,6 @@ static int __devinit mpc52xx_spi_probe(struct of_device *op,
 	if (rc)
 		goto err_register;
 
-	of_register_spi_devices(master, op->dev.of_node);
 	dev_info(&ms->master->dev, "registered MPC5200 SPI bus\n");
 
 	return rc;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index fdde706..626fa48 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
+#include <linux/of_spi.h>
 
 
 /* SPI bustype and spi_master class are registered after board init code
@@ -544,6 +545,10 @@ int spi_register_master(struct spi_master *master)
 	/* populate children from any spi device tables */
 	scan_boardinfo(master);
 	status = 0;
+
+	/* Register devices from the device tree */
+	master->dev.of_node = dev->of_node;
+	of_register_spi_devices(master);
 done:
 	return status;
 }
diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
index 97ab0a8..89fea11 100644
--- a/drivers/spi/spi_mpc8xxx.c
+++ b/drivers/spi/spi_mpc8xxx.c
@@ -38,7 +38,6 @@
 #include <linux/of_platform.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
-#include <linux/of_spi.h>
 #include <linux/slab.h>
 
 #include <sysdev/fsl_soc.h>
@@ -1299,8 +1298,6 @@ static int __devinit of_mpc8xxx_spi_probe(struct of_device *ofdev,
 		goto err;
 	}
 
-	of_register_spi_devices(master, np);
-
 	return 0;
 
 err:
diff --git a/drivers/spi/spi_ppc4xx.c b/drivers/spi/spi_ppc4xx.c
index d53466a..0bcea55 100644
--- a/drivers/spi/spi_ppc4xx.c
+++ b/drivers/spi/spi_ppc4xx.c
@@ -545,7 +545,8 @@ static int __init spi_ppc4xx_of_probe(struct of_device *op,
 	}
 
 	dev_info(dev, "driver initialized\n");
-	of_register_spi_devices(master, np);
+	master->dev.of_node = np;
+	of_register_spi_devices(master);
 
 	return 0;
 
diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index 1b47363..d101a84 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -390,6 +390,7 @@ struct spi_master *xilinx_spi_init(struct device *dev, struct resource *mem,
 
 	master->bus_num = bus_num;
 	master->num_chipselect = pdata->num_chipselect;
+	master->dev.of_node = dev->of_node;
 
 	xspi->mem = *mem;
 	xspi->irq = irq;
diff --git a/drivers/spi/xilinx_spi_of.c b/drivers/spi/xilinx_spi_of.c
index 4654805..0295bbf 100644
--- a/drivers/spi/xilinx_spi_of.c
+++ b/drivers/spi/xilinx_spi_of.c
@@ -81,7 +81,7 @@ static int __devinit xilinx_spi_of_probe(struct of_device *ofdev,
 	dev_set_drvdata(&ofdev->dev, master);
 
 	/* Add any subnodes on the SPI bus */
-	of_register_spi_devices(master, ofdev->dev.of_node);
+	of_register_spi_devices(master);
 
 	return 0;
 }
diff --git a/include/linux/of_spi.h b/include/linux/of_spi.h
index 5f71ee8..9e3e70f 100644
--- a/include/linux/of_spi.h
+++ b/include/linux/of_spi.h
@@ -9,10 +9,15 @@
 #ifndef __LINUX_OF_SPI_H
 #define __LINUX_OF_SPI_H
 
-#include <linux/of.h>
 #include <linux/spi/spi.h>
 
-extern void of_register_spi_devices(struct spi_master *master,
-				    struct device_node *np);
+#if defined(CONFIG_OF_SPI) || defined(CONFIG_OF_SPI_MODULE)
+extern void of_register_spi_devices(struct spi_master *master);
+#else
+static inline void of_register_spi_devices(struct spi_master *master)
+{
+	return;
+}
+#endif /* CONFIG_OF_SPI */
 
 #endif /* __LINUX_OF_SPI */
-- 
1.7.0.4
