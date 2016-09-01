From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: loopback-test: mark rx_ranges_cmp() static" to the spi tree
Date: Thu, 01 Sep 2016 21:35:46 +0100
Message-ID: <E1bfYiA-000335-5d@debutante>
References: <1472635307-16513-1-git-send-email-baoyou.xie@linaro.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TaqPxH82wqD4g@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        xie.baoyou-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org
To: Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1472635307-16513-1-git-send-email-baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: loopback-test: mark rx_ranges_cmp() static

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

>From dc34b89a8c611946bfa18ddc322d355e97811f01 Mon Sep 17 00:00:00 2001
From: Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Date: Wed, 31 Aug 2016 17:21:47 +0800
Subject: [PATCH] spi: loopback-test: mark rx_ranges_cmp() static

We get 1 warning when building kernel with W=1:
drivers/spi/spi-loopback-test.c:408:5: warning: no previous prototype for 'rx_ranges_cmp' [-Wmissing-prototypes]

In fact, this function is only used in the file in which it is
declared and don't need a declaration, but can be made static.
So this patch marks it 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index faa1b133b0f1..50e620f4e8fe 100644
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
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
