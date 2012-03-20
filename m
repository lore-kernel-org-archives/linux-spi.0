From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC] spi: spi-davinci: Fix DMA API usage in davinci
Date: Tue, 20 Mar 2012 16:10:09 +0530
Message-ID: <1332240009-2011-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

The driver uses NULL for dma_unmap_single instead of
the struct device that the API expects.

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
I do not have the board ,untested.

 drivers/spi/spi-davinci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 31bfba8..9b2901f 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -653,7 +653,7 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 			dev_dbg(sdev, "Couldn't DMA map a %d bytes RX buffer\n",
 								rx_buf_count);
 			if (t->tx_buf)
-				dma_unmap_single(NULL, t->tx_dma, t->len,
+				dma_unmap_single(&spi->dev, t->tx_dma, t->len,
 								DMA_TO_DEVICE);
 			return -ENOMEM;
 		}
@@ -692,10 +692,10 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	if (spicfg->io_type == SPI_IO_TYPE_DMA) {
 
 		if (t->tx_buf)
-			dma_unmap_single(NULL, t->tx_dma, t->len,
+			dma_unmap_single(&spi->dev, t->tx_dma, t->len,
 								DMA_TO_DEVICE);
 
-		dma_unmap_single(NULL, t->rx_dma, rx_buf_count,
+		dma_unmap_single(&spi->dev, t->rx_dma, rx_buf_count,
 							DMA_FROM_DEVICE);
 
 		clear_io_bits(dspi->base + SPIINT, SPIINT_DMA_REQ_EN);
-- 
1.7.1


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
