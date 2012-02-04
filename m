From: Kyoungil Kim <ki0351.kim@samsung.com>
Subject: [PATCH] spi: Add spi-s3c64xx driver dependency on ARCH_EXYNOS
Date: Sat, 04 Feb 2012 16:54:40 +0900
Message-ID: <000301cce312$40336bd0$c09a4370$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Cc: grant.likely@secretlab.ca,
	=?ks_c_5601-1987?B?J7HosObAzyc=?= <ki0351.kim@samsung.com>
To: spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

EXYNOS4 and EXYNOS5 commonly use the spi-s3c64xx driver.
So ARCH_EXYNOS covering ARCH_EXYNOS4 and ARCH_EXYNOS5
is better.

Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
---
 drivers/spi/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a9f8faf..8293658 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -299,7 +299,7 @@ config SPI_S3C24XX_FIQ
 
 config SPI_S3C64XX
 	tristate "Samsung S3C64XX series type SPI"
-	depends on (ARCH_S3C64XX || ARCH_S5P64X0 || ARCH_EXYNOS4)
+	depends on (ARCH_S3C64XX || ARCH_S5P64X0 || ARCH_EXYNOS)
 	select S3C64XX_DMA if ARCH_S3C64XX
 	help
 	  SPI driver for Samsung S3C64XX and newer SoCs.
-- 
1.7.1
