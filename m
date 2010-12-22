From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 1/4] spi/pl022: map the buffers on the DMA engine
Date: Wed, 22 Dec 2010 23:13:07 +0100
Message-ID: <1293055987-12656-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

The struct device for the DMA engine is the apropriate one to use
when mapping/unmapping buffers. This is because the memory which
is addressable by DMA is determined by the DMA engine rather than
the device.

Reported-by: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/spi/amba-pl022.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index fb3d1b3..9a14c45 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -782,9 +782,9 @@ static void *next_transfer(struct pl022 *pl022)
 static void unmap_free_dma_scatter(struct pl022 *pl022)
 {
 	/* Unmap and free the SG tables */
-	dma_unmap_sg(&pl022->adev->dev, pl022->sgt_tx.sgl,
+	dma_unmap_sg(pl022->dma_tx_channel->device->dev, pl022->sgt_tx.sgl,
 		     pl022->sgt_tx.nents, DMA_TO_DEVICE);
-	dma_unmap_sg(&pl022->adev->dev, pl022->sgt_rx.sgl,
+	dma_unmap_sg(pl022->dma_rx_channel->device->dev, pl022->sgt_rx.sgl,
 		     pl022->sgt_rx.nents, DMA_FROM_DEVICE);
 	sg_free_table(&pl022->sgt_rx);
 	sg_free_table(&pl022->sgt_tx);
@@ -991,12 +991,12 @@ static int configure_dma(struct pl022 *pl022)
 			  pl022->cur_transfer->len, &pl022->sgt_tx);
 
 	/* Map DMA buffers */
-	sglen = dma_map_sg(&pl022->adev->dev, pl022->sgt_rx.sgl,
+	sglen = dma_map_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
 			   pl022->sgt_rx.nents, DMA_FROM_DEVICE);
 	if (!sglen)
 		goto err_rx_sgmap;
 
-	sglen = dma_map_sg(&pl022->adev->dev, pl022->sgt_tx.sgl,
+	sglen = dma_map_sg(txchan->device->dev, pl022->sgt_tx.sgl,
 			   pl022->sgt_tx.nents, DMA_TO_DEVICE);
 	if (!sglen)
 		goto err_tx_sgmap;
@@ -1040,10 +1040,10 @@ err_txdesc:
 	txchan->device->device_control(txchan, DMA_TERMINATE_ALL, 0);
 err_rxdesc:
 	rxchan->device->device_control(rxchan, DMA_TERMINATE_ALL, 0);
-	dma_unmap_sg(&pl022->adev->dev, pl022->sgt_tx.sgl,
+	dma_unmap_sg(txchan->device->dev, pl022->sgt_tx.sgl,
 		     pl022->sgt_tx.nents, DMA_TO_DEVICE);
 err_tx_sgmap:
-	dma_unmap_sg(&pl022->adev->dev, pl022->sgt_rx.sgl,
+	dma_unmap_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
 		     pl022->sgt_tx.nents, DMA_FROM_DEVICE);
 err_rx_sgmap:
 	sg_free_table(&pl022->sgt_tx);
-- 
1.7.3.3


------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
