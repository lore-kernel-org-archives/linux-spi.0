From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: simplify and inline function fsl_espi_change_mode" to the spi tree
Date: Fri, 28 Oct 2016 19:52:40 +0100
Message-ID: <E1c0CGe-00068g-4H@finisterre>
References: <0aeb49f0-dbfb-7acb-3829-cabafe4e7291@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0aeb49f0-dbfb-7acb-3829-cabafe4e7291-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: simplify and inline function fsl_espi_change_mode

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

>From b3bec5f95f73520feb05b90244522f24546e96aa Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Thu, 27 Oct 2016 21:26:46 +0200
Subject: [PATCH] spi: fsl-espi: simplify and inline function
 fsl_espi_change_mode

The ESPI spec mentions no requirement to turn off the ESPI unit prior
to changing the mode. Most likely the ESPI unit is only turned off to
clear the FIFO's as before this patch series single bytes could
remain in the TX FIFO after transfer end.
Therefore remove disabling / re-enabling the ESPI unit.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 5a7449f3b3b8..d5506852e63c 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -223,26 +223,6 @@ static void fsl_espi_fill_tx_fifo(struct mpc8xxx_spi *mspi, u32 events)
 		}
 }
 
-static void fsl_espi_change_mode(struct spi_device *spi)
-{
-	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
-	struct spi_mpc8xxx_cs *cs = spi->controller_state;
-	u32 tmp;
-	unsigned long flags;
-
-	/* Turn off IRQs locally to minimize time that SPI is disabled. */
-	local_irq_save(flags);
-
-	/* Turn off SPI unit prior changing mode */
-	tmp = fsl_espi_read_reg(mspi, ESPI_SPMODE);
-	fsl_espi_write_reg(mspi, ESPI_SPMODE, tmp & ~SPMODE_ENABLE);
-	fsl_espi_write_reg(mspi, ESPI_SPMODEx(spi->chip_select),
-			      cs->hw_mode);
-	fsl_espi_write_reg(mspi, ESPI_SPMODE, tmp);
-
-	local_irq_restore(flags);
-}
-
 static void fsl_espi_setup_transfer(struct spi_device *spi,
 					struct spi_transfer *t)
 {
@@ -276,7 +256,8 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 
 	cs->hw_mode |= CSMODE_PM(pm);
 
-	fsl_espi_change_mode(spi);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODEx(spi->chip_select),
+			   cs->hw_mode);
 }
 
 static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
