From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: lp-8841: return correct error code from probe" to the spi tree
Date: Fri, 26 Feb 2016 11:47:55 +0900
Message-ID: <E1aZ8Rf-0006XR-Qw@finisterre>
References: <1456400265-3068525-1-git-send-email-arnd@arndb.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456400265-3068525-1-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: lp-8841: return correct error code from probe

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

>From 14a20428e2e02600195a71ad366c0caef97bf3d4 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Date: Thu, 25 Feb 2016 12:37:40 +0100
Subject: [PATCH] spi: lp-8841: return correct error code from probe

The spi_lp8841_rtc_probe() function misses an initialization of the
return code when it fails to get its memory resource, as gcc notices:

drivers/spi/spi-lp8841-rtc.c: In function 'spi_lp8841_rtc_probe':
drivers/spi/spi-lp8841-rtc.c:239:9: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This changes the code to propagate the error from devm_ioremap_resource().

Fixes: 7ecbfff6711f ("spi: master driver to enable RTC on ICPDAS LP-8841")
Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Tested-by: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
