From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/7] spi: omap2-mcspi: Let spi core validate Tx/Rx buffers
 for non-zero length transfer
Date: Wed, 19 Mar 2014 11:57:38 +0800
Message-ID: <1395201458.16346.6.camel@phoenix>
References: <1395201227.16346.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Illia Smyrnov <illia.smyrnov-hExfYMNmJl/Cnp4W7fqMDg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395201227.16346.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 2941c5b..a0746a7 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1081,10 +1081,6 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 
 	omap2_mcspi_set_enable(spi, 0);
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
-			status = -EINVAL;
-			break;
-		}
 		if (par_override ||
 		    (t->speed_hz != spi->max_speed_hz) ||
 		    (t->bits_per_word != spi->bits_per_word)) {
@@ -1212,16 +1208,6 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 		void		*rx_buf = t->rx_buf;
 		unsigned	len = t->len;
 
-		if ((len && !(rx_buf || tx_buf))) {
-			dev_dbg(mcspi->dev, "transfer: %d Hz, %d %s%s, %d bpw\n",
-					t->speed_hz,
-					len,
-					tx_buf ? "tx" : "",
-					rx_buf ? "rx" : "",
-					t->bits_per_word);
-			return -EINVAL;
-		}
-
 		if (m->is_dma_mapped || len < DMA_MIN_BYTES)
 			continue;
 
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
