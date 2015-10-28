From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi/spi-xilinx: Fix race condition on last word read
Date: Wed, 28 Oct 2015 16:16:02 +0100
Message-ID: <1446045362-13650-1-git-send-email-ricardo.ribalda@gmail.com>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Edward Kigwana <ekigwana-UV7F5/lgMp/QT0dZR+AlfA@public.gmane.org>,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

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

Reported-by: Edward Kigwana <ekigwana-UV7F5/lgMp/QT0dZR+AlfA@public.gmane.org>
Initial-fix-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Edward Kigwana <ekigwana-UV7F5/lgMp/QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-xilinx.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index a339c1e9997a..3009121173cd 100644
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

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
