From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 02/23] spi: fsl-espi: pre-allocate message buffer
Date: Thu, 25 Aug 2016 06:44:06 +0200
Message-ID: <448706fe-fd0a-7a56-b37e-0500c3ed4c18@gmail.com>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
 <cabc3522-8ca9-516a-e0ef-5a2ed9ad8507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cabc3522-8ca9-516a-e0ef-5a2ed9ad8507-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Currently the driver allocates a 64kb buffer with each single message.
On systems with little and fragmented memory this can result in
memory allocation errors. Solve this by pre-allocating a buffer.

This patch was developed in OpenWRT long ago, however it never
made it upstream. I slightly modified the original patch to
re-initialize the buffer at the beginning of each transfer.

Original author: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 39 ++++++++++++++++-----------------------
 drivers/spi/spi-fsl-lib.h  |  1 +
 2 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index d95fdd0..2c4b2f8 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -319,57 +319,42 @@ static void fsl_espi_do_trans(struct spi_message *m,
 static void fsl_espi_cmd_trans(struct spi_message *m,
 				struct fsl_espi_transfer *trans, u8 *rx_buff)
 {
+	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
 	struct spi_transfer *t;
-	u8 *local_buf;
 	int i = 0;
 	struct fsl_espi_transfer *espi_trans = trans;
 
-	local_buf = kzalloc(SPCOM_TRANLEN_MAX, GFP_KERNEL);
-	if (!local_buf) {
-		espi_trans->status = -ENOMEM;
-		return;
-	}
-
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (t->tx_buf) {
-			memcpy(local_buf + i, t->tx_buf, t->len);
+			memcpy(mspi->local_buf + i, t->tx_buf, t->len);
 			i += t->len;
 		}
 	}
 
-	espi_trans->tx_buf = local_buf;
-	espi_trans->rx_buf = local_buf;
+	espi_trans->tx_buf = espi_trans->rx_buf = mspi->local_buf;
 	fsl_espi_do_trans(m, espi_trans);
 
 	espi_trans->actual_length = espi_trans->len;
-	kfree(local_buf);
 }
 
 static void fsl_espi_rw_trans(struct spi_message *m,
 				struct fsl_espi_transfer *trans, u8 *rx_buff)
 {
+	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
 	struct spi_transfer *t;
-	u8 *local_buf;
 	unsigned int tx_only = 0;
 	int i = 0;
 
-	local_buf = kzalloc(SPCOM_TRANLEN_MAX, GFP_KERNEL);
-	if (!local_buf) {
-		trans->status = -ENOMEM;
-		return;
-	}
-
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (t->tx_buf) {
-			memcpy(local_buf + i, t->tx_buf, t->len);
+			memcpy(mspi->local_buf + i, t->tx_buf, t->len);
 			i += t->len;
 			if (!t->rx_buf)
 				tx_only += t->len;
 		}
 	}
 
-	trans->tx_buf = local_buf;
-	trans->rx_buf = local_buf;
+	trans->tx_buf = trans->rx_buf = mspi->local_buf;
 	fsl_espi_do_trans(m, trans);
 
 	if (!trans->status) {
@@ -379,13 +364,12 @@ static void fsl_espi_rw_trans(struct spi_message *m,
 			       trans->len - tx_only);
 		trans->actual_length += trans->len;
 	}
-
-	kfree(local_buf);
 }
 
 static int fsl_espi_do_one_msg(struct spi_master *master,
 			       struct spi_message *m)
 {
+	struct mpc8xxx_spi *mspi = spi_master_get_devdata(master);
 	struct spi_transfer *t;
 	u8 *rx_buf = NULL;
 	unsigned int n_tx = 0;
@@ -393,6 +377,8 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 	unsigned int xfer_len = 0;
 	struct fsl_espi_transfer espi_trans;
 
+	memset(mspi->local_buf, 0, SPCOM_TRANLEN_MAX);
+
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (t->tx_buf)
 			n_tx += t->len;
@@ -649,6 +635,13 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
 
+	mpc8xxx_spi->local_buf =
+		devm_kmalloc(dev, SPCOM_TRANLEN_MAX, GFP_KERNEL);
+	if (!mpc8xxx_spi->local_buf) {
+		ret = -ENOMEM;
+		goto err_probe;
+	}
+
 	mpc8xxx_spi->reg_base = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(mpc8xxx_spi->reg_base)) {
 		ret = PTR_ERR(mpc8xxx_spi->reg_base);
diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index 84f5dcb..065b9db 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -30,6 +30,7 @@ struct mpc8xxx_spi {
 	void *rx;
 #if IS_ENABLED(CONFIG_SPI_FSL_ESPI)
 	int len;
+	u8 *local_buf;
 #endif
 
 	int subblock;
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
