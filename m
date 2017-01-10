From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: make falcon-spi bool" to the spi tree
Date: Tue, 10 Jan 2017 12:27:16 +0000
Message-ID: <E1cQvWG-0003k0-Qd@finisterre>
References: <20170103170427.26120-1-hauke@hauke-m.de>
Cc: Thomas Langer <thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170103170427.26120-1-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: make falcon-spi bool

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

>From 9c6a3af003c06ef1efc5e243cdbab1be4cb90753 Mon Sep 17 00:00:00 2001
From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Date: Tue, 3 Jan 2017 18:04:27 +0100
Subject: [PATCH] spi: make falcon-spi bool

Falcon spi accesses some ebu functions which are not exported and can
not be accessed when build as module. Make this module bool instead.

Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Acked-by: Thomas Langer <thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ec4aa252d6e8..e3c256685235 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -263,7 +263,7 @@ config SPI_EP93XX
 	  mode.
 
 config SPI_FALCON
-	tristate "Falcon SPI controller support"
+	bool "Falcon SPI controller support"
 	depends on SOC_FALCON
 	help
 	  The external bus unit (EBU) found on the FALC-ON SoC has SPI
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
