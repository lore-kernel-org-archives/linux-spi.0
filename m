From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: Use list_last_entry at appropriate places
Date: Wed, 12 Feb 2014 22:13:27 +0800
Message-ID: <1392214407.11101.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-dw.c     | 3 +--
 drivers/spi/spi-pl022.c  | 5 ++---
 drivers/spi/spi-pxa2xx.c | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index bf98d63..390da9b 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -276,8 +276,7 @@ static void giveback(struct dw_spi *dws)
 	queue_work(dws->workqueue, &dws->pump_messages);
 	spin_unlock_irqrestore(&dws->lock, flags);
 
-	last_transfer = list_entry(msg->transfers.prev,
-					struct spi_transfer,
+	last_transfer = list_last_entry(&msg->transfers, struct spi_transfer,
 					transfer_list);
 
 	if (!last_transfer->cs_change && dws->cs_control)
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 74a0729..3e7c377 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -459,9 +459,8 @@ static void giveback(struct pl022 *pl022)
 	struct spi_transfer *last_transfer;
 	pl022->next_msg_cs_active = false;
 
-	last_transfer = list_entry(pl022->cur_msg->transfers.prev,
-					struct spi_transfer,
-					transfer_list);
+	last_transfer = list_last_entry(&pl022->cur_msg->transfers,
+					struct spi_transfer, transfer_list);
 
 	/* Delay if requested before any change in chip select */
 	if (last_transfer->delay_usecs)
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index c702fc5..41185d0 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -362,8 +362,7 @@ static void giveback(struct driver_data *drv_data)
 	drv_data->cur_msg = NULL;
 	drv_data->cur_transfer = NULL;
 
-	last_transfer = list_entry(msg->transfers.prev,
-					struct spi_transfer,
+	last_transfer = list_last_entry(&msg->transfers, struct spi_transfer,
 					transfer_list);
 
 	/* Delay if requested before any change in chip select */
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
