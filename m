From: Alban Bedel <albeu@free.fr>
Subject: [PATCH 3/6] spi: ath79: Enable support for compile test
Date: Wed, 16 Jan 2019 19:55:46 +0100
Message-ID: <20190116185549.23295-3-albeu@free.fr>
References: <20190116185549.23295-1-albeu@free.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Alban Bedel <albeu@free.fr>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-mips@vger.kernel.org,
        linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116185549.23295-1-albeu@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

To allow building this driver in compile test we need to remove all
dependency on headers from arch/mips/include. To allow this we
explicitly define all the registers locally instead of using
ar71xx_regs.h and we move the platform data struct definition to
include/linux/platform_data/spi-ath79.h.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/dev-spi.h                         |  2 +-
 drivers/spi/Kconfig                               |  2 +-
 drivers/spi/spi-ath79.c                           | 15 ++++++++++++---
 .../linux/platform_data/spi-ath79.h               |  0
 4 files changed, 14 insertions(+), 5 deletions(-)
 rename arch/mips/include/asm/mach-ath79/ath79_spi_platform.h => include/linux/platform_data/spi-ath79.h (100%)

diff --git a/arch/mips/ath79/dev-spi.h b/arch/mips/ath79/dev-spi.h
index d732565ca736..6e15bc8651be 100644
--- a/arch/mips/ath79/dev-spi.h
+++ b/arch/mips/ath79/dev-spi.h
@@ -13,7 +13,7 @@
 #define _ATH79_DEV_SPI_H
 
 #include <linux/spi/spi.h>
-#include <asm/mach-ath79/ath79_spi_platform.h>
+#include <linux/platform_data/spi-ath79.h>
 
 void ath79_register_spi(struct ath79_spi_platform_data *pdata,
 			 struct spi_board_info const *info,
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 128892c7e21e..71d3d2d5e5d1 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -63,7 +63,7 @@ config SPI_ALTERA
 
 config SPI_ATH79
 	tristate "Atheros AR71XX/AR724X/AR913X SPI controller driver"
-	depends on ATH79
+	depends on ATH79 || COMPILE_TEST
 	select SPI_BITBANG
 	help
 	  This enables support for the SPI controller present on the
diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index edf695a359f4..09c4fb7fcf7a 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -23,15 +23,24 @@
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-
-#include <asm/mach-ath79/ar71xx_regs.h>
-#include <asm/mach-ath79/ath79_spi_platform.h>
+#include <linux/platform_data/spi-ath79.h>
 
 #define DRV_NAME	"ath79-spi"
 
 #define ATH79_SPI_RRW_DELAY_FACTOR	12000
 #define MHZ				(1000 * 1000)
 
+#define AR71XX_SPI_REG_FS		0x00	/* Function Select */
+#define AR71XX_SPI_REG_CTRL		0x04	/* SPI Control */
+#define AR71XX_SPI_REG_IOC		0x08	/* SPI I/O Control */
+#define AR71XX_SPI_REG_RDS		0x0c	/* Read Data Shift */
+
+#define AR71XX_SPI_FS_GPIO		BIT(0)	/* Enable GPIO mode */
+
+#define AR71XX_SPI_IOC_DO		BIT(0)	/* Data Out pin */
+#define AR71XX_SPI_IOC_CLK		BIT(8)	/* CLK pin */
+#define AR71XX_SPI_IOC_CS(n)		BIT(16 + (n))
+
 struct ath79_spi {
 	struct spi_bitbang	bitbang;
 	u32			ioc_base;
diff --git a/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h b/include/linux/platform_data/spi-ath79.h
similarity index 100%
rename from arch/mips/include/asm/mach-ath79/ath79_spi_platform.h
rename to include/linux/platform_data/spi-ath79.h
-- 
2.19.1
