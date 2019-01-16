From: Alban Bedel <albeu@free.fr>
Subject: [PATCH 1/6] spi: bitbang: Don't call chipselect() in spi_bitbang_setup()
Date: Wed, 16 Jan 2019 19:55:44 +0100
Message-ID: <20190116185549.23295-1-albeu@free.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Alban Bedel <albeu@free.fr>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

spi_setup() already call spi_set_cs() right after calling the
controller setup method, so there is no need for the bitbang driver to
do that. Because of this the chipselect() callback was confusingly
still called when CS is GPIO based.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/spi/spi-bitbang.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index f29176000b8d..dd9a8c54a693 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -213,19 +213,6 @@ int spi_bitbang_setup(struct spi_device *spi)
 
 	dev_dbg(&spi->dev, "%s, %u nsec/bit\n", __func__, 2 * cs->nsecs);
 
-	/* NOTE we _need_ to call chipselect() early, ideally with adapter
-	 * setup, unless the hardware defaults cooperate to avoid confusion
-	 * between normal (active low) and inverted chipselects.
-	 */
-
-	/* deselect chip (low or high) */
-	mutex_lock(&bitbang->lock);
-	if (!bitbang->busy) {
-		bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
-		ndelay(cs->nsecs);
-	}
-	mutex_unlock(&bitbang->lock);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_bitbang_setup);
-- 
2.19.1
