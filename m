From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi/spi-xilinx: Fix race condition on last word read" to the spi tree
Date: Thu, 29 Oct 2015 09:16:56 +0900
Message-ID: <E1Zratk-0006be-IC@finisterre>
References: <1446045362-13650-1-git-send-email-ricardo.ribalda@gmail.com>
Cc: linux-spi@vger.kernel.org
To: Edward Kigwana <ekigwana@scires.com>,
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1446045362-13650-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi/spi-xilinx: Fix race condition on last word read

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

>From eca37c7c117460e2fbe4e32c991bff32a961f688 Mon Sep 17 00:00:00 2001
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Wed, 28 Oct 2015 16:16:02 +0100
Subject: [PATCH] spi/spi-xilinx: Fix race condition on last word read

Some users have reported that in polled mode the driver fails randomly
to read the last word of the transfer.

The end condition used for the transmissions (in polled and irq mode)
has been the TX_EMPTY flag. But Lars-Peter Clausen has identified a delay
from the TX_EMPTY to the actual end of the data rx.

I believe that this race condition has not been detected until now
because of the latency added by the IRQ handler or the PCIe bridge.
This bugs affects setups with low latency access to the spi core.

This patch replaces the readout logic:

For all the words, except the last one, the TX_EMPTY flag is used (and
cached).

If !TX_EMPY or is the last word. The status register is read and the
RX_EMPTY flag is used.

The performance is not affected: there is an extra read of the
Status Register, but the readout can start as soon as there is a word
in the buffer.

Reported-by: Edward Kigwana <ekigwana@scires.com>
Initial-fix-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-xilinx.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index a339c1e..3009121 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -270,6 +270,7 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 	while (remaining_words) {
 		int n_words, tx_words, rx_words;
+		u32 sr;
 
 		n_words = min(remaining_words, xspi->buffer_size);
 
@@ -284,24 +285,33 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 		if (use_irq) {
 			xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
 			wait_for_completion(&xspi->done);
-		} else
-			while (!(xspi->read_fn(xspi->regs + XSPI_SR_OFFSET) &
-						XSPI_SR_TX_EMPTY_MASK))
-				;
-
-		/* A transmit has just completed. Process received data and
-		 * check for more data to transmit. Always inhibit the
-		 * transmitter while the Isr refills the transmit register/FIFO,
-		 * or make sure it is stopped if we're done.
-		 */
-		if (use_irq)
+			/* A transmit has just completed. Process received data
+			 * and check for more data to transmit. Always inhibit
+			 * the transmitter while the Isr refills the transmit
+			 * register/FIFO, or make sure it is stopped if we're
+			 * done.
+			 */
 			xspi->write_fn(cr | XSPI_CR_TRANS_INHIBIT,
-			       xspi->regs + XSPI_CR_OFFSET);
+				       xspi->regs + XSPI_CR_OFFSET);
+			sr = XSPI_SR_TX_EMPTY_MASK;
+		} else
+			sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
 
 		/* Read out all the data from the Rx FIFO */
 		rx_words = n_words;
-		while (rx_words--)
-			xilinx_spi_rx(xspi);
+		while (rx_words) {
+			if ((sr & XSPI_SR_TX_EMPTY_MASK) && (rx_words > 1)) {
+				xilinx_spi_rx(xspi);
+				rx_words--;
+				continue;
+			}
+
+			sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
+			if (!(sr & XSPI_SR_RX_EMPTY_MASK)) {
+				xilinx_spi_rx(xspi);
+				rx_words--;
+			}
+		}
 
 		remaining_words -= n_words;
 	}
-- 
2.6.1
