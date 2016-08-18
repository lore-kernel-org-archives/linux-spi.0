From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] MAINTAINERS: add myself as Samsung SPI maintainer
Date: Thu, 18 Aug 2016 15:44:31 +0900
Message-ID: <20160818064431.8982-1-andi.shyti@samsung.com>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Create a new entry for the Samsung SPI driver supported by the
drivers/spi/spi-s3c* and remove it from its original place under
"ARM/SAMSUNG EXYNOS ARM ARCHITECTURES".

The original maintainership inherited from the Samsung Exynos
ARM Architecture is kept as it was (i.e. Kukjin and Krzysztof), I
will help and co-maintain the driver.

CC: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
CC: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
Hi,

this patch depends on Krzysztof's previous patch-set on the
MAINTAINER file: https://lkml.org/lkml/2016/8/16/571

Thanks,
Andi

 MAINTAINERS | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9cd8d3..c305fa2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1633,7 +1633,6 @@ F:	drivers/*/*s3c64xx*
 F:	drivers/*/*s5pv210*
 F:	drivers/memory/samsung/*
 F:	drivers/soc/samsung/*
-F:	drivers/spi/spi-s3c*
 F:	Documentation/arm/Samsung/
 F:	Documentation/devicetree/bindings/arm/samsung/
 F:	Documentation/devicetree/bindings/sram/samsung-sram.txt
@@ -10240,6 +10239,15 @@ S:	Supported
 L:	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (moderated for non-subscribers)
 F:	drivers/clk/samsung/
 
+SAMSUNG SPI DRIVERS
+M:	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
+M:	Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
+M:	Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
+L:	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+L:	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/spi/spi-s3c*
+
 SAMSUNG SXGBE DRIVERS
 M:	Byungho An <bh74.an-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
 M:	Girish K S <ks.giri-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
