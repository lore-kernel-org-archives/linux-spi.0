From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi/spi-xilinx: Fix spurious IRQ ACK on irq mode" to the spi tree
Date: Sat, 15 Aug 2015 09:22:55 -0700
Message-ID: <E1ZQeER-0007cG-47@finisterre>
References: <1439474968-10260-1-git-send-email-ricardo.ribalda@gmail.com>
Cc: linux-spi@vger.kernel.org
To: Edward Kigwana <ekigwana@scires.com>,
	Edward Kigwana <ekigwana@scires.com>,
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1439474968-10260-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi/spi-xilinx: Fix spurious IRQ ACK on irq mode

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

>From 74346841e6f5df5f7b83d5904435d273c507dba6 Mon Sep 17 00:00:00 2001
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Thu, 13 Aug 2015 16:09:28 +0200
Subject: [PATCH] spi/spi-xilinx: Fix spurious IRQ ACK on irq mode

The ACK of an inexistent IRQ can trigger an spurious IRQ that breaks the
txrx logic. This has been observed on axi_quad_spi:3.2 core.

This patch only ACKs IRQs that have not been Acknowledge jet.

Reported-by: Edward Kigwana <ekigwana@scires.com>
Tested-by: Edward Kigwana <ekigwana@scires.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-xilinx.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 7abf679..a339c1e 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -249,19 +249,23 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 	xspi->tx_ptr = t->tx_buf;
 	xspi->rx_ptr = t->rx_buf;
 	remaining_words = t->len / xspi->bytes_per_word;
-	reinit_completion(&xspi->done);
 
 	if (xspi->irq >= 0 &&  remaining_words > xspi->buffer_size) {
+		u32 isr;
 		use_irq = true;
-		xspi->write_fn(XSPI_INTR_TX_EMPTY,
-				xspi->regs + XIPIF_V123B_IISR_OFFSET);
-		/* Enable the global IPIF interrupt */
-		xspi->write_fn(XIPIF_V123B_GINTR_ENABLE,
-				xspi->regs + XIPIF_V123B_DGIER_OFFSET);
 		/* Inhibit irq to avoid spurious irqs on tx_empty*/
 		cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET);
 		xspi->write_fn(cr | XSPI_CR_TRANS_INHIBIT,
 			       xspi->regs + XSPI_CR_OFFSET);
+		/* ACK old irqs (if any) */
+		isr = xspi->read_fn(xspi->regs + XIPIF_V123B_IISR_OFFSET);
+		if (isr)
+			xspi->write_fn(isr,
+				       xspi->regs + XIPIF_V123B_IISR_OFFSET);
+		/* Enable the global IPIF interrupt */
+		xspi->write_fn(XIPIF_V123B_GINTR_ENABLE,
+				xspi->regs + XIPIF_V123B_DGIER_OFFSET);
+		reinit_completion(&xspi->done);
 	}
 
 	while (remaining_words) {
-- 
2.5.0
