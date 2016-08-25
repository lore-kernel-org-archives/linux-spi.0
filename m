From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 04/23] spi: fsl-espi: change return type of
 fsl_espi_setup_transfer to void
Date: Thu, 25 Aug 2016 06:44:42 +0200
Message-ID: <2800693b-704a-5530-2d58-8fd38d33dc10@gmail.com>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

fsl_espi_setup_transfer always returns 0, so change the return type
to void.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 12cb0c5..38eced3 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -128,7 +128,7 @@ static u32 fsl_espi_tx_buf_lsb(struct mpc8xxx_spi *mpc8xxx_spi)
 	return data;
 }
 
-static int fsl_espi_setup_transfer(struct spi_device *spi,
+static void fsl_espi_setup_transfer(struct spi_device *spi,
 					struct spi_transfer *t)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
@@ -193,7 +193,6 @@ static int fsl_espi_setup_transfer(struct spi_device *spi,
 	cs->hw_mode |= CSMODE_PM(pm);
 
 	fsl_espi_change_mode(spi);
-	return 0;
 }
 
 static int fsl_espi_cpu_bufs(struct mpc8xxx_spi *mspi, struct spi_transfer *t,
@@ -290,13 +289,8 @@ static void fsl_espi_do_trans(struct spi_message *m,
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
@@ -401,7 +395,6 @@ static int fsl_espi_setup(struct spi_device *spi)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi;
 	struct fsl_espi_reg *reg_base;
-	int retval;
 	u32 hw_mode;
 	u32 loop_mode;
 	struct spi_mpc8xxx_cs *cs = spi_get_ctldata(spi);
@@ -442,15 +435,11 @@ static int fsl_espi_setup(struct spi_device *spi)
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
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
