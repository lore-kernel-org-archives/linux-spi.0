From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH RESEND] spi: s3c64xx: Fix pm_runtime_get_sync() return value
 check
Date: Mon, 10 Jun 2013 18:22:26 +0200
Message-ID: <1370881346-28000-1-git-send-email-s.nawrocki@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	kyungmin.park@samsung.com, spi-devel-general@lists.sourceforge.net,
	Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

If the device is already in a runtime PM enabled state
pm_runtime_get_sync() will return 1, so a test for negative
value should be used to check for errors.

Without this patch there are seen errors like:

[    8.540000] s3c64xx-spi 13930000.spi: Failed to enable device: 1
[    8.545000] spi_master spi1: failed to prepare transfer hardware

Likely because the driver uses synchronous API to runtime enable
the device and asynchronous one to disable it.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
I used broonie@kernel.org e-mail address this time, as found in MAINATAINERS,
instead of broonie@opensource.wolfsonmicro.com which seems to be inactive.

 drivers/spi/spi-s3c64xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 5000586..71cc3e6 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -444,7 +444,7 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 	}

 	ret = pm_runtime_get_sync(&sdd->pdev->dev);
-	if (ret != 0) {
+	if (ret < 0) {
 		dev_err(dev, "Failed to enable device: %d\n", ret);
 		goto out_tx;
 	}
--
1.7.9.5
