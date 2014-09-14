From: Jeff Epler <jepler-ixP+gI44yfQ4d9/VWYMlNA@public.gmane.org>
Subject: [RFC 1/4] spi: reenable sync SPI transfers
Date: Sun, 14 Sep 2014 09:45:05 -0500
Message-ID: <1410705908-20847-2-git-send-email-jepler@unpythonic.net>
References: <1410705908-20847-1-git-send-email-jepler@unpythonic.net>
To: linux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410705908-20847-1-git-send-email-jepler-ixP+gI44yfQ4d9/VWYMlNA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

one source of excess latency in hm2_spi / hal_spidev is latency due
to async transfers.  Make the __spi_sync primitive actually synchronous,
rather than building on an asynchronous primitive.
---
 drivers/spi/spi.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 19ee901..55404b5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -664,10 +664,18 @@ void spi_finalize_current_message(struct spi_master *master)
 	struct spi_message *mesg;
 	unsigned long flags;
 
+        if(!master->cur_msg)
+                return;
+
 	spin_lock_irqsave(&master->queue_lock, flags);
 	mesg = master->cur_msg;
 	master->cur_msg = NULL;
 
+        if(!mesg) {
+                spin_unlock_irqrestore(&master->queue_lock, flags);
+                return;
+        }
+
 	queue_kthread_work(&master->kworker, &master->pump_messages);
 	spin_unlock_irqrestore(&master->queue_lock, flags);
 
@@ -1490,24 +1498,26 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message,
 		      int bus_locked)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
-	int status;
+	int status = 0;
 	struct spi_master *master = spi->master;
 
 	message->complete = spi_complete;
 	message->context = &done;
+	message->spi = spi;
 
 	if (!bus_locked)
 		mutex_lock(&master->bus_lock_mutex);
 
-	status = spi_async_locked(spi, message);
+        if(master->prepare_transfer_hardware)
+            status = master->prepare_transfer_hardware(master);
+        if(status >= 0)
+            status = master->transfer_one_message(master, message);
+        if(status >= 0 && master->unprepare_transfer_hardware)
+            status = master->unprepare_transfer_hardware(master);
 
 	if (!bus_locked)
 		mutex_unlock(&master->bus_lock_mutex);
 
-	if (status == 0) {
-		wait_for_completion(&done);
-		status = message->status;
-	}
 	message->context = NULL;
 	return status;
 }
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
