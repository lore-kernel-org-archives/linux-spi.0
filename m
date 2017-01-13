From: SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: [PATCH 08/17] spi/ppc4xx: Use kcalloc() in spi_ppc4xx_of_probe()
Date: Fri, 13 Jan 2017 18:16:57 +0100
Message-ID: <777d3bd9-4817-d688-d496-b871edbbc937@users.sourceforge.net>
References: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1413e173-dbac-7a6e-09cb-2287300a335e-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Date: Fri, 13 Jan 2017 14:30:43 +0100

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus reuse the corresponding function "kcalloc".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data type by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi-ppc4xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index dd3d0a218d8b..e0c39734d6ef 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -411,7 +411,7 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	if (num_gpios > 0) {
 		int i;
 
-		hw->gpios = kzalloc(sizeof(int) * num_gpios, GFP_KERNEL);
+		hw->gpios = kcalloc(num_gpios, sizeof(*hw->gpios), GFP_KERNEL);
 		if (!hw->gpios) {
 			ret = -ENOMEM;
 			goto free_master;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
