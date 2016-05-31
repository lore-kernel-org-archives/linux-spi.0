From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi/rockchip: add the rk3036/rk3228/rk3368 to match for driver" to the spi tree
Date: Tue, 31 May 2016 18:46:29 +0100
Message-ID: <E1b7nkL-0006By-NN@debutante>
References: <1463672824-15367-2-git-send-email-wxt@rock-chips.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463672824-15367-2-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi/rockchip: add the rk3036/rk3228/rk3368 to match for driver

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

>From aa29ea3df27dbba19ef59023d0f7330f2fdc58ae Mon Sep 17 00:00:00 2001
From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Date: Fri, 20 May 2016 07:56:21 +0800
Subject: [PATCH] spi/rockchip: add the rk3036/rk3228/rk3368 to match for
 driver

In gerenal, the "rockchip,rockchip-spi" string will match the dts
that's great in spi driver. After all the most of rockchip SoCs ar
same spi controller.

Then, we should keep the old style to match the dts various.

Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-rockchip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index cd89682065b9..bead5bfcbb0c 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -892,9 +892,12 @@ static const struct dev_pm_ops rockchip_spi_pm = {
 };
 
 static const struct of_device_id rockchip_spi_dt_match[] = {
+	{ .compatible = "rockchip,rk3036-spi", },
 	{ .compatible = "rockchip,rk3066-spi", },
 	{ .compatible = "rockchip,rk3188-spi", },
+	{ .compatible = "rockchip,rk3228-spi", },
 	{ .compatible = "rockchip,rk3288-spi", },
+	{ .compatible = "rockchip,rk3368-spi", },
 	{ .compatible = "rockchip,rk3399-spi", },
 	{ },
 };
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
