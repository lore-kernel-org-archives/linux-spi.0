From: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>
Subject: [PATCH 2/2] spi: zynq: use to_platform_device()
Date: Wed, 30 Dec 2015 22:57:36 +0800
Message-ID: <917c5adcc61a2a9e6390c0fe54445aa7c8642462.1451485340.git.geliangtang@163.com>
References: <eba9c4fde1cf48cc56afba6275a4efdda998cbbe.1451485340.git.geliangtang@163.com>
Cc: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <eba9c4fde1cf48cc56afba6275a4efdda998cbbe.1451485340.git.geliangtang-9Onoh4P/yGk@public.gmane.org>
In-Reply-To: <eba9c4fde1cf48cc56afba6275a4efdda998cbbe.1451485340.git.geliangtang-9Onoh4P/yGk@public.gmane.org>
References: <eba9c4fde1cf48cc56afba6275a4efdda998cbbe.1451485340.git.geliangtang-9Onoh4P/yGk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use to_platform_device() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>
Reviewed-by: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-zynqmp-gqspi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index f23f36e..aab9b49 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -917,9 +917,7 @@ static int zynqmp_qspi_start_transfer(struct spi_master *master,
  */
 static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
 {
-	struct platform_device *pdev = container_of(dev,
-						    struct platform_device,
-						    dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct spi_master *master = platform_get_drvdata(pdev);
 
 	spi_master_suspend(master);
@@ -940,9 +938,7 @@ static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
  */
 static int __maybe_unused zynqmp_qspi_resume(struct device *dev)
 {
-	struct platform_device *pdev = container_of(dev,
-						    struct platform_device,
-						    dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
 	int ret = 0;
-- 
2.5.0


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
