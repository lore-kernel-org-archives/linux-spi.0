From: Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi: loopback-test: mark rx_ranges_cmp() static
Date: Wed, 31 Aug 2016 17:21:47 +0800
Message-ID: <1472635307-16513-1-git-send-email-baoyou.xie@linaro.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TaqPxH82wqD4g@public.gmane.org,
        arnd-r2nGTMty4D4@public.gmane.org, baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, xie.baoyou-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

We get 1 warning when building kernel with W=1:
drivers/spi/spi-loopback-test.c:408:5: warning: no previous prototype for 'rx_ranges_cmp' [-Wmissing-prototypes]

In fact, this function is only used in the file in which it is
declared and don't need a declaration, but can be made static.
So this patch marks it 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index faa1b13..50e620f 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -405,7 +405,7 @@ struct rx_ranges {
 	u8 *end;
 };
 
-int rx_ranges_cmp(void *priv, struct list_head *a, struct list_head *b)
+static int rx_ranges_cmp(void *priv, struct list_head *a, struct list_head *b)
 {
 	struct rx_ranges *rx_a = list_entry(a, struct rx_ranges, list);
 	struct rx_ranges *rx_b = list_entry(b, struct rx_ranges, list);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
