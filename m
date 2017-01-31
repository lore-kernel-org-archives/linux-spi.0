From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: bcm-qspi: Added mspi read fallback in bcm_qspi_flash_read()" to the spi tree
Date: Tue, 31 Jan 2017 21:20:24 +0000
Message-ID: <E1cYfqi-00023P-7c@debutante>
References: <1485810676-19742-1-git-send-email-kdasu.kdev@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1485810676-19742-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: bcm-qspi: Added mspi read fallback in bcm_qspi_flash_read()

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

>From 81ab52fd94f32aaa8a9c27b41934e4ae932ca106 Mon Sep 17 00:00:00 2001
From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Mon, 30 Jan 2017 16:11:16 -0500
Subject: [PATCH] spi: bcm-qspi: Added mspi read fallback in
 bcm_qspi_flash_read()

Added mspi read fallback under certain circumstances like unaligned
buffer, address on short reads. Also takes care of version 3.0 spi
controller where flash address crosses 4MB boundary on transfers the
driver resorts to mspi reads.

Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-bcm-qspi.c | 116 +++++++++++++++++++++++++++++++++------------
 1 file changed, 85 insertions(+), 31 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 14f9dea3173f..b50b6dfc8c48 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -192,9 +192,11 @@ struct bcm_qspi_dev_id {
 	void *dev;
 };
 
+
 struct qspi_trans {
 	struct spi_transfer *trans;
 	int byte;
+	bool mspi_last_trans;
 };
 
 struct bcm_qspi {
@@ -616,6 +618,16 @@ static int bcm_qspi_setup(struct spi_device *spi)
 	return 0;
 }
 
