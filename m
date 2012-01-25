From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] spi: Add spi-s3c64xx driver dependency on ARCH_EXYNOS4
Date: Wed, 25 Jan 2012 17:20:59 +0100
Message-ID: <1327508459-30814-1-git-send-email-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: linux-samsung-soc@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net, kgene.kim@samsung.com,
	riverful.kim@samsung.com, sw0312.kim@samsung.com,
	m.szyprowski@samsung.com,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Jaswinder Singh <jassi.brar@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
To: grant.likely@secretlab.ca
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The spi-s3c64xx driver is also used on Exynos4 so update the dependency
to enable build on those platforms.

Cc: Jaswinder Singh <jassi.brar@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/spi/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3f9a47e..a9f8faf 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -299,7 +299,7 @@ config SPI_S3C24XX_FIQ
 
 config SPI_S3C64XX
 	tristate "Samsung S3C64XX series type SPI"
-	depends on (ARCH_S3C64XX || ARCH_S5P64X0)
+	depends on (ARCH_S3C64XX || ARCH_S5P64X0 || ARCH_EXYNOS4)
 	select S3C64XX_DMA if ARCH_S3C64XX
 	help
 	  SPI driver for Samsung S3C64XX and newer SoCs.
-- 
1.7.8.3
