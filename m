From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.24-rc5 2/2] atmel_spi: fix dmachain
 oops with debug enabled
Date: Tue, 11 Dec 2007 09:48:15 -0800
Message-ID: <20071211174815.78F91239895@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
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

From: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

In atmel_spi_next_xfer, xfer can be NULL because the next transfer may
already have been submitted to the PDC (using DMA chaning).  This could
cause an oops, since the debug message assumed it was never null.  The
fix changes how those debug messages are issued, ensuring that one is
issued each time a transfer is started.

Also, properly indent the "can this transfer be chained" test so it's
not hidden as if it were non-conditional code.

Signed-off-by: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
Against 2.6.24-rc5 with the RCR reorder patch, and updated dma patch.
Replaces atmel_spi-fix-dmachain-oops-with-debug-enabled.patch

 drivers/spi/atmel_spi.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

--- a/drivers/spi/atmel_spi.c	2007-12-11 09:19:18.000000000 -0800
+++ b/drivers/spi/atmel_spi.c	2007-12-11 09:28:06.000000000 -0800
@@ -198,6 +198,11 @@ static void atmel_spi_next_xfer(struct s
 			len >>= 1;
 		spi_writel(as, RCR, len);
 		spi_writel(as, TCR, len);
+
+		dev_dbg(&msg->spi->dev,
+			"  start xfer %p: len %u tx %p/%08x rx %p/%08x\n",
+			xfer, xfer->len, xfer->tx_buf, xfer->tx_dma,
+			xfer->rx_buf, xfer->rx_dma);
 	} else {
 		xfer = as->next_transfer;
 		remaining = as->next_remaining_bytes;
@@ -208,8 +213,8 @@ static void atmel_spi_next_xfer(struct s
 
 	if (remaining > 0)
 		len = remaining;
-	else if (!atmel_spi_xfer_is_last(msg, xfer) &&
-		atmel_spi_xfer_can_be_chained(xfer)) {
+	else if (!atmel_spi_xfer_is_last(msg, xfer)
+			&& atmel_spi_xfer_can_be_chained(xfer)) {
 		xfer = list_entry(xfer->transfer_list.next,
 				struct spi_transfer, transfer_list);
 		len = xfer->len;
@@ -230,6 +235,11 @@ static void atmel_spi_next_xfer(struct s
 			len >>= 1;
 		spi_writel(as, RNCR, len);
 		spi_writel(as, TNCR, len);
+
+		dev_dbg(&msg->spi->dev,
+			"  next xfer %p: len %u tx %p/%08x rx %p/%08x\n",
+			xfer, xfer->len, xfer->tx_buf, xfer->tx_dma,
+			xfer->rx_buf, xfer->rx_dma);
 	} else {
 		spi_writel(as, RNCR, 0);
 		spi_writel(as, TNCR, 0);
@@ -246,12 +256,6 @@ static void atmel_spi_next_xfer(struct s
 	 * It should be doable, though. Just not now...
 	 */
 	spi_writel(as, IER, SPI_BIT(ENDRX) | SPI_BIT(OVRES));
-
-	dev_dbg(&msg->spi->dev,
-		"  start xfer %p: len %u tx %p/%08x rx %p/%08x imr %03x\n",
-		xfer, xfer->len, xfer->tx_buf, xfer->tx_dma,
-		xfer->rx_buf, xfer->rx_dma, spi_readl(as, IMR));
-
 	spi_writel(as, PTCR, SPI_BIT(TXTEN) | SPI_BIT(RXTEN));
 }
 

-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
