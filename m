From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: spi-pxa2xx: Remove unused macro
Date: Mon, 14 Nov 2016 13:24:20 +0200
Message-ID: <20161114112420.16915-1-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

IS_DMA_ALIGNED() became unused by the commit 6356437e65c2
("spi: spi-pxa2xx: remove legacy PXA DMA bits").

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index ce31b8199bb3..2823a00a9405 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -109,7 +109,6 @@ static  inline void pxa2xx_spi_write(const struct driver_data *drv_data,
 #define DONE_STATE ((void *)2)
 #define ERROR_STATE ((void *)-1)
 
-#define IS_DMA_ALIGNED(x)	IS_ALIGNED((unsigned long)(x), DMA_ALIGNMENT)
 #define DMA_ALIGNMENT		8
 
 static inline int pxa25x_ssp_comp(struct driver_data *drv_data)
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
