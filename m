From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bcm2835: Avoid 64-bit arithmetic in xfer len calc" to
 the spi tree
Date: Wed,  8 May 2019 10:08:55 +0100 (BST)
Message-ID: <20190508090855.DA05F440039@finisterre.sirena.org.uk>
References: <20190423201513.8073-3-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, Mark Brown <broonie@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: Martin Sperl <kernel@martin.sperl.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190423201513.8073-3-kernel@martin.sperl.org>
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

   spi: bcm2835: Avoid 64-bit arithmetic in xfer len calc

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

>From 7f1922eb3adba8c372fdf0d04fe9e6268f98291a Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel@martin.sperl.org>
Date: Tue, 23 Apr 2019 20:15:09 +0000
Subject: [PATCH] spi: bcm2835: Avoid 64-bit arithmetic in xfer len calc

Avoid 64 bit aritmetics when deciding if we need to use polling or not
This replicates: commit d704afffe65c
("spi: bcm2835aux: Avoid 64-bit arithmetic in xfer len calc")
from spi-bcm2835aux

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Changelog:
  V1 -> V2: applied feedback by Stefan Wahren
            reorganized patchset
	    added extra rational, descriptions
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 6c73e694794a..b7bb07c9507d 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -749,7 +749,6 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	unsigned long spi_hz, clk_hz, cdiv;
 	unsigned long spi_used_hz;
-	unsigned long long xfer_time_us;
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 
 	/* set clock */
@@ -790,14 +789,15 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	bs->tx_len = tfr->len;
 	bs->rx_len = tfr->len;
 
-	/* calculate the estimated time in us the transfer runs */
-	xfer_time_us = (unsigned long long)tfr->len
-		* 9 /* clocks/byte - SPI-HW waits 1 clock after each byte */
-		* 1000000;
-	do_div(xfer_time_us, spi_used_hz);
-
-	/* for short requests run polling*/
-	if (xfer_time_us <= BCM2835_SPI_POLLING_LIMIT_US)
+	/* Calculate the estimated time in us the transfer runs.  Note that
+	 * there is 1 idle clocks cycles after each byte getting transferred
+	 * so we have 9 cycles/byte.  This is used to find the number of Hz
+	 * per byte per polling limit.  E.g., we can transfer 1 byte in 30 us
+	 * per 300,000 Hz of bus clock.
+	 */
+#define HZ_PER_BYTE ((9 * 1000000) / BCM2835_SPI_POLLING_LIMIT_US)
+	/* run in polling mode for short transfers */
+	if (tfr->len < spi_used_hz / HZ_PER_BYTE)
 		return bcm2835_spi_transfer_one_poll(master, spi, tfr, cs);
 
 	/* run in dma mode if conditions are right */
-- 
2.20.1
