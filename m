From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH] spi: atmel: Remove AVR32 leftover
Date: Thu, 19 Sep 2019 17:40:34 +0200
Message-ID: <20190919154034.7489-1-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

AV32 support has been from the kernel a few release ago, but there was
still some specific macro for this architecture in this driver. Lets
remove it.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/spi/spi-atmel.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index bb94f5927819..de1e1861a70c 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -222,37 +222,13 @@
 	  | SPI_BF(name, value))
 
 /* Register access macros */
-#ifdef CONFIG_AVR32
-#define spi_readl(port, reg) \
-	__raw_readl((port)->regs + SPI_##reg)
-#define spi_writel(port, reg, value) \
-	__raw_writel((value), (port)->regs + SPI_##reg)
-
-#define spi_readw(port, reg) \
-	__raw_readw((port)->regs + SPI_##reg)
-#define spi_writew(port, reg, value) \
-	__raw_writew((value), (port)->regs + SPI_##reg)
-
-#define spi_readb(port, reg) \
-	__raw_readb((port)->regs + SPI_##reg)
-#define spi_writeb(port, reg, value) \
-	__raw_writeb((value), (port)->regs + SPI_##reg)
-#else
 #define spi_readl(port, reg) \
 	readl_relaxed((port)->regs + SPI_##reg)
 #define spi_writel(port, reg, value) \
 	writel_relaxed((value), (port)->regs + SPI_##reg)
-
-#define spi_readw(port, reg) \
-	readw_relaxed((port)->regs + SPI_##reg)
 #define spi_writew(port, reg, value) \
 	writew_relaxed((value), (port)->regs + SPI_##reg)
 
-#define spi_readb(port, reg) \
-	readb_relaxed((port)->regs + SPI_##reg)
-#define spi_writeb(port, reg, value) \
-	writeb_relaxed((value), (port)->regs + SPI_##reg)
-#endif
 /* use PIO for small transfers, avoiding DMA setup/teardown overhead and
  * cache operations; better heuristics consider wordsize and bitrate.
  */
-- 
2.23.0
