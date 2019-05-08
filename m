From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bcm2835: make the polling duration limits configurable"
 to the spi tree
Date: Wed,  8 May 2019 10:08:54 +0100 (BST)
Message-ID: <20190508090854.9A734440035@finisterre.sirena.org.uk>
References: <20190423201513.8073-5-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, Mark Brown <broonie@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: Martin Sperl <kernel@martin.sperl.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190423201513.8073-5-kernel@martin.sperl.org>
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

   spi: bcm2835: make the polling duration limits configurable

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

>From ff245d90ebed8d4da6751dfee1bc76e4a5e94257 Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel@martin.sperl.org>
Date: Tue, 23 Apr 2019 20:15:11 +0000
Subject: [PATCH] spi: bcm2835: make the polling duration limits configurable

Under some circumstances the default 30 us polling limit is not optimal
and may lead to long delays because we are waiting on an interrupt.
with this patch we have the possibility to influence this policy.

So make this limit (in us) configurable via a module parameters
(but also modifyable via /sys/modules/...)

This replicates similar code found in spi-bcm2835aux.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Changelog:
  V1 -> V2: applied feedback by Stefan Wahren
            reorganized patchset
	    added extra rational, descriptions
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 0d8c97502f14..3230d37fa89a 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -73,14 +73,18 @@
 
 #define BCM2835_SPI_FIFO_SIZE		64
 #define BCM2835_SPI_FIFO_SIZE_3_4	48
-#define BCM2835_SPI_POLLING_LIMIT_US	30
-#define BCM2835_SPI_POLLING_JIFFIES	2
 #define BCM2835_SPI_DMA_MIN_LENGTH	96
 #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				| SPI_NO_CS | SPI_3WIRE)
 
 #define DRV_NAME	"spi-bcm2835"
 
+/* define polling limits */
+unsigned int polling_limit_us = 30;
+module_param(polling_limit_us, uint, 0664);
+MODULE_PARM_DESC(polling_limit_us,
+		 "time in us to run a transfer in polling mode\n");
+
 /**
  * struct bcm2835_spi - BCM2835 SPI controller
  * @regs: base address of register map
@@ -711,8 +715,8 @@ static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 	 */
 	bcm2835_wr_fifo_blind(bs, BCM2835_SPI_FIFO_SIZE);
 
-	/* set the timeout */
-	timeout = jiffies + BCM2835_SPI_POLLING_JIFFIES;
+	/* set the timeout to at least 2 jiffies */
+	timeout = jiffies + 2 + HZ * polling_limit_us / 1000000;
 
 	/* loop until finished the transfer */
 	while (bs->rx_len) {
@@ -747,8 +751,8 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 				    struct spi_transfer *tfr)
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
-	unsigned long spi_hz, clk_hz, cdiv;
-	unsigned long spi_used_hz;
+	unsigned long spi_hz, clk_hz, cdiv, spi_used_hz;
+	unsigned long hz_per_byte, byte_limit;
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 
 	/* set clock */
@@ -795,9 +799,11 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	 * per byte per polling limit.  E.g., we can transfer 1 byte in 30 us
 	 * per 300,000 Hz of bus clock.
 	 */
-#define HZ_PER_BYTE ((9 * 1000000) / BCM2835_SPI_POLLING_LIMIT_US)
+	hz_per_byte = polling_limit_us ? (9 * 1000000) / polling_limit_us : 0;
+	byte_limit = hz_per_byte ? spi_used_hz / hz_per_byte : 1;
+
 	/* run in polling mode for short transfers */
-	if (tfr->len < spi_used_hz / HZ_PER_BYTE)
+	if (tfr->len < byte_limit)
 		return bcm2835_spi_transfer_one_poll(master, spi, tfr, cs);
 
 	/* run in dma mode if conditions are right
-- 
2.20.1
