From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH 14/15] spi: sh-msiof: Enable driver compilation with COMPILE_TEST
Date: Wed, 27 Nov 2013 02:18:36 +0100
Message-ID: <1385515117-23664-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This helps increasing build testing coverage.

Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Acked-by: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
---
 drivers/spi/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index eb1f1ef..51ae940 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -407,7 +407,8 @@ config SPI_SC18IS602
 
 config SPI_SH_MSIOF
 	tristate "SuperH MSIOF SPI controller"
-	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
+	depends on HAVE_CLK
+	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
 	select SPI_BITBANG
 	help
 	  SPI driver for SuperH and SH Mobile MSIOF blocks.
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
