From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/4] spi: Only idle the message pump in the worker kthread
Date: Thu, 11 Dec 2014 12:26:42 +0000
Message-ID: <1418300802-3803-4-git-send-email-broonie@kernel.org>
References: <1418300802-3803-1-git-send-email-broonie@kernel.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418300802-3803-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In order to avoid the situation where the kthread is waiting for another
context to make the hardware idle let the message pump know if it's being
called from the worker thread context and if it isn't then defer to the
worker thread instead of idling the hardware immediately. This will ensure
that if this situation happens we block rather than busy waiting.

Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e1bf2579b9c0..3ac188fc36f5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -875,8 +875,9 @@ void spi_finalize_current_transfer(struct spi_master *master)
 EXPORT_SYMBOL_GPL(spi_finalize_current_transfer);
 
 /**
- * spi_pump_messages - kthread work function which processes spi message queue
- * @work: pointer to kthread work struct contained in the master struct
+ * __spi_pump_messages - function which processes spi message queue
+ * @master: master to process queue for
+ * @in_kthread: true if we are in the context of the message pump thread
  *
  * This function checks if there is any spi message in the queue that
  * needs processing and if so call out to the driver to initialize hardware
@@ -886,10 +887,8 @@ EXPORT_SYMBOL_GPL(spi_finalize_current_transfer);
  * inside spi_sync(); the queue extraction handling at the top of the
  * function should deal with this safely.
  */
-static void spi_pump_messages(struct kthread_work *work)
+static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
 {
-	struct spi_master *master =
-		container_of(work, struct spi_master, pump_messages);
 	unsigned long flags;
 	bool was_busy = false;
 	int ret;
@@ -916,6 +915,15 @@ static void spi_pump_messages(struct kthread_work *work)
 			spin_unlock_irqrestore(&master->queue_lock, flags);
 			return;
 		}
+
+		/* Only do teardown in the thread */
+		if (!in_kthread) {
+			queue_kthread_work(&master->kworker,
+					   &master->pump_messages);
+			spin_unlock_irqrestore(&master->queue_lock, flags);
+			return;
+		}
+
 		master->busy = false;
 		master->idling = true;
 		spin_unlock_irqrestore(&master->queue_lock, flags);
@@ -1004,6 +1012,18 @@ static void spi_pump_messages(struct kthread_work *work)
 	}
 }
 
+/**
+ * spi_pump_messages - kthread work function which processes spi message queue
+ * @work: pointer to kthread work struct contained in the master struct
+ */
+static void spi_pump_messages(struct kthread_work *work)
+{
+	struct spi_master *master =
+		container_of(work, struct spi_master, pump_messages);
+
+	__spi_pump_messages(master, true);
+}
+
 static int spi_init_queue(struct spi_master *master)
 {
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
@@ -2163,7 +2183,7 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message,
 		 * can.
 		 */
 		if (master->transfer == spi_queued_transfer)
-			spi_pump_messages(&master->pump_messages);
+			__spi_pump_messages(master, false);
 
 		wait_for_completion(&done);
 		status = message->status;
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
