From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.28-rc4] pxa2xx_spi: bugfix full
	duplex dma data corruption
Date: Sat, 15 Nov 2008 14:05:39 -0800
Message-ID: <200811151405.39327.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"J. Scott Merritt" <merrij3-IL7dBOYR4Vg@public.gmane.org>
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

From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>

Fixes a data corruption bug in pxa2xx_spi.c when operating in full
duplex mode with DMA and using buffers that overlap.

SPI transmit and receive buffers are allowed to be the same or to
overlap.  However, this driver fails if such overlap is attempted
in DMA mode because it maps the rx and tx buffers in the wrong order.
By mapping DMA_FROM_DEVICE (read) before DMA_TO_DEVICE (write), it
invalidates the cache before flushing it, thus discarding data which
should have been transmitted.

The patch corrects the order of mapping.  This bug exists in all
versions of pxa2xx_spi.c; similar bugs are in the drivers for two
other SPI controllers (au1500, imx).

A version of this patch has been tested on kernel 2.6.20 using 
verification of loopback data with: random transfer length, random 
bits-per-word, random positive offsets (both larger and smaller than 
transfer length) between the start of the rx and tx buffers, and 
varying clock rates.

Signed-off-by: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Cc: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: J. Scott Merritt <merrij3-IL7dBOYR4Vg@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
This patch applies to kernels 2.6.27 and 2.6.28; it should be
applied to both.  A separate patch will be required for older
kernels.

 drivers/spi/pxa2xx_spi.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -352,21 +352,21 @@ static int map_dma_buffers(struct driver
 	} else
 		drv_data->tx_map_len = drv_data->len;
 
-	/* Stream map the rx buffer */
-	drv_data->rx_dma = dma_map_single(dev, drv_data->rx,
-						drv_data->rx_map_len,
-						DMA_FROM_DEVICE);
-	if (dma_mapping_error(dev, drv_data->rx_dma))
-		return 0;
-
-	/* Stream map the tx buffer */
+	/* Stream map the tx buffer. Always do DMA_TO_DEVICE first
+	 * so we flush the cache *before* invalidating it, in case
+	 * the tx and rx buffers overlap.
+	 */
 	drv_data->tx_dma = dma_map_single(dev, drv_data->tx,
-						drv_data->tx_map_len,
-						DMA_TO_DEVICE);
+					drv_data->tx_map_len, DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, drv_data->tx_dma))
+		return 0;
 
-	if (dma_mapping_error(dev, drv_data->tx_dma)) {
-		dma_unmap_single(dev, drv_data->rx_dma,
+	/* Stream map the rx buffer */
+	drv_data->rx_dma = dma_map_single(dev, drv_data->rx,
 					drv_data->rx_map_len, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev, drv_data->rx_dma)) {
+		dma_unmap_single(dev, drv_data->tx_dma,
+					drv_data->tx_map_len, DMA_TO_DEVICE);
 		return 0;
 	}
 

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
