From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: fix SPI_BPW_RANGE_MASK() regression" to the spi tree
Date: Thu, 14 Mar 2019 15:54:44 +0000 (GMT)
Message-ID: <20190314155444.EBE3A1126E64@debutante.sirena.org.uk>
References: <20190313210118.3507256-1-arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190313210118.3507256-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: fix SPI_BPW_RANGE_MASK() regression

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

>From 6d85028134d3f4f946924e2f9f0aaff47d9de840 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 13 Mar 2019 22:00:34 +0100
Subject: [PATCH] spi: fix SPI_BPW_RANGE_MASK() regression

Geert points out that I confused the min/max arguments that are
reversed between SPI_BPW_RANGE_MASK() and GENMASK(). This time
I have verified the result of the macro after fixing the arguments.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: eefffb42f665 ("spi: work around clang bug in SPI_BPW_RANGE_MASK()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index b27386450089..a0975cf76cf6 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -444,7 +444,7 @@ struct spi_controller {
 	/* bitmask of supported bits_per_word for transfers */
 	u32			bits_per_word_mask;
 #define SPI_BPW_MASK(bits) BIT((bits) - 1)
-#define SPI_BPW_RANGE_MASK(min, max) GENMASK((min) - 1, (max) - 1)
+#define SPI_BPW_RANGE_MASK(min, max) GENMASK((max) - 1, (min) - 1)
 
 	/* limits on transfer speed */
 	u32			min_speed_hz;
-- 
2.20.1
