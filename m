From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH] spi: lp-8841: return correct error code from probe
Date: Thu, 25 Feb 2016 12:37:40 +0100
Message-ID: <1456400265-3068525-1-git-send-email-arnd@arndb.de>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The spi_lp8841_rtc_probe() function misses an initialization of the
return code when it fails to get its memory resource, as gcc notices:

drivers/spi/spi-lp8841-rtc.c: In function 'spi_lp8841_rtc_probe':
drivers/spi/spi-lp8841-rtc.c:239:9: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This changes the code to propagate the error from devm_ioremap_resource().

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Fixes: 7ecbfff6711f ("spi: master driver to enable RTC on ICPDAS LP-8841")
---
 drivers/spi/spi-lp8841-rtc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-lp8841-rtc.c b/drivers/spi/spi-lp8841-rtc.c
index 44bb69c3f1d6..faa577d282c0 100644
--- a/drivers/spi/spi-lp8841-rtc.c
+++ b/drivers/spi/spi-lp8841-rtc.c
@@ -217,8 +217,9 @@ spi_lp8841_rtc_probe(struct platform_device *pdev)
 	data = spi_master_get_devdata(master);
 
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->iomem =  devm_ioremap_resource(&pdev->dev, iomem);
-	if (IS_ERR(data->iomem)) {
+	data->iomem = devm_ioremap_resource(&pdev->dev, iomem);
+	ret = PTR_ERR_OR_ZERO(data->iomem);
+	if (ret) {
 		dev_err(&pdev->dev, "failed to get IO address\n");
 		goto err_put_master;
 	}
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
