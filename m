From: Huiquan Zhong <huiquan.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: fix one potential spin_lock issue
Date: Wed, 15 Apr 2015 16:00:32 +0800
Message-ID: <1429084832-8953-1-git-send-email-huiquan.zhong@intel.com>
Cc: huiquanz.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Huiquan Zhong <huiquan.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

master->pump_messages workqueue can be queued by spi_start_queue(),
__spi_queued_transfer().

there is one case that if one resume thread call spi_start_queue(),
and at the same time another spi_device thread call spi_queued_transfer()
to do spi transfer, then the first workqueue will start the spi transfer,
but the next workqueue queued before SPI transfer complete, will unusual
terminate spi transfer.

Add spin_lock protection to avoid this case.

Signed-off-by: Huiquan Zhong <huiquan.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d5d7d22..2bc387b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1017,9 +1017,11 @@ static int spi_start_queue(struct spi_master *master)
 
 	master->running = true;
 	master->cur_msg = NULL;
-	spin_unlock_irqrestore(&master->queue_lock, flags);
 
-	queue_kthread_work(&master->kworker, &master->pump_messages);
+	if (!list_empty(&master->queue))
+		queue_kthread_work(&master->kworker, &master->pump_messages);
+
+	spin_unlock_irqrestore(&master->queue_lock, flags);
 
 	return 0;
 }
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
