From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: merge fsl_espi_cmd_trans and fsl_espi_rw_trans" to the spi tree
Date: Mon, 12 Sep 2016 20:08:34 +0100
Message-ID: <E1bjWao-0002ry-2d@debutante>
References: <5cf9843f-11c0-4a14-d7ec-66522592ece9@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5cf9843f-11c0-4a14-d7ec-66522592ece9-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: merge fsl_espi_cmd_trans and fsl_espi_rw_trans

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

>From 809b1e017bbdaf40d35619e41c1dbc542a5449d2 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 7 Sep 2016 22:52:25 +0200
Subject: [PATCH] spi: fsl-espi: merge fsl_espi_cmd_trans and fsl_espi_rw_trans

fsl_espi_cmd_trans and fsl_espi_rw_trans share most of the code so
we can merge them.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 8554f18e4cf6..f8a6dd13ee02 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -299,23 +299,8 @@ static int fsl_espi_do_trans(struct spi_message *m, struct spi_transfer *trans)
 	return ret;
 }
 
-static int fsl_espi_cmd_trans(struct spi_message *m,
-			      struct spi_transfer *trans, u8 *rx_buff)
-{
-	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
-	int ret;
-
-	fsl_espi_copy_to_buf(m, mspi);
-
-	trans->tx_buf = mspi->local_buf;
-	trans->rx_buf = mspi->local_buf;
-	ret = fsl_espi_do_trans(m, trans);
-
-	return ret;
-}
-
-static int fsl_espi_rw_trans(struct spi_message *m,
-			     struct spi_transfer *trans, u8 *rx_buff)
+static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans,
+			  u8 *rx_buff)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
 	unsigned int tx_only;
@@ -327,12 +312,9 @@ static int fsl_espi_rw_trans(struct spi_message *m,
 	trans->rx_buf = mspi->local_buf;
 	ret = fsl_espi_do_trans(m, trans);
 
-	if (!ret) {
-		/* If there is at least one RX byte then copy it to rx_buff */
-		if (trans->len > tx_only)
-			memcpy(rx_buff, trans->rx_buf + tx_only,
-			       trans->len - tx_only);
-	}
+	/* If there is at least one RX byte then copy it to rx_buff */
+	if (!ret && rx_buff && trans->len > tx_only)
+		memcpy(rx_buff, trans->rx_buf + tx_only, trans->len - tx_only);
 
 	return ret;
 }
@@ -354,10 +336,7 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 
 	trans.len = xfer_len;
 
-	if (!rx_buf)
-		ret = fsl_espi_cmd_trans(m, &trans, NULL);
-	else
-		ret = fsl_espi_rw_trans(m, &trans, rx_buf);
+	ret = fsl_espi_trans(m, &trans, rx_buf);
 
 	m->actual_length = ret ? 0 : trans.len;
 
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
