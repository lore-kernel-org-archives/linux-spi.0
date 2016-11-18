From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: set spi_master members min_speed_hz and max_speed_hz" to the spi tree
Date: Fri, 18 Nov 2016 12:02:14 +0000
Message-ID: <E1c7hry-0005Qd-4P@debutante>
References: <e80a16db-fec3-0236-f2e1-b4818ab28e73@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e80a16db-fec3-0236-f2e1-b4818ab28e73-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: set spi_master members min_speed_hz and max_speed_hz

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

>From f254e65ce20fda3c442ebc50ae1502281963a79b Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, 15 Nov 2016 21:56:33 +0100
Subject: [PATCH] spi: fsl-espi: set spi_master members min_speed_hz and
 max_speed_hz

ESPI has a max and min supported SPI frequency, determined by the
clock divider range. Set master->min_speed_hz/max_speed_hz to inform
the SPI core about these limits.
Then the SPI core handles cases where a transfer requests a frequency
outside the supported range.

So far the driver simply set the lowest supported frequency if the
requested frequency was below the supported range. This is not
necessarily an appropriate action as the device might not support
frequencies greater than the requested one.
With this patch the SPI core will reject transfers requesting a
too low frequency.

The check in fsl_espi_setup can be removed because the SPI core sets
spi->max_speed_hz to master->max_speed_hz if it's not set already.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 2635a33b8e98..4fbcc36fa891 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -314,13 +314,6 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 	if (pm > 15) {
 		cs->hw_mode |= CSMODE_DIV16;
 		pm = DIV_ROUND_UP(espi->spibrg, hz * 16 * 4) - 1;
-
-		WARN_ONCE(pm > 15,
-			  "%s: Requested speed is too low: %u Hz. Will use %u Hz instead.\n",
-			  dev_name(&spi->dev), hz,
-			  espi->spibrg / (4 * 16 * (15 + 1)));
-		if (pm > 15)
-			pm = 15;
 	}
 
 	cs->hw_mode |= CSMODE_PM(pm);
@@ -460,9 +453,6 @@ static int fsl_espi_setup(struct spi_device *spi)
 	u32 loop_mode;
 	struct fsl_espi_cs *cs = spi_get_ctldata(spi);
 
-	if (!spi->max_speed_hz)
-		return -EINVAL;
-
 	if (!cs) {
 		cs = kzalloc(sizeof(*cs), GFP_KERNEL);
 		if (!cs)
@@ -673,6 +663,9 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 		ret = -EINVAL;
 		goto err_probe;
 	}
+	/* determined by clock divider fields DIV16/PM in register SPMODEx */
+	master->min_speed_hz = DIV_ROUND_UP(espi->spibrg, 4 * 16 * 16);
+	master->max_speed_hz = DIV_ROUND_UP(espi->spibrg, 4);
 
 	init_completion(&espi->done);
 
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
