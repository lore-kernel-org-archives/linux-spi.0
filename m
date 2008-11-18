From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] Blackfin SPI Driver: implement
	spi_lock_bus(), spi_unlock_bus() in blackfin spi controller driver.
Date: Tue, 18 Nov 2008 15:57:47 +0800
Message-ID: <1226995067-4484-3-git-send-email-cooloney@kernel.org>
References: <1226995067-4484-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1226995067-4484-1-git-send-email-cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   81 +++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 0e3102a..28dd0fe 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -45,6 +45,8 @@ MODULE_LICENSE("GPL");
 #define QUEUE_RUNNING	0
 #define QUEUE_STOPPED	1
 
+#define BFIN_SPI_LOCK 1
+
 struct driver_data {
 	/* Driver model hookup */
 	struct platform_device *pdev;
@@ -68,7 +70,10 @@ struct driver_data {
 	struct list_head queue;
 	int busy;
 	int run;
-
+#ifdef BFIN_SPI_LOCK
+	/* SPI bus is lock by a slave for exclusive access */
+	int locked;
+#endif
 	/* Message Transfer pump */
 	struct tasklet_struct pump_transfers;
 
@@ -932,6 +937,10 @@ static void pump_messages(struct work_struct *work)
 {
 	struct driver_data *drv_data;
 	unsigned long flags;
+#ifdef BFIN_SPI_LOCK
+	int locked_cs = -1;
+	struct spi_message *next_msg = NULL, *msg = NULL;
+#endif
 
 	drv_data = container_of(work, struct driver_data, pump_messages);
 
@@ -950,10 +959,35 @@ static void pump_messages(struct work_struct *work)
 		return;
 	}
 
+#ifdef BFIN_SPI_LOCK
+	/* Extract head of queue */
+	next_msg = list_entry(drv_data->queue.next,
+		struct spi_message, queue);
+
+	if (drv_data->locked)
+		locked_cs = drv_data->locked;
+
+	/* Someone has locked the bus */
+	if (drv_data->locked && next_msg->spi->chip_select != locked_cs) {
+		list_for_each_entry(msg, &drv_data->queue, queue) {
+			if (msg->spi->chip_select == locked_cs) {
+				next_msg = msg;
+				break;
+			}
+		}
+		/* Do nothing even if there are messages for other devices */
+		if (next_msg->spi->chip_select != locked_cs) {
+			drv_data->busy = 0;
+			spin_unlock_irqrestore(&drv_data->lock, flags);
+			return;
+		}
+	}
+	drv_data->cur_msg = next_msg;
+#else
 	/* Extract head of queue */
 	drv_data->cur_msg = list_entry(drv_data->queue.next,
-				       struct spi_message, queue);
-
+		struct spi_message, queue);
+#endif
 	/* Setup the SSP using the per chip configuration */
 	drv_data->cur_chip = spi_get_ctldata(drv_data->cur_msg->spi);
 	restore_state(drv_data);
@@ -982,6 +1016,39 @@ static void pump_messages(struct work_struct *work)
 }
 
 /*
+ * lock the spi bus for exclusive access
+ */
+static int lock_bus(struct spi_device *spi)
+{
+#ifdef BFIN_SPI_LOCK
+	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
+	unsigned long flags;
+
+	spin_lock_irqsave(&drv_data->lock, flags);
+	if (drv_data->locked) {
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+		return -ENOLCK;
+	}
+	drv_data->locked = spi->chip_select;
+	spin_unlock_irqrestore(&drv_data->lock, flags);
+#endif
+	return 0;
+}
+
+static int unlock_bus(struct spi_device *spi)
+{
+#ifdef BFIN_SPI_LOCK
+	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
+	unsigned long flags;
+
+	spin_lock_irqsave(&drv_data->lock, flags);
+	drv_data->locked = 0;
+	spin_unlock_irqrestore(&drv_data->lock, flags);
+#endif
+	return 0;
+}
+
+/*
  * got a msg to transfer, queue it in drv_data->queue.
  * And kick off message pumper
  */
@@ -1188,6 +1255,9 @@ static inline int init_queue(struct driver_data *drv_data)
 	INIT_LIST_HEAD(&drv_data->queue);
 	spin_lock_init(&drv_data->lock);
 
+#ifdef BFIN_SPI_LOCK
+	drv_data->locked = 0;
+#endif
 	drv_data->run = QUEUE_STOPPED;
 	drv_data->busy = 0;
 
@@ -1235,6 +1305,9 @@ static inline int stop_queue(struct driver_data *drv_data)
 
 	spin_lock_irqsave(&drv_data->lock, flags);
 
+#ifdef BFIN_SPI_LOCK
+	drv_data->locked = 0;
+#endif
 	/*
 	 * This is a bit lame, but is optimized for the common execution path.
 	 * A wait_queue on the drv_data->busy could be used, but then the common
@@ -1298,6 +1371,8 @@ static int __init bfin5xx_spi_probe(struct platform_device *pdev)
 	master->cleanup = cleanup;
 	master->setup = setup;
 	master->transfer = transfer;
+	master->lock_bus = lock_bus;
+	master->unlock_bus = unlock_bus;
 
 	/* Find and map our resources */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.5.6.3

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
