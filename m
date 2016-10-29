From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: fix support for all available clock rates" to the spi tree
Date: Sat, 29 Oct 2016 12:12:58 -0600
Message-ID: <E1c0Y7m-0007kO-G7@finisterre>
References: <6da14f3b-24ad-366a-68d6-ade31ff50d2e@gmail.com>
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paulo Zaneti <paulo.zaneti-rCUF4CxDseZknzVnJbg3IA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6da14f3b-24ad-366a-68d6-ade31ff50d2e-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: fix support for all available clock rates

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

>From 73aaf15849d9421fa696c3d7785952d8100042b2 Mon Sep 17 00:00:00 2001
From: Paulo Zaneti <paulo.zaneti-rCUF4CxDseZknzVnJbg3IA@public.gmane.org>
Date: Sat, 29 Oct 2016 11:02:19 +0200
Subject: [PATCH] spi: fsl-espi: fix support for all available clock rates

According to NXP ESPI datasheet, the SPI clock rate is:

    spi_clk = System_Clock / ( 2 * DIV16 * ( 1 + PM ) )

Where System_Clock is the platform clock divided by 2,
DIV16 may be 1 or 16, and PM is a 4 bits integer (0 to 15).

Isolating PM on the expression, we get:

    PM = (System_Clock / ( 2 * DIV16 * spi_clk ) ) - 1

Where System_Clock = mpc8xxx_spi->spibrg / 2, spi_clk = hz,
and DIV16 = 1 or DIV16 = 16. So,

    PM = (mpc8xxx_spi->spibrg / ( 4 * hz) ) - 1
or
    PM = (mpc8xxx_spi->spibrg / ( 16 * 4 * hz) ) - 1

Current spi-fsl-espi driver can't configure the HW for all
supported clock rates. It filters out clock rates for PM = 0
and PM = 1.

This patch allows all range of supported clock rates to be
configured on the ESPI controller.

Signed-off-by: Paulo Zaneti <paulo.zaneti-rCUF4CxDseZknzVnJbg3IA@public.gmane.org>
Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 1d3c9023391d..8b3a28739d9a 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -247,8 +247,7 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
 	int bits_per_word = t ? t->bits_per_word : spi->bits_per_word;
-	u32 hz = t ? t->speed_hz : spi->max_speed_hz;
-	u8 pm;
+	u32 pm, hz = t ? t->speed_hz : spi->max_speed_hz;
 	struct spi_mpc8xxx_cs *cs = spi->controller_state;
 
 	/* mask out bits we are going to set */
@@ -256,22 +255,19 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 
 	cs->hw_mode |= CSMODE_LEN(bits_per_word - 1);
 
-	if ((mpc8xxx_spi->spibrg / hz) > 64) {
+	pm = DIV_ROUND_UP(mpc8xxx_spi->spibrg, hz * 4) - 1;
+
+	if (pm > 15) {
 		cs->hw_mode |= CSMODE_DIV16;
-		pm = DIV_ROUND_UP(mpc8xxx_spi->spibrg, hz * 16 * 4);
-
-		WARN_ONCE(pm > 33, "%s: Requested speed is too low: %d Hz. "
-			  "Will use %d Hz instead.\n", dev_name(&spi->dev),
-				hz, mpc8xxx_spi->spibrg / (4 * 16 * (32 + 1)));
-		if (pm > 33)
-			pm = 33;
-	} else {
-		pm = DIV_ROUND_UP(mpc8xxx_spi->spibrg, hz * 4);
+		pm = DIV_ROUND_UP(mpc8xxx_spi->spibrg, hz * 16 * 4) - 1;
+
+		WARN_ONCE(pm > 15,
+			  "%s: Requested speed is too low: %u Hz. Will use %u Hz instead.\n",
+			  dev_name(&spi->dev), hz,
+			  mpc8xxx_spi->spibrg / (4 * 16 * (15 + 1)));
+		if (pm > 15)
+			pm = 15;
 	}
-	if (pm)
-		pm--;
-	if (pm < 2)
-		pm = 2;
 
 	cs->hw_mode |= CSMODE_PM(pm);
 
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
