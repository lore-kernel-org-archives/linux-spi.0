From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 5/6] spi/pl022: move device disable to workqueue thread
Date: Wed, 9 Nov 2011 11:39:22 +0100
Message-ID: <1320835162-31337-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>,
	Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Moves the disabling of the device and clocks to the same thread in
which the device and clocks are enabled. This avoids SMP issues where
the device can be enabled for a transfer by one thread and then
disabled by the completion of the previous transfer in another thread.

Signed-off-by: Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pl022.c |   33 +++++++++++++++++++--------------
 1 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index bffad2a..2e3522d 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -512,13 +512,6 @@ static void giveback(struct pl022 *pl022)
 	msg->state = NULL;
 	if (msg->complete)
 		msg->complete(msg->context);
-
-	/* disable the SPI/SSP operation */
-	writew((readw(SSP_CR1(pl022->virtbase)) &
-		(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
-
-	/* This message is completed, so let's turn off the clocks & power */
-	pm_runtime_put(&pl022->adev->dev);
 }
 
 /**
@@ -1513,10 +1506,17 @@ static void pump_messages(struct work_struct *work)
 	struct pl022 *pl022 =
 		container_of(work, struct pl022, pump_messages);
 	unsigned long flags;
+	bool was_busy = false;
 
 	/* Lock queue and check for queue work */
 	spin_lock_irqsave(&pl022->queue_lock, flags);
 	if (list_empty(&pl022->queue) || !pl022->running) {
+		if (pl022->busy) {
+			/* nothing more to do - disable spi/ssp and power off */
+			writew((readw(SSP_CR1(pl022->virtbase)) &
+				(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
+			pm_runtime_put(&pl022->adev->dev);
+		}
 		pl022->busy = false;
 		spin_unlock_irqrestore(&pl022->queue_lock, flags);
 		return;
@@ -1531,7 +1531,10 @@ static void pump_messages(struct work_struct *work)
 	    list_entry(pl022->queue.next, struct spi_message, queue);
 
 	list_del_init(&pl022->cur_msg->queue);
-	pl022->busy = true;
+	if (pl022->busy)
+		was_busy = true;
+	else
+		pl022->busy = true;
 	spin_unlock_irqrestore(&pl022->queue_lock, flags);
 
 	/* Initial message state */
@@ -1541,12 +1544,14 @@ static void pump_messages(struct work_struct *work)
 
 	/* Setup the SPI using the per chip configuration */
 	pl022->cur_chip = spi_get_ctldata(pl022->cur_msg->spi);
-	/*
-	 * We enable the core voltage and clocks here, then the clocks
-	 * and core will be disabled when giveback() is called in each method
-	 * (poll/interrupt/DMA)
-	 */
-	pm_runtime_get_sync(&pl022->adev->dev);
+	if (!was_busy)
+		/*
+		 * We enable the core voltage and clocks here, then the clocks
+		 * and core will be disabled when this workqueue is run again
+		 * and there is no more work to be done.
+		 */
+		pm_runtime_get_sync(&pl022->adev->dev);
+
 	restore_state(pl022);
 	flush(pl022);
 
-- 
1.7.3.2


------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
