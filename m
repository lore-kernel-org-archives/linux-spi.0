From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: topcliff-pch: allow build for MIPS platforms" to the spi tree
Date: Mon, 30 Nov 2015 16:39:49 +0000
Message-ID: <E1a3RUT-0006C2-5q@debutante>
References: <1448900513-20856-18-git-send-email-paul.burton@imgtec.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448900513-20856-18-git-send-email-paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: topcliff-pch: allow build for MIPS platforms

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

>From f05ca854b3df79bf6596de5102eb99ca10d6089f Mon Sep 17 00:00:00 2001
From: Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Date: Mon, 30 Nov 2015 16:21:42 +0000
Subject: [PATCH] spi: topcliff-pch: allow build for MIPS platforms

Allow the topcliff-pch driver to be built for MIPS platforms, in
preparation for use on the MIPS Boston board.

Signed-off-by: Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8b9c2a38d1cc..7c78d52591af 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -585,7 +585,7 @@ config SPI_TEGRA20_SLINK
 
 config SPI_TOPCLIFF_PCH
 	tristate "Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) SPI"
-	depends on PCI && (X86_32 || COMPILE_TEST)
+	depends on PCI && (X86_32 || MIPS || COMPILE_TEST)
 	help
 	  SPI driver for the Topcliff PCH (Platform Controller Hub) SPI bus
 	  used in some x86 embedded processors.
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
