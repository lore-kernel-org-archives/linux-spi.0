From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: merge fsl_espi_trans and fsl_espi_do_trans" to the spi tree
Date: Mon, 12 Sep 2016 20:07:09 +0100
Message-ID: <E1bjWZR-0002fX-NB@debutante>
References: <b8a3ee2d-b46a-2681-a11e-b5a773179589@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b8a3ee2d-b46a-2681-a11e-b5a773179589-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: merge fsl_espi_trans and fsl_espi_do_trans

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

>From 38d003f1a43f3afd6b5e0da728f06dad07a85687 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 7 Sep 2016 22:54:51 +0200
Subject: [PATCH] spi: fsl-espi: merge fsl_espi_trans and fsl_espi_do_trans

Merge both functions to reduce source code size and improve
readability.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 7b2f997b061f..bef06762a770 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -276,11 +276,13 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	return mpc8xxx_spi->count > 0 ? -EMSGSIZE : 0;
 }
 
-static int fsl_espi_do_trans(struct spi_message *m, struct spi_transfer *trans)
+static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 {
+	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
 	struct spi_device *spi = m->spi;
-	int ret = 0;
+	int ret;
 
+	fsl_espi_copy_to_buf(m, mspi);
 	fsl_espi_setup_transfer(spi, trans);
 
 	ret = fsl_espi_bufs(spi, trans);
@@ -290,18 +292,6 @@ static int fsl_espi_do_trans(struct spi_message *m, struct spi_transfer *trans)
 
 	fsl_espi_setup_transfer(spi, NULL);
 
-	return ret;
-}
-
-static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
-{
-	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
-	int ret;
-
-	fsl_espi_copy_to_buf(m, mspi);
-
-	ret = fsl_espi_do_trans(m, trans);
-
 	if (!ret)
 		fsl_espi_copy_from_buf(m, mspi);
 
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
