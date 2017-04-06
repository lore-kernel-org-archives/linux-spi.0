From: Rabin Vincent <rabin.vincent-VrBV9hrLPhE@public.gmane.org>
Subject: [PATCH] spi: pl022: don't use uninitialized variable
Date: Thu,  6 Apr 2017 10:16:23 +0200
Message-ID: <1491466583-6121-1-git-send-email-rabin.vincent@axis.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rabin Vincent <rabinv-VrBV9hrLPhE@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Rabin Vincent <rabinv-VrBV9hrLPhE@public.gmane.org>

The num-cs property is a required property according to the binding
documentation.  However, if it is not present, the driver currently
simply uses random junk from the stack for the num-cs since the variable
whose pointer is passed to of_property_read_u32() is not initialized.

Signed-off-by: Rabin Vincent <rabinv-VrBV9hrLPhE@public.gmane.org>
---
 drivers/spi/spi-pl022.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index f7f7ba1..2f76e02 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2074,7 +2074,7 @@ pl022_platform_data_dt_get(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 	struct pl022_ssp_controller *pd;
-	u32 tmp;
+	u32 tmp = 0;
 
 	if (!np) {
 		dev_err(dev, "no dt node defined\n");
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
