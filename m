From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: factor out handling of read data" to the spi tree
Date: Mon, 12 Sep 2016 20:07:37 +0100
Message-ID: <E1bjWZt-0002iR-7o@debutante>
References: <23b15e58-4833-7180-5c5d-81af382c54c0@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <23b15e58-4833-7180-5c5d-81af382c54c0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: factor out handling of read data

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

>From cce7e3a2fe39a5b66162a3dc1463a1af598d0803 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 7 Sep 2016 22:54:18 +0200
Subject: [PATCH] spi: fsl-espi: factor out handling of read data

Factor out copying read data to the read buffers in the original
message to a new function fsl_espi_copy_from_buf.
This also allows to simplify fsl_espi_copy_to_buf.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 7fc9a2c66396..2af7463aea8d 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -77,25 +77,32 @@ struct fsl_espi_reg {
 
 #define AUTOSUSPEND_TIMEOUT 2000
 
-static unsigned int fsl_espi_copy_to_buf(struct spi_message *m,
-					 struct mpc8xxx_spi *mspi)
+static void fsl_espi_copy_to_buf(struct spi_message *m,
+				 struct mpc8xxx_spi *mspi)
 {
-	unsigned int tx_only = 0;
 	struct spi_transfer *t;
 	u8 *buf = mspi->local_buf;
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->tx_buf) {
+		if (t->tx_buf)
 			memcpy(buf, t->tx_buf, t->len);
-			if (!t->rx_buf)
-				tx_only += t->len;
-		} else {
+		else
 			memset(buf, 0, t->len);
-		}
 		buf += t->len;
 	}
+}
+
+static void fsl_espi_copy_from_buf(struct spi_message *m,
+				   struct mpc8xxx_spi *mspi)
+{
+	struct spi_transfer *t;
+	u8 *buf = mspi->local_buf;
 
-	return tx_only;
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (t->rx_buf)
+			memcpy(t->rx_buf, buf, t->len);
+		buf += t->len;
+	}
 }
 
 static int fsl_espi_check_message(struct spi_message *m)
@@ -287,20 +294,17 @@ static int fsl_espi_do_trans(struct spi_message *m, struct spi_transfer *trans)
 	return ret;
 }
 
-static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans,
-			  u8 *rx_buff)
+static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
-	unsigned int tx_only;
 	int ret;
 
-	tx_only = fsl_espi_copy_to_buf(m, mspi);
+	fsl_espi_copy_to_buf(m, mspi);
 
 	ret = fsl_espi_do_trans(m, trans);
 
-	/* If there is at least one RX byte then copy it to rx_buff */
-	if (!ret && rx_buff && trans->len > tx_only)
-		memcpy(rx_buff, trans->rx_buf + tx_only, trans->len - tx_only);
+	if (!ret)
+		fsl_espi_copy_from_buf(m, mspi);
 
 	return ret;
 }
@@ -309,7 +313,6 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 			       struct spi_message *m)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
-	u8 *rx_buf = NULL;
 	unsigned int delay_usecs = 0, xfer_len = 0;
 	struct spi_transfer *t, trans = {};
 	int ret;
@@ -319,8 +322,6 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 		goto out;
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->rx_buf)
-			rx_buf = t->rx_buf;
 		if ((t->tx_buf) || (t->rx_buf))
 			xfer_len += t->len;
 		if (t->delay_usecs > delay_usecs)
@@ -337,7 +338,7 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 	trans.tx_buf = mspi->local_buf;
 	trans.rx_buf = mspi->local_buf;
 
-	ret = fsl_espi_trans(m, &trans, rx_buf);
+	ret = fsl_espi_trans(m, &trans);
 
 	m->actual_length = ret ? 0 : trans.len;
 out:
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
