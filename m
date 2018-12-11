From: Mark Brown <broonie@kernel.org>
Subject: Applied "mtd: atmel-quadspi: disallow building on ebsa110" to the spi tree
Date: Tue, 11 Dec 2018 01:16:29 +0000 (GMT)
Message-ID: <20181211011629.6BA4311254C7@debutante.sirena.org.uk>
References: <20181210203837.2118450-1-arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, cyrille.pitchen@microchip.com,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210203837.2118450-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   mtd: atmel-quadspi: disallow building on ebsa110

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

>From 2a9d92fb3a1282a4659f1bb6d5684018846537b7 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Dec 2018 21:38:16 +0100
Subject: [PATCH] mtd: atmel-quadspi: disallow building on ebsa110

I ran into a link-time error with the atmel-quadspi driver on the
EBSA110 platform:

drivers/mtd/built-in.o: In function `atmel_qspi_run_command':
:(.text+0x1ee3c): undefined reference to `_memcpy_toio'
:(.text+0x1ee48): undefined reference to `_memcpy_fromio'

The problem is that _memcpy_toio/_memcpy_fromio are not available on
that platform, and we have to prevent building the driver there.

In case we want to backport this to older kernels: between linux-4.8
and linux-4.20, the Kconfig entry was in drivers/mtd/spi-nor/Kconfig
but had the same problem.

Link: https://lore.kernel.org/patchwork/patch/812860/
Fixes: 161aaab8a067 ("mtd: atmel-quadspi: add driver for Atmel QSPI controller")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ca68ac63c6c3..3135f80ec853 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -93,7 +93,7 @@ config SPI_AT91_USART
 
 config SPI_ATMEL_QUADSPI
 	tristate "Atmel Quad SPI Controller"
-	depends on ARCH_AT91 || (ARM && COMPILE_TEST)
+	depends on ARCH_AT91 || (ARM && COMPILE_TEST && !ARCH_EBSA110)
 	depends on OF && HAS_IOMEM
 	help
 	  This enables support for the Quad SPI controller in master mode.
-- 
2.19.0.rc2
