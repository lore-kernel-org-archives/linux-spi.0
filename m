From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mt65xx: Fix module alias" to the spi tree
Date: Tue, 11 Aug 2015 17:28:09 +0100
Message-ID: <E1ZPCPJ-0005Iz-GM@finisterre>
References: <1439255730.30868.1.camel@ingics.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439255730.30868.1.camel-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mt65xx: Fix module alias

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

>From e4001885ca4fa3107898205503f2552ed50f4f02 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Date: Tue, 11 Aug 2015 09:15:30 +0800
Subject: [PATCH] spi: mt65xx: Fix module alias

Remove extra space and make the alias matches driver name.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index e62d304..08da77e 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -746,4 +746,4 @@ module_platform_driver(mtk_spi_driver);
 MODULE_DESCRIPTION("MTK SPI Controller driver");
 MODULE_AUTHOR("Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform: mtk_spi");
+MODULE_ALIAS("platform:mtk-spi");
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
