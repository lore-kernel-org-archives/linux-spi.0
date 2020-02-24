From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Return error codes from pxa2xx_spi_init_pdata()" to the spi tree
Date: Mon, 24 Feb 2020 22:22:27 +0000
Message-ID: <applied-20200224154556.11627-1-andriy.shevchenko@linux.intel.com>
References: <20200224154556.11627-1-andriy.shevchenko@linux.intel.com>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200224154556.11627-1-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Return error codes from pxa2xx_spi_init_pdata()

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

>From 14af1df3b03309f6204661e12c40cdf71bc8f773 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Mon, 24 Feb 2020 17:45:55 +0200
Subject: [PATCH] spi: pxa2xx: Return error codes from pxa2xx_spi_init_pdata()

For better understanding what's going on on error path,
return distinguished error codes instead of NULL pointer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Link: https://lore.kernel.org/r/20200224154556.11627-1-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 4c7a71f0fb3e..934bfe2c8a90 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1548,18 +1548,18 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	else if (pcidev_id)
 		type = (enum pxa_ssp_type)pcidev_id->driver_data;
 	else
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	ssp = &pdata->ssp;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ssp->mmio_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(ssp->mmio_base))
-		return NULL;
+		return ERR_CAST(ssp->mmio_base);
 
 	ssp->phys_base = res->start;
 
@@ -1573,11 +1573,11 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ssp->clk))
-		return NULL;
+		return ERR_CAST(ssp->clk);
 
 	ssp->irq = platform_get_irq(pdev, 0);
 	if (ssp->irq < 0)
-		return NULL;
+		return ERR_PTR(ssp->irq);
 
 	ssp->type = type;
 	ssp->dev = &pdev->dev;
@@ -1634,9 +1634,9 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	platform_info = dev_get_platdata(dev);
 	if (!platform_info) {
 		platform_info = pxa2xx_spi_init_pdata(pdev);
-		if (!platform_info) {
+		if (IS_ERR(platform_info)) {
 			dev_err(&pdev->dev, "missing platform data\n");
-			return -ENODEV;
+			return PTR_ERR(platform_info);
 		}
 	}
 
-- 
2.20.1
