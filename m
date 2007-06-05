From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.22-rc4 3/7] SPI "exclusive access"
	(experimental)
Date: Mon, 4 Jun 2007 20:31:28 -0700
Message-ID: <200706042031.29315.david-b@pacbell.net>
References: <200706042025.18252.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706042025.18252.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This is a draft API and reference implementation for a new SPI protocol
tweaking option, which supports more complex protocol stacks over SPI.

Examples: MMC/SD-over-SPI, wireless network chips, and hardware tools
at the JTAG/ISP level.

  - A new SPI protocol tweaking interface, giving one driver exclusive
    access to a SPI bus for transfer sequences too complex to fit into
    one spi_message.

  - An initial implementation of that, for the "bitbang" core.  I'm
    sure someone can come up with a much better implementation for this,
    which I'd expect to feed back to improve that interface.

It behaves in light testing without contention for the bus lock.

Includes secondary queue code from Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
to make submissions to other devices act "normally"; they're executed
when the exclusion is released.

NOT YET READY for prime time.  An alternate scheme has recently been
suggested, more amenable to IRQ-driven code that needs to start and
sustain "exclusion" in contexts that can't sleep.

---
 drivers/spi/spi_bitbang.c       |   92 +++++++++++++++++++++++++++++++++++++---
 include/linux/spi/spi.h         |   58 +++++++++++++++++++++++++
 include/linux/spi/spi_bitbang.h |    3 +
 3 files changed, 148 insertions(+), 5 deletions(-)

--- g26.orig/include/linux/spi/spi.h	2007-06-04 19:57:23.000000000 -0700
+++ g26/include/linux/spi/spi.h	2007-06-04 19:57:45.000000000 -0700
@@ -182,6 +182,9 @@ static inline void spi_unregister_driver
  *	the device whose settings are being modified.
  * @transfer: adds a message to the controller's transfer queue.
  * @cleanup: frees controller-specific state
+ * @get_exclusive: Waits until the message queue is empty, then reserves
+ *	the bus for exclusive use with that devices.
+ * @put_exclusive: Reverses the effect of @get_exclusive.
  *
  * Each SPI master controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -237,6 +240,12 @@ struct spi_master {
 
 	/* called on release() to free memory provided by spi_master */
 	void			(*cleanup)(struct spi_device *spi);
+
+	/* Some protocols, like MMC or SD over SPI, need to lock a device's
+	 * chipselect for an extended period of time.
+	 */
+	int			(*get_exclusive)(struct spi_device *spi);
+	void			(*put_exclusive)(struct spi_device *spi);
 };
 
 static inline void *spi_master_get_devdata(struct spi_master *master)
@@ -538,6 +547,55 @@ spi_async(struct spi_device *spi, struct
 	return spi->master->transfer(spi, message);
 }
 
+
+#define SPI_HAS_EXCLUSIVE
+
+/**
+ * spi_get_exclusive - temporarily acquire exclusive access to a SPI bus
+ * @spi: device which will have exclusive access to the SPI bus.
+ * Context: can sleep
+ *
+ * Some SPI protocols, such as those for MMC and SD cards, involve keeping
+ * a given device's chipselect active for more complex sequences of transfers
+ * than the known-in-advance contents of one spi_message.  Drivers for such
+ * protocols should use this method and its sibling spi_put_exclusive().
+ *
+ * When spi_get_exclusive() returns success, any pending transfers on that
+ * bus will have completed, and that device's chipselect will be active.
+ * From that point until spi_put_exclusive() is called, only spi_message
+ * transfers to that device will be acted on, and the device will only be
+ * (briefly) deselected mid-message, according to by spi_transfer.cs_change.
+ *
+ * Message being sent to other devices on this bus are queued for processing
+ * after the matching put_exclusive() call.
+ *
+ * This call may only be from contexts which can sleep.  It returns zero
+ * on success, else a negative error number.
+ */
+static inline int spi_get_exclusive(struct spi_device *spi)
+{
+	if (!spi->master->get_exclusive)
+		return -EIO;
+	return spi->master->get_exclusive(spi);
+}
+
+/**
+ * spi_put_exclusive - release exclusive access to a SPI bus
+ * @spi: device which has been granted that access
+ * Context: can sleep
+ *
+ * This reverses the effect of a successful spi_get_exclusive(), and
+ * deselects the device.
+ *
+ * This call may only be from contexts which can sleep.  It is an error to
+ * call this when messages are still queued to the specified device, or
+ * from code that doesn't hold the exclusive access.
+ */
+static inline void spi_put_exclusive(struct spi_device *spi)
+{
+	spi->master->put_exclusive(spi);
+}
+
 /*---------------------------------------------------------------------------*/
 
 /* All these synchronous SPI transfer routines are utilities layered
--- g26.orig/include/linux/spi/spi_bitbang.h	2007-06-04 19:57:23.000000000 -0700
+++ g26/include/linux/spi/spi_bitbang.h	2007-06-04 19:57:45.000000000 -0700
@@ -29,6 +29,9 @@ struct spi_bitbang {
 	u8			flags;		/* extra spi->mode support */
 
 	struct spi_master	*master;
