From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.27-rc6] pxa2xx_spi: dma bugfixes
Date: Wed, 10 Sep 2008 17:42:05 -0700
Message-ID: <200809101742.05535.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
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

From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>

Fixes two DMA bugs in the pxa2xx_spi driver.  The first bug is
in all versions of this driver; the second was introduced in
the 2.6.20 kernel, and prevents using the driver with chips
like m25p16 flash (which can issue large DMA reads).

 1. Zero length transfers are permitted for use to insert timing,
    but pxa2xx_spi.c will fail if this is requested in DMA mode.
    Fixed by using programmed I/O (PIO) mode for such transfers.

 2. Transfers larger than 8191 are not permitted in DMA mode.  A
    test for length rejects all large transfers regardless of DMA
    or PIO mode.  Worked around by rejecting only large transfers
    with DMA mapped buffers, and forcing all other transfers
    larger than 8191 to use PIO mode.  A rate limited warning is
    issued for DMA transfers forced to PIO mode.

This patch should apply to all kernels back to and including 2.6.20;
it was test patched against 2.6.20.  An additional patch would be
required for older kernels, but those versions are very buggy anyway.

Signed-off-by: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Cc: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/pxa2xx_spi.c |   57 +++++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 14 deletions(-)

--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -47,9 +47,10 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 
 #define MAX_BUSES 3
 
-#define DMA_INT_MASK (DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR)
-#define RESET_DMA_CHANNEL (DCSR_NODESC | DMA_INT_MASK)
-#define IS_DMA_ALIGNED(x) (((u32)(x)&0x07)==0)
+#define DMA_INT_MASK		(DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR)
+#define RESET_DMA_CHANNEL	(DCSR_NODESC | DMA_INT_MASK)
+#define IS_DMA_ALIGNED(x)	(((x) & 0x07) == 0)
+#define MAX_DMA_LEN		8191
 
 /*
  * for testing SSCR1 changes that require SSP restart, basically
@@ -887,14 +888,27 @@ static void pump_transfers(unsigned long
 			drv_data->cs_control(PXA2XX_CS_DEASSERT);
 	}
 
-	/* Check transfer length */
-	if (transfer->len > 8191)
-	{
-		dev_warn(&drv_data->pdev->dev, "pump_transfers: transfer "
-				"length greater than 8191\n");
-		message->status = -EINVAL;
-		giveback(drv_data);
-		return;
+	/* Check for transfers that need multiple DMA segments */
+	if (transfer->len > MAX_DMA_LEN && chip->enable_dma) {
+
+		/* reject already-mapped transfers; PIO won't always work */
+		if (message->is_dma_mapped
+				|| transfer->rx_dma || transfer->tx_dma) {
+			dev_err(&drv_data->pdev->dev,
+				"pump_transfers: mapped transfer length "
+				"of %lu is greater than %d\n",
+				transfer->len, MAX_DMA_LEN);
+			message->status = -EINVAL;
+			giveback(drv_data);
+			return;
+		}
+
+		/* warn ... we force this to PIO mode */
+		if (printk_ratelimit())
+			dev_warn(&message->spi->dev, "pump_transfers: "
+				"DMA disabled for transfer length %ld "
+				"greater than %d\n",
+				(long)drv_data->len, MAX_DMA_LEN);
 	}
 
 	/* Setup the transfer state based on the type of transfer */
@@ -962,7 +976,7 @@ static void pump_transfers(unsigned long
 							&dma_thresh))
 				if (printk_ratelimit())
 					dev_warn(&message->spi->dev,
-						"pump_transfer: "
+						"pump_transfers: "
 						"DMA burst size reduced to "
 						"match bits_per_word\n");
 		}
@@ -976,8 +990,23 @@ static void pump_transfers(unsigned long
 
 	message->state = RUNNING_STATE;
 
-	/* Try to map dma buffer and do a dma transfer if successful */
-	if ((drv_data->dma_mapped = map_dma_buffers(drv_data))) {
+	/* Try to map dma buffer and do a dma transfer if successful, but
+	 * only if the length is non-zero and less than MAX_DMA_LEN.
+	 *
+	 * Zero-length non-descriptor DMA is illegal on PXA2xx; force use
+	 * of PIO instead.  Care is needed above because the transfer may
+	 * have have been passed with buffers that are already dma mapped.
+	 * A zero-length transfer in PIO mode will not try to write/read
+	 * to/from the buffers
+	 *
+	 * REVISIT large transfers are exactly where we most want to be
+	 * using DMA.  If this happens much, split those transfers into
+	 * multiple DMA segments rather than forcing PIO.
+	 */
+	drv_data->dma_mapped = 0;
+	if (drv_data->len > 0 && drv_data->len <= MAX_DMA_LEN)
+		drv_data->dma_mapped = map_dma_buffers(drv_data);
+	if (drv_data->dma_mapped) {
 
 		/* Ensure we have the correct interrupt handler */
 		drv_data->transfer_handler = dma_transfer;

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
