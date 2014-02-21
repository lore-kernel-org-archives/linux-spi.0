From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: core: Replace msleep with usleep_range to get more
 accurate sleep time
Date: Fri, 21 Feb 2014 09:15:18 +0800
Message-ID: <1392945318.4125.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fixes below checkpatch warning:
WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
+               msleep(10);

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2b664c8..055580f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1078,7 +1078,7 @@ static int spi_stop_queue(struct spi_master *master)
 	 */
 	while ((!list_empty(&master->queue) || master->busy) && limit--) {
 		spin_unlock_irqrestore(&master->queue_lock, flags);
-		msleep(10);
+		usleep_range(10000, 11000);
 		spin_lock_irqsave(&master->queue_lock, flags);
 	}
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
