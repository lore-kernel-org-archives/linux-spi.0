From: Zhiqiang Hou <Zhiqiang.Hou-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 2/2] spi/fsl-espi: Remove the address conversion operation
Date: Fri, 22 Jan 2016 18:58:27 +0800
Message-ID: <1453460307-9768-2-git-send-email-Zhiqiang.Hou@freescale.com>
References: <1453460307-9768-1-git-send-email-Zhiqiang.Hou@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, <Shaohui.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453460307-9768-1-git-send-email-Zhiqiang.Hou-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

The eSPI bus driver should not touch the protocol layer drivers'
operations. It makes the eSPI driver isn't compatiable with devices
except 3-Byte addressing SPI flash. So, remove the address
conversion operations to make it compatible for most SPI interface
devices.

The eSPI controller is able to transfer maxminum 64KiB each time.
If the transaction length exceed the limited length, the eSPI
controller driver will add the address by length of the last time
transferred with assuming that the SPI flash address width is 3
Bytes.

With this patch, if the transaction length exceed the limited
length, it will truncate the transaction to max-length and return
the actual length transferred.

Signed-off-by: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 Tested on T1042D4RDB.
 This patch depend on patchset:
 http://patchwork.ozlabs.org/patch/551304/
 http://patchwork.ozlabs.org/patch/551308/
 http://patchwork.ozlabs.org/patch/551305/
 http://patchwork.ozlabs.org/patch/551306/
 http://patchwork.ozlabs.org/patch/551309/
 http://patchwork.ozlabs.org/patch/551307/
 http://patchwork.ozlabs.org/patch/551310/
 http://patchwork.ozlabs.org/patch/551311/
 and patch:
 http://patchwork.ozlabs.org/patch/571581/

 drivers/spi/spi-fsl-espi.c | 84 ++++++++++++----------------------------------
 1 file changed, 21 insertions(+), 63 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 7cb0c19..66ebb02 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -253,23 +253,6 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
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
@@ -366,12 +349,9 @@ static void fsl_espi_rw_trans(struct spi_message *m,
 	struct spi_transfer *t;
 	u8 *local_buf;
 	u8 *rx_buf = rx_buff;
-	unsigned int trans_len;
-	unsigned int addr;
-	unsigned int tx_only;
-	unsigned int rx_pos = 0;
-	unsigned int pos;
-	int i, loop;
+	unsigned int trans_len = total_len;
+	unsigned int tx_only = 0;
+	int i = 0;
 
 	local_buf = kzalloc(SPCOM_TRANLEN_MAX, GFP_KERNEL);
 	if (!local_buf) {
@@ -379,51 +359,29 @@ static void fsl_espi_rw_trans(struct spi_message *m,
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
+	if (trans_len > SPCOM_TRANLEN_MAX)
+		trans_len = SPCOM_TRANLEN_MAX;
 
-		/* If there is at least one RX byte then copy it to rx_buf */
-		if (tx_only < SPCOM_TRANLEN_MAX)
-			memcpy(rx_buf + rx_pos, espi_trans->rx_buf + tx_only,
-					trans_len - tx_only);
+	espi_trans->len = trans_len;
+	espi_trans->tx_buf = local_buf;
+	espi_trans->rx_buf = local_buf;
+	fsl_espi_do_trans(m, espi_trans);
 
-		rx_pos += trans_len - tx_only;
+	/* If there is at least one RX byte then copy it to rx_buf */
+	if (tx_only < SPCOM_TRANLEN_MAX)
+		memcpy(rx_buf, espi_trans->rx_buf + tx_only,
+				trans_len - tx_only);
 
-		if (loop > 0)
-			espi_trans->actual_length += espi_trans->len - tx_only;
-		else
-			espi_trans->actual_length += espi_trans->len;
-	}
+	espi_trans->actual_length += espi_trans->len;
 
 	kfree(local_buf);
 }
-- 
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
