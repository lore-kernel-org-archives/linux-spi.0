From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bcm2835: BUG: fix wrong use of PAGE_MASK" to the spi tree
Date: Thu, 10 Sep 2015 11:36:01 +0100
Message-ID: <E1ZZzCz-0008QS-H2@finisterre>
References: <1441877535-2218-1-git-send-email-kernel@martin.sperl.org>
Cc: linux-spi@vger.kernel.org
To: <robert@axium.co.nz>, Martin Sperl <kernel@martin.sperl.org>,
	Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1441877535-2218-1-git-send-email-kernel@martin.sperl.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: bcm2835: BUG: fix wrong use of PAGE_MASK

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

>From 2a3fffd45822070309bcf0b1e1dae624d633824a Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel@martin.sperl.org>
Date: Thu, 10 Sep 2015 09:32:14 +0000
Subject: [PATCH] spi: bcm2835: BUG: fix wrong use of PAGE_MASK

There is a bug in the alignment checking of transfers,
that results in DMA not being used for un-aligned
transfers that do not cross page-boundries, which is valid.

This is due to a missconception of the meaning PAGE_MASK
when implementing that check originally - (PAGE_SIZE - 1)
should have been used instead.

Also fixes a copy/paste error.

Reported-by: <robert@axium.co.nz>
Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-bcm2835.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 59705ab..ed74786 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -386,14 +386,14 @@ static bool bcm2835_spi_can_dma(struct spi_master *master,
 	/* otherwise we only allow transfers within the same page
 	 * to avoid wasting time on dma_mapping when it is not practical
 	 */
-	if (((size_t)tfr->tx_buf & PAGE_MASK) + tfr->len > PAGE_SIZE) {
+	if (((size_t)tfr->tx_buf & (PAGE_SIZE - 1)) + tfr->len > PAGE_SIZE) {
 		dev_warn_once(&spi->dev,
 			      "Unaligned spi tx-transfer bridging page\n");
 		return false;
 	}
-	if (((size_t)tfr->rx_buf & PAGE_MASK) + tfr->len > PAGE_SIZE) {
+	if (((size_t)tfr->rx_buf & (PAGE_SIZE - 1)) + tfr->len > PAGE_SIZE) {
 		dev_warn_once(&spi->dev,
-			      "Unaligned spi tx-transfer bridging page\n");
+			      "Unaligned spi rx-transfer bridging page\n");
 		return false;
 	}
 
-- 
2.5.0
