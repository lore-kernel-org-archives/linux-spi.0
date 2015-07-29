From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Fix regression in spi-bitbang-txrx.h" to the spi tree
Date: Wed, 29 Jul 2015 15:14:52 +0100
Message-ID: <E1ZKS8C-0004oC-Vk@finisterre>
References: <1438155122-2923-1-git-send-email-larper@axis.com>
Cc: linux-spi@vger.kernel.org
To: Lars Persson <larper@axis.com>, Mark Brown <broonie@kernel.org>,
	stable@vger.kernel.org
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1438155122-2923-1-git-send-email-larper@axis.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Fix regression in spi-bitbang-txrx.h

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 26a67ec47a4c58fe79c6421c3dc3d697d322d2d6 Mon Sep 17 00:00:00 2001
From: Lars Persson <lars.persson@axis.com>
Date: Wed, 29 Jul 2015 09:32:02 +0200
Subject: [PATCH] spi: Fix regression in spi-bitbang-txrx.h

This patch fixes a regression introduced by commit 232a5adc5199 ("spi:
bitbang: only toggle bitchanges"). The attempt to optimize writes of
consecutive bit patterns broke most of the combinations of word size
and SPI modes due to selecting the wrong bit as the MSB value.

Fixes: 232a5adc5199 (spi: bitbang: only toggle bitchanges)
Signed-off-by: Lars Persson <larper@axis.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-bitbang-txrx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
index 06b34e5..47bb9b89 100644
--- a/drivers/spi/spi-bitbang-txrx.h
+++ b/drivers/spi/spi-bitbang-txrx.h
@@ -49,7 +49,7 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
 {
 	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
 
-	bool oldbit = !(word & 1);
+	u32 oldbit = (!(word & (1<<(bits-1)))) << 31;
 	/* clock starts at inactive polarity */
 	for (word <<= (32 - bits); likely(bits); bits--) {
 
@@ -81,7 +81,7 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
 {
 	/* if (cpol == 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
 
-	bool oldbit = !(word & (1 << 31));
+	u32 oldbit = (!(word & (1<<(bits-1)))) << 31;
 	/* clock starts at inactive polarity */
 	for (word <<= (32 - bits); likely(bits); bits--) {
 
-- 
2.1.4
