From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: bcm-qspi: don't include linux/mtd/cfi.h" to the spi tree
Date: Fri, 16 Sep 2016 18:40:43 +0100
Message-ID: <E1bkx7z-0004D7-Pg@debutante>
References: <20160915154033.3002634-1-arnd@arndb.de>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Yendapally Reddy Dhananjaya Reddy
        <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160915154033.3002634-1-arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: bcm-qspi: don't include linux/mtd/cfi.h

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

>From c0a75d072a501effd66d3392ada8d3f4283b87ef Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Date: Thu, 15 Sep 2016 17:40:15 +0200
Subject: [PATCH] spi: bcm-qspi: don't include linux/mtd/cfi.h

The header isn't actually needed here, but including it leads
to a build warning when CONFIG_MTD is disabled:

include/linux/mtd/cfi.h:76:2: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Werror=cpp]

Fixes: fa236a7ef240 (spi: bcm-qspi: Add Broadcom MSPI driver)
Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-bcm-qspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 8fff43e12242..5da182be073e 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -25,7 +25,6 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/mtd/cfi.h>
 #include <linux/mtd/spi-nor.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
