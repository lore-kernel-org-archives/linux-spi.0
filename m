From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.23-rc1] spi device setup gets better
	error checking
Date: Tue, 24 Jul 2007 14:19:33 -0700
Message-ID: <200707241419.33987.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This updates some error reporting paths in SPI device setup:

 - Move validation logic for SPI chipselects to spi_new_device(),
   which is where it should always have been.

 - In spi_new_device(), emit error messages if the device can't
   be created.  This is LOTS better than a silent failure; though
   eventually, the calling convention should probably change to
   use the <linux/err.h> conventions.

 - Includes one previously-missing check:  SPI masters must always
   have at least one chipselect, even for dedicated busses which
   always keep it selected!

It also adds a FIXME (IDR for dynamic ID allocation) so the issue
doesn't live purely in my mailbox.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi.c |   45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

--- g26.orig/drivers/spi/spi.c	2007-07-24 14:02:26.000000000 -0700
+++ g26/drivers/spi/spi.c	2007-07-24 14:04:28.000000000 -0700
@@ -200,6 +200,8 @@ static DEFINE_MUTEX(board_lock);
  * platforms may not be able to use spi_register_board_info though, and
  * this is exported so that for example a USB or parport based adapter
  * driver could add devices (which it would learn about out-of-band).
+ *
+ * Returns the new device, or NULL.
  */
 struct spi_device *spi_new_device(struct spi_master *master,
 				  struct spi_board_info *chip)
@@ -208,7 +210,20 @@ struct spi_device *spi_new_device(struct
 	struct device		*dev = master->cdev.dev;
 	int			status;
 
-	/* NOTE:  caller did any chip->bus_num checks necessary */
+	/* NOTE:  caller did any chip->bus_num checks necessary.
+	 *
+	 * Also, unless we change the return value convention to use
+	 * error-or-pointer (not NULL-or-pointer), troubleshootability
+	 * suggests syslogged diagnostics are best here (ugh).
+	 */
+
+	/* Chipselects are numbered 0..max; validate. */
+	if (chip->chip_select >= master->num_chipselect) {
+		dev_err(dev, "cs%d > max %d\n",
+			chip->chip_select,
+			master->num_chipselect);
+		return NULL;
+	}
 
 	if (!spi_master_get(master))
 		return NULL;
@@ -236,10 +251,10 @@ struct spi_device *spi_new_device(struct
 	proxy->controller_state = NULL;
 	proxy->dev.release = spidev_release;
 
-	/* drivers may modify this default i/o setup */
+	/* drivers may modify this initial i/o setup */
 	status = master->setup(proxy);
 	if (status < 0) {
-		dev_dbg(dev, "can't %s %s, status %d\n",
+		dev_err(dev, "can't %s %s, status %d\n",
 				"setup", proxy->dev.bus_id, status);
 		goto fail;
 	}
@@ -249,7 +264,7 @@ struct spi_device *spi_new_device(struct
 	 */
 	status = device_register(&proxy->dev);
 	if (status < 0) {
-		dev_dbg(dev, "can't %s %s, status %d\n",
+		dev_err(dev, "can't %s %s, status %d\n",
 				"add", proxy->dev.bus_id, status);
 		goto fail;
 	}
@@ -306,7 +321,6 @@ spi_register_board_info(struct spi_board
 static void scan_boardinfo(struct spi_master *master)
 {
 	struct boardinfo	*bi;
-	struct device		*dev = master->cdev.dev;
 
 	mutex_lock(&board_lock);
 	list_for_each_entry(bi, &board_list, list) {
@@ -316,17 +330,9 @@ static void scan_boardinfo(struct spi_ma
 		for (n = bi->n_board_info; n > 0; n--, chip++) {
 			if (chip->bus_num != master->bus_num)
 				continue;
-			/* some controllers only have one chip, so they
-			 * might not use chipselects.  otherwise, the
-			 * chipselects are numbered 0..max.
+			/* NOTE: this relies on spi_new_device to
+			 * issue diagnostics when given bogus inputs
 			 */
-			if (chip->chip_select >= master->num_chipselect
-					&& master->num_chipselect) {
-				dev_dbg(dev, "cs%d > max %d\n",
-					chip->chip_select,
-					master->num_chipselect);
-				continue;
-			}
 			(void) spi_new_device(master, chip);
 		}
 	}
@@ -419,8 +425,17 @@ int spi_register_master(struct spi_maste
 	if (!dev)
 		return -ENODEV;
 
+	/* even if it's just one always-selected device, there must
+	 * be at least one chipselect
+	 */
+	if (master->num_chipselect == 0)
+		return -EINVAL;
+
 	/* convention:  dynamically assigned bus IDs count down from the max */
 	if (master->bus_num < 0) {
+		/* FIXME switch to an IDR based scheme, something like
+		 * I2C now uses, so we can't run out of "dynamic" IDs
+		 */
 		master->bus_num = atomic_dec_return(&dyn_bus_id);
 		dynamic = 1;
 	}

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
