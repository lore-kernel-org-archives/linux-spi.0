From: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Subject: [PATCH] spi: davinci: Use correct length parameter to dma_map_single
	calls
Date: Sun, 13 Mar 2011 10:34:21 -0400
Message-ID: <1300026862-1179-1-git-send-email-michael.williamson@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The davinci spi driver provides an option to use DMA transfers for
data.  In the dma_map_single() call, the driver is passing the
number of words to be transfered for the mapping size.  It should
be the number of bytes.

Signed-off-by: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
---
Note: I only have 8 bit devices to test with, so I can only confirm this
patch does not break such a configuration.

 drivers/spi/davinci_spi.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 166a879..037ba82 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -591,10 +591,10 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 		if (t->tx_buf) {
 			t->tx_dma = dma_map_single(&spi->dev, (void *)t->tx_buf,
-						dspi->wcount, DMA_TO_DEVICE);
+						t->len, DMA_TO_DEVICE);
 			if (dma_mapping_error(&spi->dev, t->tx_dma)) {
 				dev_dbg(sdev, "Unable to DMA map %d bytes"
-						"TX buffer\n", dspi->wcount);
+						"TX buffer\n", t->len);
 				return -ENOMEM;
 			}
 		}
@@ -624,7 +624,7 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 		if (t->rx_buf) {
 			rx_buf = t->rx_buf;
-			rx_buf_count = dspi->rcount;
+			rx_buf_count = t->len;
 		} else {
 			rx_buf = dspi->rx_tmp_buf;
 			rx_buf_count = sizeof(dspi->rx_tmp_buf);
@@ -636,7 +636,7 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 			dev_dbg(sdev, "Couldn't DMA map a %d bytes RX buffer\n",
 								rx_buf_count);
 			if (t->tx_buf)
-				dma_unmap_single(NULL, t->tx_dma, dspi->wcount,
+				dma_unmap_single(NULL, t->tx_dma, t->len,
 								DMA_TO_DEVICE);
 			return -ENOMEM;
 		}
@@ -675,7 +675,7 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	if (spicfg->io_type == SPI_IO_TYPE_DMA) {
 
 		if (t->tx_buf)
-			dma_unmap_single(NULL, t->tx_dma, dspi->wcount,
+			dma_unmap_single(NULL, t->tx_dma, t->len,
 								DMA_TO_DEVICE);
 
 		dma_unmap_single(NULL, t->rx_dma, rx_buf_count,
-- 
1.7.0.4
