From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 7/7] spi: bitbang: Let spi core validate Tx/Rx buffers for
 non-zero length transfer
Date: Wed, 19 Mar 2014 12:00:29 +0800
Message-ID: <1395201629.16346.9.camel@phoenix>
References: <1395201227.16346.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395201227.16346.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-bitbang.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index 3bfdb85..4beabea 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -317,10 +317,6 @@ static int spi_bitbang_transfer_one(struct spi_master *master,
 			ndelay(nsecs);
 		}
 		cs_change = t->cs_change;
-		if (!t->tx_buf && !t->rx_buf && t->len) {
-			status = -EINVAL;
-			break;
-		}
 
 		/* transfer data.  the lower level code handles any
 		 * new dma mappings it needs. our caller always gave
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
