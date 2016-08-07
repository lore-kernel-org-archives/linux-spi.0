From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] spi: fsl-espi: eliminate spi nor flash read loop
Date: Sun, 7 Aug 2016 21:49:30 +0200
Message-ID: <64289061-b779-1dcf-abd7-274a23e91b49@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The fsl-espi driver contains a read loop that implicitely assumes that
the device to read from is a m25p80 SPI NOR flash (bytes 2 - 4 of the
first write transfer are interpreted as 3 byte flash address).

Now that we have such a read loop in the spi-nor driver and are able
to correctly indicate the message size limit of the controller, the
read loop can be removed from the fsl-espi driver.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 88 +++++++++++-----------------------------------
 1 file changed, 20 insertions(+), 68 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 8d85a3c..f3ff65f 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -258,23 +258,6 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	return mpc8xxx_spi->count;
 }
 
-static inline void fsl_espi_addr2cmd(unsigned int addr, u8 *cmd)
-{
-	if (cmd) {
-		cmd[1] = (u8)(addr >> 16);
-		cmd[2] = (u8)(addr >> 8);
-		cmd[3] = (u8)(addr >> 0);
-	}
-}
-
-static inline unsigned int fsl_espi_cmd2addr(u8 *cmd)
-{
-	if (cmd)
-		return cmd[1] << 16 | cmd[2] << 8 | cmd[3] << 0;
-
-	return 0;
-}
-
 static void fsl_espi_do_trans(struct spi_message *m,
 				struct fsl_espi_transfer *tr)
 {
@@ -366,68 +349,36 @@ static void fsl_espi_cmd_trans(struct spi_message *m,
 static void fsl_espi_rw_trans(struct spi_message *m,
 				struct fsl_espi_transfer *trans, u8 *rx_buff)
 {
-	struct fsl_espi_transfer *espi_trans = trans;
-	unsigned int total_len = espi_trans->len;
 	struct spi_transfer *t;
 	u8 *local_buf;
-	u8 *rx_buf = rx_buff;
-	unsigned int trans_len;
-	unsigned int addr;
-	unsigned int tx_only;
-	unsigned int rx_pos = 0;
-	unsigned int pos;
-	int i, loop;
+	unsigned int tx_only = 0;
+	int i = 0;
 
 	local_buf = kzalloc(SPCOM_TRANLEN_MAX, GFP_KERNEL);
 	if (!local_buf) {
-		espi_trans->status = -ENOMEM;
+		trans->status = -ENOMEM;
 		return;
 	}
 
-	for (pos = 0, loop = 0; pos < total_len; pos += trans_len, loop++) {
-		trans_len = total_len - pos;
-
-		i = 0;
-		tx_only = 0;
-		list_for_each_entry(t, &m->transfers, transfer_list) {
-			if (t->tx_buf) {
-				memcpy(local_buf + i, t->tx_buf, t->len);
-				i += t->len;
-				if (!t->rx_buf)
-					tx_only += t->len;
-			}
-		}
-
-		/* Add additional TX bytes to compensate SPCOM_TRANLEN_MAX */
-		if (loop > 0)
-			trans_len += tx_only;
-
-		if (trans_len > SPCOM_TRANLEN_MAX)
-			trans_len = SPCOM_TRANLEN_MAX;
-
-		/* Update device offset */
-		if (pos > 0) {
-			addr = fsl_espi_cmd2addr(local_buf);
-			addr += rx_pos;
-			fsl_espi_addr2cmd(addr, local_buf);
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (t->tx_buf) {
+			memcpy(local_buf + i, t->tx_buf, t->len);
+			i += t->len;
+			if (!t->rx_buf)
+				tx_only += t->len;
 		}
+	}
 
-		espi_trans->len = trans_len;
-		espi_trans->tx_buf = local_buf;
-		espi_trans->rx_buf = local_buf;
-		fsl_espi_do_trans(m, espi_trans);
-
-		/* If there is at least one RX byte then copy it to rx_buf */
-		if (tx_only < SPCOM_TRANLEN_MAX)
-			memcpy(rx_buf + rx_pos, espi_trans->rx_buf + tx_only,
-					trans_len - tx_only);
-
-		rx_pos += trans_len - tx_only;
+	trans->tx_buf = local_buf;
+	trans->rx_buf = local_buf;
+	fsl_espi_do_trans(m, trans);
 
-		if (loop > 0)
-			espi_trans->actual_length += espi_trans->len - tx_only;
-		else
-			espi_trans->actual_length += espi_trans->len;
+	if (!trans->status) {
+		/* If there is at least one RX byte then copy it to rx_buff */
+		if (trans->len > tx_only)
+			memcpy(rx_buff, trans->rx_buf + tx_only,
+			       trans->len - tx_only);
+		trans->actual_length += trans->len;
 	}
 
 	kfree(local_buf);
@@ -696,6 +647,7 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	master->transfer_one_message = fsl_espi_do_one_msg;
 	master->auto_runtime_pm = true;
 	master->max_transfer_size = fsl_espi_max_transfer_size;
+	master->max_message_size_flag = true;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
 
-- 
2.9.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
