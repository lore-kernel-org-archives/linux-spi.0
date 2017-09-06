From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi: Use ida to manage SPI bus number
Date: Wed,  6 Sep 2017 19:26:51 +0800
Message-ID: <2a15b398a8f8d3f6f46f9fd6e8591242d29c44a2.1504697026.git.baolin.wang@linaro.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch adds one static ida variable to manage SPI bus number, moreover
we can get dynamic bus number from ida instead of one "dynamic" IDs, which
can be removed.

Signed-off-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4fcbb0a..1498be2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -40,10 +40,13 @@
 #include <linux/ioport.h>
 #include <linux/acpi.h>
 #include <linux/highmem.h>
+#include <linux/idr.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
 
+static DEFINE_IDA(spi_bus_ida);
+
 static void spidev_release(struct device *dev)
 {
 	struct spi_device	*spi = to_spi_device(dev);
@@ -2052,7 +2055,6 @@ static int of_spi_register_master(struct spi_controller *ctlr)
  */
 int spi_register_controller(struct spi_controller *ctlr)
 {
-	static atomic_t		dyn_bus_id = ATOMIC_INIT((1<<15) - 1);
 	struct device		*dev = ctlr->dev.parent;
 	struct boardinfo	*bi;
 	int			status = -ENODEV;
@@ -2076,12 +2078,15 @@ int spi_register_controller(struct spi_controller *ctlr)
 	if ((ctlr->bus_num < 0) && ctlr->dev.of_node)
 		ctlr->bus_num = of_alias_get_id(ctlr->dev.of_node, "spi");
 
-	/* convention:  dynamically assigned bus IDs count down from the max */
+	if (ctlr->bus_num >= 0)
+		ctlr->bus_num = ida_simple_get(&spi_bus_ida, ctlr->bus_num,
+					       ctlr->bus_num + 1, GFP_KERNEL);
+
 	if (ctlr->bus_num < 0) {
-		/* FIXME switch to an IDR based scheme, something like
-		 * I2C now uses, so we can't run out of "dynamic" IDs
-		 */
-		ctlr->bus_num = atomic_dec_return(&dyn_bus_id);
+		ctlr->bus_num = ida_simple_get(&spi_bus_ida, 0, 0, GFP_KERNEL);
+		if (ctlr->bus_num < 0)
+			return ctlr->bus_num;
+
 		dynamic = 1;
 	}
 
@@ -2128,7 +2133,10 @@ int spi_register_controller(struct spi_controller *ctlr)
 	/* Register devices from the device tree and ACPI */
 	of_register_spi_devices(ctlr);
 	acpi_register_spi_devices(ctlr);
+
+	return 0;
 done:
+	ida_simple_remove(&spi_bus_ida, ctlr->bus_num);
 	return status;
 }
 EXPORT_SYMBOL_GPL(spi_register_controller);
@@ -2202,6 +2210,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	list_del(&ctlr->list);
 	mutex_unlock(&board_lock);
 
+	ida_simple_remove(&spi_bus_ida, ctlr->bus_num);
 	dummy = device_for_each_child(&ctlr->dev, NULL, __unregister);
 	device_unregister(&ctlr->dev);
 }
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
