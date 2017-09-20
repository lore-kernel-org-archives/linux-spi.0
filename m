From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Kconfig: Remove old comments now that SPI slave is supported" to the spi tree
Date: Wed, 20 Sep 2017 04:42:51 -0700 (PDT)
Message-ID: <20170920114251.E403B4400D3@finisterre.ee.mobilebroadband>
References: <1505881037-16661-1-git-send-email-festevam@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1505881037-16661-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Kconfig: Remove old comments now that SPI slave is supported

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

>From da394712324e9a0c91ae05cc24396af6d99f3ad6 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Date: Wed, 20 Sep 2017 01:17:17 -0300
Subject: [PATCH] spi: Kconfig: Remove old comments now that SPI slave is
 supported

Since commit 6c364062bfed ("spi: core: Add support for registering SPI
slave controllers") SPI slave is also supported, so remove the old
comments that say SPI slave is unsupported.

Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Acked-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a75f2a2cf780..948a74bb2795 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1,10 +1,6 @@
 #
 # SPI driver configuration
 #
-# NOTE:  the reason this doesn't show SPI slave support is mostly that
-# nobody's needed a slave side API yet.  The master-role API is not
-# fully appropriate there, so it'd need some thought to do well.
-#
 menuconfig SPI
 	bool "SPI support"
 	depends on HAS_IOMEM
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
