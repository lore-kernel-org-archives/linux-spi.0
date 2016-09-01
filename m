From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: remove unneeded variable in fsl_espi_do_trans" to the spi tree
Date: Thu, 01 Sep 2016 21:35:31 +0100
Message-ID: <E1bfYhv-0002y8-0j@debutante>
References: <683bca81-4522-78d7-338f-0e1a137f4f4f@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <683bca81-4522-78d7-338f-0e1a137f4f4f-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: remove unneeded variable in fsl_espi_do_trans

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

>From dbd4fefb5b7cba19e3f89c097d93ad02049e38e3 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Thu, 25 Aug 2016 06:45:55 +0200
Subject: [PATCH] spi: fsl-espi: remove unneeded variable in fsl_espi_do_trans

Creating a message, adding one transfer, and then iterating over
all transfers in the message doesn't make sense.
We can simply use the original transfer directly.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 029017818685..f9ef50444447 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -258,11 +258,9 @@ static void fsl_espi_do_trans(struct spi_message *m,
 	struct spi_device *spi = m->spi;
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
 	struct fsl_espi_transfer *espi_trans = tr;
-	struct spi_message message;
 	struct spi_transfer *t, *first, trans;
 	int status = 0;
 
-	spi_message_init(&message);
 	memset(&trans, 0, sizeof(trans));
 
 	first = list_first_entry(&m->transfers, struct spi_transfer,
@@ -284,23 +282,18 @@ static void fsl_espi_do_trans(struct spi_message *m,
 	trans.len = espi_trans->len;
 	trans.tx_buf = espi_trans->tx_buf;
 	trans.rx_buf = espi_trans->rx_buf;
-	spi_message_add_tail(&trans, &message);
 
-	list_for_each_entry(t, &message.transfers, transfer_list) {
-		if (t->bits_per_word || t->speed_hz)
-			fsl_espi_setup_transfer(spi, t);
+	if (trans.bits_per_word || trans.speed_hz)
+		fsl_espi_setup_transfer(spi, &trans);
 
-		if (t->len)
-			status = fsl_espi_bufs(spi, t);
+	if (trans.len)
+		status = fsl_espi_bufs(spi, &trans);
 
-		if (status) {
-			status = -EMSGSIZE;
-			break;
-		}
+	if (status)
+		status = -EMSGSIZE;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
-	}
+	if (trans.delay_usecs)
+		udelay(trans.delay_usecs);
 
 	espi_trans->status = status;
 	fsl_espi_setup_transfer(spi, NULL);
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
