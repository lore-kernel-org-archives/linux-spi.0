From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 08/23] spi: fsl-espi: factor out filling the local buffer
Date: Fri, 2 Sep 2016 22:03:28 +0200
Message-ID: <75a01618-11f4-d54c-4cb7-21e1ed40951a@gmail.com>
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

Better structure the code by factoring out filling the local buffer.

In addition don't initialize the complete local buffer at the
beginning of fsl_espi_do_one_msg. Instead move initialization of
those parts of the local buffer to be used for transfers w/o tx_buf
to fsl_espi_copy_to_buf.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- fixed coding style issue
- improved commit message
---
 drivers/spi/spi-fsl-espi.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index a3a75ae..c0023c0 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -85,6 +85,27 @@ struct fsl_espi_transfer {
 
 #define AUTOSUSPEND_TIMEOUT 2000
 
+static unsigned int fsl_espi_copy_to_buf(struct spi_message *m,
+					 struct mpc8xxx_spi *mspi)
+{
+	unsigned int tx_only = 0;
+	struct spi_transfer *t;
+	u8 *buf = mspi->local_buf;
+
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (t->tx_buf) {
+			memcpy(buf, t->tx_buf, t->len);
+			if (!t->rx_buf)
+				tx_only += t->len;
+		} else {
+			memset(buf, 0, t->len);
+		}
+		buf += t->len;
+	}
+
+	return tx_only;
+}
+
 static void fsl_espi_change_mode(struct spi_device *spi)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
@@ -301,16 +322,9 @@ static void fsl_espi_cmd_trans(struct spi_message *m,
 				struct fsl_espi_transfer *trans, u8 *rx_buff)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
-	struct spi_transfer *t;
-	int i = 0;
 	struct fsl_espi_transfer *espi_trans = trans;
 
-	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->tx_buf) {
-			memcpy(mspi->local_buf + i, t->tx_buf, t->len);
-			i += t->len;
-		}
-	}
+	fsl_espi_copy_to_buf(m, mspi);
 
 	espi_trans->tx_buf = mspi->local_buf;
 	espi_trans->rx_buf = mspi->local_buf;
@@ -323,18 +337,9 @@ static void fsl_espi_rw_trans(struct spi_message *m,
 				struct fsl_espi_transfer *trans, u8 *rx_buff)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
-	struct spi_transfer *t;
-	unsigned int tx_only = 0;
-	int i = 0;
+	unsigned int tx_only;
 
-	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->tx_buf) {
-			memcpy(mspi->local_buf + i, t->tx_buf, t->len);
-			i += t->len;
-			if (!t->rx_buf)
-				tx_only += t->len;
-		}
-	}
+	tx_only = fsl_espi_copy_to_buf(m, mspi);
 
 	trans->tx_buf = mspi->local_buf;
 	trans->rx_buf = mspi->local_buf;
@@ -352,14 +357,11 @@ static void fsl_espi_rw_trans(struct spi_message *m,
 static int fsl_espi_do_one_msg(struct spi_master *master,
 			       struct spi_message *m)
 {
-	struct mpc8xxx_spi *mspi = spi_master_get_devdata(master);
 	struct spi_transfer *t;
 	u8 *rx_buf = NULL;
 	unsigned int xfer_len = 0;
 	struct fsl_espi_transfer espi_trans;
 
-	memset(mspi->local_buf, 0, SPCOM_TRANLEN_MAX);
-
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (t->rx_buf)
 			rx_buf = t->rx_buf;
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
