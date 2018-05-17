From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-s3c64xx: Fix system resume support" to the spi tree
Date: Thu, 17 May 2018 17:42:02 +0100 (BST)
Message-ID: <20180517164202.8861144007E@finisterre.ee.mobilebroadband>
References: <20180516084239.29244-1-m.szyprowski@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-spi@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180516084239.29244-1-m.szyprowski@samsung.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-s3c64xx: Fix system resume support

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

>From e935dba111621bd6a0c5d48e6511a4d9885103b4 Mon Sep 17 00:00:00 2001
From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Wed, 16 May 2018 10:42:39 +0200
Subject: [PATCH] spi: spi-s3c64xx: Fix system resume support

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
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
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
