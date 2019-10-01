From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: atmel: Remove AVR32 leftover" to the spi tree
Date: Tue,  1 Oct 2019 12:41:07 +0100 (BST)
Message-ID: <20191001114107.0FAEC2742A10@ypsilon.sirena.org.uk>
References: <20190919154034.7489-1-gregory.clement@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190919154034.7489-1-gregory.clement@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: atmel: Remove AVR32 leftover

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

>From e61bb114d41ddf6ae5bf05a0109fc13116550c7d Mon Sep 17 00:00:00 2001
From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Thu, 19 Sep 2019 17:40:34 +0200
Subject: [PATCH] spi: atmel: Remove AVR32 leftover

AV32 support has been from the kernel a few release ago, but there was
still some specific macro for this architecture in this driver. Lets
remove it.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/r/20190919154034.7489-1-gregory.clement@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index acf318e7330c..3ed5e663da6f 100644
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
2.20.1
