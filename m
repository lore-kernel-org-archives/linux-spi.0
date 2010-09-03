From: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/6] SPI: S3C64XX: Prevent unnecessary map-unmap
Date: Fri,  3 Sep 2010 10:36:37 +0900
Message-ID: <1283477797-31163-1-git-send-email-jassi.brar@samsung.com>
References: <1OrKX4-0007cO-1K>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1OrKX4-0007cO-1K>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Since we use DMA mode only for xfers bigger than FIFO size,
do not map/unmap buffers for polling mode transfers.

Signed-off-by: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi_s3c64xx.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
index 774e861..12e7915 100644
--- a/drivers/spi/spi_s3c64xx.c
+++ b/drivers/spi/spi_s3c64xx.c
@@ -492,6 +492,7 @@ void s3c64xx_spi_dma_txcb(struct s3c2410_dma_chan *chan, void *buf_id,
 static int s3c64xx_spi_map_mssg(struct s3c64xx_spi_driver_data *sdd,
 						struct spi_message *msg)
 {
+	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	struct device *dev = &sdd->pdev->dev;
 	struct spi_transfer *xfer;
 
@@ -507,6 +508,9 @@ static int s3c64xx_spi_map_mssg(struct s3c64xx_spi_driver_data *sdd,
 	/* Map until end or first fail */
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 
+		if (xfer->len <= ((sci->fifo_lvl_mask >> 1) + 1))
+			continue;
+
 		if (xfer->tx_buf != NULL) {
 			xfer->tx_dma = dma_map_single(dev,
 					(void *)xfer->tx_buf, xfer->len,
@@ -538,6 +542,7 @@ static int s3c64xx_spi_map_mssg(struct s3c64xx_spi_driver_data *sdd,
 static void s3c64xx_spi_unmap_mssg(struct s3c64xx_spi_driver_data *sdd,
 						struct spi_message *msg)
 {
+	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	struct device *dev = &sdd->pdev->dev;
 	struct spi_transfer *xfer;
 
@@ -546,6 +551,9 @@ static void s3c64xx_spi_unmap_mssg(struct s3c64xx_spi_driver_data *sdd,
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 
+		if (xfer->len <= ((sci->fifo_lvl_mask >> 1) + 1))
+			continue;
+
 		if (xfer->rx_buf != NULL
 				&& xfer->rx_dma != XFER_DMAADDR_INVALID)
 			dma_unmap_single(dev, xfer->rx_dma,
-- 
1.6.2.5


------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
