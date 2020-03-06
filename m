From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Remove CONFIG_ prefix from Kconfig select" to the spi tree
Date: Fri, 06 Mar 2020 15:19:23 +0000
Message-ID: <applied-f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel@perches.com>
References: <f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel@perches.com>
Cc: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Remove CONFIG_ prefix from Kconfig select

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From e14572c52546c16e159c4c1814984843a119e823 Mon Sep 17 00:00:00 2001
From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Date: Thu, 5 Mar 2020 07:15:53 -0800
Subject: [PATCH] spi: Remove CONFIG_ prefix from Kconfig select

commit a2ca53b52e00 ("spi: Add HiSilicon v3xx SPI NOR flash
controller driver") likely inadvertently used a select statement
with a CONFIG_ prefix, remove the prefix.

Reported-by: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Signed-off-by: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Acked-by: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Link: https://lore.kernel.org/r/f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 887fefe87fd5..9c5dadb238dc 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -292,7 +292,7 @@ config SPI_HISI_SFC_V3XX
 	tristate "HiSilicon SPI-NOR Flash Controller for Hi16XX chipsets"
 	depends on (ARM64 && ACPI) || COMPILE_TEST
 	depends on HAS_IOMEM
-	select CONFIG_MTD_SPI_NOR
+	select MTD_SPI_NOR
 	help
 	  This enables support for HiSilicon v3xx SPI-NOR flash controller
 	  found in hi16xx chipsets.
-- 
2.20.1
