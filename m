From: Takuo Koguchi <takuo.koguchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V3] spi: sun4i: disable clocks in the remove function
Date: Thu,  7 Dec 2017 16:20:14 +0900
Message-ID: <1512631227-27334-1-git-send-email-takuo.koguchi.sw@hitachi.com>
References: <20171206152005.yfbyylu6tbe5gnnv@flea.lan>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        khoroshilov-ufN2psIa012HXe+LvDLADg@public.gmane.org, takuo.koguchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171206152005.yfbyylu6tbe5gnnv-ZC1Zs529Oq4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

mclk and hclk need to be disabled. Since pm_runtime_disable does
not disable the clocks, use pm_runtime_force_suspend instead.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Takuo Koguchi <takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org>
---
 V3: remove redundant pm_runtime_disable call.
     Compile test only, no runtime test done.
 drivers/spi/spi-sun4i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index c5cd635..4141003 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -525,7 +525,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 
 static int sun4i_spi_remove(struct platform_device *pdev)
 {
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_force_suspend(&pdev->dev);
 
 	return 0;
 }
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
