From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: change return type of fsl_espi_setup_transfer to void" to the spi tree
Date: Thu, 01 Sep 2016 21:35:40 +0100
Message-ID: <E1bfYi4-00031K-BZ@debutante>
References: <2800693b-704a-5530-2d58-8fd38d33dc10@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2800693b-704a-5530-2d58-8fd38d33dc10-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: change return type of fsl_espi_setup_transfer to void

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

>From ea616ee220e70308cf33fa32496ae9c5ad18e190 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Thu, 25 Aug 2016 06:44:42 +0200
Subject: [PATCH] spi: fsl-espi: change return type of fsl_espi_setup_transfer
 to void

fsl_espi_setup_transfer always returns 0, so change the return type
to void.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index d95fdd0632e4..02a55f50f03f 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -130,7 +130,7 @@ static u32 fsl_espi_tx_buf_lsb(struct mpc8xxx_spi *mpc8xxx_spi)
 	return data;
 }
 
-static int fsl_espi_setup_transfer(struct spi_device *spi,
+static void fsl_espi_setup_transfer(struct spi_device *spi,
 					struct spi_transfer *t)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
@@ -195,7 +195,6 @@ static int fsl_espi_setup_transfer(struct spi_device *spi,
 	cs->hw_mode |= CSMODE_PM(pm);
 
 	fsl_espi_change_mode(spi);
-	return 0;
 }
 
 static int fsl_espi_cpu_bufs(struct mpc8xxx_spi *mspi, struct spi_transfer *t,
@@ -292,13 +291,8 @@ static void fsl_espi_do_trans(struct spi_message *m,
 	spi_message_add_tail(&trans, &message);
 
 	list_for_each_entry(t, &message.transfers, transfer_list) {
-		if (t->bits_per_word || t->speed_hz) {
-			status = -EINVAL;
-
-			status = fsl_espi_setup_transfer(spi, t);
-			if (status < 0)
-				break;
-		}
+		if (t->bits_per_word || t->speed_hz)
+			fsl_espi_setup_transfer(spi, t);
 
 		if (t->len)
 			status = fsl_espi_bufs(spi, t);
@@ -425,7 +419,6 @@ static int fsl_espi_setup(struct spi_device *spi)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi;
 	struct fsl_espi_reg *reg_base;
-	int retval;
 	u32 hw_mode;
 	u32 loop_mode;
 	struct spi_mpc8xxx_cs *cs = spi_get_ctldata(spi);
@@ -466,15 +459,11 @@ static int fsl_espi_setup(struct spi_device *spi)
 		loop_mode |= SPMODE_LOOP;
 	mpc8xxx_spi_write_reg(&reg_base->mode, loop_mode);
 
-	retval = fsl_espi_setup_transfer(spi, NULL);
+	fsl_espi_setup_transfer(spi, NULL);
 
 	pm_runtime_mark_last_busy(mpc8xxx_spi->dev);
 	pm_runtime_put_autosuspend(mpc8xxx_spi->dev);
 
-	if (retval < 0) {
-		cs->hw_mode = hw_mode; /* Restore settings */
-		return retval;
-	}
 	return 0;
 }
 
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
