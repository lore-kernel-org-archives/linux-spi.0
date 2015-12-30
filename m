From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: s3c64xx: Remove unused platform_device_id entries" to the spi tree
Date: Wed, 30 Dec 2015 18:05:28 +0000
Message-ID: <E1aEL7o-0007Uu-Tp@debutante>
References: <1451410480-13935-1-git-send-email-s.nawrocki@samsung.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1451410480-13935-1-git-send-email-s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: s3c64xx: Remove unused platform_device_id entries

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

>From cc023478dc8a3ab07828620dd80303fcd81fb227 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Date: Tue, 29 Dec 2015 18:34:40 +0100
Subject: [PATCH] spi: s3c64xx: Remove unused platform_device_id entries

s5pv210 and exynos4 are now DT only platforms hence these
entries can now be safely removed from the match table.

Signed-off-by: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b954c5444cca..5a76a50063b5 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1357,12 +1357,6 @@ static const struct platform_device_id s3c64xx_spi_driver_ids[] = {
 	}, {
 		.name		= "s3c6410-spi",
 		.driver_data	= (kernel_ulong_t)&s3c6410_spi_port_config,
-	}, {
-		.name		= "s5pv210-spi",
-		.driver_data	= (kernel_ulong_t)&s5pv210_spi_port_config,
-	}, {
-		.name		= "exynos4210-spi",
-		.driver_data	= (kernel_ulong_t)&exynos4_spi_port_config,
 	},
 	{ },
 };
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
