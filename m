From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: use to_spi_device" to the spi tree
Date: Wed, 23 Dec 2015 12:15:55 +0000
Message-ID: <E1aBiKh-0005m9-GK@debutante>
References: <a196696aefe502e775a025cdb662c39cbdabf412.1450800897.git.geliangtang@163.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a196696aefe502e775a025cdb662c39cbdabf412.1450800897.git.geliangtang-9Onoh4P/yGk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: use to_spi_device

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

>From d1eba93bd0fcd3f699cb8d666bc97788ee85d557 Mon Sep 17 00:00:00 2001
From: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>
Date: Wed, 23 Dec 2015 00:18:41 +0800
Subject: [PATCH] spi: use to_spi_device

Use to_spi_device() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e2415be209d5..70828521e6bb 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -84,8 +84,7 @@ static ssize_t spi_device_##field##_show(struct device *dev,		\
 					 struct device_attribute *attr,	\
 					char *buf)			\
 {									\
-	struct spi_device *spi = container_of(dev,			\
-					      struct spi_device, dev);	\
+	struct spi_device *spi = to_spi_device(dev);			\
 	return spi_statistics_##field##_show(&spi->statistics, buf);	\
 }									\
 static struct device_attribute dev_attr_spi_device_##field = {		\
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
