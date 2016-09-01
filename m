From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: change return type of fsl_espi_cpu_bufs to void" to the spi tree
Date: Thu, 01 Sep 2016 21:35:37 +0100
Message-ID: <E1bfYi1-0002ze-Em@debutante>
References: <40dcd903-fdae-6669-5c35-af4b9e9e953b@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <40dcd903-fdae-6669-5c35-af4b9e9e953b-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: change return type of fsl_espi_cpu_bufs to void

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

>From bbb55f6d6276b39a96b7bcd79f1159a1365bb318 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Thu, 25 Aug 2016 06:44:58 +0200
Subject: [PATCH] spi: fsl-espi: change return type of fsl_espi_cpu_bufs to
 void

fsl_espi_cpu_bufs always returns 0, so change the return type to void.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 02a55f50f03f..2c4714abdde7 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -197,7 +197,7 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 	fsl_espi_change_mode(spi);
 }
 
-static int fsl_espi_cpu_bufs(struct mpc8xxx_spi *mspi, struct spi_transfer *t,
+static void fsl_espi_cpu_bufs(struct mpc8xxx_spi *mspi, struct spi_transfer *t,
 		unsigned int len)
 {
 	u32 word;
@@ -211,8 +211,6 @@ static int fsl_espi_cpu_bufs(struct mpc8xxx_spi *mspi, struct spi_transfer *t,
 	/* transmit word */
 	word = mspi->get_tx(mspi);
 	mpc8xxx_spi_write_reg(&reg_base->transmit, word);
-
-	return 0;
 }
 
 static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
@@ -239,9 +237,7 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	mpc8xxx_spi_write_reg(&reg_base->command,
 		(SPCOM_CS(spi->chip_select) | SPCOM_TRANLEN(t->len - 1)));
 
-	ret = fsl_espi_cpu_bufs(mpc8xxx_spi, t, len);
-	if (ret)
-		return ret;
+	fsl_espi_cpu_bufs(mpc8xxx_spi, t, len);
 
 	/* Won't hang up forever, SPI bus sometimes got lost interrupts... */
 	ret = wait_for_completion_timeout(&mpc8xxx_spi->done, 2 * HZ);
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
