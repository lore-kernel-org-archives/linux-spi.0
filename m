From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Pick spi bus number from Linux idr or spi alias" to the spi tree
Date: Wed, 16 Aug 2017 17:02:22 +0100
Message-ID: <E1di0ly-0003WF-HD@debutante>
Cc: Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>,
        Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Pick spi bus number from Linux idr or spi alias

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 9b61e302210eba55768962f2f11e96bb508c2408 Mon Sep 17 00:00:00 2001
From: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Date: Thu, 3 Aug 2017 10:05:57 +0530
Subject: [PATCH] spi: Pick spi bus number from Linux idr or spi alias

Modify existing code, for automatically picking the spi bus number based
on Linux idr scheme as mentioned in FIXME.
This patch does the following:
(a) Remove the now unnecessary code which was allocating bus numbers using
    ATOMIC_INIT and atomic_dec_return macros.
(b) If we have an alias, pick the bus number from alias ID
(c) Convert to linux idr interface

Signed-off-by: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Signed-off-by: Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Tested-by: Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 71 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index aed78093b130..b851888a0a0b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -40,9 +40,13 @@
 #include <linux/ioport.h>
 #include <linux/acpi.h>
 #include <linux/highmem.h>
+#include <linux/idr.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
+#define SPI_DYN_FIRST_BUS_NUM 0
+
+static DEFINE_IDR(spi_master_idr);
 
 static void spidev_release(struct device *dev)
 {
@@ -420,6 +424,7 @@ static LIST_HEAD(spi_controller_list);
 /*
  * Used to protect add/del opertion for board_info list and
  * spi_controller list, and their matching process
+ * also used to protect object of type struct idr 
  */
 static DEFINE_MUTEX(board_lock);
 
@@ -2051,11 +2056,10 @@ static int of_spi_register_master(struct spi_controller *ctlr)
  */
 int spi_register_controller(struct spi_controller *ctlr)
 {
-	static atomic_t		dyn_bus_id = ATOMIC_INIT((1<<15) - 1);
 	struct device		*dev = ctlr->dev.parent;
 	struct boardinfo	*bi;
 	int			status = -ENODEV;
-	int			dynamic = 0;
+	int			id;
 
 	if (!dev)
 		return -ENODEV;
@@ -2071,17 +2075,29 @@ int spi_register_controller(struct spi_controller *ctlr)
 	 */
 	if (ctlr->num_chipselect == 0)
 		return -EINVAL;
-
-	if ((ctlr->bus_num < 0) && ctlr->dev.of_node)
-		ctlr->bus_num = of_alias_get_id(ctlr->dev.of_node, "spi");
-
-	/* convention:  dynamically assigned bus IDs count down from the max */
+	
+	/* allocate dynamic bus number using Linux idr */
+	if ((ctlr->bus_num < 0) && ctlr->dev.of_node) {
+		id = of_alias_get_id(ctlr->dev.of_node, "spi");
+		if (id >= 0) {
+			ctlr->bus_num = id;
+			mutex_lock(&board_lock);
+			id = idr_alloc(&spi_master_idr, ctlr, ctlr->bus_num,
+				       ctlr->bus_num + 1, GFP_KERNEL);
+			mutex_unlock(&board_lock);
+			if (WARN(id < 0, "couldn't get idr"))
+				return id == -ENOSPC ? -EBUSY : id;
+		}
+	}
 	if (ctlr->bus_num < 0) {
-		/* FIXME switch to an IDR based scheme, something like
-		 * I2C now uses, so we can't run out of "dynamic" IDs
-		 */
-		ctlr->bus_num = atomic_dec_return(&dyn_bus_id);
-		dynamic = 1;
+			mutex_lock(&board_lock);
+			id = idr_alloc(&spi_master_idr, ctlr,
+				       SPI_DYN_FIRST_BUS_NUM, 0, GFP_KERNEL);
+			mutex_unlock(&board_lock);
+			if (WARN(id < 0, "couldn't get idr"))
+				return id;
+
+			ctlr->bus_num = id;
 	}
 
 	INIT_LIST_HEAD(&ctlr->queue);
@@ -2099,11 +2115,16 @@ int spi_register_controller(struct spi_controller *ctlr)
 	 */
 	dev_set_name(&ctlr->dev, "spi%u", ctlr->bus_num);
 	status = device_add(&ctlr->dev);
-	if (status < 0)
+	if (status < 0) {
+		/* free bus id */
+		mutex_lock(&board_lock);
+		idr_remove(&spi_master_idr, ctlr->bus_num);
+		mutex_unlock(&board_lock);
 		goto done;
-	dev_dbg(dev, "registered %s %s%s\n",
+	}
+	dev_dbg(dev, "registered %s %s\n",
 			spi_controller_is_slave(ctlr) ? "slave" : "master",
-			dev_name(&ctlr->dev), dynamic ? " (dynamic)" : "");
+			dev_name(&ctlr->dev));
 
 	/* If we're using a queued driver, start the queue */
 	if (ctlr->transfer)
@@ -2112,6 +2133,10 @@ int spi_register_controller(struct spi_controller *ctlr)
 		status = spi_controller_initialize_queue(ctlr);
 		if (status) {
 			device_del(&ctlr->dev);
+			/* free bus id */
+			mutex_lock(&board_lock);
+			idr_remove(&spi_master_idr, ctlr->bus_num);
+			mutex_unlock(&board_lock);
 			goto done;
 		}
 	}
@@ -2190,8 +2215,20 @@ static int __unregister(struct device *dev, void *null)
  */
 void spi_unregister_controller(struct spi_controller *ctlr)
 {
+	struct spi_controller *found;
 	int dummy;
 
+	/* First make sure that this controller was ever added */
+	mutex_lock(&board_lock);
+	found = idr_find(&spi_master_idr, ctlr->bus_num);
+	mutex_unlock(&board_lock);
+        if (found != ctlr) {
+                dev_dbg(&ctlr->dev, 
+			"attempting to delete unregistered controller [%s]\n",
+			dev_name(&ctlr->dev));
+                return;
+        }
+
 	if (ctlr->queued) {
 		if (spi_destroy_queue(ctlr))
 			dev_err(&ctlr->dev, "queue remove failed\n");
@@ -2203,6 +2240,10 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 
 	dummy = device_for_each_child(&ctlr->dev, NULL, __unregister);
 	device_unregister(&ctlr->dev);
+	/* free bus id */
+	mutex_lock(&board_lock);
+	idr_remove(&spi_master_idr, ctlr->bus_num);
+	mutex_unlock(&board_lock);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_controller);
 
-- 
2.13.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
