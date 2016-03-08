From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: core: Fix deadlock when sending messages
Date: Tue, 8 Mar 2016 09:49:03 +0000
Message-ID: <1457430543-15179-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

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

This deadlock is seen on the Tegra124 Nyan Big chromebook and prevents
the board from booting -next.

 drivers/spi/spi.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index fe0196328aa0..e699fec9ddc5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1062,7 +1062,8 @@ EXPORT_SYMBOL_GPL(spi_finalize_current_transfer);
  * inside spi_sync(); the queue extraction handling at the top of the
  * function should deal with this safely.
  */
-static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
+static void __spi_pump_messages(struct spi_master *master, bool in_kthread,
+				bool bus_locked)
 {
 	unsigned long flags;
 	bool was_busy = false;
@@ -1158,7 +1159,9 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
 		}
 	}
 
-	mutex_lock(&master->bus_lock_mutex);
+	if (!bus_locked)
+		mutex_lock(&master->bus_lock_mutex);
+
 	trace_spi_message_start(master->cur_msg);
 
 	if (master->prepare_message) {
@@ -1168,8 +1171,7 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
 				"failed to prepare message: %d\n", ret);
 			master->cur_msg->status = ret;
 			spi_finalize_current_message(master);
-			mutex_unlock(&master->bus_lock_mutex);
-			return;
+			goto out;
 		}
 		master->cur_msg_prepared = true;
 	}
@@ -1178,21 +1180,23 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
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
@@ -1204,7 +1208,7 @@ static void spi_pump_messages(struct kthread_work *work)
 	struct spi_master *master =
 		container_of(work, struct spi_master, pump_messages);
 
-	__spi_pump_messages(master, true);
+	__spi_pump_messages(master, true, false);
 }
 
 static int spi_init_queue(struct spi_master *master)
@@ -2814,7 +2818,7 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message,
 						       spi_sync_immediate);
 			SPI_STATISTICS_INCREMENT_FIELD(&spi->statistics,
 						       spi_sync_immediate);
-			__spi_pump_messages(master, false);
+			__spi_pump_messages(master, false, bus_locked);
 		}
 
 		wait_for_completion(&done);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
