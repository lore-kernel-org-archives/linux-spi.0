From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: core: Use list_first_entry to extract head of queue
Date: Thu, 09 Jan 2014 16:03:58 +0800
Message-ID: <1389254638.31143.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

For slightly better readability.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f360525e..eccf5a7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -685,7 +685,7 @@ static void spi_pump_messages(struct kthread_work *work)
 	}
 	/* Extract head of queue */
 	master->cur_msg =
-	    list_entry(master->queue.next, struct spi_message, queue);
+		list_first_entry(&master->queue, struct spi_message, queue);
 
 	list_del_init(&master->cur_msg->queue);
 	if (master->busy)
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
