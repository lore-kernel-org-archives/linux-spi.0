From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: sh-msiof: Remove obsolete spi_r8a779x_msiof platform_device_id entries" to the spi tree
Date: Tue, 07 Jul 2015 14:58:47 +0100
Message-ID: <E1ZCTOZ-0005mY-0D@finisterre>
References: <1435064564-11877-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435064564-11877-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: sh-msiof: Remove obsolete spi_r8a779x_msiof platform_device_id entries

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

>From f6d1b3e20a840a7201ae400a970f42cca96aa17b Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Date: Tue, 23 Jun 2015 15:02:44 +0200
Subject: [PATCH] spi: sh-msiof: Remove obsolete spi_r8a779x_msiof
 platform_device_id entries

Since commit a483dcbfa21f919c ("ARM: shmobile: lager: Remove legacy
board support"), R-Car Gen2 SoCs are only supported in generic DT-only
ARM multi-platform builds.  The driver doesn't need to match platform
devices by name anymore, hence remove the corresponding
platform_device_id entry.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Acked-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index d3370a6..118c652 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1265,11 +1265,6 @@ static int sh_msiof_spi_remove(struct platform_device *pdev)
 
 static const struct platform_device_id spi_driver_ids[] = {
 	{ "spi_sh_msiof",	(kernel_ulong_t)&sh_data },
-	{ "spi_r8a7790_msiof",	(kernel_ulong_t)&r8a779x_data },
-	{ "spi_r8a7791_msiof",	(kernel_ulong_t)&r8a779x_data },
-	{ "spi_r8a7792_msiof",	(kernel_ulong_t)&r8a779x_data },
-	{ "spi_r8a7793_msiof",	(kernel_ulong_t)&r8a779x_data },
-	{ "spi_r8a7794_msiof",	(kernel_ulong_t)&r8a779x_data },
 	{},
 };
 MODULE_DEVICE_TABLE(platform, spi_driver_ids);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
