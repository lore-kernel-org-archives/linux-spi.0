From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: remove element actual_length from struct fsl_espi_trans" to the spi tree
Date: Mon, 12 Sep 2016 20:08:40 +0100
Message-ID: <E1bjWau-0002tW-LB@debutante>
References: <ebb38b20-1977-9980-9042-cefaac7ed765@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ebb38b20-1977-9980-9042-cefaac7ed765-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: remove element actual_length from struct fsl_espi_trans

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

>From 5cd7b8be6b7b4c4fb9e2bfbfba596d27357cc359 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 7 Sep 2016 22:51:48 +0200
Subject: [PATCH] spi: fsl-espi: remove element actual_length from struct
 fsl_espi_trans

If an error occurs during processing the message, then we don't have
to populate the actual_length element of struct message.
So we can get rid of element actual_length in struct
fsl_espi_transfer.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 6b60f7b29869..726d5fdca3b6 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -41,7 +41,6 @@ struct fsl_espi_transfer {
 	const void *tx_buf;
 	void *rx_buf;
 	unsigned len;
-	unsigned actual_length;
 };
 
 /* eSPI Controller mode register definitions */
@@ -327,8 +326,6 @@ static int fsl_espi_cmd_trans(struct spi_message *m,
 	espi_trans->rx_buf = mspi->local_buf;
 	ret = fsl_espi_do_trans(m, espi_trans);
 
-	espi_trans->actual_length = espi_trans->len;
-
 	return ret;
 }
 
@@ -350,7 +347,6 @@ static int fsl_espi_rw_trans(struct spi_message *m,
 		if (trans->len > tx_only)
 			memcpy(rx_buff, trans->rx_buf + tx_only,
 			       trans->len - tx_only);
-		trans->actual_length += trans->len;
 	}
 
 	return ret;
@@ -373,14 +369,14 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 	}
 
 	espi_trans.len = xfer_len;
-	espi_trans.actual_length = 0;
 
 	if (!rx_buf)
 		ret = fsl_espi_cmd_trans(m, &espi_trans, NULL);
 	else
 		ret = fsl_espi_rw_trans(m, &espi_trans, rx_buf);
 
-	m->actual_length = espi_trans.actual_length;
+	m->actual_length = ret ? 0 : espi_trans.len;
+
 	if (m->status == -EINPROGRESS)
 		m->status = ret;
 
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
