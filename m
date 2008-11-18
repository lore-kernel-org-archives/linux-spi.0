From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] spi: Add two new APIs
	spi_lock_bus() and spi_unlock_bus() to spi framework.
Date: Tue, 18 Nov 2008 15:57:46 +0800
Message-ID: <1226995067-4484-2-git-send-email-cooloney@kernel.org>
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

For some MMC card over SPI bus, it needs to lock the SPI bus for its own
use. The SPI transfer can not be interrupted by other SPI devices
which sharing the SPI bus with SPI MMC card.

This patch introduces 2 APIs for SPI bus locking operation.

Signed-off-by: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c       |   48 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |    7 ++++++
 2 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3734dc9..03b8747 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -591,6 +591,54 @@ static void spi_complete(void *arg)
 }
 
 /**
+ * spi_lock_bus - lock SPI bus for exclusive access
+ * @@spi: device which want to lock the bus
+ * Context: any
+ *
+ * Once the caller owns exclusive access to the SPI bus,
+ * only messages for this device will be transferred.
+ * Messages for other devices are queued but not transferred until
+ * the bus owner unlock the bus.
+ *
+ * The caller may call spi_lock_bus() before spi_sync() or spi_async().
+ * So this call may be used in irq and other contexts which can't sleep,
+ * as well as from task contexts which can sleep.
+ *
+ * It returns zero on success, else a negative error code.
+ */
+int spi_lock_bus(struct spi_device *spi)
+{
+	if (spi->master->lock_bus)
+		return spi->master->lock_bus(spi);
+	else
+		return 0;
+}
+EXPORT_SYMBOL_GPL(spi_lock_bus);
+
+/**
+ * spi_unlock_bus - unlock SPI bus
+ * @@spi: device which want to unlock the bus
+ * Context: any
+ *
+ * The caller has called spi_lock_bus() to lock the bus. It calls
+ * spi_unlock_bus() to release the bus so messages for other devices
+ * can be transferred.
+ *
+ * If the caller did not call spi_lock_bus() before, spi_unlock_bus()
+ * should have no effect.
+ *
+ * It returns zero on success, else a negative error code.
+ */
+int spi_unlock_bus(struct spi_device *spi)
+{
+	if (spi->master->unlock_bus)
+		return spi->master->unlock_bus(spi);
+	else
+		return 0;
+}
+EXPORT_SYMBOL_GPL(spi_unlock_bus);
+
+/**
  * spi_sync - blocking/synchronous SPI data transfers
  * @spi: device with which data will be exchanged
  * @message: describes the data transfers
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4be01bb..c8819e3 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -209,6 +209,8 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	the device whose settings are being modified.
  * @transfer: adds a message to the controller's transfer queue.
  * @cleanup: frees controller-specific state
+ * @lock_bus: lock SPI bus for exclusive access
+ * @unlock_bus: unlock SPI bus so other devices can access
  *
  * Each SPI master controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -264,6 +266,9 @@ struct spi_master {
 
 	/* called on release() to free memory provided by spi_master */
 	void			(*cleanup)(struct spi_device *spi);
+
+	int			(*lock_bus)(struct spi_device *spi);
+	int			(*unlock_bus)(struct spi_device *spi);
 };
 
 static inline void *spi_master_get_devdata(struct spi_master *master)
@@ -579,6 +584,8 @@ spi_async(struct spi_device *spi, struct spi_message *message)
  */
 
 extern int spi_sync(struct spi_device *spi, struct spi_message *message);
+extern int spi_lock_bus(struct spi_device *spi);
+extern int spi_unlock_bus(struct spi_device *spi);
 
 /**
  * spi_write - SPI synchronous write
-- 
1.5.6.3

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
