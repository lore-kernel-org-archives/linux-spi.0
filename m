From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 16/36] ARM: s3c: move spi fiq handler into platform
Date: Thu, 10 Oct 2019 22:30:00 +0200
Message-ID: <20191010203043.1241612-16-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The fiq handler needs access to some register definitions that
should not be used directly by device drivers.

Since this is closely related to the irqchip driver anyway,
move it into the same place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c24xx/Makefile                           | 2 ++
 arch/arm/mach-s3c24xx/irq-s3c24xx-fiq-exports.c          | 9 +++++++++
 .../arm/mach-s3c24xx/irq-s3c24xx-fiq.S                   | 2 +-
 drivers/spi/Makefile                                     | 1 -
 drivers/spi/spi-s3c24xx.c                                | 7 +------
 .../spi-s3c24xx-fiq.h => include/linux/spi/s3c24xx-fiq.h | 5 +++++
 6 files changed, 18 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-s3c24xx/irq-s3c24xx-fiq-exports.c
 rename drivers/spi/spi-s3c24xx-fiq.S => arch/arm/mach-s3c24xx/irq-s3c24xx-fiq.S (98%)
 rename drivers/spi/spi-s3c24xx-fiq.h => include/linux/spi/s3c24xx-fiq.h (78%)

diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 8c31f84f8c97..695573df00b1 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -9,6 +9,8 @@
 
 obj-y				+= common.o
 obj-y				+= irq-s3c24xx.o
+obj-$(CONFIG_SPI_S3C24XX_FIQ)	+= irq-s3c24xx-fiq.o
+obj-$(CONFIG_SPI_S3C24XX_FIQ)	+= irq-s3c24xx-fiq-exports.o
 
 obj-$(CONFIG_CPU_S3C2410)	+= s3c2410.o
 obj-$(CONFIG_S3C2410_PLL)	+= pll-s3c2410.o
diff --git a/arch/arm/mach-s3c24xx/irq-s3c24xx-fiq-exports.c b/arch/arm/mach-s3c24xx/irq-s3c24xx-fiq-exports.c
new file mode 100644
index 000000000000..ef2d1f664e67
--- /dev/null
+++ b/arch/arm/mach-s3c24xx/irq-s3c24xx-fiq-exports.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/stddef.h>
+#include <linux/export.h>
+#include <linux/spi/s3c24xx-fiq.h>
+
+EXPORT_SYMBOL(s3c24xx_spi_fiq_rx);
+EXPORT_SYMBOL(s3c24xx_spi_fiq_txrx);
+EXPORT_SYMBOL(s3c24xx_spi_fiq_tx);
diff --git a/drivers/spi/spi-s3c24xx-fiq.S b/arch/arm/mach-s3c24xx/irq-s3c24xx-fiq.S
similarity index 98%
rename from drivers/spi/spi-s3c24xx-fiq.S
rename to arch/arm/mach-s3c24xx/irq-s3c24xx-fiq.S
index 9d5f8f1e5e81..2a84535a14fd 100644
--- a/drivers/spi/spi-s3c24xx-fiq.S
+++ b/arch/arm/mach-s3c24xx/irq-s3c24xx-fiq.S
@@ -13,7 +13,7 @@
 #include <mach/map.h>
 #include <mach/regs-irq.h>
 
-#include "spi-s3c24xx-fiq.h"
+#include <linux/spi/s3c24xx-fiq.h>
 
 #define S3C2410_SPTDAT           (0x10)
 #define S3C2410_SPRDAT           (0x14)
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index bb49c9e6d0a0..4bcbbd35d2e8 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -89,7 +89,6 @@ obj-$(CONFIG_SPI_RB4XX)			+= spi-rb4xx.o
 obj-$(CONFIG_SPI_RSPI)			+= spi-rspi.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi-s3c24xx-hw.o
 spi-s3c24xx-hw-y			:= spi-s3c24xx.o
-spi-s3c24xx-hw-$(CONFIG_SPI_S3C24XX_FIQ) += spi-s3c24xx-fiq.o
 obj-$(CONFIG_SPI_S3C64XX)		+= spi-s3c64xx.o
 obj-$(CONFIG_SPI_SC18IS602)		+= spi-sc18is602.o
 obj-$(CONFIG_SPI_SH)			+= spi-sh.o
diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index 2f395e4861f6..464146fc8420 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -19,12 +19,12 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/spi/s3c24xx.h>
+#include <linux/spi/s3c24xx-fiq.h>
 #include <linux/module.h>
 
 #include <asm/fiq.h>
 
 #include "spi-s3c24xx-regs.h"
-#include "spi-s3c24xx-fiq.h"
 
 /**
  * s3c24xx_spi_devstate - per device data
@@ -229,10 +229,6 @@ struct spi_fiq_code {
 	u8	data[0];
 };
 
-extern struct spi_fiq_code s3c24xx_spi_fiq_txrx;
-extern struct spi_fiq_code s3c24xx_spi_fiq_tx;
-extern struct spi_fiq_code s3c24xx_spi_fiq_rx;
-
 /**
  * ack_bit - turn IRQ into IRQ acknowledgement bit
  * @irq: The interrupt number
@@ -282,7 +278,6 @@ static void s3c24xx_spi_tryfiq(struct s3c24xx_spi *hw)
 	regs.uregs[fiq_rrx]  = (long)hw->rx;
 	regs.uregs[fiq_rtx]  = (long)hw->tx + 1;
 	regs.uregs[fiq_rcount] = hw->len - 1;
-	regs.uregs[fiq_rirq] = (long)S3C24XX_VA_IRQ;
 
 	set_fiq_regs(&regs);
 
diff --git a/drivers/spi/spi-s3c24xx-fiq.h b/include/linux/spi/s3c24xx-fiq.h
similarity index 78%
rename from drivers/spi/spi-s3c24xx-fiq.h
rename to include/linux/spi/s3c24xx-fiq.h
index 7786b0ea56ec..954452618dfe 100644
--- a/drivers/spi/spi-s3c24xx-fiq.h
+++ b/include/linux/spi/s3c24xx-fiq.h
@@ -12,6 +12,11 @@
 #ifdef __ASSEMBLY__
 #define __REG_NR(x)     r##x
 #else
+
+extern struct spi_fiq_code s3c24xx_spi_fiq_txrx;
+extern struct spi_fiq_code s3c24xx_spi_fiq_tx;
+extern struct spi_fiq_code s3c24xx_spi_fiq_rx;
+
 #define __REG_NR(x)     (x)
 #endif
 
-- 
2.20.0
