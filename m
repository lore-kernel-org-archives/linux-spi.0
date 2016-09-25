From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: remove unused variable in fsl_espi_setup" to the spi tree
Date: Sat, 24 Sep 2016 22:59:29 -0700
Message-ID: <E1bo2TJ-0003Ho-3V@finisterre>
References: <a71abf9f-4254-af63-f7eb-1579faaeada3@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a71abf9f-4254-af63-f7eb-1579faaeada3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: remove unused variable in fsl_espi_setup

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

>From fb8ac912df93ea4edc549992d7c9d173e5413164 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sat, 17 Sep 2016 15:42:42 +0200
Subject: [PATCH] spi: fsl-espi: remove unused variable in fsl_espi_setup

Remove an unused variable.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index a7984aeede6b..4f9d9ec6880a 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -361,7 +361,6 @@ out:
 static int fsl_espi_setup(struct spi_device *spi)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi;
-	u32 hw_mode;
 	u32 loop_mode;
 	struct spi_mpc8xxx_cs *cs = spi_get_ctldata(spi);
 
@@ -379,7 +378,6 @@ static int fsl_espi_setup(struct spi_device *spi)
 
 	pm_runtime_get_sync(mpc8xxx_spi->dev);
 
-	hw_mode = cs->hw_mode; /* Save original settings */
 	cs->hw_mode = fsl_espi_read_reg(mpc8xxx_spi,
 					   ESPI_SPMODEx(spi->chip_select));
 	/* mask out bits we are going to set */
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
