From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/7] spi: omap-100k: Let spi core validate Tx/Rx buffers for
 non-zero length transfer
Date: Wed, 19 Mar 2014 11:56:21 +0800
Message-ID: <1395201381.16346.4.camel@phoenix>
References: <1395201227.16346.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Fabrice Crohas <fcrohas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395201227.16346.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-omap-100k.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index c9e2282..05069ee 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -324,10 +324,6 @@ static int omap1_spi100k_transfer_one_message(struct spi_master *master,
 	int status = 0;
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
-			status = -EINVAL;
-			break;
-		}
 		if (par_override || t->speed_hz || t->bits_per_word) {
 			par_override = 1;
 			status = omap1_spi100k_setup_transfer(spi, t);
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
