From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: bfin5xx: Remove unused last_transfer pointer in
 bfin_spi_giveback()
Date: Sun, 09 Feb 2014 11:25:34 +0800
Message-ID: <1391916334.20382.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Jiang, Scott" <Scott.Jiang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-bfin5xx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-bfin5xx.c b/drivers/spi/spi-bfin5xx.c
index f0f195a..d0f36ac 100644
--- a/drivers/spi/spi-bfin5xx.c
+++ b/drivers/spi/spi-bfin5xx.c
@@ -350,7 +350,6 @@ static void *bfin_spi_next_transfer(struct bfin_spi_master_data *drv_data)
 static void bfin_spi_giveback(struct bfin_spi_master_data *drv_data)
 {
 	struct bfin_spi_slave_data *chip = drv_data->cur_chip;
-	struct spi_transfer *last_transfer;
 	unsigned long flags;
 	struct spi_message *msg;
 
@@ -362,9 +361,6 @@ static void bfin_spi_giveback(struct bfin_spi_master_data *drv_data)
 	queue_work(drv_data->workqueue, &drv_data->pump_messages);
 	spin_unlock_irqrestore(&drv_data->lock, flags);
 
-	last_transfer = list_entry(msg->transfers.prev,
-				   struct spi_transfer, transfer_list);
-
 	msg->state = NULL;
 
 	if (!drv_data->cs_change)
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
