From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH 6/6] spi/s3c64xx: Allow usage for ARCH_S3C24XX
Date: Sun, 4 Mar 2012 19:09:10 +0100
Message-ID: <201203041909.10400.heiko@sntech.de>
References: <201203041902.38318.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: ben-linux@fluff.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net
To: Kukjin Kim <kgene.kim@samsung.com>,
	Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <201203041902.38318.heiko@sntech.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Newer SoCs from the S3C24XX line, namely S3C2416/2443/2450 contain
hsspi-controllers compatible with the s3c64xx type.

The previous patches enabled platform support for it, so make the
driver also usable for the S3C24xx architecture.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
As it is part of a series this probably needs an ack from Grant Likely
and should be merged via the samsung tree.

 drivers/spi/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ac92194..e411364 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -299,7 +299,7 @@ config SPI_S3C24XX_FIQ
 
 config SPI_S3C64XX
 	tristate "Samsung S3C64XX series type SPI"
-	depends on (ARCH_S3C64XX || ARCH_S5P64X0 || ARCH_EXYNOS)
+	depends on (ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5P64X0 || ARCH_EXYNOS)
 	select S3C64XX_DMA if ARCH_S3C64XX
 	help
 	  SPI driver for Samsung S3C64XX and newer SoCs.
-- 
1.7.2.3
