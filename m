From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] spi: spi-s3c64xx: Fix system resume support
Date: Thu, 17 May 2018 12:15:08 +0200
Message-ID: <20180517101508.25867-1-m.szyprowski@samsung.com>
References: <CGME20180517102518eucas1p10e55ae3c884f6fe29b37c01eff0fe7a4@eucas1p1.samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        stable@vger.kernel.org
To: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Since Linux v4.10 release (commit 1d9174fbc55e "PM / Runtime: Defer
resuming of the device in pm_runtime_force_resume()"),
pm_runtime_force_resume() function doesn't runtime resume device if it was
not runtime active before system suspend. Thus, driver should not do any
register access after pm_runtime_force_resume() without checking the
runtime status of the device. To fix this issue, simply move
s3c64xx_spi_hwinit() call to s3c64xx_spi_runtime_resume() to ensure that
hardware is always properly initialized. This fixes Synchronous external
abort issue on system suspend/resume cycle on newer Exynos SoCs.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
CC: <stable@vger.kernel.org> # 4.10.x: 1c75862d8e5a spi: spi-s3c64xx: Remove unused s3c64xx_spi_hwinit()
CC: <stable@vger.kernel.org> # 4.10.x
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Andi Shyti <andi@etezian.org>
---
Resend reason: added cc: stable, reviewed and acked tags
---
 drivers/spi/spi-s3c64xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index f55dc78957ad..7b7151ec14c8 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1292,8 +1292,6 @@ static int s3c64xx_spi_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	s3c64xx_spi_hwinit(sdd);
-
 	return spi_master_resume(master);
 }
 #endif /* CONFIG_PM_SLEEP */
@@ -1331,6 +1329,8 @@ static int s3c64xx_spi_runtime_resume(struct device *dev)
 	if (ret != 0)
 		goto err_disable_src_clk;
 
+	s3c64xx_spi_hwinit(sdd);
+
 	return 0;
 
 err_disable_src_clk:
-- 
2.17.0
