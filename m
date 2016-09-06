From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: remove unused elements n_rx and n_tx in struct fsl_espi_transfer" to the spi tree
Date: Tue, 06 Sep 2016 12:29:52 +0100
Message-ID: <E1bhEZc-000488-3R@finisterre>
References: <52c5893a-5927-4c83-4838-d618d434922c@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52c5893a-5927-4c83-4838-d618d434922c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: remove unused elements n_rx and n_tx in struct fsl_espi_transfer

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

>From daae020ce9fe4324322c6ed18a840234a05d76b3 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sun, 4 Sep 2016 09:53:01 +0200
Subject: [PATCH] spi: fsl-espi: remove unused elements n_rx and n_tx in struct
 fsl_espi_transfer

Both elements are not used, so remove them.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index f9ef50444447..a9004fe5a5ed 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -41,8 +41,6 @@ struct fsl_espi_transfer {
 	const void *tx_buf;
 	void *rx_buf;
 	unsigned len;
-	unsigned n_tx;
-	unsigned n_rx;
 	unsigned actual_length;
 	int status;
 };
@@ -371,24 +369,16 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 {
 	struct spi_transfer *t;
 	u8 *rx_buf = NULL;
-	unsigned int n_tx = 0;
-	unsigned int n_rx = 0;
 	unsigned int xfer_len = 0;
 	struct fsl_espi_transfer espi_trans;
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->tx_buf)
-			n_tx += t->len;
-		if (t->rx_buf) {
-			n_rx += t->len;
+		if (t->rx_buf)
 			rx_buf = t->rx_buf;
-		}
 		if ((t->tx_buf) || (t->rx_buf))
 			xfer_len += t->len;
 	}
 
-	espi_trans.n_tx = n_tx;
-	espi_trans.n_rx = n_rx;
 	espi_trans.len = xfer_len;
 	espi_trans.actual_length = 0;
 	espi_trans.status = 0;
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
