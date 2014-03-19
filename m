From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 5/7] spi: txx9: Let spi core validate Tx/Rx buffers for
 non-zero length transfer
Date: Wed, 19 Mar 2014 11:58:43 +0800
Message-ID: <1395201523.16346.7.camel@phoenix>
References: <1395201227.16346.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395201227.16346.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-txx9.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index 820b499..10ffbc0 100644
--- a/drivers/spi/spi-txx9.c
+++ b/drivers/spi/spi-txx9.c
@@ -299,17 +299,10 @@ static int txx9spi_transfer(struct spi_device *spi, struct spi_message *m)
 {
 	struct spi_master *master = spi->master;
 	struct txx9spi *c = spi_master_get_devdata(master);
-	struct spi_transfer *t;
 	unsigned long flags;
 
 	m->actual_length = 0;
 
-	/* check each transfer's parameters */
-	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (!t->tx_buf && !t->rx_buf && t->len)
-			return -EINVAL;
-	}
-
 	spin_lock_irqsave(&c->lock, flags);
 	list_add_tail(&m->queue, &c->queue);
 	queue_work(c->workqueue, &c->work);
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
