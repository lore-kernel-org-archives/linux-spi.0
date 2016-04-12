From: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: [PATCH v2 2/2] spi: spi-ti-qspi: Handle truncated frames properly
Date: Tue, 12 Apr 2016 12:58:14 +0100
Message-ID: <1460462294.32355.9.camel@codethink.co.uk>
References: <1460462185.32355.7.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	CT kernel <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460462185.32355.7.camel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

We clamp frame_len_words to a maximum of 4096, but do not actually
limit the number of words written or read through the DATA registers
or the length added to spi_message::actual_length.  This results in
silent data corruption for commands longer than this maximum.

Recalculate the length of each transfer, taking frame_len_words into
account.  Use this length in qspi_{read,write}_msg(), and to increment
spi_message::actual_length.

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
---
v2: Rebase; rename transfer_length to tranfer_len_words; improve commit
    message

 drivers/spi/spi-ti-qspi.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 2137f2112804..5044c6198332 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -225,16 +225,16 @@ static inline int ti_qspi_poll_wc(struct ti_qspi *qspi)
 	return  -ETIMEDOUT;
 }
 
-static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
+static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t,
+			  int count)
 {
-	int wlen, count, xfer_len;
+	int wlen, xfer_len;
 	unsigned int cmd;
 	const u8 *txbuf;
 	u32 data;
 
 	txbuf = t->tx_buf;
 	cmd = qspi->cmd | QSPI_WR_SNGL;
-	count = t->len;
 	wlen = t->bits_per_word >> 3;	/* in bytes */
 	xfer_len = wlen;
 
@@ -294,9 +294,10 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 	return 0;
 }
 
-static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
+static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
+			 int count)
 {
-	int wlen, count;
+	int wlen;
 	unsigned int cmd;
 	u8 *rxbuf;
 
@@ -313,7 +314,6 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 		cmd |= QSPI_RD_SNGL;
 		break;
 	}
-	count = t->len;
 	wlen = t->bits_per_word >> 3;	/* in bytes */
 
 	while (count) {
@@ -344,12 +344,13 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 	return 0;
 }
 
-static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer *t)
+static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer *t,
+			     int count)
 {
 	int ret;
 
 	if (t->tx_buf) {
-		ret = qspi_write_msg(qspi, t);
+		ret = qspi_write_msg(qspi, t, count);
 		if (ret) {
 			dev_dbg(qspi->dev, "Error while writing\n");
 			return ret;
@@ -357,7 +358,7 @@ static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 	}
 
 	if (t->rx_buf) {
-		ret = qspi_read_msg(qspi, t);
+		ret = qspi_read_msg(qspi, t, count);
 		if (ret) {
 			dev_dbg(qspi->dev, "Error while reading\n");
 			return ret;
@@ -374,7 +375,8 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 	struct spi_device *spi = m->spi;
 	struct spi_transfer *t;
 	int status = 0, ret;
-	unsigned int frame_len_words;
+	unsigned int frame_len_words, transfer_len_words;
+	int wlen;
 
 	/* setup device control reg */
 	qspi->dc = 0;
@@ -404,14 +406,20 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 		qspi->cmd = ((qspi->cmd & ~QSPI_WLEN_MASK) |
 			     QSPI_WLEN(t->bits_per_word));
 
-		ret = qspi_transfer_msg(qspi, t);
+		wlen = t->bits_per_word >> 3;
+		transfer_len_words = min(t->len / wlen, frame_len_words);
+
+		ret = qspi_transfer_msg(qspi, t, transfer_len_words * wlen);
 		if (ret) {
 			dev_dbg(qspi->dev, "transfer message failed\n");
 			mutex_unlock(&qspi->list_lock);
 			return -EINVAL;
 		}
 
-		m->actual_length += t->len;
+		m->actual_length += transfer_len_words * wlen;
+		frame_len_words -= transfer_len_words;
+		if (frame_len_words == 0)
+			break;
 	}
 
 	mutex_unlock(&qspi->list_lock);
-- 
2.8.0.rc3


-- 
Ben Hutchings
Software Developer, Codethink Ltd.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
