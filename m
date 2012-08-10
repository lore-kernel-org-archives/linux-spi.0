From: Deepak Sikri <deepak.sikri-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH] spi/pl022: Fix the dma map/unmap calls sequencing
Date: Fri, 10 Aug 2012 13:37:59 +0530
Message-ID: <1344586079-5238-1-git-send-email-deepak.sikri@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org,
	Deepak Sikri <deepak.sikri-qxv4g6HH51o@public.gmane.org>
To: <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
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

The current driver implementation for the DMA tranfers first invalidates
the cache for Rx buffers and then cleans the cache for Tx buffers before
starting the DMA transfers.

The SPIDEV framework assigns a single buffer for both reception and
transmission of data.So the above sequence of invalidating the cache and
then cleaning it does not work well when the same buffer is used for Rx
& Tx.

This patch alters the sequence, i.e first flushes the cache and then
invalidate them to ensure data integrity.

Signed-off-by: Deepak Sikri <deepak.sikri-qxv4g6HH51o@public.gmane.org>
---
 drivers/spi/spi-pl022.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 1e33b83..2c231b7 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -755,10 +755,10 @@ static void *next_transfer(struct pl022 *pl022)
 static void unmap_free_dma_scatter(struct pl022 *pl022)
 {
 	/* Unmap and free the SG tables */
-	dma_unmap_sg(pl022->dma_tx_channel->device->dev, pl022->sgt_tx.sgl,
-		     pl022->sgt_tx.nents, DMA_TO_DEVICE);
 	dma_unmap_sg(pl022->dma_rx_channel->device->dev, pl022->sgt_rx.sgl,
 		     pl022->sgt_rx.nents, DMA_FROM_DEVICE);
+	dma_unmap_sg(pl022->dma_tx_channel->device->dev, pl022->sgt_tx.sgl,
+		     pl022->sgt_tx.nents, DMA_TO_DEVICE);
 	sg_free_table(&pl022->sgt_rx);
 	sg_free_table(&pl022->sgt_tx);
 }
@@ -1009,16 +1009,16 @@ static int configure_dma(struct pl022 *pl022)
 			  pl022->cur_transfer->len, &pl022->sgt_tx);
 
 	/* Map DMA buffers */
-	rx_sglen = dma_map_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
-			   pl022->sgt_rx.nents, DMA_FROM_DEVICE);
-	if (!rx_sglen)
-		goto err_rx_sgmap;
-
 	tx_sglen = dma_map_sg(txchan->device->dev, pl022->sgt_tx.sgl,
 			   pl022->sgt_tx.nents, DMA_TO_DEVICE);
 	if (!tx_sglen)
 		goto err_tx_sgmap;
 
+	rx_sglen = dma_map_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
+			   pl022->sgt_rx.nents, DMA_FROM_DEVICE);
+	if (!rx_sglen)
+		goto err_rx_sgmap;
+
 	/* Send both scatterlists */
 	rxdesc = dmaengine_prep_slave_sg(rxchan,
 				      pl022->sgt_rx.sgl,
@@ -1053,12 +1053,12 @@ err_txdesc:
 	dmaengine_terminate_all(txchan);
 err_rxdesc:
 	dmaengine_terminate_all(rxchan);
-	dma_unmap_sg(txchan->device->dev, pl022->sgt_tx.sgl,
+	dma_unmap_sg(txchan->device->dev, pl022->sgt_rx.sgl,
+		     pl022->sgt_rx.nents, DMA_FROM_DEVICE);
+err_rx_sgmap:
+	dma_unmap_sg(rxchan->device->dev, pl022->sgt_tx.sgl,
 		     pl022->sgt_tx.nents, DMA_TO_DEVICE);
 err_tx_sgmap:
-	dma_unmap_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
-		     pl022->sgt_tx.nents, DMA_FROM_DEVICE);
-err_rx_sgmap:
 	sg_free_table(&pl022->sgt_tx);
 err_alloc_tx_sg:
 	sg_free_table(&pl022->sgt_rx);
-- 
1.7.2.2


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
