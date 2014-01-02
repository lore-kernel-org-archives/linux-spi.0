From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: core: Use list_first_entry_or_null() instead of
 open-coded
Date: Thu, 02 Jan 2014 15:16:40 +0800
Message-ID: <1388647000.28565.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use list_first_entry_or_null() to save a few lines.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 98f4b77..a1a7f78 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -791,11 +791,8 @@ struct spi_message *spi_get_next_queued_message(struct spi_master *master)
 
 	/* get a pointer to the next message, if any */
 	spin_lock_irqsave(&master->queue_lock, flags);
-	if (list_empty(&master->queue))
-		next = NULL;
-	else
-		next = list_entry(master->queue.next,
-				  struct spi_message, queue);
+	next = list_first_entry_or_null(&master->queue, struct spi_message,
+					queue);
 	spin_unlock_irqrestore(&master->queue_lock, flags);
 
 	return next;
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
