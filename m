From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-ti-qspi: Handle truncated frames properly" to the spi tree
Date: Wed, 13 Apr 2016 08:13:31 +0100
Message-ID: <E1aqEzT-0003Sb-3i@debutante>
References: <1460462294.32355.9.camel@codethink.co.uk>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	CT kernel <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>
To: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460462294.32355.9.camel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-ti-qspi: Handle truncated frames properly

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1ff7760ff66b98ef244bf0e5e2bd5310651205ad Mon Sep 17 00:00:00 2001
From: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Date: Tue, 12 Apr 2016 12:58:14 +0100
Subject: [PATCH] spi: spi-ti-qspi: Handle truncated frames properly

We clamp frame_len_words to a maximum of 4096, but do not actually
limit the number of words written or read through the DATA registers
or the length added to spi_message::actual_length.  This results in
silent data corruption for commands longer than this maximum.

Recalculate the length of each transfer, taking frame_len_words into
account.  Use this length in qspi_{read,write}_msg(), and to increment
spi_message::actual_length.

Signed-off-by: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/spi/spi-ti-qspi.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 0ee4139dec48..443f664534e1 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -236,16 +236,16 @@ static inline int ti_qspi_poll_wc(struct ti_qspi *qspi)
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
 
@@ -305,9 +305,10 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
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
 
@@ -324,7 +325,6 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 		cmd |= QSPI_RD_SNGL;
 		break;
 	}
-	count = t->len;
 	wlen = t->bits_per_word >> 3;	/* in bytes */
 
 	while (count) {
@@ -355,12 +355,13 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
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
@@ -368,7 +369,7 @@ static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 	}
 
 	if (t->rx_buf) {
-		ret = qspi_read_msg(qspi, t);
+		ret = qspi_read_msg(qspi, t, count);
 		if (ret) {
 			dev_dbg(qspi->dev, "Error while reading\n");
 			return ret;
@@ -451,7 +452,8 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 	struct spi_device *spi = m->spi;
 	struct spi_transfer *t;
 	int status = 0, ret;
-	unsigned int frame_len_words;
+	unsigned int frame_len_words, transfer_len_words;
+	int wlen;
 
 	/* setup device control reg */
 	qspi->dc = 0;
@@ -484,14 +486,20 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
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
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
