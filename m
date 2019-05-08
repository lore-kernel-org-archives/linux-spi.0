From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bcm2835: added comment about different bus behaviour of
 DMA mode" to the spi tree
Date: Wed,  8 May 2019 10:08:55 +0100 (BST)
Message-ID: <20190508090855.3E3B3440036@finisterre.sirena.org.uk>
References: <20190423201513.8073-4-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, Mark Brown <broonie@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: Martin Sperl <kernel@martin.sperl.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190423201513.8073-4-kernel@martin.sperl.org>
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

The patch

   spi: bcm2835: added comment about different bus behaviour of DMA mode

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

>From c41d62b06cb92289ab5db9d37a0f27fe6271fa34 Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel@martin.sperl.org>
Date: Tue, 23 Apr 2019 20:15:10 +0000
Subject: [PATCH] spi: bcm2835: added comment about different bus behaviour of
 DMA mode

The DMA mode behaves slightly different than polling or interrupt driven
mode, so just document the fact

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Changelog:
  V1 -> V2: applied feedback by Stefan Wahren
            new in V2
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index b7bb07c9507d..0d8c97502f14 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -800,7 +800,10 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	if (tfr->len < spi_used_hz / HZ_PER_BYTE)
 		return bcm2835_spi_transfer_one_poll(master, spi, tfr, cs);
 
-	/* run in dma mode if conditions are right */
+	/* run in dma mode if conditions are right
+	 * Note that unlike poll or interrupt mode DMA mode does not have
+	 * this 1 idle clock cycle pattern but runs the spi clock without gaps
+	 */
 	if (master->can_dma && bcm2835_spi_can_dma(master, spi, tfr))
 		return bcm2835_spi_transfer_one_dma(master, spi, tfr, cs);
 
-- 
2.20.1
