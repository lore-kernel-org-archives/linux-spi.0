From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 1/2] spi/mmc_spi: SPI bus locking API,
	using mutex
Date: Wed, 17 Feb 2010 19:17:09 +0100
Message-ID: <20100217191709.2fd1028c.eschwab@online.de>
References: <20100217191513.52392dd6.eschwab@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org,
	vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Kumar Gala
	<galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, David Brownell
	<dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100217191513.52392dd6.eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>

SPI bus locking API to allow exclusive access to the SPI bus, especially, but
not limited to, for the mmc_spi driver.

Coded according to an outline from Grant Likely; here is his
specification (accidentally swapped function names corrected):

It requires 3 things to be added to struct spi_master.
- 1 Mutex
- 1 spin lock
- 1 flag.

The mutex protects spi_sync, and provides sleeping "for free"
The spinlock protects the atomic spi_async call.
The flag is set when the lock is obtained, and checked while holding
the spinlock in spi_async().  If the flag is checked, then spi_async()
must fail immediately.

The current runtime API looks like this:
spi_async(struct spi_device*, struct spi_message*);
spi_sync(struct spi_device*, struct spi_message*);

The API needs to be extended to this:
spi_async(struct spi_device*, struct spi_message*)
spi_sync(struct spi_device*, struct spi_message*)
spi_bus_lock(struct spi_master*)  /* although struct spi_device* might
be easier */
spi_bus_unlock(struct spi_master*)
spi_async_locked(struct spi_device*, struct spi_message*)
spi_sync_locked(struct spi_device*, struct spi_message*)

Drivers can only call the last two if they already hold the spi_master_lock().

spi_bus_lock() obtains the mutex, obtains the spin lock, sets the
flag, and releases the spin lock before returning.  It doesn't even
need to sleep while waiting for "in-flight" spi_transactions to
complete because its purpose is to guarantee no additional
transactions are added.  It does not guarantee that the bus is idle.

spi_bus_unlock() clears the flag and releases the mutex, which will
wake up any waiters.

The difference between spi_async() and spi_async_locked() is that the
locked version bypasses the check of the lock flag.  Both versions
need to obtain the spinlock.

The difference between spi_sync() and spi_sync_locked() is that
spi_sync() must hold the mutex while enqueuing a new transfer.
spi_sync_locked() doesn't because the mutex is already held.  Note
however that spi_sync must *not* continue to hold the mutex while
waiting for the transfer to complete, otherwise only one transfer
could be queued up at a time!

Almost no code needs to be written.  The current spi_async() and
spi_sync() can probably be renamed to __spi_async() and __spi_sync()
so that spi_async(), spi_sync(), spi_async_locked() and
spi_sync_locked() can just become wrappers around the common code.

spi_sync() is protected by a mutex because it can sleep
spi_async() needs to be protected with a flag and a spinlock because
it can be called atomically and must not sleep

Signed-off-by: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
---
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -524,6 +524,10 @@ int spi_register_master(struct spi_master *master)
 		dynamic = 1;
 	}
 
+	spin_lock_init(&master->bus_lock_spinlock);
+	mutex_init(&master->bus_lock_mutex);
+	master->bus_lock_chipselect = SPI_MASTER_BUS_UNLOCKED;
+
 	/* register the device, then userspace will see it.
 	 * registration fails if the bus ID is in use.
 	 */
@@ -692,7 +696,7 @@ EXPORT_SYMBOL_GPL(spi_setup);
  * (This rule applies equally to all the synchronous transfer calls,
  * which are wrappers around this core asynchronous primitive.)
  */
-int spi_async(struct spi_device *spi, struct spi_message *message)
+static int __spi_async(struct spi_device *spi, struct spi_message *message)
 {
 	struct spi_master *master = spi->master;
 
@@ -720,7 +724,6 @@ int spi_async(struct spi_device *spi, struct spi_message *message)
 	message->status = -EINPROGRESS;
 	return master->transfer(spi, message);
 }
-EXPORT_SYMBOL_GPL(spi_async);
 
 
 /*-------------------------------------------------------------------------*/
@@ -756,14 +759,50 @@ static void spi_complete(void *arg)
  *
  * It returns zero on success, else a negative error code.
  */
