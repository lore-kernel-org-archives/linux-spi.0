From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 10/10] spi: fsl-espi: separate fsl-espi from fsl-lib
 completely
Date: Sun, 13 Nov 2016 14:41:06 +0100
Message-ID: <a6b9fab3-655b-5f13-7307-8cf692b41403@gmail.com>
References: <678a565f-90b9-bf13-3e06-924fd0fbf232@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <678a565f-90b9-bf13-3e06-924fd0fbf232-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

After having removed all code dependencies we can make fsl-espi
completely independent of fsl-lib now.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Kconfig        | 1 -
 drivers/spi/spi-fsl-espi.c | 2 --
 drivers/spi/spi-fsl-lib.h  | 7 -------
 3 files changed, 10 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 6891091..7fd8561 100644
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
index 8539f05..b5feae3 100644
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
index 3951322..f303f30 100644
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
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
