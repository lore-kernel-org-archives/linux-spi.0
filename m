From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 14/18] spi: fsl-espi: factor out initial message checking
Date: Sun, 4 Sep 2016 10:01:58 +0200
Message-ID: <adb04a89-542e-12fc-e71d-0fdf21c8bc5b@gmail.com>
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

Checking the message is currently done at diffrent places in the
driver. Factor it out to fsl_espi_check_message.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- rebased
---
 drivers/spi/spi-fsl-espi.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 534dc14..a32bc3a 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -98,6 +98,30 @@ static unsigned int fsl_espi_copy_to_buf(struct spi_message *m,
 	return tx_only;
 }
 
+static int fsl_espi_check_message(struct spi_message *m)
+{
+	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
+	struct spi_transfer *t, *first;
+
+	if (m->frame_length > SPCOM_TRANLEN_MAX) {
+		dev_err(mspi->dev, "message too long, size is %u bytes\n",
+			m->frame_length);
+		return -EMSGSIZE;
+	}
+
+	first = list_first_entry(&m->transfers, struct spi_transfer,
+				 transfer_list);
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (first->bits_per_word != t->bits_per_word ||
+		    first->speed_hz != t->speed_hz) {
+			dev_err(mspi->dev, "bits_per_word/speed_hz should be the same for all transfers\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static void fsl_espi_change_mode(struct spi_device *spi)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
@@ -222,11 +246,6 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	reinit_completion(&mpc8xxx_spi->done);
 
 	/* Set SPCOM[CS] and SPCOM[TRANLEN] field */
-	if (t->len > SPCOM_TRANLEN_MAX) {
-		dev_err(mpc8xxx_spi->dev, "Transaction length (%d)"
-				" beyond the SPCOM[TRANLEN] field\n", t->len);
-		return -EINVAL;
-	}
 	mpc8xxx_spi_write_reg(&reg_base->command,
 		(SPCOM_CS(spi->chip_select) | SPCOM_TRANLEN(t->len - 1)));
 
@@ -253,20 +272,12 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 static int fsl_espi_do_trans(struct spi_message *m, struct spi_transfer *trans)
 {
 	struct spi_device *spi = m->spi;
-	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
 	struct spi_transfer *t, *first;
 	int ret = 0;
 
 	first = list_first_entry(&m->transfers, struct spi_transfer,
 			transfer_list);
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if ((first->bits_per_word != t->bits_per_word) ||
-			(first->speed_hz != t->speed_hz)) {
-			dev_err(mspi->dev,
-				"bits_per_word/speed_hz should be same for the same SPI transfer\n");
-			return -EINVAL;
-		}
-
 		trans->speed_hz = t->speed_hz;
 		trans->bits_per_word = t->bits_per_word;
 		trans->delay_usecs = max(first->delay_usecs, t->delay_usecs);
@@ -313,6 +324,10 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 	struct spi_transfer *t, trans = {};
 	int ret;
 
+	ret = fsl_espi_check_message(m);
+	if (ret)
+		goto out;
+
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (t->rx_buf)
 			rx_buf = t->rx_buf;
@@ -325,7 +340,7 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 	ret = fsl_espi_trans(m, &trans, rx_buf);
 
 	m->actual_length = ret ? 0 : trans.len;
-
+out:
 	if (m->status == -EINPROGRESS)
 		m->status = ret;
 
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
