From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: pre-allocate message buffer" to the spi tree
Date: Mon, 12 Sep 2016 20:08:52 +0100
Message-ID: <E1bjWb6-0002x7-IS@debutante>
References: <c6fcea87-94b1-76e8-b8da-a7727a22282e@gmail.com>
Cc: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Felix Fietkau <nbd-Vt+b4OUoWG0@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c6fcea87-94b1-76e8-b8da-a7727a22282e-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: pre-allocate message buffer

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

>From 1423877b73ed5f4982eaba8bed359605b9918a2b Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 7 Sep 2016 22:50:22 +0200
Subject: [PATCH] spi: fsl-espi: pre-allocate message buffer

Currently the driver allocates a 64kb buffer for each single message.
On systems with little and fragmented memory this can result in
memory allocation errors. Solve this by pre-allocating a buffer.

This patch was developed in OpenWRT long ago, however it never
made it upstream.

I slightly modified the original patch to re-initialize the buffer
at the beginning of each transfer.

Signed-off-by: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Signed-off-by: Felix Fietkau <nbd-Vt+b4OUoWG0@public.gmane.org>
Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 41 ++++++++++++++++++-----------------------
 drivers/spi/spi-fsl-lib.h  |  1 +
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 16fff7237ab2..81d7416668b8 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -297,57 +297,44 @@ static void fsl_espi_do_trans(struct spi_message *m,
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
+	espi_trans->tx_buf = mspi->local_buf;
+	espi_trans->rx_buf = mspi->local_buf;
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
+	trans->tx_buf = mspi->local_buf;
+	trans->rx_buf = mspi->local_buf;
 	fsl_espi_do_trans(m, trans);
 
 	if (!trans->status) {
@@ -357,18 +344,19 @@ static void fsl_espi_rw_trans(struct spi_message *m,
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
 	unsigned int xfer_len = 0;
 	struct fsl_espi_transfer espi_trans;
 
+	memset(mspi->local_buf, 0, SPCOM_TRANLEN_MAX);
+
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (t->rx_buf)
 			rx_buf = t->rx_buf;
@@ -614,6 +602,13 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 
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
index 84f5dcb7a897..065b9db212cf 100644
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
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
