From: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] au1550_spi: improve pio transfer mode
Date: Wed, 11 Jun 2008 15:55:17 +0200
Message-ID: <20080611135517.GA32704@nikitenko.systec.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Improve PIO transfer mode of au1550 spi controller by continuing of spi
transfer, instead of transfer abort when transmit underflow interrupt
occurred.
Verified by oscilloscope, that spi clock is paused on trasmit underflow,
and transfer continue is perfectly valid, even though au1550 datasheet says,
that on tx underflow, zeroes would be transfered.
Also make few error messages more specific.

Signed-off-by: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 drivers/spi/au1550_spi.c |   69 ++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/au1550_spi.c b/drivers/spi/au1550_spi.c
index 072c4a5..186fb37 100644
--- a/drivers/spi/au1550_spi.c
+++ b/drivers/spi/au1550_spi.c
@@ -480,9 +480,13 @@ static irqreturn_t au1550_spi_dma_irq_callback(struct au1550_spi *hw)
 		au1xxx_dbdma_reset(hw->dma_tx_ch);
 		au1550_spi_reset_fifos(hw);
 
-		dev_err(hw->dev,
-			"Unexpected SPI error: event=0x%x stat=0x%x!\n",
-			evnt, stat);
+		if (evnt == PSC_SPIEVNT_RO)
+			dev_err(hw->dev,
+				"dma transfer: receive FIFO overflow!\n");
+		else
+			dev_err(hw->dev,
+				"dma transfer: unexpected SPI error "
+				"(event=0x%x stat=0x%x)!\n", evnt, stat);
 
 		complete(&hw->master_done);
 		return IRQ_HANDLED;
@@ -592,17 +596,17 @@ static irqreturn_t au1550_spi_pio_irq_callback(struct au1550_spi *hw)
 
 	if ((evnt & (PSC_SPIEVNT_MM | PSC_SPIEVNT_RO
 				| PSC_SPIEVNT_RU | PSC_SPIEVNT_TO
-				| PSC_SPIEVNT_TU | PSC_SPIEVNT_SD))
+			 	| PSC_SPIEVNT_SD))
 			!= 0) {
-		dev_err(hw->dev,
-			"Unexpected SPI error: event=0x%x stat=0x%x!\n",
-			evnt, stat);
 		/*
 		 * due to an error we consider transfer as done,
 		 * so mask all events until before next transfer start
 		 */
 		au1550_spi_mask_ack_all(hw);
 		au1550_spi_reset_fifos(hw);
+		dev_err(hw->dev,
+			"pio transfer: unexpected SPI error "
+			"(event=0x%x stat=0x%x)!\n", evnt, stat);
 		complete(&hw->master_done);
 		return IRQ_HANDLED;
 	}
@@ -616,27 +620,50 @@ static irqreturn_t au1550_spi_pio_irq_callback(struct au1550_spi *hw)
 		stat = hw->regs->psc_spistat;
 		au_sync();
 
-		if ((stat & PSC_SPISTAT_RE) == 0 && hw->rx_count < hw->len) {
+		/*
+		 * Take care to not let the Rx FIFO overflow.
+		 *
+		 * We only write a byte if we have read one at least. Initially,
+		 * the write fifo is full, so we should read from the read fifo
+		 * first.
+		 * In case we miss a word from the read fifo, we should get a
+		 * RO event and should back out.
+		 */
+		if (!(stat & PSC_SPISTAT_RE) && hw->rx_count < hw->len) {
 			hw->rx_word(hw);
-			/* ack the receive request event */
-			hw->regs->psc_spievent = PSC_SPIEVNT_RR;
-			au_sync();
 			busy = 1;
-		}
 
-		if ((stat & PSC_SPISTAT_TF) == 0 && hw->tx_count < hw->len) {
-			hw->tx_word(hw);
-			/* ack the transmit request event */
-			hw->regs->psc_spievent = PSC_SPIEVNT_TR;
-			au_sync();
-			busy = 1;
+			if (!(stat & PSC_SPISTAT_TF) && hw->tx_count < hw->len)
+				hw->tx_word(hw);
 		}
 	} while (busy);
 
-	evnt = hw->regs->psc_spievent;
+	hw->regs->psc_spievent = PSC_SPIEVNT_RR | PSC_SPIEVNT_TR;
 	au_sync();
 
-	if (hw->rx_count >= hw->len || (evnt & PSC_SPIEVNT_MD) != 0) {
+	/*
+	 * Restart the SPI transmission in case of a transmit underflow.
+	 * This seems to work despite the notes in the Au1550 data book
+	 * of Figure 8-4 with flowchart for SPI master operation:
+	 *
+	 * """Note 1: An XFR Error Interrupt occurs, unless masked,
+	 * for any of the following events: Tx FIFO Underflow,
+	 * Rx FIFO Overflow, or Multiple-master Error
+	 *    Note 2: In case of a Tx Underflow Error, all zeroes are
+	 * transmitted."""
+	 *
+	 * By simply restarting the spi transfer on Tx Underflow Error,
+	 * we assume that spi transfer was paused instead of zeroes
+	 * transmittion mentioned in the Note 2 of Au1550 data book.
+	 */
+	if (evnt & PSC_SPIEVNT_TU) {
+		hw->regs->psc_spievent = PSC_SPIEVNT_TU | PSC_SPIEVNT_MD;
+		au_sync();
+		hw->regs->psc_spipcr = PSC_SPIPCR_MS;
+		au_sync();
+	}
+
+	if (hw->rx_count >= hw->len) {
 		/* transfer completed successfully */
 		au1550_spi_mask_ack_all(hw);
 		complete(&hw->master_done);
@@ -725,6 +752,8 @@ static void __init au1550_spi_setup_psc_as_spi(struct au1550_spi *hw)
 		stat = hw->regs->psc_spistat;
 		au_sync();
 	} while ((stat & PSC_SPISTAT_DR) == 0);
+
+	au1550_spi_reset_fifos(hw);
 }
 
 


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
