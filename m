From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "MAINTAINERS: add tools/spi/ to the SPI entry" to the spi tree
Date: Mon, 15 Aug 2016 15:11:48 +0100
Message-ID: <E1bZIcG-0006xa-K9@debutante>
References: <0a72700f59da77159881031d5b44eff3256612fe.1471006532.git.baruch@tkos.co.il>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0a72700f59da77159881031d5b44eff3256612fe.1471006532.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   MAINTAINERS: add tools/spi/ to the SPI entry

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

>From a43cd4bb3795cfda579cf856d7a438bddd5aa0e4 Mon Sep 17 00:00:00 2001
From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Date: Fri, 12 Aug 2016 15:55:32 +0300
Subject: [PATCH] MAINTAINERS: add tools/spi/ to the SPI entry

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20bb1d00098c..67ccef9ed015 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11083,6 +11083,7 @@ F:	Documentation/spi/
 F:	drivers/spi/
 F:	include/linux/spi/
 F:	include/uapi/linux/spi/
+F:	tools/spi/
 
 SPIDERNET NETWORK DRIVER for CELL
 M:	Ishizaki Kou <kou.ishizaki-g3qfMnKXm6lL9jVzuh4AOg@public.gmane.org>
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
