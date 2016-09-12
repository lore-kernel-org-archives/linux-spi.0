From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: factor out filling the local buffer" to the spi tree
Date: Mon, 12 Sep 2016 20:08:49 +0100
Message-ID: <E1bjWb3-0002w5-IS@debutante>
References: <75a01618-11f4-d54c-4cb7-21e1ed40951a@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <75a01618-11f4-d54c-4cb7-21e1ed40951a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: factor out filling the local buffer

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

>From 7c159aa8c103b02a8434ae18b22048952c796e6f Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 7 Sep 2016 22:50:53 +0200
Subject: [PATCH] spi: fsl-espi: factor out filling the local buffer

Better structure the code by factoring out filling the local buffer.

In addition don't initialize the complete local buffer at the
beginning of fsl_espi_do_one_msg. Instead move initialization of
those parts of the local buffer to be used for transfers w/o tx_buf
to fsl_espi_copy_to_buf.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 81d7416668b8..8e6ef9b153d7 100644
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
@@ -298,16 +319,9 @@ static void fsl_espi_cmd_trans(struct spi_message *m,
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
@@ -320,18 +334,9 @@ static void fsl_espi_rw_trans(struct spi_message *m,
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
@@ -349,14 +354,11 @@ static void fsl_espi_rw_trans(struct spi_message *m,
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
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
