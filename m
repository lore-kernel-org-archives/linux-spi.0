From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch/rfc 1/2] spi: support TX-only/RX-only
Date: Thu, 2 Jul 2009 16:32:53 -0700
Message-ID: <200907021632.53938.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Support two new half-duplex SPI implementation restrictions, for links
that talk to TX-only or RX-only devices.  (Existing half-duplex flavors
support both transfer directions, just not at the same time.)

Move spi_async() into the spi.c core, and stop inlining it.  Then make
that function perform error checks and reject messages that demand more
than the underlying controller can support.

Based on a patch from Marek Szyprowski which did this only for the
bitbanged GPIO driver.

Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
Marek, please test these two to make sure they still work on
your hardware.  If they do, I'll send them on...

 drivers/spi/spi.c       |   57 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |   39 ++-----------------------------
 2 files changed, 60 insertions(+), 36 deletions(-)

--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -639,6 +639,63 @@ int spi_setup(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_setup);
 
+/**
+ * spi_async - asynchronous SPI transfer
+ * @spi: device with which data will be exchanged
+ * @message: describes the data transfers, including completion callback
+ * Context: any (irqs may be blocked, etc)
+ *
+ * This call may be used in_irq and other contexts which can't sleep,
+ * as well as from task contexts which can sleep.
+ *
+ * The completion callback is invoked in a context which can't sleep.
+ * Before that invocation, the value of message->status is undefined.
+ * When the callback is issued, message->status holds either zero (to
+ * indicate complete success) or a negative error code.  After that
+ * callback returns, the driver which issued the transfer request may
+ * deallocate the associated memory; it's no longer in use by any SPI
+ * core or controller driver code.
+ *
+ * Note that although all messages to a spi_device are handled in
+ * FIFO order, messages may go to different devices in other orders.
+ * Some device might be higher priority, or have various "hard" access
+ * time requirements, for example.
+ *
+ * On detection of any fault during the transfer, processing of
+ * the entire message is aborted, and the device is deselected.
+ * Until returning from the associated message completion callback,
+ * no other spi_message queued to that device will be processed.
+ * (This rule applies equally to all the synchronous transfer calls,
+ * which are wrappers around this core asynchronous primitive.)
+ */
+int spi_async(struct spi_device *spi, struct spi_message *message)
+{
+	struct spi_master *master = spi->master;
+
+	/* Half-duplex links include original MicroWire, and ones with
+	 * only one data pin like SPI_3WIRE (switches direction) or
+	 * where the MOSI or MISO signal is missing.
+	 */
+	if ((master->flags & SPI_MASTER_HALF_DUPLEX)
+			|| (spi->mode & SPI_3WIRE)) {
+		struct spi_transfer *xfer;
+		unsigned flags = master->flags;
+
+		list_for_each_entry(xfer, &message->transfers, transfer_list) {
+			if (xfer->rx_buf && xfer->tx_buf)
+				return -EINVAL;
+			if ((flags & SPI_MASTER_NO_TX) && xfer->tx_buf)
+				return -EINVAL;
+			if ((flags & SPI_MASTER_NO_RX) && xfer->rx_buf)
+				return -EINVAL;
+		}
+	}
+
+	message->spi = spi;
+	return master->transfer(spi, message);
+}
+EXPORT_SYMBOL_GPL(spi_async);
+
 
 /*-------------------------------------------------------------------------*/
 
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -253,6 +253,8 @@ struct spi_master {
 	/* other constraints relevant to this driver */
 	u16			flags;
 #define SPI_MASTER_HALF_DUPLEX	BIT(0)		/* can't do full duplex */
+#define SPI_MASTER_NO_RX	BIT(1)		/* can't do buffer read */
+#define SPI_MASTER_NO_TX	BIT(2)		/* can't do buffer write */
 
 	/* Setup mode and clock, etc (spi driver may call many times).
 	 *
@@ -533,42 +535,7 @@ static inline void spi_message_free(stru
 }
 
 extern int spi_setup(struct spi_device *spi);
-
-/**
- * spi_async - asynchronous SPI transfer
- * @spi: device with which data will be exchanged
- * @message: describes the data transfers, including completion callback
- * Context: any (irqs may be blocked, etc)
- *
- * This call may be used in_irq and other contexts which can't sleep,
- * as well as from task contexts which can sleep.
- *
- * The completion callback is invoked in a context which can't sleep.
- * Before that invocation, the value of message->status is undefined.
- * When the callback is issued, message->status holds either zero (to
- * indicate complete success) or a negative error code.  After that
- * callback returns, the driver which issued the transfer request may
- * deallocate the associated memory; it's no longer in use by any SPI
- * core or controller driver code.
- *
- * Note that although all messages to a spi_device are handled in
- * FIFO order, messages may go to different devices in other orders.
- * Some device might be higher priority, or have various "hard" access
- * time requirements, for example.
- *
- * On detection of any fault during the transfer, processing of
- * the entire message is aborted, and the device is deselected.
- * Until returning from the associated message completion callback,
- * no other spi_message queued to that device will be processed.
- * (This rule applies equally to all the synchronous transfer calls,
- * which are wrappers around this core asynchronous primitive.)
- */
-static inline int
-spi_async(struct spi_device *spi, struct spi_message *message)
-{
-	message->spi = spi;
-	return spi->master->transfer(spi, message);
-}
+extern int spi_async(struct spi_device *spi, struct spi_message *message);
 
 /*---------------------------------------------------------------------------*/
 

------------------------------------------------------------------------------
