From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.22-rc4] atmel_spi, minor updates
Date: Thu, 7 Jun 2007 13:54:46 -0700
Message-ID: <200706071354.46447.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Minor updates to atmel_spi:

 - DMA:
    * Comments to explain the DMA policies
    * Report any mapping errors from spi_transfer()
    * Remove extra loop for DMA mapping

 - Diagnostics:  report minimum clock rate, if we need to reject a
   spi_setup() request because that rate is too low.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/atmel_spi.c |   57 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 12 deletions(-)

--- g26.orig/drivers/spi/atmel_spi.c	2007-06-07 13:47:13.000000000 -0700
+++ g26/drivers/spi/atmel_spi.c	2007-06-07 13:47:18.000000000 -0700
@@ -184,18 +184,39 @@ static void atmel_spi_next_message(struc
 	atmel_spi_next_xfer(master, msg);
 }
 
-static void
+/*
+ * For DMA, tx_buf/tx_dma have the same relationship as rx_buf/rx_dma:
+ *  - The buffer is either valid for CPU access, else NULL
+ *  - If the buffer is valid, so is its DMA addresss
+ *
+ * This driver manages the dma addresss unless message->is_dma_mapped.
+ */
+static int
 atmel_spi_dma_map_xfer(struct atmel_spi *as, struct spi_transfer *xfer)
 {
+	struct device	*dev = &as->pdev->dev;
+
 	xfer->tx_dma = xfer->rx_dma = INVALID_DMA_ADDRESS;
-	if (xfer->tx_buf)
-		xfer->tx_dma = dma_map_single(&as->pdev->dev,
+	if (xfer->tx_buf) {
+		xfer->tx_dma = dma_map_single(dev,
 				(void *) xfer->tx_buf, xfer->len,
 				DMA_TO_DEVICE);
-	if (xfer->rx_buf)
-		xfer->rx_dma = dma_map_single(&as->pdev->dev,
+		if (dma_mapping_error(xfer->tx_dma))
+			return -ENOMEM;
+	}
+	if (xfer->rx_buf) {
+		xfer->rx_dma = dma_map_single(dev,
 				xfer->rx_buf, xfer->len,
 				DMA_FROM_DEVICE);
+		if (dma_mapping_error(xfer->tx_dma)) {
+			if (xfer->tx_buf)
+				dma_unmap_single(dev,
+						xfer->tx_dma, xfer->len,
+						DMA_TO_DEVICE);
+			return -ENOMEM;
+		}
+	}
+	return 0;
 }
 
 static void atmel_spi_dma_unmap_xfer(struct spi_master *master,
@@ -398,8 +419,9 @@ static int atmel_spi_setup(struct spi_de
 		scbr = ((bus_hz + spi->max_speed_hz - 1)
 			/ spi->max_speed_hz);
 		if (scbr >= (1 << SPI_SCBR_SIZE)) {
-			dev_dbg(&spi->dev, "setup: %d Hz too slow, scbr %u\n",
-					spi->max_speed_hz, scbr);
+			dev_dbg(&spi->dev,
+				"setup: %d Hz too slow, scbr %u; min %ld Hz\n",
+				spi->max_speed_hz, scbr, bus_hz/255);
 			return -EINVAL;
 		}
 	} else
@@ -465,12 +487,19 @@ static int atmel_spi_transfer(struct spi
 			dev_dbg(&spi->dev, "no protocol options yet\n");
 			return -ENOPROTOOPT;
 		}
-	}
 
-	/* scrub dcache "early" */
-	if (!msg->is_dma_mapped) {
-		list_for_each_entry(xfer, &msg->transfers, transfer_list)
-			atmel_spi_dma_map_xfer(as, xfer);
+		/*
+		 * DMA map early, for performance (empties dcache ASAP) and
+		 * better fault reporting.  This is a DMA-only driver.
+		 *
+		 * NOTE that if dma_unmap_single() ever starts to do work on
+		 * platforms supported by this driver, we would need to clean
+		 * up mappings for previously-mapped transfers.
+		 */
+		if (!msg->is_dma_mapped) {
+			if (atmel_spi_dma_map_xfer(as, xfer) < 0)
+				return -ENOMEM;
+		}
 	}
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
@@ -537,6 +566,10 @@ static int __init atmel_spi_probe(struct
 
 	as = spi_master_get_devdata(master);
 
+	/*
+	 * Scratch buffer is used for throwaway rx and tx data.
+	 * It's coherent to minimize dcache pollution.
+	 */
 	as->buffer = dma_alloc_coherent(&pdev->dev, BUFFER_SIZE,
 					&as->buffer_dma, GFP_KERNEL);
 	if (!as->buffer)

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
