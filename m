From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: separate fsl-espi from fsl-lib completely" to the spi tree
Date: Mon, 14 Nov 2016 13:54:09 +0000
Message-ID: <E1c6Hi5-0003Hx-QJ@finisterre>
References: <a6b9fab3-655b-5f13-7307-8cf692b41403@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a6b9fab3-655b-5f13-7307-8cf692b41403-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: separate fsl-espi from fsl-lib completely

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

>From 278c48d2ab2c2f803a7ac501b67b14aa7e73e771 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sun, 13 Nov 2016 14:41:06 +0100
Subject: [PATCH] spi: fsl-espi: separate fsl-espi from fsl-lib completely

After having removed all code dependencies we can make fsl-espi
completely independent of fsl-lib now.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig        | 1 -
 drivers/spi/spi-fsl-espi.c | 2 --
 drivers/spi/spi-fsl-lib.h  | 7 -------
 3 files changed, 10 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b7995474148c..9abc803f7ec0 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -373,7 +373,6 @@ config SPI_FSL_DSPI
 config SPI_FSL_ESPI
 	tristate "Freescale eSPI controller"
 	depends on FSL_SOC
-	select SPI_FSL_LIB
 	help
 	  This enables using the Freescale eSPI controllers in master mode.
 	  From MPC8536, 85xx platform uses the controller, and all P10xx,
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 8539f0584a8a..b5feae31fcc0 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -23,8 +23,6 @@
 #include <linux/pm_runtime.h>
 #include <sysdev/fsl_soc.h>
 
-#include "spi-fsl-lib.h"
-
 /* eSPI Controller registers */
 #define ESPI_SPMODE	0x00	/* eSPI mode register */
 #define ESPI_SPIE	0x04	/* eSPI event register */
diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index 3951322265d4..f303f306b38e 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -28,13 +28,6 @@ struct mpc8xxx_spi {
 	/* rx & tx bufs from the spi_transfer */
 	const void *tx;
 	void *rx;
-#if IS_ENABLED(CONFIG_SPI_FSL_ESPI)
-	unsigned int rx_len;
-	unsigned int tx_len;
-	unsigned int rxskip;
-	u8 *local_buf;
-	spinlock_t lock;
-#endif
 
 	int subblock;
 	struct spi_pram __iomem *pram;
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
