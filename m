From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: [Fwd: [patch 2.6.26 and earlier] pxa2xx_spi:
 bugfix full duplex dma data corruption]
Date: Tue, 23 Dec 2008 13:58:43 -0500
Message-ID: <495134E3.3010004@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

David,

Did you ever push this patch?  I don't recall seeing any confirmation
that it was being processed by the stable maintainers.  I do see that
the alternate version is showing up in the 2.6.27stable and 2.6.28 git
trees, but nothing for this version is in 2.6.26 or prior.

I see that the last changes to 2.6.25 and 2.6.26 stable are 6 weeks old,
so maybe they are not being updated anymore.

-------- Original Message --------
Subject: [patch 2.6.26 and earlier] pxa2xx_spi: bugfix full duplex dma
data corruption
Date: Thu, 20 Nov 2008 17:56:38 -0500
From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Organization: Woods Hole Oceanographic Institution
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
CC: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,  Vernon Sauder
<vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "J. Scott Merritt" <merrij3-IL7dBOYR4Vg@public.gmane.org>,  Stephen
Street <stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org>

From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>

Fixes a data corruption bug in pxa2xx_spi.c when operating in full
duplex mode with DMA and using buffers that overlap.

SPI transmit and receive buffers are allowed to be the same or to
overlap.  However, this driver fails if such overlap is attempted in
DMA mode because it maps the rx and tx buffers in the wrong order.  By
mapping DMA_FROM_DEVICE (read) before DMA_TO_DEVICE (write), it
invalidates the cache before flushing it, thus discarding data which
should have been transmitted.

The patch corrects the order of mapping.  This bug exists in all
versions of pxa2xx_spi.c; similar bugs are in the drivers for two
other SPI controllers (au1500, imx).

This patch has been tested on kernel 2.6.20 using verification of
loopback data with: random transfer length, random bits-per-word,
random positive offsets (both larger and smaller than transfer length)
between the start of the rx and tx buffers, and varying clock rates.

This patch applies to all kernels from 2.6.17 t 2.6.26.

Signed-off-by: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Cc: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: J. Scott Merritt <merrij3-IL7dBOYR4Vg@public.gmane.org>
Cc: Stephen Street <stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org>

---

 drivers/spi/pxa2xx_spi.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff -Nurp linux-2.6.20/drivers/spi/pxa2xx_spi.c
linux-2.6.20_dma_overlap_patch/drivers/spi/pxa2xx_spi.c
--- linux-2.6.20/drivers/spi/pxa2xx_spi.c	2007-02-04 18:44:54.000000000
+0000
+++ linux-2.6.20_dma_overlap_patch/drivers/spi/pxa2xx_spi.c	2008-11-17
18:21:57.000000000 +0000
@@ -334,21 +334,21 @@ static int map_dma_buffers(struct driver
 	} else
 		drv_data->tx_map_len = drv_data->len;

-	/* Stream map the rx buffer */
-	drv_data->rx_dma = dma_map_single(dev, drv_data->rx,
-						drv_data->rx_map_len,
-						DMA_FROM_DEVICE);
-	if (dma_mapping_error(drv_data->rx_dma))
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
+	if (dma_mapping_error(drv_data->tx_dma))
+		return 0;

-	if (dma_mapping_error(drv_data->tx_dma)) {
-		dma_unmap_single(dev, drv_data->rx_dma,
+	/* Stream map the rx buffer */
+	drv_data->rx_dma = dma_map_single(dev, drv_data->rx,
 					drv_data->rx_map_len, DMA_FROM_DEVICE);
+	if (dma_mapping_error(drv_data->rx_dma)) {
+		dma_unmap_single(dev, drv_data->tx_dma,
+					drv_data->tx_map_len, DMA_TO_DEVICE);
 		return 0;
 	}

-- 


-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


------------------------------------------------------------------------------
