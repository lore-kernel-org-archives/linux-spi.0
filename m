From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3] spi: enable spi_board_info to be
 registered after spi_master
Date: Mon, 2 Aug 2010 13:47:36 +0800
Message-ID: <20100802134736.24854fac@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, David Brownell
	<david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, spi-devel-list
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi All,

Pls review this patch. thanks,

-Feng

Changelog:
	v3:
	   * As suggested by Grant, use one lock to protect the match
	     between spi_master and spi board info
	v2:
	   * fix a typo in looping scan_masterlist()
	   * fix one race condition found by Grant

>From 28af337ec89225a0dfb7ca516545b7eff112e3b2 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date: Tue, 27 Jul 2010 17:15:05 +0800
Subject: [PATCH] spi: enable spi_board_info to be registered after spi_master

Currently spi_register_board_info() has to be called before its related
spi_master be registered, otherwise these board info will be just ignored.

This patch will remove this order limit, it adds a global spi master list
like the existing global board info listr. Whenever a board info or a
spi_master is registered, the spi master list or board info list
will be scanned, and a new spi device will be created if there is a
master-board info match.

Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi.c       |   84 ++++++++++++++++++++++++++++++++--------------
 include/linux/spi/spi.h |    3 ++
 2 files changed, 61 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b3a1f92..8fb2337 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -196,11 +196,16 @@ EXPORT_SYMBOL_GPL(spi_register_driver);
 
 struct boardinfo {
 	struct list_head	list;
-	unsigned		n_board_info;
-	struct spi_board_info	board_info[0];
+	struct spi_board_info	board_info;
 };
 
 static LIST_HEAD(board_list);
+static LIST_HEAD(spi_master_list);
+
+/*
+ * Used to protect add/del opertion for board_info list and
+ * spi_master list, and their matching process
+ */
 static DEFINE_MUTEX(board_lock);
 
 /**
@@ -365,6 +370,24 @@ struct spi_device *spi_new_device(struct spi_master *master,
 }
 EXPORT_SYMBOL_GPL(spi_new_device);
 
+/* Has to be called when board_lock is acquired */
+static void spi_scan_masterlist(struct spi_board_info *bi)
+{
+	struct spi_master *master;
+	struct spi_device *dev;
+
+	list_for_each_entry(master, &spi_master_list, list) {
+		if (master->bus_num != bi->bus_num)
+			continue;
+
+		dev = spi_new_device(master, bi);
+		if (!dev)
+			dev_err(master->dev.parent,
+				"can't create new device for %s\n",
+				bi->modalias);
+	}
+}
+
 /**
  * spi_register_board_info - register SPI devices for a given board
  * @info: array of chip descriptors
@@ -387,43 +410,46 @@ EXPORT_SYMBOL_GPL(spi_new_device);
 int __init
 spi_register_board_info(struct spi_board_info const *info, unsigned n)
 {
-	struct boardinfo	*bi;
+	struct boardinfo *bi;
+	int i;
 
-	bi = kmalloc(sizeof(*bi) + n * sizeof *info, GFP_KERNEL);
+	bi = kzalloc(n * sizeof(*bi), GFP_KERNEL);
 	if (!bi)
 		return -ENOMEM;
-	bi->n_board_info = n;
-	memcpy(bi->board_info, info, n * sizeof *info);
 
-	mutex_lock(&board_lock);
-	list_add_tail(&bi->list, &board_list);
-	mutex_unlock(&board_lock);
+	for (i = 0; i < n; i++, bi++, info++) {
+		memcpy(&bi->board_info, info, sizeof(*info));
+		mutex_lock(&board_lock);
+		list_add_tail(&bi->list, &board_list);
+		spi_scan_masterlist(&bi->board_info);
+		mutex_unlock(&board_lock);
+	}
+
 	return 0;
 }
 
-/* FIXME someone should add support for a __setup("spi", ...) that
+/*
+ * FIXME someone should add support for a __setup("spi", ...) that
  * creates board info from kernel command lines
+ *
+ * Should be called when board_lock is acquired
  */
-
 static void scan_boardinfo(struct spi_master *master)
 {
 	struct boardinfo	*bi;
+	struct spi_device	*dev;
 
-	mutex_lock(&board_lock);
 	list_for_each_entry(bi, &board_list, list) {
-		struct spi_board_info	*chip = bi->board_info;
-		unsigned		n;
-
-		for (n = bi->n_board_info; n > 0; n--, chip++) {
-			if (chip->bus_num != master->bus_num)
-				continue;
-			/* NOTE: this relies on spi_new_device to
-			 * issue diagnostics when given bogus inputs
-			 */
-			(void) spi_new_device(master, chip);
-		}
+		struct spi_board_info	*chip = &bi->board_info;
+
+		if (chip->bus_num != master->bus_num)
+			continue;
+		dev = spi_new_device(master, chip);
+		if (!dev)
+			dev_err(master->dev.parent,
+				"can't create new device for %s\n",
+				chip->modalias);
 	}
-	mutex_unlock(&board_lock);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -537,15 +563,17 @@ int spi_register_master(struct spi_master *master)
 	dev_dbg(dev, "registered master %s%s\n", dev_name(&master->dev),
 			dynamic ? " (dynamic)" : "");
 
-	/* populate children from any spi device tables */
+	mutex_lock(&board_lock);
+	list_add_tail(&master->list, &spi_master_list);
 	scan_boardinfo(master);
+	mutex_unlock(&board_lock);
+
 	status = 0;
 done:
 	return status;
 }
 EXPORT_SYMBOL_GPL(spi_register_master);
 
-
 static int __unregister(struct device *dev, void *master_dev)
 {
 	/* note: before about 2.6.14-rc1 this would corrupt memory: */
@@ -568,6 +596,10 @@ void spi_unregister_master(struct spi_master *master)
 {
 	int dummy;
 
+	mutex_lock(&board_lock);
+	list_del(&master->list);
+	mutex_unlock(&board_lock);
+
 	dummy = device_for_each_child(master->dev.parent, &master->dev,
 					__unregister);
 	device_unregister(&master->dev);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index af56071..f4a29b6 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -204,6 +204,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
 /**
  * struct spi_master - interface to SPI master controller
  * @dev: device interface to this driver
+ * @list: link with the global spi_master list
  * @bus_num: board-specific (and often SOC-specific) identifier for a
  *	given SPI controller.
  * @num_chipselect: chipselects are used to distinguish individual
@@ -235,6 +236,8 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
 struct spi_master {
 	struct device	dev;
 
+	struct list_head list;
+
 	/* other than negative (== assign one dynamically), bus_num is fully
 	 * board-specific.  usually that simplifies to being SOC-specific.
 	 * example:  one SOC has three SPI controllers, numbered 0..2,
-- 
1.7.0.4

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