+
+int spi_sync_locked(struct spi_device *spi, struct spi_message *message)
+{
+	DECLARE_COMPLETION_ONSTACK(done);
+	int status;
+	struct spi_master *master = spi->master;
+
+	message->complete = spi_complete;
+	message->context = &done;
+
+	spin_lock(&master->bus_lock_spinlock);
+
+	status = __spi_async(spi, message);
+
+	spin_unlock(&master->bus_lock_spinlock);
+
+	if (status == 0) {
+		wait_for_completion(&done);
+		status = message->status;
+	}
+
+	message->context = NULL;
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(spi_sync_locked);
+
 int spi_sync(struct spi_device *spi, struct spi_message *message)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 	int status;
+	struct spi_master *master = spi->master;
 
 	message->complete = spi_complete;
 	message->context = &done;
-	status = spi_async(spi, message);
+
+	mutex_lock(&master->bus_lock_mutex);
+
+	spin_lock(&master->bus_lock_spinlock);
+	status = __spi_async(spi, message);
+	spin_unlock(&master->bus_lock_spinlock);
+
+	mutex_unlock(&master->bus_lock_mutex);
+
 	if (status == 0) {
 		wait_for_completion(&done);
 		status = message->status;
@@ -773,6 +812,82 @@ int spi_sync(struct spi_device *spi, struct spi_message *message)
 }
 EXPORT_SYMBOL_GPL(spi_sync);
 
+int spi_async(struct spi_device *spi, struct spi_message *message)
+{
+	struct spi_master *master = spi->master;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&master->bus_lock_spinlock, flags);
+
+	if (master->bus_lock_chipselect == SPI_MASTER_BUS_UNLOCKED
+	 || master->bus_lock_chipselect == spi->chip_select) {
+		ret = __spi_async(spi, message);
+	} else {
+		/* REVISIT:
+		 * if the bus is locked to an other device, message transfer
+		 * fails. Maybe messages should be queued in the SPI layer
+		 * and be transmitted after the lock is released.
+		 */
+		ret = -EBUSY;
+	}
+
+	spin_unlock_irqrestore(&master->bus_lock_spinlock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_async);
+
+int spi_async_locked(struct spi_device *spi, struct spi_message *message)
+{
+	struct spi_master *master = spi->master;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&master->bus_lock_spinlock, flags);
+
+	if (master->bus_lock_chipselect == spi->chip_select) {
+		ret = __spi_async(spi, message);
+	} else {
+		/* API error: the SPI bus lock is not held by the caller */
+		ret = -EINVAL;
+	}
+
+	spin_unlock_irqrestore(&master->bus_lock_spinlock, flags);
+
+	return ret;
+
+}
+EXPORT_SYMBOL_GPL(spi_async_locked);
+
+int spi_bus_lock(struct spi_device *spi)
+{
+	struct spi_master *master = spi->master;
+
+	spin_lock(&master->bus_lock_spinlock);
+	mutex_lock(&master->bus_lock_mutex);
+	master->bus_lock_chipselect = spi->chip_select;
+	spin_unlock(&master->bus_lock_spinlock);
+
+	/* mutex remains locked until spi_bus_unlock is called */
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_bus_lock);
+
+int spi_bus_unlock(struct spi_device *spi)
+{
+	struct spi_master	*master = spi->master;
+
+	spin_lock(&master->bus_lock_spinlock);
+	mutex_unlock(&master->bus_lock_mutex);
+	master->bus_lock_chipselect = SPI_MASTER_BUS_UNLOCKED;
+	spin_unlock(&master->bus_lock_spinlock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_bus_unlock);
+
 /* portable code must never pass more than 32 bytes */
 #define	SPI_BUFSIZ	max(32,SMP_CACHE_BYTES)
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -261,6 +261,14 @@ struct spi_master {
 #define SPI_MASTER_NO_RX	BIT(1)		/* can't do buffer read */
 #define SPI_MASTER_NO_TX	BIT(2)		/* can't do buffer write */
 
+	/* lock and mutex for SPI bus locking */
+	spinlock_t		bus_lock_spinlock;
+	struct mutex		bus_lock_mutex;
+
+	/* chipselect of the spi device that locked the bus for exclusive use */
+	u8			bus_lock_chipselect;
+#define SPI_MASTER_BUS_UNLOCKED 0xFF		/* value to indicate unlocked */
+
 	/* Setup mode and clock, etc (spi driver may call many times).
 	 *
 	 * IMPORTANT:  this may be called when transfers to another
@@ -541,6 +549,8 @@ static inline void spi_message_free(struct spi_message *m)
 
 extern int spi_setup(struct spi_device *spi);
 extern int spi_async(struct spi_device *spi, struct spi_message *message);
+extern int
+spi_async_locked(struct spi_device *spi, struct spi_message *message);
 
 /*---------------------------------------------------------------------------*/
 
@@ -550,6 +560,9 @@ extern int spi_async(struct spi_device *spi, struct spi_message *message);
  */
 
 extern int spi_sync(struct spi_device *spi, struct spi_message *message);
+extern int spi_sync_locked(struct spi_device *spi, struct spi_message *message);
+extern int spi_bus_lock(struct spi_device *spi);
+extern int spi_bus_unlock(struct spi_device *spi);
 
 /**
  * spi_write - SPI synchronous write



------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
