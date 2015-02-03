From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi: spi-pxa2xx: only include mach/dma.h for legacy DMA
Date: Tue,  3 Feb 2015 17:03:35 -0600
Message-ID: <1423004615-16085-1-git-send-email-robh@kernel.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Move the include of mach/dma.h to the legacy PXA DMA code where it is used.
This enables building spi-pxa2xx on ARM64.

Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Cc: Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/spi/spi-pxa2xx-pxadma.c | 1 +
 include/linux/spi/pxa2xx_spi.h  | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx-pxadma.c b/drivers/spi/spi-pxa2xx-pxadma.c
index e8a26f2..e866f2c 100644
--- a/drivers/spi/spi-pxa2xx-pxadma.c
+++ b/drivers/spi/spi-pxa2xx-pxadma.c
@@ -25,6 +25,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/pxa2xx_spi.h>
 
+#include <mach/dma.h>
 #include "spi-pxa2xx.h"
 
 #define DMA_INT_MASK		(DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR)
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index d5a3165..46d8fa9 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -57,7 +57,6 @@ struct pxa2xx_spi_chip {
 #if defined(CONFIG_ARCH_PXA) || defined(CONFIG_ARCH_MMP)
 
 #include <linux/clk.h>
-#include <mach/dma.h>
 
 extern void pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_master *info);
 
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
