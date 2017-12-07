From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: sun4i: disable clocks in the remove function" to the spi tree
Date: Thu, 07 Dec 2017 12:35:02 +0000
Message-ID: <E1eMvOI-0006Ak-FL@debutante>
References: <1512631227-27334-1-git-send-email-takuo.koguchi.sw@hitachi.com>
Cc: Takuo Koguchi <takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org>,
        Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        khoroshilov-ufN2psIa012HXe+LvDLADg@public.gmane.org, takuo.koguchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takuo Koguchi <takuo.koguchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512631227-27334-1-git-send-email-takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: sun4i: disable clocks in the remove function

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From c810daba0ab5226084a56893a789af427a801146 Mon Sep 17 00:00:00 2001
From: Takuo Koguchi <takuo.koguchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Thu, 7 Dec 2017 16:20:14 +0900
Subject: [PATCH] spi: sun4i: disable clocks in the remove function

mclk and hclk need to be disabled. Since pm_runtime_disable does
not disable the clocks, use pm_runtime_force_suspend instead.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Takuo Koguchi <takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-sun4i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index c5cd635c28f3..41410031f8e9 100644
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
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
