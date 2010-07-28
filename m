From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] spi: enable spi_board_info to be
	registered after spi_master
Date: Wed, 28 Jul 2010 10:39:56 +0800
Message-ID: <1280284796-26136-1-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Currently spi_register_board_info() has to be called before its related
spi_master be registered, otherwise these board info will be just ignored.

This patch will remove this order limit, it adds a global spi master list
like the existing global board info listr. Whenever a board info is
registered, the spi master list will be scanned, and a new spi device will
be created if master and boardinfo match.

Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi.c       |   73 ++++++++++++++++++++++++++++++++++-------------
 include/linux/spi/spi.h |    3 ++
 2 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b3a1f92..1266fb2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -196,13 +196,16 @@ EXPORT_SYMBOL_GPL(spi_register_driver);
 
 struct boardinfo {
 	struct list_head	list;
-	unsigned		n_board_info;
-	struct spi_board_info	board_info[0];
+	struct spi_board_info	board_info;
 };
 
 static LIST_HEAD(board_list);
 static DEFINE_MUTEX(board_lock);
 
+
+static LIST_HEAD(spi_master_list);
+static DEFINE_MUTEX(spi_master_lock);
+
 /**
  * spi_alloc_device - Allocate a new SPI device
  * @master: Controller to which device is connected
@@ -365,6 +368,25 @@ struct spi_device *spi_new_device(struct spi_master *master,
 }
 EXPORT_SYMBOL_GPL(spi_new_device);
 
+static void spi_scan_masterlist(struct spi_board_info *bi)
+{
+	struct spi_master *master;
+	struct spi_device *dev;
+
+	mutex_lock(&spi_master_lock);
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
+	mutex_unlock(&spi_master_lock);
+}
+
 /**
  * spi_register_board_info - register SPI devices for a given board
  * @info: array of chip descriptors
@@ -387,41 +409,45 @@ EXPORT_SYMBOL_GPL(spi_new_device);
 int __init
 spi_register_board_info(struct spi_board_info const *info, unsigned n)
 {
-	struct boardinfo	*bi;
+	struct boardinfo *bi, *tmp_bi;
+	int i;
 
-	bi = kmalloc(sizeof(*bi) + n * sizeof *info, GFP_KERNEL);
+	bi = kzalloc(n * sizeof(*bi), GFP_KERNEL);
 	if (!bi)
 		return -ENOMEM;
-	bi->n_board_info = n;
-	memcpy(bi->board_info, info, n * sizeof *info);
 
 	mutex_lock(&board_lock);
-	list_add_tail(&bi->list, &board_list);
+	for (i = 0, tmp_bi = bi; i < n; i++, tmp_bi++, info++) {
+		memcpy(&tmp_bi->board_info, info, sizeof(*info));
+		list_add_tail(&tmp_bi->list, &board_list);
+	}
 	mutex_unlock(&board_lock);
+
+	for (i = 0, tmp_bi = bi; i < n; i++, tmp_bi++)
+		spi_scan_masterlist(&tmp_bi->board_info);
+
 	return 0;
 }
 
 /* FIXME someone should add support for a __setup("spi", ...) that
  * creates board info from kernel command lines
  */
-
 static void scan_boardinfo(struct spi_master *master)
 {
 	struct boardinfo	*bi;
+	struct spi_device	*dev;
 
 	mutex_lock(&board_lock);
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
 	mutex_unlock(&board_lock);
 }
@@ -537,15 +563,18 @@ int spi_register_master(struct spi_master *master)
 	dev_dbg(dev, "registered master %s%s\n", dev_name(&master->dev),
 			dynamic ? " (dynamic)" : "");
 
+	mutex_lock(&spi_master_lock);
+	list_add_tail(&master->list, &spi_master_list);
 	/* populate children from any spi device tables */
 	scan_boardinfo(master);
+	mutex_unlock(&spi_master_lock);
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
@@ -568,6 +597,10 @@ void spi_unregister_master(struct spi_master *master)
 {
 	int dummy;
 
+	mutex_lock(&spi_master_lock);
+	list_del(&master->list);
+	mutex_unlock(&spi_master_lock);
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
http://ad.doubleclick.net/clk;226879339;13503038;l?
http://clk.atdmt.com/CRS/go/247765532/direct/01/
