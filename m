From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V2] spi: core: Fix deadlock when sending messages
Date: Tue, 8 Mar 2016 12:28:20 +0000
Message-ID: <1457440100-31546-1-git-send-email-jonathanh@nvidia.com>
References: <1457430543-15179-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <vigneshr-l0cyMroinI0@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457430543-15179-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The function __spi_pump_messages() is called by spi_pump_messages() and
__spi_sync(). The function __spi_sync() has an argument 'bus_locked'
that indicates if it is called with the SPI bus mutex held or not. If
'bus_locked' is false then __spi_sync() will acquire the mutex itself.

Commit 556351f14e74 ("spi: introduce accelerated read support for spi
flash devices") made a change to acquire the SPI bus mutex within
__spi_pump_messages(). However, this change did not check to see if the
mutex is already held. If __spi_sync() is called with the mutex held
(ie. 'bus_locked' is true), then a deadlock occurs when
__spi_pump_messages() is called.

Fix this deadlock by passing the 'bus_locked' state from __spi_sync() to
__spi_pump_messages() and only acquire the mutex if not already held. In
the case where __spi_pump_messages() is called from spi_pump_messages()
it is assumed that the mutex is not held and so call
__spi_pump_messages() with 'bus_locked' set to false. Finally, move the
unlocking of the mutex to the end of the __spi_pump_messages() function
to simplify the code and only call cond_resched() if there are no
errors.

Fixes: 556351f14e74 ("spi: introduce accelerated read support for spi flash devices")

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---

Changes v1-v2:
- Updated kernel-doc for new parameter added to __spi_pump_messages()

 drivers/spi/spi.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index fe0196328aa0..78b7e899ce76 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1053,6 +1053,7 @@ EXPORT_SYMBOL_GPL(spi_finalize_current_transfer);
  * __spi_pump_messages - function which processes spi message queue
  * @master: master to process queue for
  * @in_kthread: true if we are in the context of the message pump thread
+ * @bus_locked: true if the bus mutex is held when calling this function
  *
  * This function checks if there is any spi message in the queue that
  * needs processing and if so call out to the driver to initialize hardware
@@ -1062,7 +1063,8 @@ EXPORT_SYMBOL_GPL(spi_finalize_current_transfer);
  * inside spi_sync(); the queue extraction handling at the top of the
  * function should deal with this safely.
  */
-static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
+static void __spi_pump_messages(struct spi_master *master, bool in_kthread,
+				bool bus_locked)
 {
 	unsigned long flags;
 	bool was_busy = false;
@@ -1158,7 +1160,9 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
 		}
 	}
 
-	mutex_lock(&master->bus_lock_mutex);
+	if (!bus_locked)
+		mutex_lock(&master->bus_lock_mutex);
+
 	trace_spi_message_start(master->cur_msg);
 
 	if (master->prepare_message) {
@@ -1168,8 +1172,7 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
 				"failed to prepare message: %d\n", ret);
 			master->cur_msg->status = ret;
 			spi_finalize_current_message(master);
-			mutex_unlock(&master->bus_lock_mutex);
-			return;
+			goto out;
 		}
 		master->cur_msg_prepared = true;
 	}
@@ -1178,21 +1181,23 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
 	if (ret) {
 		master->cur_msg->status = ret;
 		spi_finalize_current_message(master);
-		mutex_unlock(&master->bus_lock_mutex);
-		return;
+		goto out;
 	}
 
 	ret = master->transfer_one_message(master, master->cur_msg);
 	if (ret) {
 		dev_err(&master->dev,
 			"failed to transfer one message from queue\n");
-		mutex_unlock(&master->bus_lock_mutex);
-		return;
+		goto out;
 	}
-	mutex_unlock(&master->bus_lock_mutex);
+
+out:
+	if (!bus_locked)
+		mutex_unlock(&master->bus_lock_mutex);
 
 	/* Prod the scheduler in case transfer_one() was busy waiting */
-	cond_resched();
+	if (!ret)
+		cond_resched();
 }
 
 /**
@@ -1204,7 +1209,7 @@ static void spi_pump_messages(struct kthread_work *work)
 	struct spi_master *master =
 		container_of(work, struct spi_master, pump_messages);
 
-	__spi_pump_messages(master, true);
+	__spi_pump_messages(master, true, false);
 }
 
 static int spi_init_queue(struct spi_master *master)
@@ -2814,7 +2819,7 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message,
 						       spi_sync_immediate);
 			SPI_STATISTICS_INCREMENT_FIELD(&spi->statistics,
 						       spi_sync_immediate);
-			__spi_pump_messages(master, false);
+			__spi_pump_messages(master, false, bus_locked);
 		}
 
 		wait_for_completion(&done);
-- 
2.1.4
