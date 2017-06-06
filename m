From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: Nothing to do in setupxfer when transfer is NULL" to the spi tree
Date: Tue, 06 Jun 2017 20:07:44 +0100
Message-ID: <E1dIJpQ-0007h3-L9@debutante>
References: <20170602053804.3238-2-s.hauer@pengutronix.de>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170602053804.3238-2-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: Nothing to do in setupxfer when transfer is NULL

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

>From abb1ff195a21094f3bfb1cf8d425ff360d8a89ee Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Date: Fri, 2 Jun 2017 07:37:59 +0200
Subject: [PATCH] spi: imx: Nothing to do in setupxfer when transfer is NULL

When the spi_transfer given in spi_imx_setupxfer is NULL then
we have nothing to do. Bail out early in this case so that
we do not have to test for t != NULL multiple times later.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b402530a7a9a..4b5cd0c84450 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -217,9 +217,6 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 	if (!master->dma_rx)
 		return false;
 
-	if (!transfer)
-		return false;
-
 	bpw = transfer->bits_per_word;
 	if (!bpw)
 		bpw = spi->bits_per_word;
@@ -895,8 +892,11 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	struct spi_imx_config config;
 	int ret;
 
-	config.bpw = t ? t->bits_per_word : spi->bits_per_word;
-	config.speed_hz  = t ? t->speed_hz : spi->max_speed_hz;
+	if (!t)
+		return 0;
+
+	config.bpw = t->bits_per_word;
+	config.speed_hz  = t->speed_hz;
 
 	if (!config.speed_hz)
 		config.speed_hz = spi->max_speed_hz;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
