From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/4] spi: Pump transfers inside calling context for spi_sync()
Date: Thu, 11 Dec 2014 12:26:41 +0000
Message-ID: <1418300802-3803-3-git-send-email-broonie@kernel.org>
References: <1418300802-3803-1-git-send-email-broonie@kernel.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418300802-3803-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If we are using the standard SPI message pump (which all drivers should be
transitioning over to) then special case the message enqueue and instead of
starting the worker thread to push messages to the hardware do so in the
context of the caller if the controller is idle. This avoids a context
switch in the common case where the controller has a single user in a
single thread, for short PIO transfers there may be no need to context
switch away from the calling context to complete the transfer.

The code is a bit more complex than is desirable in part due to the need
to handle drivers not using the standard queue and in part due to handling
the various combinations of bus locking and asynchronous submission in
interrupt context.

It is still suboptimal since it will still wake the message pump for each
transfer in order to schedule idling of the hardware and if multiple
contexts are using the controller simultaneously a caller may end up
pumping a message for some random other thread rather than for itself,
and if the thread ends up deferring due to another context idling the
hardware then it will just busy wait.  It can, however, have the benefit
of aggregating power up and down of the hardware when a caller performs
a series of transfers back to back without any need for the use of
spi_async().

Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c       | 66 +++++++++++++++++++++++++++++++++++++++++++------
 include/linux/spi/spi.h |  2 ++
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0bc752d17be5..e1bf2579b9c0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -882,6 +882,9 @@ EXPORT_SYMBOL_GPL(spi_finalize_current_transfer);
  * needs processing and if so call out to the driver to initialize hardware
  * and transfer each message.
  *
+ * Note that it is called both from the kthread itself and also from
+ * inside spi_sync(); the queue extraction handling at the top of the
+ * function should deal with this safely.
  */
 static void spi_pump_messages(struct kthread_work *work)
 {
@@ -900,6 +903,13 @@ static void spi_pump_messages(struct kthread_work *work)
 		return;
 	}
 
+	/* If another context is idling the device then defer */
+	if (master->idling) {
+		queue_kthread_work(&master->kworker, &master->pump_messages);
+		spin_unlock_irqrestore(&master->queue_lock, flags);
+		return;
+	}
+
 	/* Check if the queue is idle */
 	if (list_empty(&master->queue) || !master->running) {
 		if (!master->busy) {
@@ -907,7 +917,9 @@ static void spi_pump_messages(struct kthread_work *work)
 			return;
 		}
 		master->busy = false;
+		master->idling = true;
 		spin_unlock_irqrestore(&master->queue_lock, flags);
+
 		kfree(master->dummy_rx);
 		master->dummy_rx = NULL;
 		kfree(master->dummy_tx);
@@ -921,6 +933,10 @@ static void spi_pump_messages(struct kthread_work *work)
 			pm_runtime_put_autosuspend(master->dev.parent);
 		}
 		trace_spi_master_idle(master);
+
+		spin_lock_irqsave(&master->queue_lock, flags);
+		master->idling = false;
+		spin_unlock_irqrestore(&master->queue_lock, flags);
 		return;
 	}
 
@@ -1161,12 +1177,9 @@ static int spi_destroy_queue(struct spi_master *master)
 	return 0;
 }
 
-/**
- * spi_queued_transfer - transfer function for queued transfers
- * @spi: spi device which is requesting transfer
- * @msg: spi message which is to handled is queued to driver queue
- */
-static int spi_queued_transfer(struct spi_device *spi, struct spi_message *msg)
+static int __spi_queued_transfer(struct spi_device *spi,
+				 struct spi_message *msg,
+				 bool need_pump)
 {
 	struct spi_master *master = spi->master;
 	unsigned long flags;
@@ -1181,13 +1194,23 @@ static int spi_queued_transfer(struct spi_device *spi, struct spi_message *msg)
 	msg->status = -EINPROGRESS;
 
 	list_add_tail(&msg->queue, &master->queue);
-	if (!master->busy)
+	if (!master->busy && need_pump)
 		queue_kthread_work(&master->kworker, &master->pump_messages);
 
 	spin_unlock_irqrestore(&master->queue_lock, flags);
 	return 0;
 }
 
+/**
+ * spi_queued_transfer - transfer function for queued transfers
+ * @spi: spi device which is requesting transfer
+ * @msg: spi message which is to handled is queued to driver queue
+ */
+static int spi_queued_transfer(struct spi_device *spi, struct spi_message *msg)
+{
+	return __spi_queued_transfer(spi, msg, true);
+}
+
 static int spi_master_initialize_queue(struct spi_master *master)
 {
 	int ret;
@@ -2102,19 +2125,46 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message,
 	DECLARE_COMPLETION_ONSTACK(done);
 	int status;
 	struct spi_master *master = spi->master;
+	unsigned long flags;
+
+	status = __spi_validate(spi, message);
+	if (status != 0)
+		return status;
 
 	message->complete = spi_complete;
 	message->context = &done;
+	message->spi = spi;
 
 	if (!bus_locked)
 		mutex_lock(&master->bus_lock_mutex);
 
-	status = spi_async_locked(spi, message);
+	/* If we're not using the legacy transfer method then we will
+	 * try to transfer in the calling context so special case.
+	 * This code would be less tricky if we could remove the
+	 * support for driver implemented message queues.
+	 */
+	if (master->transfer == spi_queued_transfer) {
+		spin_lock_irqsave(&master->bus_lock_spinlock, flags);
+
+		trace_spi_message_submit(message);
+
+		status = __spi_queued_transfer(spi, message, false);
+
+		spin_unlock_irqrestore(&master->bus_lock_spinlock, flags);
+	} else {
+		status = spi_async_locked(spi, message);
+	}
 
 	if (!bus_locked)
 		mutex_unlock(&master->bus_lock_mutex);
 
 	if (status == 0) {
+		/* Push out the messages in the calling context if we
+		 * can.
+		 */
+		if (master->transfer == spi_queued_transfer)
+			spi_pump_messages(&master->pump_messages);
+
 		wait_for_completion(&done);
 		status = message->status;
 	}
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a6ef2a8e6de4..4e6db75e9469 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -260,6 +260,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @pump_messages: work struct for scheduling work to the message pump
  * @queue_lock: spinlock to syncronise access to message queue
  * @queue: message queue
+ * @idling: the device is entering idle state
  * @cur_msg: the currently in-flight message
  * @cur_msg_prepared: spi_prepare_message was called for the currently
  *                    in-flight message
@@ -425,6 +426,7 @@ struct spi_master {
 	spinlock_t			queue_lock;
 	struct list_head		queue;
 	struct spi_message		*cur_msg;
+	bool				idling;
 	bool				busy;
 	bool				running;
 	bool				rt;
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
