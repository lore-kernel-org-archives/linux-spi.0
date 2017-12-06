From: Takuo Koguchi <takuo.koguchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: sun4i: disable clocks in the remove function
Date: Thu,  7 Dec 2017 03:00:00 +0900
Message-ID: <1512583209-19398-1-git-send-email-takuo.koguchi.sw@hitachi.com>
References: <20171206152005.yfbyylu6tbe5gnnv@flea.lan>
Cc: Takuo Koguchi <takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khoroshilov-ufN2psIa012HXe+LvDLADg@public.gmane.org,
        takuo.koguchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20171206152005.yfbyylu6tbe5gnnv-ZC1Zs529Oq4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

mclk and hclk need to be disabled since pm_runtime_disable does
not disable the clocks.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Takuo Koguchi <takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org>
---
 V2: use pm_runtime_force_suspend to avoid unbalance disable
     call.
     Compile test only, no runtime test.
 drivers/spi/spi-sun4i.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index c5cd635..ca733b2 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -525,6 +525,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 
 static int sun4i_spi_remove(struct platform_device *pdev)
 {
+	pm_runtime_force_suspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