+static bool bcm_qspi_mspi_transfer_is_last(struct bcm_qspi *qspi,
+					   struct qspi_trans *qt)
+{
+	if (qt->mspi_last_trans &&
+	    spi_transfer_is_last(qspi->master, qt->trans))
+		return true;
+	else
+		return false;
+}
+
 static int update_qspi_trans_byte_count(struct bcm_qspi *qspi,
 					struct qspi_trans *qt, int flags)
 {
@@ -629,7 +641,6 @@ static int update_qspi_trans_byte_count(struct bcm_qspi *qspi,
 
 	if (qt->byte >= qt->trans->len) {
 		/* we're at the end of the spi_transfer */
-
 		/* in TX mode, need to pause for a delay or CS change */
 		if (qt->trans->delay_usecs &&
 		    (flags & TRANS_STATUS_BREAK_DELAY))
@@ -641,7 +652,7 @@ static int update_qspi_trans_byte_count(struct bcm_qspi *qspi,
 			goto done;
 
 		dev_dbg(&qspi->pdev->dev, "advance msg exit\n");
-		if (spi_transfer_is_last(qspi->master, qt->trans))
+		if (bcm_qspi_mspi_transfer_is_last(qspi, qt))
 			ret = TRANS_STATUS_BREAK_EOM;
 		else
 			ret = TRANS_STATUS_BREAK_NO_BYTES;
@@ -885,6 +896,76 @@ static int bcm_qspi_bspi_flash_read(struct spi_device *spi,
 	return ret;
 }
 
+static int bcm_qspi_transfer_one(struct spi_master *master,
+				 struct spi_device *spi,
+				 struct spi_transfer *trans)
+{
+	struct bcm_qspi *qspi = spi_master_get_devdata(master);
+	int slots;
+	unsigned long timeo = msecs_to_jiffies(100);
+
+	bcm_qspi_chip_select(qspi, spi->chip_select);
+	qspi->trans_pos.trans = trans;
+	qspi->trans_pos.byte = 0;
+
+	while (qspi->trans_pos.byte < trans->len) {
+		reinit_completion(&qspi->mspi_done);
+
+		slots = write_to_hw(qspi, spi);
+		if (!wait_for_completion_timeout(&qspi->mspi_done, timeo)) {
+			dev_err(&qspi->pdev->dev, "timeout waiting for MSPI\n");
+			return -ETIMEDOUT;
+		}
+
+		read_from_hw(qspi, slots);
+	}
+
+	return 0;
+}
+
+static int bcm_qspi_mspi_flash_read(struct spi_device *spi,
+				    struct spi_flash_read_message *msg)
+{
+	struct bcm_qspi *qspi = spi_master_get_devdata(spi->master);
+	struct spi_transfer t[2];
+	u8 cmd[6];
+	int ret;
+
+	memset(cmd, 0, sizeof(cmd));
+	memset(t, 0, sizeof(t));
+
+	/* tx */
+	/* opcode is in cmd[0] */
+	cmd[0] = msg->read_opcode;
+	cmd[1] = msg->from >> (msg->addr_width * 8 -  8);
+	cmd[2] = msg->from >> (msg->addr_width * 8 - 16);
+	cmd[3] = msg->from >> (msg->addr_width * 8 - 24);
+	cmd[4] = msg->from >> (msg->addr_width * 8 - 32);
+	t[0].tx_buf = cmd;
+	t[0].len = msg->addr_width + msg->dummy_bytes + 1;
+	t[0].bits_per_word = spi->bits_per_word;
+	t[0].tx_nbits = msg->opcode_nbits;
+	/* lets mspi know that this is not last transfer */
+	qspi->trans_pos.mspi_last_trans = false;
+	ret = bcm_qspi_transfer_one(spi->master, spi, &t[0]);
+
+	/* rx */
+	qspi->trans_pos.mspi_last_trans = true;
+	if (!ret) {
+		/* rx */
+		t[1].rx_buf = msg->buf;
+		t[1].len = msg->len;
+		t[1].rx_nbits =  msg->data_nbits;
+		t[1].bits_per_word = spi->bits_per_word;
+		ret = bcm_qspi_transfer_one(spi->master, spi, &t[1]);
+	}
+
+	if (!ret)
+		msg->retlen = msg->len;
+
+	return ret;
+}
+
 static int bcm_qspi_flash_read(struct spi_device *spi,
 			       struct spi_flash_read_message *msg)
 {
@@ -918,8 +999,7 @@ static int bcm_qspi_flash_read(struct spi_device *spi,
 		mspi_read = true;
 
 	if (mspi_read)
-		/* this will make the m25p80 read to fallback to mspi read */
-		return -EAGAIN;
+		return bcm_qspi_mspi_flash_read(spi, msg);
 
 	io_width = msg->data_nbits ? msg->data_nbits : SPI_NBITS_SINGLE;
 	addrlen = msg->addr_width;
@@ -931,33 +1011,6 @@ static int bcm_qspi_flash_read(struct spi_device *spi,
 	return ret;
 }
 
-static int bcm_qspi_transfer_one(struct spi_master *master,
-				 struct spi_device *spi,
-				 struct spi_transfer *trans)
-{
-	struct bcm_qspi *qspi = spi_master_get_devdata(master);
-	int slots;
-	unsigned long timeo = msecs_to_jiffies(100);
-
-	bcm_qspi_chip_select(qspi, spi->chip_select);
-	qspi->trans_pos.trans = trans;
-	qspi->trans_pos.byte = 0;
-
-	while (qspi->trans_pos.byte < trans->len) {
-		reinit_completion(&qspi->mspi_done);
-
-		slots = write_to_hw(qspi, spi);
-		if (!wait_for_completion_timeout(&qspi->mspi_done, timeo)) {
-			dev_err(&qspi->pdev->dev, "timeout waiting for MSPI\n");
-			return -ETIMEDOUT;
-		}
-
-		read_from_hw(qspi, slots);
-	}
-
-	return 0;
-}
-
 static void bcm_qspi_cleanup(struct spi_device *spi)
 {
 	struct bcm_qspi_parms *xp = spi_get_ctldata(spi);
@@ -1187,6 +1240,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	qspi->pdev = pdev;
 	qspi->trans_pos.trans = NULL;
 	qspi->trans_pos.byte = 0;
+	qspi->trans_pos.mspi_last_trans = true;
 	qspi->master = master;
 
 	master->bus_num = -1;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
