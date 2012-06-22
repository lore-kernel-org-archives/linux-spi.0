From: Bryan Freed <bfreed@chromium.org>
Subject: [PATCH] spi: Unlock a spinlock before calling into the controller driver.
Date: Fri, 22 Jun 2012 16:53:25 -0700
Message-ID: <1340409205-23606-1-git-send-email-bfreed@chromium.org>
Cc: grant.likely@secretlab.ca, linux-kernel@vger.kernel.org,
	Bryan Freed <bfreed@chromium.org>
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

spi_pump_messages() calls into a controller driver with
unprepare_transfer_hardware() which is documented as "This may sleep".
As in the prepare_transfer_hardware() call below, we should release the
queue_lock spinlock before making the call.
Rework the logic a bit to hold queue_lock to protect the 'busy' flag,
then release it to call unprepare_transfer_hardware().

Signed-off-by: Bryan Freed <bfreed@chromium.org>

---
 drivers/spi/spi.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index fc0da39..f7f9df9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -532,17 +532,16 @@ static void spi_pump_messages(struct kthread_work *work)
 	/* Lock queue and check for queue work */
 	spin_lock_irqsave(&master->queue_lock, flags);
 	if (list_empty(&master->queue) || !master->running) {
-		if (master->busy && master->unprepare_transfer_hardware) {
-			ret = master->unprepare_transfer_hardware(master);
-			if (ret) {
-				spin_unlock_irqrestore(&master->queue_lock, flags);
-				dev_err(&master->dev,
-					"failed to unprepare transfer hardware\n");
-				return;
-			}
+		if (!master->busy) {
+			spin_unlock_irqrestore(&master->queue_lock, flags);
+			return;
 		}
 		master->busy = false;
 		spin_unlock_irqrestore(&master->queue_lock, flags);
+		if (master->unprepare_transfer_hardware &&
+		    master->unprepare_transfer_hardware(master))
+			dev_err(&master->dev,
+				"failed to unprepare transfer hardware\n");
 		return;
 	}
 
-- 
1.7.7.3
