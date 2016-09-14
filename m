From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: simplify fsl_espi_setup_transfer" to the spi tree
Date: Wed, 14 Sep 2016 18:25:12 +0100
Message-ID: <E1bkDvs-00038i-Sb@debutante>
References: <b3d6f046-0331-3482-ca87-9205ffd380d4@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b3d6f046-0331-3482-ca87-9205ffd380d4-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: simplify fsl_espi_setup_transfer

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

>From d198ebfb75adec5156b07b96dc21b6b9e5144018 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, 13 Sep 2016 23:15:45 +0200
Subject: [PATCH] spi: fsl-espi: simplify fsl_espi_setup_transfer

If t is not null then the SPI core takes care that bits_per_word and
speed_hz are populated. This allows to simplify fsl_espi_setup_transfer.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index bef06762a770..060624f45ce0 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -176,23 +176,11 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 					struct spi_transfer *t)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
-	int bits_per_word = 0;
+	int bits_per_word = t ? t->bits_per_word : spi->bits_per_word;
+	u32 hz = t ? t->speed_hz : spi->max_speed_hz;
 	u8 pm;
-	u32 hz = 0;
 	struct spi_mpc8xxx_cs *cs = spi->controller_state;
 
-	if (t) {
-		bits_per_word = t->bits_per_word;
-		hz = t->speed_hz;
-	}
-
-	/* spi_transfer level calls that work per-word */
-	if (!bits_per_word)
-		bits_per_word = spi->bits_per_word;
-
-	if (!hz)
-		hz = spi->max_speed_hz;
-
 	cs->rx_shift = 0;
 	cs->tx_shift = 0;
 	cs->get_rx = mpc8xxx_spi_rx_buf_u32;
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
