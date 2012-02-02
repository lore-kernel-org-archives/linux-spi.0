From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 2/3] spi: split spi_register_master
Date: Thu, 2 Feb 2012 13:59:50 +0100
Message-ID: <1328187590-12947-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
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

From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This splits the spi_register_master() function in two parts,
easing the addition of a queued master and making the code
somewhat easier to read.

Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c |   74 ++++++++++++++++++++++++++++++++++------------------
 1 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b2ccdea..cd7ecd2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -562,30 +562,13 @@ struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
 EXPORT_SYMBOL_GPL(spi_alloc_master);
 
 /**
- * spi_register_master - register SPI master controller
- * @master: initialized master, originally from spi_alloc_master()
- * Context: can sleep
- *
- * SPI master controllers connect to their drivers using some non-SPI bus,
- * such as the platform bus.  The final stage of probe() in that code
- * includes calling spi_register_master() to hook up to this SPI bus glue.
- *
- * SPI controllers use board specific (often SOC specific) bus numbers,
- * and board-specific addressing for SPI devices combines those numbers
- * with chip select numbers.  Since SPI does not directly support dynamic
- * device identification, boards need configuration tables telling which
- * chip is at which address.
- *
- * This must be called from context that can sleep.  It returns zero on
- * success, else a negative error code (dropping the master's refcount).
- * After a successful return, the caller is responsible for calling
- * spi_unregister_master().
+ * spi_prepare_master() - initialize the SPI master structure
+ * @master: the master struct to initialize
  */
-int spi_register_master(struct spi_master *master)
+static int spi_prepare_master(struct spi_master *master)
 {
 	static atomic_t		dyn_bus_id = ATOMIC_INIT((1<<15) - 1);
 	struct device		*dev = master->dev.parent;
-	struct boardinfo	*bi;
 	int			status = -ENODEV;
 	int			dynamic = 0;
 
@@ -611,15 +594,26 @@ int spi_register_master(struct spi_master *master)
 	mutex_init(&master->bus_lock_mutex);
 	master->bus_lock_flag = 0;
 
-	/* register the device, then userspace will see it.
+	/*
+	 * register the device, then userspace will see it.
 	 * registration fails if the bus ID is in use.
 	 */
 	dev_set_name(&master->dev, "spi%u", master->bus_num);
 	status = device_add(&master->dev);
 	if (status < 0)
-		goto done;
+		return status;
 	dev_dbg(dev, "registered master %s%s\n", dev_name(&master->dev),
 			dynamic ? " (dynamic)" : "");
+	return 0;
+}
+
+/**
+ * spi_finalize_master() - finalize the SPI master, adding devices
+ * @master: the master to finalize
+ */
+static void spi_finalize_master(struct spi_master *master)
+{
+	struct boardinfo	*bi;
 
 	mutex_lock(&board_lock);
 	list_add_tail(&master->list, &spi_master_list);
@@ -627,12 +621,40 @@ int spi_register_master(struct spi_master *master)
 		spi_match_master_to_boardinfo(master, &bi->board_info);
 	mutex_unlock(&board_lock);
 
-	status = 0;
-
 	/* Register devices from the device tree */
 	of_register_spi_devices(master);
-done:
-	return status;
+}
+
+/**
+ * spi_register_master - register SPI master controller
+ * @master: initialized master, originally from spi_alloc_master()
+ * Context: can sleep
+ *
+ * SPI master controllers connect to their drivers using some non-SPI bus,
+ * such as the platform bus.  The final stage of probe() in that code
+ * includes calling spi_register_master() to hook up to this SPI bus glue.
+ *
+ * SPI controllers use board specific (often SOC specific) bus numbers,
+ * and board-specific addressing for SPI devices combines those numbers
+ * with chip select numbers.  Since SPI does not directly support dynamic
+ * device identification, boards need configuration tables telling which
+ * chip is at which address.
+ *
+ * This must be called from context that can sleep.  It returns zero on
+ * success, else a negative error code (dropping the master's refcount).
+ * After a successful return, the caller is responsible for calling
+ * spi_unregister_master().
+ */
+int spi_register_master(struct spi_master *master)
+{
+	int ret;
+
+	ret = spi_prepare_master(master);
+	if (ret)
+		return ret;
+	spi_finalize_master(master);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_register_master);
 
-- 
1.7.8


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
