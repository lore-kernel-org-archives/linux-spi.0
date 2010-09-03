From: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/6] SPI: S3C64XX: Fix compilation warning
Date: Fri,  3 Sep 2010 10:36:26 +0900
Message-ID: <1283477786-31131-1-git-send-email-jassi.brar@samsung.com>
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

Fix compilation warning by typecasting the tx_buf pointer.

Signed-off-by: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi_s3c64xx.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
index 9736581..774e861 100644
--- a/drivers/spi/spi_s3c64xx.c
+++ b/drivers/spi/spi_s3c64xx.c
@@ -508,8 +508,9 @@ static int s3c64xx_spi_map_mssg(struct s3c64xx_spi_driver_data *sdd,
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 
 		if (xfer->tx_buf != NULL) {
-			xfer->tx_dma = dma_map_single(dev, xfer->tx_buf,
-						xfer->len, DMA_TO_DEVICE);
+			xfer->tx_dma = dma_map_single(dev,
+					(void *)xfer->tx_buf, xfer->len,
+					DMA_TO_DEVICE);
 			if (dma_mapping_error(dev, xfer->tx_dma)) {
 				dev_err(dev, "dma_map_single Tx failed\n");
 				xfer->tx_dma = XFER_DMAADDR_INVALID;
-- 
1.6.2.5


------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
