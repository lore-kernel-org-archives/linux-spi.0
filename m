From: "Silvester Erdeg" <slipszi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] atmel_spi: Allow chained transfers
Date: Thu, 8 Nov 2007 00:25:41 +0100
Message-ID: <ac67d9130711071525q16c861b8yd03dd212828d5a13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

This patch adds support for chained transfers in the atmel_spi driver.
Almost all of the logic can be found in the reworked
atmel_spi_next_xfer() function. When it is called, the driver is in
one of the following three states:

1. It isn't transferring anything (in which case the first transfer of
the current message is going to be sent)
2. It has finished transfering a non-chainable transfer (in which case
it will go to the next transfer in the message)
3. It has finished transfering a chained transfer (in which case the
next transfer is already queued)

After that it will queue the next transfer if it can be chained.

The patch is made against 2.6.24-rc2.

Signed-off-by: Szilveszter Ordog <slipszi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--- linux-2.6.24-rc2.orig/drivers/spi/atmel_spi.c	2007-11-01
01:34:18.000000000 +0100
+++ linux-2.6.24-rc2/drivers/spi/atmel_spi.c	2007-11-07 18:12:48.000000000 +0100
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
@@ -121,6 +123,45 @@ static void cs_deactivate(struct atmel_s
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
+				u32 *len)
+{
+	struct atmel_spi	*as = spi_master_get_devdata(master);
+
+	/* use scratch buffer only when rx or tx data is unspecified */
+	if (xfer->rx_buf)
+		*rx_dma = xfer->rx_dma + xfer->len - *len;
+	else {
+		*rx_dma = as->buffer_dma;
+		if (*len > BUFFER_SIZE)
+			*len = BUFFER_SIZE;
+	}
+	if (xfer->tx_buf)
+		*tx_dma = xfer->tx_dma + xfer->len - *len;
+	else {
+		*tx_dma = as->buffer_dma;
+		if (*len > BUFFER_SIZE)
+			*len = BUFFER_SIZE;
+		memset(as->buffer, 0, *len);
+		dma_sync_single_for_device(&as->pdev->dev,
+				as->buffer_dma, *len, DMA_TO_DEVICE);
+	}
+}
+
 /*
  * Submit next transfer for DMA.
  * lock is held, spi irq is blocked
@@ -129,54 +170,72 @@ static void atmel_spi_next_xfer(struct s
 				struct spi_message *msg)
 {
 	struct atmel_spi	*as = spi_master_get_devdata(master);
-	struct spi_transfer	*xfer;
-	u32			len;
-	dma_addr_t		tx_dma, rx_dma;
-
-	xfer = as->current_transfer;
-	if (!xfer || as->remaining_bytes == 0) {
-		if (xfer)
-			xfer = list_entry(xfer->transfer_list.next,
-					struct spi_transfer, transfer_list);
-		else
-			xfer = list_entry(msg->transfers.next,
-					struct spi_transfer, transfer_list);
-		as->remaining_bytes = xfer->len;
+	struct spi_transfer	*xfer, *next_xfer;
+	u32			len, next_len;
+	dma_addr_t		tx_dma, rx_dma, next_tx_dma, next_rx_dma;
+
+	if (!as->current_transfer) {
+		xfer = list_entry(msg->transfers.next,
+				struct spi_transfer, transfer_list);
 		as->current_transfer = xfer;
-	}
-
-	len = as->remaining_bytes;
+		as->current_remaining_bytes = xfer->len;
+	} else if (!as->next_transfer) {
+		xfer = list_entry(as->current_transfer->transfer_list.next,
+				struct spi_transfer, transfer_list);
+		as->current_transfer = xfer;
+		as->current_remaining_bytes = xfer->len;
+	} else {
+		xfer = NULL;
+		as->current_transfer = as->next_transfer;
+		as->current_remaining_bytes = as->next_remaining_bytes;
+	}
+
+	if (xfer) {
+		len = as->current_remaining_bytes;
+		atmel_spi_next_xfer_data(master, xfer, &tx_dma, &rx_dma, &len);
+		as->current_remaining_bytes -= len;
+
+		spi_writel(as, RPR, rx_dma);
+		spi_writel(as, TPR, tx_dma);
+
+		if (msg->spi->bits_per_word > 8)
+			len >>= 1;
+		spi_writel(as, TCR, len);
+		spi_writel(as, RCR, len);
+	}
+
+	if (as->current_remaining_bytes > 0) {
+		next_xfer = as->current_transfer;
+		next_len = as->current_remaining_bytes;
+	} else if (!atmel_spi_xfer_is_last(msg, as->current_transfer) &&
+		atmel_spi_xfer_can_be_chained(as->current_transfer)) {
+		next_xfer = list_entry(as->current_transfer->transfer_list.next,
+					struct spi_transfer, transfer_list);
+		next_len = next_xfer->len;
+	} else
+		next_xfer = NULL;

-	tx_dma = xfer->tx_dma + xfer->len - len;
-	rx_dma = xfer->rx_dma + xfer->len - len;
+	as->next_transfer = next_xfer;

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
+	if (next_xfer) {
+		as->next_remaining_bytes = next_len;
+		atmel_spi_next_xfer_data(master, next_xfer, &next_tx_dma,
+					&next_rx_dma, &next_len);
+		as->next_remaining_bytes -= next_len;
+
+		spi_writel(as, RNPR, next_rx_dma);
+		spi_writel(as, TNPR, next_tx_dma);
+
+		if (msg->spi->bits_per_word > 8)
+			next_len >>= 1;
+		spi_writel(as, TNCR, next_len);
+		spi_writel(as, RNCR, next_len);
+	} else {
+		spi_writel(as, TNCR, 0);
+		spi_writel(as, RNCR, 0);
 	}

-	spi_writel(as, RPR, rx_dma);
-	spi_writel(as, TPR, tx_dma);
-
-	as->remaining_bytes -= len;
-	if (msg->spi->bits_per_word > 8)
-		len >>= 1;
-
-	/* REVISIT: when xfer->delay_usecs == 0, the PDC "next transfer"
-	 * mechanism might help avoid the IRQ latency between transfers
-	 * (and improve the nCS0 errata handling on at91rm9200 chips)
-	 *
-	 * We're also waiting for ENDRX before we start the next
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

-	spi_writel(as, TCR, len);
-	spi_writel(as, RCR, len);
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
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