+	struct spi_device	*exclusive;
+	wait_queue_head_t	xwait;
+	struct list_head	xqueue;
 
 	/* setup_transfer() changes clock and/or wordsize to match settings
 	 * for this transfer; zeroes restore defaults from spi_device.
--- g26.orig/drivers/spi/spi_bitbang.c	2007-06-04 19:57:23.000000000 -0700
+++ g26/drivers/spi/spi_bitbang.c	2007-06-04 19:57:45.000000000 -0700
@@ -284,7 +284,6 @@ static void bitbang_work(struct work_str
 
 		m = container_of(bitbang->queue.next, struct spi_message,
 				queue);
-		list_del_init(&m->queue);
 		spin_unlock_irqrestore(&bitbang->lock, flags);
 
 		/* FIXME this is made-up ... the correct value is known to
@@ -295,7 +294,7 @@ static void bitbang_work(struct work_str
 
 		spi = m->spi;
 		tmp = 0;
-		cs_change = 1;
+		cs_change = (spi != bitbang->exclusive);
 		status = 0;
 		setup_transfer = NULL;
 
@@ -369,7 +368,6 @@ static void bitbang_work(struct work_str
 		}
 
 		m->status = status;
-		m->complete(m->context);
 
 		/* restore speed and wordsize */
 		if (setup_transfer)
@@ -377,17 +375,24 @@ static void bitbang_work(struct work_str
 
 		/* normally deactivate chipselect ... unless no error and
 		 * cs_change has hinted that the next message will probably
-		 * be for this chip too.
+		 * be for this chip too, or this device reserved the bus
 		 */
-		if (!(status == 0 && cs_change)) {
+		if (!(status == 0 && cs_change) && spi != bitbang->exclusive) {
 			ndelay(nsecs);
 			bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
 			ndelay(nsecs);
 		}
 
 		spin_lock_irqsave(&bitbang->lock, flags);
+		list_del_init(&m->queue);
+		spin_unlock_irqrestore(&bitbang->lock, flags);
+
+		m->complete(m->context);
+
+		spin_lock_irqsave(&bitbang->lock, flags);
 	}
 	bitbang->busy = 0;
+	wake_up(&bitbang->xwait);
 	spin_unlock_irqrestore(&bitbang->lock, flags);
 }
 
@@ -408,6 +413,8 @@ int spi_bitbang_transfer(struct spi_devi
 	spin_lock_irqsave(&bitbang->lock, flags);
 	if (!spi->max_speed_hz)
 		status = -ENETDOWN;
+	else if (bitbang->exclusive && bitbang->exclusive != spi)
+		list_add_tail(&m->queue, &bitbang->xqueue);
 	else {
 		list_add_tail(&m->queue, &bitbang->queue);
 		queue_work(bitbang->workqueue, &bitbang->work);
@@ -418,6 +425,75 @@ int spi_bitbang_transfer(struct spi_devi
 }
 EXPORT_SYMBOL_GPL(spi_bitbang_transfer);
 
+/*
+ * NOTE:  This current version of the exclusive access calls is not cast
+ * in stone either for interface or implementation.
+ *
+ * In particular, if it gets used very widely, it's possible that handling
+ * EBUSY returns from get_exclusive() might too annoying...
+ */
+
+static int check_empty(struct spi_bitbang *bitbang)
+{
+	unsigned long		flags;
+	int			value;
+
+	/* this "knows" that bitbang_work() leaves requests at the head
+	 * of the queue until it's done processing them.
+	 */
+	spin_lock_irqsave(&bitbang->lock, flags);
+	value = list_empty(&bitbang->queue);
+	spin_unlock_irqrestore(&bitbang->lock, flags);
+	return value;
+}
+
+static int spi_bitbang_get_exclusive(struct spi_device *spi)
+{
+	struct spi_bitbang	*bitbang;
+	int			status = 0;
+
+	bitbang = spi_master_get_devdata(spi->master);
+	might_sleep();
+
+	/* from now on, no more new messages except those to that device */
+	spin_lock_irq(&bitbang->lock);
+	if (bitbang->exclusive)
+		status = -EBUSY;		/* REVISIT better to wait! */
+	else
+		bitbang->exclusive = spi;
+	spin_unlock_irq(&bitbang->lock);
+
+	/* ... and chipselect for that device stays active */
+	if (!status) {
+		wait_event(bitbang->xwait, check_empty(bitbang));
+		bitbang->chipselect(spi, BITBANG_CS_ACTIVE);
+	}
+	return status;
+}
+
+static void spi_bitbang_put_exclusive(struct spi_device *spi)
+{
+	struct spi_bitbang	*bitbang;
+
+	bitbang = spi_master_get_devdata(spi->master);
+	might_sleep();
+
+	if (bitbang->exclusive == spi) {
+		wait_event(bitbang->xwait, check_empty(bitbang));
+		bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
+
+		spin_lock_irq(&bitbang->lock);
+		bitbang->exclusive = NULL;
+		if (!list_empty(&bitbang->xqueue)) {
+			__list_splice(&bitbang->xqueue, &bitbang->queue);
+			INIT_LIST_HEAD(&bitbang->xqueue);
+			queue_work(bitbang->workqueue, &bitbang->work);
+		}
+		spin_unlock_irq(&bitbang->lock);
+
+	}
+}
+
 /*----------------------------------------------------------------------*/
 
 /**
@@ -454,6 +530,11 @@ int spi_bitbang_start(struct spi_bitbang
 	spin_lock_init(&bitbang->lock);
 	INIT_LIST_HEAD(&bitbang->queue);
 
+	init_waitqueue_head(&bitbang->xwait);
+	INIT_LIST_HEAD(&bitbang->xqueue);
+	bitbang->master->get_exclusive = spi_bitbang_get_exclusive;
+	bitbang->master->put_exclusive = spi_bitbang_put_exclusive;
+
 	if (!bitbang->master->transfer)
 		bitbang->master->transfer = spi_bitbang_transfer;
 	if (!bitbang->txrx_bufs) {
@@ -502,6 +583,7 @@ int spi_bitbang_stop(struct spi_bitbang 
 	spi_unregister_master(bitbang->master);
 
 	WARN_ON(!list_empty(&bitbang->queue));
+	WARN_ON(!list_empty(&bitbang->xqueue));
 
 	destroy_workqueue(bitbang->workqueue);
 

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
