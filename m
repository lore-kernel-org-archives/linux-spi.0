From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: introduce struct fsl_espi_cs" to the spi tree
Date: Mon, 14 Nov 2016 13:54:32 +0000
Message-ID: <E1c6HiS-0003KM-Su@finisterre>
References: <fcce5b10-4433-9ff2-2f17-bc0cf2f0f6b5@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fcce5b10-4433-9ff2-2f17-bc0cf2f0f6b5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: introduce struct fsl_espi_cs

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

>From 219b5e3b239226c50ff6c4de6abf0534407df620 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sun, 13 Nov 2016 14:38:05 +0100
Subject: [PATCH] spi: fsl-espi: introduce struct fsl_espi_cs

Very little from struct spi_mpc8xxx_cs is relevant for fsl-espi.
Therefore replace it with struct fsl_espi_cs.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 58314d775925..5d84694b7323 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -93,6 +93,10 @@
 
 #define AUTOSUSPEND_TIMEOUT 2000
 
+struct fsl_espi_cs {
+	u32 hw_mode;
+};
+
 static inline u32 fsl_espi_read_reg(struct mpc8xxx_spi *mspi, int offset)
 {
 	return ioread32be(mspi->reg_base + offset);
@@ -280,7 +284,7 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
 	int bits_per_word = t ? t->bits_per_word : spi->bits_per_word;
 	u32 pm, hz = t ? t->speed_hz : spi->max_speed_hz;
-	struct spi_mpc8xxx_cs *cs = spi->controller_state;
+	struct fsl_espi_cs *cs = spi_get_ctldata(spi);
 	u32 hw_mode_old = cs->hw_mode;
 
 	/* mask out bits we are going to set */
@@ -437,7 +441,7 @@ static int fsl_espi_setup(struct spi_device *spi)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi;
 	u32 loop_mode;
-	struct spi_mpc8xxx_cs *cs = spi_get_ctldata(spi);
+	struct fsl_espi_cs *cs = spi_get_ctldata(spi);
 
 	if (!spi->max_speed_hz)
 		return -EINVAL;
@@ -483,7 +487,7 @@ static int fsl_espi_setup(struct spi_device *spi)
 
 static void fsl_espi_cleanup(struct spi_device *spi)
 {
-	struct spi_mpc8xxx_cs *cs = spi_get_ctldata(spi);
+	struct fsl_espi_cs *cs = spi_get_ctldata(spi);
 
 	kfree(cs);
 	spi_set_ctldata(spi, NULL);
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
