From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/3] spi: txx9: Let spi core handle validating transfer
 length
Date: Tue, 25 Feb 2014 19:19:43 +0800
Message-ID: <1393327183.6723.5.camel@phoenix>
References: <1393327017.6723.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393327017.6723.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi core will handle validating transfer length since commit 4d94bd21b333
"spi: core: Validate length of the transfers in message".
So remove the same checking in this driver.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-txx9.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index 523f13d..b5f5dc8 100644
--- a/drivers/spi/spi-txx9.c
+++ b/drivers/spi/spi-txx9.c
@@ -306,12 +306,8 @@ static int txx9spi_transfer(struct spi_device *spi, struct spi_message *m)
 
 	/* check each transfer's parameters */
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		u8 bits_per_word = t->bits_per_word;
-
 		if (!t->tx_buf && !t->rx_buf && t->len)
 			return -EINVAL;
-		if (t->len & ((bits_per_word >> 3) - 1))
-			return -EINVAL;
 	}
 
 	spin_lock_irqsave(&c->lock, flags);
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
