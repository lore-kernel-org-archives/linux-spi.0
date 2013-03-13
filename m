From: Doug Anderson <dianders@chromium.org>
Subject: [REPOST PATCH] spi: Unlock a spinlock before calling into the controller driver.
Date: Wed, 13 Mar 2013 11:17:40 -0700
Message-ID: <1363198660-21656-1-git-send-email-dianders@chromium.org>
References: <1340409205-23606-1-git-send-email-bfreed@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Olof Johansson <olof@lixom.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bryan Freed <bfreed@chromium.org>,
	Doug Anderson <dianders@chromium.org>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340409205-23606-1-git-send-email-bfreed@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Bryan Freed <bfreed@chromium.org>

spi_pump_messages() calls into a controller driver with
unprepare_transfer_hardware() which is documented as "This may sleep".
As in the prepare_transfer_hardware() call below, we should release the
queue_lock spinlock before making the call.
Rework the logic a bit to hold queue_lock to protect the 'busy' flag,
then release it to call unprepare_transfer_hardware().

Signed-off-by: Bryan Freed <bfreed@chromium.org>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Doug Anderson <dianders@chromium.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
During a rebase we noticed that this old patch never actually landed
anywhere.  I haven't gone through an reproduced the original bug on
ToT but I believe that this patch is still required.  Perhaps it could
land somewhere?  ;)  Thanks!

 drivers/spi/spi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f996c60..5b96250 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -543,17 +543,16 @@ static void spi_pump_messages(struct kthread_work *work)
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
1.8.1.3
