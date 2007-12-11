From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.24-rc5 1/2] atmel_spi: chain dma
	transfers
Date: Tue, 11 Dec 2007 09:47:09 -0800
Message-ID: <20071211174709.F147E113F58@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

From: "Silvester Erdeg" <slipszi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This patch adds support for chained transfers in the atmel_spi driver.
Almost all of the changes are in the reworked atmel_spi_next_xfer()
function.  That's called with the driver in one of these three states:

 1. It isn't transferring anything (in which case the first transfer of
    the current message is going to be sent)
 2. It has finished transfering a non-chainable transfer (in which case
    it will go to the next transfer in the message)
 3. It has finished transfering a chained transfer (in which case the
    next transfer is already queued)

After that it will queue the next transfer if it can be chained.

Signed-off-by: Szilveszter Ordog <slipszi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
The patch is against 2.6.24-rc5 (with the RCR fix).
Replaces atmel_spi-chain-dma-transfers.patch in current MM.

 drivers/spi/atmel_spi.c |  146 +++++++++++++++++++++++++++++++++---------------
 1 files changed, 101 insertions(+), 45 deletions(-)

--- a/drivers/spi/atmel_spi.c	2007-12-11 09:15:52.000000000 -0800
+++ b/drivers/spi/atmel_spi.c	2007-12-11 09:19:18.000000000 -0800
@@ -51,7 +51,9 @@ struct atmel_spi {
 	u8			stopping;
 	struct list_head	queue;
 	struct spi_transfer	*current_transfer;
-	unsigned long		remaining_bytes;
+	unsigned long		current_remaining_bytes;
+	struct spi_transfer	*next_transfer;
+	unsigned long		next_remaining_bytes;
 
 	void			*buffer;
 	dma_addr_t		buffer_dma;
@@ -121,6 +123,48 @@ static void cs_deactivate(struct atmel_s
 		gpio_set_value(gpio, !active);
 }
 
+static inline int atmel_spi_xfer_is_last(struct spi_message *msg,
+					struct spi_transfer *xfer)
+{
+	return msg->transfers.prev == &xfer->transfer_list;
+}
+
+static inline int atmel_spi_xfer_can_be_chained(struct spi_transfer *xfer)
+{
+	return xfer->delay_usecs == 0 && !xfer->cs_change;
+}
+
+static void atmel_spi_next_xfer_data(struct spi_master *master,
+				struct spi_transfer *xfer,
+				dma_addr_t *tx_dma,
+				dma_addr_t *rx_dma,
+				u32 *plen)
+{
+	struct atmel_spi	*as = spi_master_get_devdata(master);
+	u32			len = *plen;
+
+	/* use scratch buffer only when rx or tx data is unspecified */
+	if (xfer->rx_buf)
+		*rx_dma = xfer->rx_dma + xfer->len - len;
+	else {
+		*rx_dma = as->buffer_dma;
+		if (len > BUFFER_SIZE)
+			len = BUFFER_SIZE;
+	}
+	if (xfer->tx_buf)
+		*tx_dma = xfer->tx_dma + xfer->len - len;
+	else {
+		*tx_dma = as->buffer_dma;
+		if (len > BUFFER_SIZE)
+			len = BUFFER_SIZE;
+		memset(as->buffer, 0, len);
+		dma_sync_single_for_device(&as->pdev->dev,
+				as->buffer_dma, len, DMA_TO_DEVICE);
+	}
+
+	*plen = len;
+}
+
 /*
  * Submit next transfer for DMA.
  * lock is held, spi irq is blocked
@@ -130,53 +174,68 @@ static void atmel_spi_next_xfer(struct s
 {
 	struct atmel_spi	*as = spi_master_get_devdata(master);
 	struct spi_transfer	*xfer;
-	u32			len;
+	u32			len, remaining, total;
 	dma_addr_t		tx_dma, rx_dma;
 
-	xfer = as->current_transfer;
-	if (!xfer || as->remaining_bytes == 0) {
-		if (xfer)
-			xfer = list_entry(xfer->transfer_list.next,
-					struct spi_transfer, transfer_list);
-		else
-			xfer = list_entry(msg->transfers.next,
-					struct spi_transfer, transfer_list);
-		as->remaining_bytes = xfer->len;
-		as->current_transfer = xfer;
-	}
+	if (!as->current_transfer)
+		xfer = list_entry(msg->transfers.next,
+				struct spi_transfer, transfer_list);
+	else if (!as->next_transfer)
+		xfer = list_entry(as->current_transfer->transfer_list.next,
+				struct spi_transfer, transfer_list);
+	else
+		xfer = NULL;
 
-	len = as->remaining_bytes;
+	if (xfer) {
+		len = xfer->len;
+		atmel_spi_next_xfer_data(master, xfer, &tx_dma, &rx_dma, &len);
+		remaining = xfer->len - len;
 
-	tx_dma = xfer->tx_dma + xfer->len - len;
-	rx_dma = xfer->rx_dma + xfer->len - len;
+		spi_writel(as, RPR, rx_dma);
+		spi_writel(as, TPR, tx_dma);
 
-	/* use scratch buffer only when rx or tx data is unspecified */
-	if (!xfer->rx_buf) {
-		rx_dma = as->buffer_dma;
-		if (len > BUFFER_SIZE)
-			len = BUFFER_SIZE;
-	}
-	if (!xfer->tx_buf) {
-		tx_dma = as->buffer_dma;
-		if (len > BUFFER_SIZE)
-			len = BUFFER_SIZE;
-		memset(as->buffer, 0, len);
-		dma_sync_single_for_device(&as->pdev->dev,
-				as->buffer_dma, len, DMA_TO_DEVICE);
+		if (msg->spi->bits_per_word > 8)
+			len >>= 1;
+		spi_writel(as, RCR, len);
+		spi_writel(as, TCR, len);
+	} else {
+		xfer = as->next_transfer;
+		remaining = as->next_remaining_bytes;
 	}
 
-	spi_writel(as, RPR, rx_dma);
-	spi_writel(as, TPR, tx_dma);
+	as->current_transfer = xfer;
+	as->current_remaining_bytes = remaining;
 
-	as->remaining_bytes -= len;
-	if (msg->spi->bits_per_word > 8)
-		len >>= 1;
+	if (remaining > 0)
+		len = remaining;
+	else if (!atmel_spi_xfer_is_last(msg, xfer) &&
+		atmel_spi_xfer_can_be_chained(xfer)) {
+		xfer = list_entry(xfer->transfer_list.next,
+				struct spi_transfer, transfer_list);
+		len = xfer->len;
+	} else
+		xfer = NULL;
 
-	/* REVISIT: when xfer->delay_usecs == 0, the PDC "next transfer"
-	 * mechanism might help avoid the IRQ latency between transfers
-	 * (and improve the nCS0 errata handling on at91rm9200 chips)
-	 *
-	 * We're also waiting for ENDRX before we start the next
+	as->next_transfer = xfer;
+
+	if (xfer) {
+		total = len;
+		atmel_spi_next_xfer_data(master, xfer, &tx_dma, &rx_dma, &len);
+		as->next_remaining_bytes = total - len;
+
+		spi_writel(as, RNPR, rx_dma);
+		spi_writel(as, TNPR, tx_dma);
+
+		if (msg->spi->bits_per_word > 8)
+			len >>= 1;
+		spi_writel(as, RNCR, len);
+		spi_writel(as, TNCR, len);
+	} else {
+		spi_writel(as, RNCR, 0);
+		spi_writel(as, TNCR, 0);
+	}
+
+	/* REVISIT: We're waiting for ENDRX before we start the next
 	 * transfer because we need to handle some difficult timing
 	 * issues otherwise. If we wait for ENDTX in one transfer and
 	 * then starts waiting for ENDRX in the next, it's difficult
@@ -186,8 +245,6 @@ static void atmel_spi_next_xfer(struct s
 	 *
 	 * It should be doable, though. Just not now...
 	 */
-	spi_writel(as, TNCR, 0);
-	spi_writel(as, RNCR, 0);
 	spi_writel(as, IER, SPI_BIT(ENDRX) | SPI_BIT(OVRES));
 
 	dev_dbg(&msg->spi->dev,
@@ -195,8 +252,6 @@ static void atmel_spi_next_xfer(struct s
 		xfer, xfer->len, xfer->tx_buf, xfer->tx_dma,
 		xfer->rx_buf, xfer->rx_dma, spi_readl(as, IMR));
 
-	spi_writel(as, RCR, len);
-	spi_writel(as, TCR, len);
 	spi_writel(as, PTCR, SPI_BIT(TXTEN) | SPI_BIT(RXTEN));
 }
 
@@ -294,6 +349,7 @@ atmel_spi_msg_done(struct spi_master *ma
 	spin_lock(&as->lock);
 
 	as->current_transfer = NULL;
+	as->next_transfer = NULL;
 
 	/* continue if needed */
 	if (list_empty(&as->queue) || as->stopping)
@@ -377,7 +433,7 @@ atmel_spi_interrupt(int irq, void *dev_i
 
 		spi_writel(as, IDR, pending);
 
-		if (as->remaining_bytes == 0) {
+		if (as->current_remaining_bytes == 0) {
 			msg->actual_length += xfer->len;
 
 			if (!msg->is_dma_mapped)
@@ -387,7 +443,7 @@ atmel_spi_interrupt(int irq, void *dev_i
 			if (xfer->delay_usecs)
 				udelay(xfer->delay_usecs);
 
-			if (msg->transfers.prev == &xfer->transfer_list) {
+			if (atmel_spi_xfer_is_last(msg, xfer)) {
 				/* report completed message */
 				atmel_spi_msg_done(master, as, msg, 0,
 						xfer->cs_change);

-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
