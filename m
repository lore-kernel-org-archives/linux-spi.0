From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] spi: s3c64xx: Remove unused platform_device_id entries
Date: Tue, 29 Dec 2015 18:34:40 +0100
Message-ID: <1451410480-13935-1-git-send-email-s.nawrocki@samsung.com>
Cc: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

s5pv210 and exynos4 are now DT only platforms hence these
entries can now be safely removed from the match table.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/spi/spi-s3c64xx.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8e86e7f..ec697fe 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1370,12 +1370,6 @@ static const struct platform_device_id s3c64xx_spi_driver_ids[] = {
 	}, {
 		.name		= "s3c6410-spi",
 		.driver_data	= (kernel_ulong_t)&s3c6410_spi_port_config,
-	}, {
-		.name		= "s5pv210-spi",
-		.driver_data	= (kernel_ulong_t)&s5pv210_spi_port_config,
-	}, {
-		.name		= "exynos4210-spi",
-		.driver_data	= (kernel_ulong_t)&exynos4_spi_port_config,
 	},
 	{ },
 };
-- 
1.7.9.5
