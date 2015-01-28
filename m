From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 06/15] spi/xilinx: Do not inhibit transmission in polling
 mode
Date: Wed, 28 Jan 2015 13:23:45 +0100
Message-ID: <1422447834-23116-7-git-send-email-ricardo.ribalda@gmail.com>
References: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@xilinx.com>,
 =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
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

When no irq is used, there is no need to inhibit the transmission for
every transaction. This inhibition was implemented to avoid a race
condition with the irq handler.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index f21e857..6656b2c 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -163,6 +163,7 @@ static void xspi_rx32(struct xilinx_spi *xspi)
 static void xspi_init_hw(struct xilinx_spi *xspi)
 {
 	void __iomem *regs_base = xspi->regs;
+	u32 inhibit;
 
 	/* Reset the SPI device */
 	xspi->write_fn(XIPIF_V123B_RESET_MASK,
@@ -173,16 +174,19 @@ static void xspi_init_hw(struct xilinx_spi *xspi)
 	xspi->write_fn(XSPI_INTR_TX_EMPTY,
 			regs_base + XIPIF_V123B_IIER_OFFSET);
 	/* Enable the global IPIF interrupt */
-	if (xspi->irq >= 0)
+	if (xspi->irq >= 0) {
 		xspi->write_fn(XIPIF_V123B_GINTR_ENABLE,
 			regs_base + XIPIF_V123B_DGIER_OFFSET);
-	else
+		inhibit = XSPI_CR_TRANS_INHIBIT;
+	} else {
 		xspi->write_fn(0, regs_base + XIPIF_V123B_DGIER_OFFSET);
+		inhibit = 0;
+	}
 	/* Deselect the slave on the SPI bus */
 	xspi->write_fn(0xffff, regs_base + XSPI_SSR_OFFSET);
 	/* Disable the transmitter, enable Manual Slave Select Assertion,
 	 * put SPI controller into master mode, and enable it */
-	xspi->write_fn(XSPI_CR_TRANS_INHIBIT | XSPI_CR_MANUAL_SSELECT |
+	xspi->write_fn(inhibit | XSPI_CR_MANUAL_SSELECT |
 		XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE | XSPI_CR_TXFIFO_RESET |
 		XSPI_CR_RXFIFO_RESET, regs_base + XSPI_CR_OFFSET);
 }
@@ -252,7 +256,7 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 	reinit_completion(&xspi->done);
 
 	while (xspi->remaining_bytes) {
-		u16 cr;
+		u16 cr = 0;
 		int n_words;
 
 		n_words = (xspi->remaining_bytes * 8) / xspi->bits_per_word;
@@ -263,13 +267,13 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 		/* Start the transfer by not inhibiting the transmitter any
 		 * longer
 		 */
-		cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET) &
-							~XSPI_CR_TRANS_INHIBIT;
-		xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
 
-		if (xspi->irq >= 0)
+		if (xspi->irq >= 0) {
+			cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET) &
+							~XSPI_CR_TRANS_INHIBIT;
+			xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
 			wait_for_completion(&xspi->done);
-		else
+		} else
 			while (!(xspi->read_fn(xspi->regs + XSPI_SR_OFFSET) &
 						XSPI_SR_TX_EMPTY_MASK))
 				;
@@ -279,7 +283,8 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 		 * transmitter while the Isr refills the transmit register/FIFO,
 		 * or make sure it is stopped if we're done.
 		 */
-		xspi->write_fn(cr | XSPI_CR_TRANS_INHIBIT,
+		if (xspi->irq >= 0)
+			xspi->write_fn(cr | XSPI_CR_TRANS_INHIBIT,
 			       xspi->regs + XSPI_CR_OFFSET);
 
 		/* Read out all the data from the Rx FIFO */
-- 
2.1.4
