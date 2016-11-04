From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: don't write ESPI_SPMODE register if the mode doesn't change" to the spi tree
Date: Fri, 04 Nov 2016 14:46:53 -0600
Message-ID: <E1c2lO1-00027L-OU@finisterre>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: don't write ESPI_SPMODE register if the mode doesn't change

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

>From 8f3086d2a9c1104f42d2d0247ef52b01c6d898d8 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Fri, 4 Nov 2016 21:01:12 +0100
Subject: [PATCH] spi: fsl-espi: don't write ESPI_SPMODE register if the mode
 doesn't change

There's no need to bother the chip if the mode doesn't change.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 1029bd2ff5f1..edb524f831a3 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -249,6 +249,7 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 	int bits_per_word = t ? t->bits_per_word : spi->bits_per_word;
 	u32 pm, hz = t ? t->speed_hz : spi->max_speed_hz;
 	struct spi_mpc8xxx_cs *cs = spi->controller_state;
+	u32 hw_mode_old = cs->hw_mode;
 
 	/* mask out bits we are going to set */
 	cs->hw_mode &= ~(CSMODE_LEN(0xF) | CSMODE_DIV16 | CSMODE_PM(0xF));
@@ -271,8 +272,10 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 
 	cs->hw_mode |= CSMODE_PM(pm);
 
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODEx(spi->chip_select),
-			   cs->hw_mode);
+	/* don't write the mode register if the mode doesn't change */
+	if (cs->hw_mode != hw_mode_old)
+		fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODEx(spi->chip_select),
+				   cs->hw_mode);
 }
 
 static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
