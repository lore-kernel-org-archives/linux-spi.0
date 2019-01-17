From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bitbang: Don't call chipselect() in spi_bitbang_setup()" to the spi tree
Date: Thu, 17 Jan 2019 12:40:20 +0000 (GMT)
Message-ID: <20190117124020.41A871126FE2@debutante.sirena.org.uk>
References: <20190116185549.23295-1-albeu@free.fr>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Alban Bedel <albeu@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116185549.23295-1-albeu@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: bitbang: Don't call chipselect() in spi_bitbang_setup()

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

>From a666f2619a97ab9264d3b06055a336b3ee75c108 Mon Sep 17 00:00:00 2001
From: Alban Bedel <albeu@free.fr>
Date: Wed, 16 Jan 2019 19:55:44 +0100
Subject: [PATCH] spi: bitbang: Don't call chipselect() in spi_bitbang_setup()

spi_setup() already call spi_set_cs() right after calling the
controller setup method, so there is no need for the bitbang driver to
do that. Because of this the chipselect() callback was confusingly
still called when CS is GPIO based.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
