From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: eliminate struct fsl_espi_transfer" to the spi tree
Date: Mon, 12 Sep 2016 20:08:37 +0100
Message-ID: <E1bjWar-0002si-KP@debutante>
References: <2872c612-a0c4-581f-4880-80bf7f8af9f9@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2872c612-a0c4-581f-4880-80bf7f8af9f9-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: eliminate struct fsl_espi_transfer

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

>From faceef390702bad8bdf9c93554a3364253d9d943 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 7 Sep 2016 22:52:06 +0200
Subject: [PATCH] spi: fsl-espi: eliminate struct fsl_espi_transfer

The remaining elements of struct fsl_espi_transfer are part of struct
spi_transfer anyway. So we can get rid of struct fsl_espi_transfer
and use a struct spi_transfer only.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 56 +++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 36 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 726d5fdca3b6..8554f18e4cf6 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -37,12 +37,6 @@ struct fsl_espi_reg {
 	__be32 csmode[4];	/* 0x020 - 0x02c eSPI cs mode register */
 };
 
-struct fsl_espi_transfer {
-	const void *tx_buf;
-	void *rx_buf;
-	unsigned len;
-};
-
 /* eSPI Controller mode register definitions */
 #define SPMODE_ENABLE		(1 << 31)
 #define SPMODE_LOOP		(1 << 30)
@@ -267,17 +261,13 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	return mpc8xxx_spi->count;
 }
 
-static int fsl_espi_do_trans(struct spi_message *m,
-			     struct fsl_espi_transfer *tr)
+static int fsl_espi_do_trans(struct spi_message *m, struct spi_transfer *trans)
 {
 	struct spi_device *spi = m->spi;
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
-	struct fsl_espi_transfer *espi_trans = tr;
-	struct spi_transfer *t, *first, trans;
+	struct spi_transfer *t, *first;
 	int ret = 0;
 
-	memset(&trans, 0, sizeof(trans));
-
 	first = list_first_entry(&m->transfers, struct spi_transfer,
 			transfer_list);
 	list_for_each_entry(t, &m->transfers, transfer_list) {
@@ -288,25 +278,21 @@ static int fsl_espi_do_trans(struct spi_message *m,
 			return -EINVAL;
 		}
 
-		trans.speed_hz = t->speed_hz;
-		trans.bits_per_word = t->bits_per_word;
-		trans.delay_usecs = max(first->delay_usecs, t->delay_usecs);
+		trans->speed_hz = t->speed_hz;
+		trans->bits_per_word = t->bits_per_word;
+		trans->delay_usecs = max(first->delay_usecs, t->delay_usecs);
 	}
 
-	trans.len = espi_trans->len;
-	trans.tx_buf = espi_trans->tx_buf;
-	trans.rx_buf = espi_trans->rx_buf;
-
-	fsl_espi_setup_transfer(spi, &trans);
+	fsl_espi_setup_transfer(spi, trans);
 
-	if (trans.len)
-		ret = fsl_espi_bufs(spi, &trans);
+	if (trans->len)
+		ret = fsl_espi_bufs(spi, trans);
 
 	if (ret)
 		ret = -EMSGSIZE;
 
-	if (trans.delay_usecs)
-		udelay(trans.delay_usecs);
+	if (trans->delay_usecs)
+		udelay(trans->delay_usecs);
 
 	fsl_espi_setup_transfer(spi, NULL);
 
@@ -314,23 +300,22 @@ static int fsl_espi_do_trans(struct spi_message *m,
 }
 
 static int fsl_espi_cmd_trans(struct spi_message *m,
-			      struct fsl_espi_transfer *trans, u8 *rx_buff)
+			      struct spi_transfer *trans, u8 *rx_buff)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
-	struct fsl_espi_transfer *espi_trans = trans;
 	int ret;
 
 	fsl_espi_copy_to_buf(m, mspi);
 
-	espi_trans->tx_buf = mspi->local_buf;
-	espi_trans->rx_buf = mspi->local_buf;
-	ret = fsl_espi_do_trans(m, espi_trans);
+	trans->tx_buf = mspi->local_buf;
+	trans->rx_buf = mspi->local_buf;
+	ret = fsl_espi_do_trans(m, trans);
 
 	return ret;
 }
 
 static int fsl_espi_rw_trans(struct spi_message *m,
-			     struct fsl_espi_transfer *trans, u8 *rx_buff)
+			     struct spi_transfer *trans, u8 *rx_buff)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
 	unsigned int tx_only;
@@ -355,10 +340,9 @@ static int fsl_espi_rw_trans(struct spi_message *m,
 static int fsl_espi_do_one_msg(struct spi_master *master,
 			       struct spi_message *m)
 {
-	struct spi_transfer *t;
 	u8 *rx_buf = NULL;
 	unsigned int xfer_len = 0;
-	struct fsl_espi_transfer espi_trans;
+	struct spi_transfer *t, trans = {};
 	int ret;
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
@@ -368,14 +352,14 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 			xfer_len += t->len;
 	}
 
-	espi_trans.len = xfer_len;
+	trans.len = xfer_len;
 
 	if (!rx_buf)
-		ret = fsl_espi_cmd_trans(m, &espi_trans, NULL);
+		ret = fsl_espi_cmd_trans(m, &trans, NULL);
 	else
-		ret = fsl_espi_rw_trans(m, &espi_trans, rx_buf);
+		ret = fsl_espi_rw_trans(m, &trans, rx_buf);
 
-	m->actual_length = ret ? 0 : espi_trans.len;
+	m->actual_length = ret ? 0 : trans.len;
 
 	if (m->status == -EINPROGRESS)
 		m->status = ret;
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
