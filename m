From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Fix race condition in TCFQ/EOQ interrupt" to the spi tree
Date: Tue,  3 Sep 2019 12:57:48 +0100 (BST)
Message-ID: <20190903115748.A1DA72742D32@ypsilon.sirena.org.uk>
References: <20190903105708.32273-1-olteanv@gmail.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903105708.32273-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-fsl-dspi: Fix race condition in TCFQ/EOQ interrupt

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

>From e327364948492f6a4e866417d3d4d17d95fed285 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue, 3 Sep 2019 13:57:08 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Fix race condition in TCFQ/EOQ interrupt

When the driver is working in TCFQ/EOQ mode (i.e. interacts with the SPI
controller's FIFOs directly) the following sequence of operations
happens:

- The first byte of the tx buffer gets pushed to the TX FIFO (dspi->len
  gets decremented). This triggers the train of interrupts that handle
  the rest of the bytes.

- The dspi_interrupt handles a TX confirmation event. It reads the newly
  available byte from the RX FIFO, checks the dspi->len exit condition,
  and if there's more to be done, it kicks off the next interrupt in the
  train by writing the next byte to the TX FIFO.

Now the problem is that the wait queue is woken up one byte too early,
because dspi->len becomes 0 as soon as the byte has been pushed into the
TX FIFO. Its interrupt has not yet been processed and the RX byte has
not been put from the FIFO into the buffer.

Depending on the timing of the wait queue wakeup vs the handling of the
last dspi_interrupt, it can happen that the main SPI message pump thread
has already returned back into the spi_device driver. When the rx buffer
is on stack (which it can be, because in this mode, the DSPI doesn't do
DMA), the last interrupt will perform a memory write into an rx buffer
that has been freed. This manifests as stack corruption.

The solution is to only wake up the wait queue when dspi_rxtx says so,
i.e. after it has processed the last TX confirmation interrupt and
collected the last RX byte.

Fixes: c55be3059159 ("spi: spi-fsl-dspi: Use poll mode in case the platform IRQ is missing")
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190903105708.32273-1-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 77db43f1290f..bec758e978fb 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -710,9 +710,7 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	if (!(spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)))
 		return IRQ_NONE;
 
-	dspi_rxtx(dspi);
-
-	if (!dspi->len) {
+	if (dspi_rxtx(dspi) == 0) {
 		dspi->waitflags = 1;
 		wake_up_interruptible(&dspi->waitq);
 	}
-- 
2.20.1
