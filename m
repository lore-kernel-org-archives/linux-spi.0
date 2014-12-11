From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/4] spi: Check to see if the device is processing a message before we idle
Date: Thu, 11 Dec 2014 12:26:40 +0000
Message-ID: <1418300802-3803-2-git-send-email-broonie@kernel.org>
References: <1418300802-3803-1-git-send-email-broonie@kernel.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418300802-3803-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

cur_msg is updated under the queue lock and holds the message we are
currently processing. Since currently we only ever do removals in the
pump kthread it doesn't matter in what order we do things but we want
to be able to push things out from the submitting thread so pull the
check to see if we're currently handling a message before we check to
see if the queue is idle.

Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b81ccdb1bc16..0bc752d17be5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -891,8 +891,16 @@ static void spi_pump_messages(struct kthread_work *work)
 	bool was_busy = false;
 	int ret;
 
-	/* Lock queue and check for queue work */
+	/* Lock queue */
 	spin_lock_irqsave(&master->queue_lock, flags);
+
+	/* Make sure we are not already running a message */
+	if (master->cur_msg) {
+		spin_unlock_irqrestore(&master->queue_lock, flags);
+		return;
+	}
+
+	/* Check if the queue is idle */
 	if (list_empty(&master->queue) || !master->running) {
 		if (!master->busy) {
 			spin_unlock_irqrestore(&master->queue_lock, flags);
@@ -916,11 +924,6 @@ static void spi_pump_messages(struct kthread_work *work)
 		return;
 	}
 
-	/* Make sure we are not already running a message */
-	if (master->cur_msg) {
-		spin_unlock_irqrestore(&master->queue_lock, flags);
-		return;
-	}
 	/* Extract head of queue */
 	master->cur_msg =
 		list_first_entry(&master->queue, struct spi_message, queue);
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
