From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: centralize populating struct spi_transfer" to the spi tree
Date: Mon, 12 Sep 2016 20:07:40 +0100
Message-ID: <E1bjWZw-0002jE-87@debutante>
References: <fc3ba27b-b7e1-a093-23d2-82956b8476c5@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fc3ba27b-b7e1-a093-23d2-82956b8476c5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: centralize populating struct spi_transfer

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

>From 96361fafbbfc8a07b4c7ec09d96d742ef68bfbad Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 7 Sep 2016 22:54:00 +0200
Subject: [PATCH] spi: fsl-espi: centralize populating struct spi_transfer

Better structure the code by population all elements of struct
spi_transfer in one place.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 2bfaff64beb8..7fc9a2c66396 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -272,17 +272,8 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 static int fsl_espi_do_trans(struct spi_message *m, struct spi_transfer *trans)
 {
 	struct spi_device *spi = m->spi;
-	struct spi_transfer *t, *first;
 	int ret = 0;
 
-	first = list_first_entry(&m->transfers, struct spi_transfer,
-			transfer_list);
-	list_for_each_entry(t, &m->transfers, transfer_list) {
-		trans->speed_hz = t->speed_hz;
-		trans->bits_per_word = t->bits_per_word;
-		trans->delay_usecs = max(first->delay_usecs, t->delay_usecs);
-	}
-
 	fsl_espi_setup_transfer(spi, trans);
 
 	if (trans->len)
@@ -305,8 +296,6 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans,
 
 	tx_only = fsl_espi_copy_to_buf(m, mspi);
 
-	trans->tx_buf = mspi->local_buf;
-	trans->rx_buf = mspi->local_buf;
 	ret = fsl_espi_do_trans(m, trans);
 
 	/* If there is at least one RX byte then copy it to rx_buff */
@@ -319,8 +308,9 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans,
 static int fsl_espi_do_one_msg(struct spi_master *master,
 			       struct spi_message *m)
 {
+	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
 	u8 *rx_buf = NULL;
-	unsigned int xfer_len = 0;
+	unsigned int delay_usecs = 0, xfer_len = 0;
 	struct spi_transfer *t, trans = {};
 	int ret;
 
@@ -333,9 +323,19 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 			rx_buf = t->rx_buf;
 		if ((t->tx_buf) || (t->rx_buf))
 			xfer_len += t->len;
+		if (t->delay_usecs > delay_usecs)
+			delay_usecs = t->delay_usecs;
 	}
 
+	t = list_first_entry(&m->transfers, struct spi_transfer,
+			     transfer_list);
+
 	trans.len = xfer_len;
+	trans.speed_hz = t->speed_hz;
+	trans.bits_per_word = t->bits_per_word;
+	trans.delay_usecs = delay_usecs;
+	trans.tx_buf = mspi->local_buf;
+	trans.rx_buf = mspi->local_buf;
 
 	ret = fsl_espi_trans(m, &trans, rx_buf);
 
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
