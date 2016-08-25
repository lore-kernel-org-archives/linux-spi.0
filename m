From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 09/23] spi: fsl-espi: remove element status from struct
 fsl_espi_transfer
Date: Thu, 25 Aug 2016 06:46:58 +0200
Message-ID: <90daff66-65f0-a3c7-790a-a768e3a29714@gmail.com>
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

Use the return values of the functions in the call chain to transport
status information instead of using an element in struct
fsl_espi_transfer for this.

This is more in line with the general approach how to handle status
information and is one step further to eventually get rid of
struct fsl_espi_transfer completely.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 47 +++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index c3aa6f0..68bf72a 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -42,7 +42,6 @@ struct fsl_espi_transfer {
 	void *rx_buf;
 	unsigned len;
 	unsigned actual_length;
-	int status;
 };
 
 /* eSPI Controller mode register definitions */
@@ -270,14 +269,14 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	return mpc8xxx_spi->count;
 }
 
-static void fsl_espi_do_trans(struct spi_message *m,
-				struct fsl_espi_transfer *tr)
+static int fsl_espi_do_trans(struct spi_message *m,
+			     struct fsl_espi_transfer *tr)
 {
 	struct spi_device *spi = m->spi;
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
 	struct fsl_espi_transfer *espi_trans = tr;
 	struct spi_transfer *t, *first, trans;
-	int status = 0;
+	int ret = 0;
 
 	memset(&trans, 0, sizeof(trans));
 
@@ -286,10 +285,9 @@ static void fsl_espi_do_trans(struct spi_message *m,
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if ((first->bits_per_word != t->bits_per_word) ||
 			(first->speed_hz != t->speed_hz)) {
-			espi_trans->status = -EINVAL;
 			dev_err(mspi->dev,
 				"bits_per_word/speed_hz should be same for the same SPI transfer\n");
-			return;
+			return -EINVAL;
 		}
 
 		trans.speed_hz = t->speed_hz;
@@ -305,50 +303,57 @@ static void fsl_espi_do_trans(struct spi_message *m,
 		fsl_espi_setup_transfer(spi, &trans);
 
 	if (trans.len)
-		status = fsl_espi_bufs(spi, &trans);
+		ret = fsl_espi_bufs(spi, &trans);
 
-	if (status)
-		status = -EMSGSIZE;
+	if (ret)
+		ret = -EMSGSIZE;
 
 	if (trans.delay_usecs)
 		udelay(trans.delay_usecs);
 
-	espi_trans->status = status;
 	fsl_espi_setup_transfer(spi, NULL);
+
+	return ret;
 }
 
-static void fsl_espi_cmd_trans(struct spi_message *m,
-				struct fsl_espi_transfer *trans, u8 *rx_buff)
+static int fsl_espi_cmd_trans(struct spi_message *m,
+			      struct fsl_espi_transfer *trans, u8 *rx_buff)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
 	struct fsl_espi_transfer *espi_trans = trans;
+	int ret;
 
 	fsl_espi_copy_to_buf(m, mspi);
 
 	espi_trans->tx_buf = espi_trans->rx_buf = mspi->local_buf;
-	fsl_espi_do_trans(m, espi_trans);
+	ret = fsl_espi_do_trans(m, espi_trans);
 
 	espi_trans->actual_length = espi_trans->len;
+
+	return ret;
 }
 
-static void fsl_espi_rw_trans(struct spi_message *m,
-				struct fsl_espi_transfer *trans, u8 *rx_buff)
+static int fsl_espi_rw_trans(struct spi_message *m,
+			     struct fsl_espi_transfer *trans, u8 *rx_buff)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
 	unsigned int tx_only;
+	int ret;
 
 	tx_only = fsl_espi_copy_to_buf(m, mspi);
 
 	trans->tx_buf = trans->rx_buf = mspi->local_buf;
-	fsl_espi_do_trans(m, trans);
+	ret = fsl_espi_do_trans(m, trans);
 
-	if (!trans->status) {
+	if (!ret) {
 		/* If there is at least one RX byte then copy it to rx_buff */
 		if (trans->len > tx_only)
 			memcpy(rx_buff, trans->rx_buf + tx_only,
 			       trans->len - tx_only);
 		trans->actual_length += trans->len;
 	}
+
+	return ret;
 }
 
 static int fsl_espi_do_one_msg(struct spi_master *master,
@@ -358,6 +363,7 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 	u8 *rx_buf = NULL;
 	unsigned int xfer_len = 0;
 	struct fsl_espi_transfer espi_trans;
+	int ret;
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (t->rx_buf)
@@ -368,15 +374,14 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 
 	espi_trans.len = xfer_len;
 	espi_trans.actual_length = 0;
-	espi_trans.status = 0;
 
 	if (!rx_buf)
-		fsl_espi_cmd_trans(m, &espi_trans, NULL);
+		ret = fsl_espi_cmd_trans(m, &espi_trans, NULL);
 	else
-		fsl_espi_rw_trans(m, &espi_trans, rx_buf);
+		ret = fsl_espi_rw_trans(m, &espi_trans, rx_buf);
 
 	m->actual_length = espi_trans.actual_length;
-	m->status = espi_trans.status;
+	m->status = ret;
 	spi_finalize_current_message(master);
 	return 0;
 }
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
