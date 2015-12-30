From: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>
Subject: [PATCH 1/2] spi: cadence: use to_platform_device()
Date: Wed, 30 Dec 2015 22:57:35 +0800
Message-ID: <eba9c4fde1cf48cc56afba6275a4efdda998cbbe.1451485340.git.geliangtang@163.com>
References: <CAAtXAHd_Xp4WbXMSY5QVLT7cYnpbzObf5UHCnuzh64LgOBER3Q@mail.gmail.com>
Cc: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAtXAHd_Xp4WbXMSY5QVLT7cYnpbzObf5UHCnuzh64LgOBER3Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use to_platform_device() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>
Reviewed-by: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-cadence.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 5a67498..121a413 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -617,8 +617,7 @@ static int cdns_spi_remove(struct platform_device *pdev)
  */
 static int __maybe_unused cdns_spi_suspend(struct device *dev)
 {
-	struct platform_device *pdev = container_of(dev,
-			struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct cdns_spi *xspi = spi_master_get_devdata(master);
 
@@ -641,8 +640,7 @@ static int __maybe_unused cdns_spi_suspend(struct device *dev)
  */
 static int __maybe_unused cdns_spi_resume(struct device *dev)
 {
-	struct platform_device *pdev = container_of(dev,
-			struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct cdns_spi *xspi = spi_master_get_devdata(master);
 	int ret = 0;
-- 
2.5.0


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
