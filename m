From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] spi: fix SPI_BPW_RANGE_MASK() regression
Date: Wed, 13 Mar 2019 22:00:34 +0100
Message-ID: <20190313210118.3507256-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Geert points out that I confused the min/max arguments that are
reversed between SPI_BPW_RANGE_MASK() and GENMASK(). This time
I have verified the result of the macro after fixing the arguments.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: eefffb42f665 ("spi: work around clang bug in SPI_BPW_RANGE_MASK()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The broken commit is currently in the for-5.2 branch of the spi
tree. If this is a branch that gets rebased, please just fold this
fix into the original patch
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
2.20.0
