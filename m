From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: eliminate spi nor flash read loop" to the spi tree
Date: Thu, 18 Aug 2016 11:17:42 +0100
Message-ID: <E1baKOM-00029K-Bi@debutante>
References: <b66e4ae5-3528-5141-e1fe-90c19ffcb7ac@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b66e4ae5-3528-5141-e1fe-90c19ffcb7ac-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: eliminate spi nor flash read loop

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

>From 02a595d5d6e4ecc0564ec31afb76202035a7591c Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 17 Aug 2016 21:11:01 +0200
Subject: [PATCH] spi: fsl-espi: eliminate spi nor flash read loop

The fsl-espi driver contains a read loop that implicitely assumes that
the device to read from is a m25p80 SPI NOR flash (bytes 2 - 4 of the
first write transfer are interpreted as 3 byte flash address).

Now that we have such a read loop in the spi-nor driver and are able
to correctly indicate the message size limit of the controller,
the read loop can be removed from the fsl-espi driver.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 91 +++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 70 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 8d85a3c343da..96a2442c1623 100644
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
@@ -663,7 +614,7 @@ static int fsl_espi_runtime_resume(struct device *dev)
 }
 #endif
 
-static size_t fsl_espi_max_transfer_size(struct spi_device *spi)
+static size_t fsl_espi_max_message_size(struct spi_device *spi)
 {
 	return SPCOM_TRANLEN_MAX;
 }
@@ -695,7 +646,7 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	master->cleanup = fsl_espi_cleanup;
 	master->transfer_one_message = fsl_espi_do_one_msg;
 	master->auto_runtime_pm = true;
-	master->max_transfer_size = fsl_espi_max_transfer_size;
+	master->max_message_size = fsl_espi_max_message_size;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
 
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
