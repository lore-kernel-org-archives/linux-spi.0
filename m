From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: [patch 2.6.28-rc4] spi: pxa2xx_spi.c fix DMA
	mapping sequence
Date: Sat, 15 Nov 2008 16:16:10 -0500
Message-ID: <491F3C1A.1030402@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"J. Scott Merritt" <merrij3-IL7dBOYR4Vg@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Fixes a bug in pxa2xx_spi.c when operating in direct memory access
(DMA) mode.  The transmit and receive buffers are allowed to be the
same or to overlap, but pxa2xx_spi.c fails if this is attempted in DMA
mode because it performs mapping of the rx and tx buffers in the wrong
order. By mapping DMA_FROM_DEVICE before DMA_TO_DEVICE, it invalidates
the cache before flushing it.  The patch corrects the order of
mapping.  This bug exists in all versions of pxa2xx_spi.c

A version of this patch has been tested on kernel 2.6.20 using 
verification of loopback data with: random transfer length, random 
bits-per-word, random positive offsets (both larger and smaller than 
transfer length) between the start of the rx and tx buffers, and 
varying clock rates.

This patch applies to kernels 2.6.27 and 2.6.28.
A separate patch is required for 2.6.20 through 2.6.26.

Signed-off-by: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Cc: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: J. Scott Merritt <merrij3-IL7dBOYR4Vg@public.gmane.org>

---

 drivers/spi/pxa2xx_spi.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff -Nurp linux-2.6.28-rc4/drivers/spi/pxa2xx_spi.c linux-2.6.28-rc4_dma_overlap_patch/drivers/spi/pxa2xx_spi.c
--- linux-2.6.28-rc4/drivers/spi/pxa2xx_spi.c	2008-11-13 13:59:03.000000000 +0000
+++ linux-2.6.28-rc4_dma_overlap_patch/drivers/spi/pxa2xx_spi.c	2008-11-15 17:25:36.000000000 +0000
@@ -352,21 +352,20 @@ static int map_dma_buffers(struct driver
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
+	/* Stream map the tx buffer. Always do DMA_TO_DEVICE first,
+	 * because we want to flush the cache before invalidating it,
+	 * in case the tx and rx buffers overlap */
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
 
-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
