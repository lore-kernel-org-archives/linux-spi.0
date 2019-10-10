From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 13/36] ARM: s3c: move regs-spi.h into spi driver
Date: Thu, 10 Oct 2019 22:29:57 +0200
Message-ID: <20191010203043.1241612-13-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The file is mostly specific to the driver, the few bits that
are actually used by the platform code get moved to mach/map.h
instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c24xx/include/mach/map.h                      | 2 ++
 arch/arm/mach-s3c24xx/s3c2412.c                               | 1 -
 arch/arm/plat-samsung/devs.c                                  | 1 -
 drivers/spi/spi-s3c24xx-fiq.S                                 | 4 +++-
 .../include/plat/regs-spi.h => drivers/spi/spi-s3c24xx-regs.h | 3 ---
 drivers/spi/spi-s3c24xx.c                                     | 3 +--
 6 files changed, 6 insertions(+), 8 deletions(-)
 rename arch/arm/plat-samsung/include/plat/regs-spi.h => drivers/spi/spi-s3c24xx-regs.h (95%)

diff --git a/arch/arm/mach-s3c24xx/include/mach/map.h b/arch/arm/mach-s3c24xx/include/mach/map.h
index bca93112f57d..a20c9fd0d855 100644
--- a/arch/arm/mach-s3c24xx/include/mach/map.h
+++ b/arch/arm/mach-s3c24xx/include/mach/map.h
@@ -86,6 +86,8 @@
 #define S3C2410_PA_SPI	   (0x59000000)
 #define S3C2443_PA_SPI0		(0x52000000)
 #define S3C2443_PA_SPI1		S3C2410_PA_SPI
+#define S3C2410_SPI1		(0x20)
+#define S3C2412_SPI1		(0x100)
 
 /* SDI */
 #define S3C2410_PA_SDI	   (0x5A000000)
diff --git a/arch/arm/mach-s3c24xx/s3c2412.c b/arch/arm/mach-s3c24xx/s3c2412.c
index 8fe4d4670dcb..c3fb3e6c0dd8 100644
--- a/arch/arm/mach-s3c24xx/s3c2412.c
+++ b/arch/arm/mach-s3c24xx/s3c2412.c
@@ -37,7 +37,6 @@
 #include <plat/cpu-freq.h>
 #include <plat/devs.h>
 #include <plat/pm.h>
-#include <plat/regs-spi.h>
 
 #include "common.h"
 #include "nand-core.h"
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 6e4c1cb07104..fd94a35e22f8 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -59,7 +59,6 @@
 #include <linux/platform_data/usb-s3c2410_udc.h>
 #include <linux/platform_data/usb-ohci-s3c2410.h>
 #include <plat/usb-phy.h>
-#include <plat/regs-spi.h>
 #include <linux/platform_data/asoc-s3c.h>
 #include <linux/platform_data/spi-s3c64xx.h>
 
diff --git a/drivers/spi/spi-s3c24xx-fiq.S b/drivers/spi/spi-s3c24xx-fiq.S
index e95d6282109e..9d5f8f1e5e81 100644
--- a/drivers/spi/spi-s3c24xx-fiq.S
+++ b/drivers/spi/spi-s3c24xx-fiq.S
@@ -12,10 +12,12 @@
 
 #include <mach/map.h>
 #include <mach/regs-irq.h>
-#include <plat/regs-spi.h>
 
 #include "spi-s3c24xx-fiq.h"
 
+#define S3C2410_SPTDAT           (0x10)
+#define S3C2410_SPRDAT           (0x14)
+
 	.text
 
 	@ entry to these routines is as follows, with the register names
diff --git a/arch/arm/plat-samsung/include/plat/regs-spi.h b/drivers/spi/spi-s3c24xx-regs.h
similarity index 95%
rename from arch/arm/plat-samsung/include/plat/regs-spi.h
rename to drivers/spi/spi-s3c24xx-regs.h
index 607844311566..37b93ff7c7fe 100644
--- a/arch/arm/plat-samsung/include/plat/regs-spi.h
+++ b/drivers/spi/spi-s3c24xx-regs.h
@@ -8,9 +8,6 @@
 #ifndef __ASM_ARCH_REGS_SPI_H
 #define __ASM_ARCH_REGS_SPI_H
 
-#define S3C2410_SPI1		(0x20)
-#define S3C2412_SPI1		(0x100)
-
 #define S3C2410_SPCON		(0x00)
 
 #define S3C2410_SPCON_SMOD_DMA	(2 << 5)	/* DMA mode */
diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index 2d6e37f25e2d..2f395e4861f6 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -21,10 +21,9 @@
 #include <linux/spi/s3c24xx.h>
 #include <linux/module.h>
 
-#include <plat/regs-spi.h>
-
 #include <asm/fiq.h>
 
+#include "spi-s3c24xx-regs.h"
 #include "spi-s3c24xx-fiq.h"
 
 /**
-- 
2.20.0
