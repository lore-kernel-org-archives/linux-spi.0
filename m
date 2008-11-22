From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.28-rc6] spi: au1550_spi full duplex
	dma fix
Date: Sat, 22 Nov 2008 11:55:37 -0800
Message-ID: <200811221155.37889.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Fix unsafe order in dma mapping operation: always flush data from
the cache *BEFORE* invalidating it, to allow full duplex transfers
where the same buffer may be used for both writes and reads.
Tested with mmc-spi.

Signed-off-by: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
This looks like the last of these particular DMA fixes.
(For 2.6.28-final please.)

 drivers/spi/au1550_spi.c |   26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

--- a/drivers/spi/au1550_spi.c
+++ b/drivers/spi/au1550_spi.c
@@ -369,10 +369,23 @@ static int au1550_spi_dma_txrxb(struct s
 	dma_rx_addr = t->rx_dma;
 
 	/*
-	 * check if buffers are already dma mapped, map them otherwise
+	 * check if buffers are already dma mapped, map them otherwise:
+	 * - first map the TX buffer, so cache data gets written to memory
+	 * - then map the RX buffer, so that cache entries (with
+	 *   soon-to-be-stale data) get removed
 	 * use rx buffer in place of tx if tx buffer was not provided
 	 * use temp rx buffer (preallocated or realloc to fit) for rx dma
 	 */
+	if (t->tx_buf) {
+		if (t->tx_dma == 0) {	/* if DMA_ADDR_INVALID, map it */
+			dma_tx_addr = dma_map_single(hw->dev,
+					(void *)t->tx_buf,
+					t->len, DMA_TO_DEVICE);
+			if (dma_mapping_error(hw->dev, dma_tx_addr))
+				dev_err(hw->dev, "tx dma map error\n");
+		}
+	}
+
 	if (t->rx_buf) {
 		if (t->rx_dma == 0) {	/* if DMA_ADDR_INVALID, map it */
 			dma_rx_addr = dma_map_single(hw->dev,
@@ -396,15 +409,8 @@ static int au1550_spi_dma_txrxb(struct s
 		dma_sync_single_for_device(hw->dev, dma_rx_addr,
 			t->len, DMA_FROM_DEVICE);
 	}
-	if (t->tx_buf) {
-		if (t->tx_dma == 0) {	/* if DMA_ADDR_INVALID, map it */
-			dma_tx_addr = dma_map_single(hw->dev,
-					(void *)t->tx_buf,
-					t->len, DMA_TO_DEVICE);
-			if (dma_mapping_error(hw->dev, dma_tx_addr))
-				dev_err(hw->dev, "tx dma map error\n");
-		}
-	} else {
+
+	if (!t->tx_buf) {
 		dma_sync_single_for_device(hw->dev, dma_rx_addr,
 				t->len, DMA_BIDIRECTIONAL);
 		hw->tx = hw->rx;

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
