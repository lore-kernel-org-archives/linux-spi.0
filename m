From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/2] spi: pxa2xx: Return error codes from pxa2xx_spi_init_pdata()
Date: Mon, 24 Feb 2020 17:45:55 +0200
Message-ID: <20200224154556.11627-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

For better understanding what's going on on error path,
return distinguished error codes instead of NULL pointer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index b0d36dd583f5..e33ef1169491 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1553,18 +1553,18 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
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
 
@@ -1578,11 +1578,11 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 
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
@@ -1639,9 +1639,9 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
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
2.25.0
