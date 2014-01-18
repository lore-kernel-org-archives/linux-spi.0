From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: core: Fix transfer failure when master->transfer_one
 returns positive value
Date: Sat, 18 Jan 2014 22:05:22 +0800
Message-ID: <1390053922.16621.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

master->transfer_one returns positive value is not a error.
So set ret to 0 when master->transfer_one returns positive value.
Otherwise, I hit "spi_master spi0: failed to transfer one message from queue"
error when my transfer_one callback returns 1.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index db421bd..11fefd5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -609,8 +609,10 @@ static int spi_transfer_one_message(struct spi_master *master,
 			goto out;
 		}
 
-		if (ret > 0)
+		if (ret > 0) {
+			ret = 0;
 			wait_for_completion(&master->xfer_completion);
+		}
 
 		trace_spi_transfer_stop(msg, xfer);
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
