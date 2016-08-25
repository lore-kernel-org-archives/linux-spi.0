From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 03/23] spi: fsl-espi: remove unused elements n_rx and n_tx in
 struct fsl_espi_transfer
Date: Thu, 25 Aug 2016 06:44:19 +0200
Message-ID: <b5777cc4-1ab7-d7cb-00be-c597060e7af6@gmail.com>
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
 drivers/spi/spi-fsl-espi.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 2c4b2f8..12cb0c5 100644
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
@@ -372,26 +370,18 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(master);
 	struct spi_transfer *t;
 	u8 *rx_buf = NULL;
-	unsigned int n_tx = 0;
-	unsigned int n_rx = 0;
 	unsigned int xfer_len = 0;
 	struct fsl_espi_transfer espi_trans;
 
 	memset(mspi->local_buf, 0, SPCOM_TRANLEN_MAX);
 
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
