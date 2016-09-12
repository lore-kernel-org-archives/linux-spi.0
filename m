From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: improve return value handling in fsl_espi_bufs" to the spi tree
Date: Mon, 12 Sep 2016 20:08:31 +0100
Message-ID: <E1bjWal-0002rC-1l@debutante>
References: <d8aa466c-1366-8aa0-5cf6-d0be7dbafa3a@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d8aa466c-1366-8aa0-5cf6-d0be7dbafa3a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: improve return value handling in fsl_espi_bufs

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

>From 84ccfc371f4a8d1ff86efd7ca7914e33b90325c2 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 7 Sep 2016 22:52:43 +0200
Subject: [PATCH] spi: fsl-espi: improve return value handling in fsl_espi_bufs

Return a proper status code from fsl_espi_bufs instead of returning
the number of remaining words and let the caller evaluate it.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index f8a6dd13ee02..8d6a570ac704 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -258,7 +258,7 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	/* disable rx ints */
 	mpc8xxx_spi_write_reg(&reg_base->mask, 0);
 
-	return mpc8xxx_spi->count;
+	return mpc8xxx_spi->count > 0 ? -EMSGSIZE : 0;
 }
 
 static int fsl_espi_do_trans(struct spi_message *m, struct spi_transfer *trans)
@@ -288,9 +288,6 @@ static int fsl_espi_do_trans(struct spi_message *m, struct spi_transfer *trans)
 	if (trans->len)
 		ret = fsl_espi_bufs(spi, trans);
 
-	if (ret)
-		ret = -EMSGSIZE;
-
 	if (trans->delay_usecs)
 		udelay(trans->delay_usecs);
 
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
