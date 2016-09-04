From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 01/18] spi: fsl-espi: remove unused elements n_rx and n_tx
 in struct fsl_espi_transfer
Date: Sun, 4 Sep 2016 09:53:01 +0200
Message-ID: <768db945-1d61-d258-e82d-24db9a7ecc9c@gmail.com>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Both elements are not used, so remove them.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- switch order of patches to do the trivial changes first
---
 drivers/spi/spi-fsl-espi.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index f9ef504..a9004fe 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -41,8 +41,6 @@ struct fsl_espi_transfer {
 	const void *tx_buf;
 	void *rx_buf;
 	unsigned len;
-	unsigned n_tx;
-	unsigned n_rx;
 	unsigned actual_length;
 	int status;
 };
@@ -371,24 +369,16 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 {
 	struct spi_transfer *t;
 	u8 *rx_buf = NULL;
-	unsigned int n_tx = 0;
-	unsigned int n_rx = 0;
 	unsigned int xfer_len = 0;
 	struct fsl_espi_transfer espi_trans;
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->tx_buf)
-			n_tx += t->len;
-		if (t->rx_buf) {
-			n_rx += t->len;
+		if (t->rx_buf)
 			rx_buf = t->rx_buf;
-		}
 		if ((t->tx_buf) || (t->rx_buf))
 			xfer_len += t->len;
 	}
 
-	espi_trans.n_tx = n_tx;
-	espi_trans.n_rx = n_rx;
 	espi_trans.len = xfer_len;
 	espi_trans.actual_length = 0;
 	espi_trans.status = 0;
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
