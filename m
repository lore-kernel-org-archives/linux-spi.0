From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: rockchip: add compatible string for px30 rk3308 rk3328" to the spi tree
Date: Tue, 10 Mar 2020 14:31:16 +0000
Message-ID: <applied-20200309151004.7780-1-jbx6244@gmail.com>
References: <20200309151004.7780-1-jbx6244@gmail.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Johan Jonker <jbx6244-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200309151004.7780-1-jbx6244-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: rockchip: add compatible string for px30 rk3308 rk3328

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

>From c6486eadb4feae730b68dda95fe2cc8dbe210fae Mon Sep 17 00:00:00 2001
From: Johan Jonker <jbx6244-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Mon, 9 Mar 2020 16:10:03 +0100
Subject: [PATCH] spi: rockchip: add compatible string for px30 rk3308 rk3328

The Rockchip spi binding is updated to yaml and new models
were added. The spi on px30,rk3308 and rk3328 are the same as
other Rockchip based SoCs, so add compatible string for it.

Signed-off-by: Johan Jonker <jbx6244-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Link: https://lore.kernel.org/r/20200309151004.7780-1-jbx6244-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-rockchip.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 2cc6d9951b52..70ef63e0b6b8 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -843,14 +843,17 @@ static const struct dev_pm_ops rockchip_spi_pm = {
 };
 
 static const struct of_device_id rockchip_spi_dt_match[] = {
-	{ .compatible = "rockchip,rv1108-spi", },
+	{ .compatible = "rockchip,px30-spi", },
 	{ .compatible = "rockchip,rk3036-spi", },
 	{ .compatible = "rockchip,rk3066-spi", },
 	{ .compatible = "rockchip,rk3188-spi", },
 	{ .compatible = "rockchip,rk3228-spi", },
 	{ .compatible = "rockchip,rk3288-spi", },
+	{ .compatible = "rockchip,rk3308-spi", },
+	{ .compatible = "rockchip,rk3328-spi", },
 	{ .compatible = "rockchip,rk3368-spi", },
 	{ .compatible = "rockchip,rk3399-spi", },
+	{ .compatible = "rockchip,rv1108-spi", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, rockchip_spi_dt_match);
-- 
2.20.1
