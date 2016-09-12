From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: improve message length handling" to the spi tree
Date: Mon, 12 Sep 2016 20:07:19 +0100
Message-ID: <E1bjWZb-0002gp-CV@debutante>
References: <aac7ea51-62ea-69b9-a149-2209e0766905@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <aac7ea51-62ea-69b9-a149-2209e0766905-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: improve message length handling

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

>From 06af115d6c6d8b3d7b6cbc8a46f0603e70b1be58 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 7 Sep 2016 22:54:35 +0200
Subject: [PATCH] spi: fsl-espi: improve message length handling

Move checking for a zero-length message up in the call chain and
use m->frame_length instead of re-calculating the overall length
of all transfers in the message.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 2af7463aea8d..7b2f997b061f 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -283,8 +283,7 @@ static int fsl_espi_do_trans(struct spi_message *m, struct spi_transfer *trans)
 
 	fsl_espi_setup_transfer(spi, trans);
 
-	if (trans->len)
-		ret = fsl_espi_bufs(spi, trans);
+	ret = fsl_espi_bufs(spi, trans);
 
 	if (trans->delay_usecs)
 		udelay(trans->delay_usecs);
@@ -313,7 +312,7 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 			       struct spi_message *m)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
-	unsigned int delay_usecs = 0, xfer_len = 0;
+	unsigned int delay_usecs = 0;
 	struct spi_transfer *t, trans = {};
 	int ret;
 
@@ -322,8 +321,6 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 		goto out;
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if ((t->tx_buf) || (t->rx_buf))
-			xfer_len += t->len;
 		if (t->delay_usecs > delay_usecs)
 			delay_usecs = t->delay_usecs;
 	}
@@ -331,14 +328,15 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 	t = list_first_entry(&m->transfers, struct spi_transfer,
 			     transfer_list);
 
-	trans.len = xfer_len;
+	trans.len = m->frame_length;
 	trans.speed_hz = t->speed_hz;
 	trans.bits_per_word = t->bits_per_word;
 	trans.delay_usecs = delay_usecs;
 	trans.tx_buf = mspi->local_buf;
 	trans.rx_buf = mspi->local_buf;
 
-	ret = fsl_espi_trans(m, &trans);
+	if (trans.len)
+		ret = fsl_espi_trans(m, &trans);
 
 	m->actual_length = ret ? 0 : trans.len;
 out:
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
