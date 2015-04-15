From: Jonatas Rech <jonatas.rech-rCUF4CxDseZknzVnJbg3IA@public.gmane.org>
Subject: [PATCH] spi: fsl-espi: fix behaviour for full-duplex xfers
Date: Wed, 15 Apr 2015 12:23:18 -0300
Message-ID: <1429111398-21444-1-git-send-email-jonatas.rech@datacom.ind.br>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jonatas Rech <jonatas.rech-rCUF4CxDseZknzVnJbg3IA@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch makes possible for protocol drivers to do full-duplex SPI
transfers properly. Until now this driver could only be used for
half-duplex transfers, since it always expected an spi_transfer with
non-null tx_buf to be only used for TX, and those with non-null rx_buf
to be only used for RX.

The fix consists in correcting the fsl_espi_transfer length by taking
into consideration duplex spi_transfers, and not just by adding n_tx
and n_rx.

Furthermore, this correction has exposed an inconsistency in the
protocol driver <-> controller driver interaction. The spi-fsl-espi
driver artificially inserts TX bytes when message fragmentation is
necessary (due to SPCOM_TRANLEN_MAX) instead of informing the
protocol driver of the hardware limitation. This was tested with the
m25p80 NOR flash protocol driver. Since fixing this issue may cause
other client drivers to malfunction, it was left as is.

Signed-off-by: Jonatas Rech <jonatas.rech-rCUF4CxDseZknzVnJbg3IA@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index d0a73a0..80d245a 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -359,14 +359,16 @@ static void fsl_espi_rw_trans(struct spi_message *m,
 				struct fsl_espi_transfer *trans, u8 *rx_buff)
 {
 	struct fsl_espi_transfer *espi_trans = trans;
-	unsigned int n_tx = espi_trans->n_tx;
-	unsigned int n_rx = espi_trans->n_rx;
+	unsigned int total_len = espi_trans->len;
 	struct spi_transfer *t;
 	u8 *local_buf;
 	u8 *rx_buf = rx_buff;
 	unsigned int trans_len;
 	unsigned int addr;
-	int i, pos, loop;
+	unsigned int tx_only;
+	unsigned int rx_pos = 0;
+	unsigned int pos;
+	int i, loop;
 
 	local_buf = kzalloc(SPCOM_TRANLEN_MAX, GFP_KERNEL);
 	if (!local_buf) {
@@ -374,36 +376,48 @@ static void fsl_espi_rw_trans(struct spi_message *m,
 		return;
 	}
 
-	for (pos = 0, loop = 0; pos < n_rx; pos += trans_len, loop++) {
-		trans_len = n_rx - pos;
-		if (trans_len > SPCOM_TRANLEN_MAX - n_tx)
-			trans_len = SPCOM_TRANLEN_MAX - n_tx;
+	for (pos = 0, loop = 0; pos < total_len; pos += trans_len, loop++) {
+		trans_len = total_len - pos;
 
 		i = 0;
+		tx_only = 0;
 		list_for_each_entry(t, &m->transfers, transfer_list) {
 			if (t->tx_buf) {
 				memcpy(local_buf + i, t->tx_buf, t->len);
 				i += t->len;
+				if (!t->rx_buf)
+					tx_only += t->len;
 			}
 		}
 
+		/* Add additional TX bytes to compensate SPCOM_TRANLEN_MAX */
+		if (loop > 0)
+			trans_len += tx_only;
+
+		if (trans_len > SPCOM_TRANLEN_MAX)
+			trans_len = SPCOM_TRANLEN_MAX;
+
+		/* Update device offset */
 		if (pos > 0) {
 			addr = fsl_espi_cmd2addr(local_buf);
-			addr += pos;
+			addr += rx_pos;
 			fsl_espi_addr2cmd(addr, local_buf);
 		}
 
-		espi_trans->n_tx = n_tx;
-		espi_trans->n_rx = trans_len;
-		espi_trans->len = trans_len + n_tx;
+		espi_trans->len = trans_len;
 		espi_trans->tx_buf = local_buf;
 		espi_trans->rx_buf = local_buf;
 		fsl_espi_do_trans(m, espi_trans);
 
-		memcpy(rx_buf + pos, espi_trans->rx_buf + n_tx, trans_len);
+		/* If there is at least one RX byte then copy it to rx_buf */
+		if (tx_only < SPCOM_TRANLEN_MAX)
+			memcpy(rx_buf + rx_pos, espi_trans->rx_buf + tx_only,
+					trans_len - tx_only);
+
+		rx_pos += trans_len - tx_only;
 
 		if (loop > 0)
-			espi_trans->actual_length += espi_trans->len - n_tx;
+			espi_trans->actual_length += espi_trans->len - tx_only;
 		else
 			espi_trans->actual_length += espi_trans->len;
 	}
@@ -418,6 +432,7 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 	u8 *rx_buf = NULL;
 	unsigned int n_tx = 0;
 	unsigned int n_rx = 0;
+	unsigned int xfer_len = 0;
 	struct fsl_espi_transfer espi_trans;
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
@@ -427,11 +442,13 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 			n_rx += t->len;
 			rx_buf = t->rx_buf;
 		}
+		if ((t->tx_buf) || (t->rx_buf))
+			xfer_len += t->len;
 	}
 
 	espi_trans.n_tx = n_tx;
 	espi_trans.n_rx = n_rx;
-	espi_trans.len = n_tx + n_rx;
+	espi_trans.len = xfer_len;
 	espi_trans.actual_length = 0;
 	espi_trans.status = 0;
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
