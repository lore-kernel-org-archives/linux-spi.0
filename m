From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-lpspi: fix indentation error" to the spi tree
Date: Mon, 09 Jan 2017 20:01:58 +0000
Message-ID: <E1cQg8k-00073O-Oi@debutante>
References: <1483522697-6691-1-git-send-email-pandy.gao@nxp.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pandy.gao-3arQi8VN3Tc@public.gmane.org
To: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483522697-6691-1-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-lpspi: fix indentation error

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

>From 102ecc471b9d2f41f10c586f077a0d8e853335f8 Mon Sep 17 00:00:00 2001
From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Date: Wed, 4 Jan 2017 17:38:16 +0800
Subject: [PATCH] spi: fsl-lpspi: fix indentation error

This patch fixes the indentation error in spi-fsl-lpspi.c.

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-lpspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 2b93bc605b91..cb3c73007ca1 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -512,9 +512,9 @@ static int fsl_lpspi_remove(struct platform_device *pdev)
 
 static struct platform_driver fsl_lpspi_driver = {
 	.driver = {
-		   .name = DRIVER_NAME,
-		   .of_match_table = fsl_lpspi_dt_ids,
-		   },
+		.name = DRIVER_NAME,
+		.of_match_table = fsl_lpspi_dt_ids,
+	},
 	.probe = fsl_lpspi_probe,
 	.remove = fsl_lpspi_remove,
 };
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
