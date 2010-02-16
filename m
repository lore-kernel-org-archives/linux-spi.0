From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 1/5] spi: spi_lock_bus and spi_unlock_bus
Date: Tue, 16 Feb 2010 20:57:20 +0100
Message-ID: <20100216205720.ebe949a1.eschwab@online.de>
References: <20100216204450.e043eed8.eschwab@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Kumar Gala
	<galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, David Brownell
	<dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100216204450.e043eed8.eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
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

For some MMC cards over SPI bus, it needs to lock the SPI bus for its own
use.  The SPI transfer must not be interrupted by other SPI devices that
share the SPI bus with SPI MMC card.

This patch introduces 2 APIs for SPI bus locking operation.

Signed-off-by: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
Andrew: we've posted these in the past with no response.  could you pick
        them up please ?
 drivers/spi/spi.c       |   48 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |    7 ++++++
 2 files changed, 55 insertions(+), 0 deletions(-)
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 70845cc..b82b8ad 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -653,6 +653,54 @@ static void spi_complete(void *arg)
 }
 
 /**
+ * spi_lock_bus - lock SPI bus for exclusive access
+ * @spi: device which want to lock the bus
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
+ * @spi: device which want to unlock the bus
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
index c47c4b4..c53292c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -214,6 +214,8 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	the device whose settings are being modified.
  * @transfer: adds a message to the controller's transfer queue.
  * @cleanup: frees controller-specific state
+ * @lock_bus: lock SPI bus for exclusive access
+ * @unlock_bus: unlock SPI bus so other devices can access
  *
  * Each SPI master controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -286,6 +288,9 @@ struct spi_master {
 
 	/* called on release() to free memory provided by spi_master */
 	void			(*cleanup)(struct spi_device *spi);
+
+	int			(*lock_bus)(struct spi_device *spi);
+	int			(*unlock_bus)(struct spi_device *spi);
 };
 
 static inline void *spi_master_get_devdata(struct spi_master *master)
@@ -578,6 +583,8 @@ spi_async(struct spi_device *spi, struct spi_message *message)
  */
 
 extern int spi_sync(struct spi_device *spi, struct spi_message *message);
+extern int spi_lock_bus(struct spi_device *spi);
+extern int spi_unlock_bus(struct spi_device *spi);
 
 /**
  * spi_write - SPI synchronous write

  



------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
