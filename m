From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.28-rc5] SPI -- Freescale iMX SPI
	controller driver
Date: Mon, 17 Nov 2008 12:18:47 -0800
Message-ID: <200811171218.47550.david-b@pacbell.net>
References: <49217ACF.7080904@swapp-eng.it>
Reply-To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: SPI Devel General <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Linux ARM Kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
To: Andrea Paterniani <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <49217ACF.7080904-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
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

On Monday 17 November 2008, Andrea Paterniani wrote:
> Fix unsafe order in dma mapping operation.

This arrived horribly mangled.  Can you verify that the
appended patch is an appropriate un-mangled version?

======= CUT HERE
From: Andrea Paterniani <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>

Fix unsafe order in dma mapping operation: always flush data from
the cache *BEFORE* invalidating it, to allow full duplex transfers
where the same buffer may be used for both writes and reads.

Signed-off-by: Andrea Paterniani <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
---
 drivers/spi/spi_imx.c |   45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -506,20 +506,6 @@ static int map_dma_buffers(struct driver
 	if (!IS_DMA_ALIGNED(drv_data->rx) || !IS_DMA_ALIGNED(drv_data->tx))
 		return -1;
 
-	/* NULL rx means write-only transfer and no map needed
-	   since rx DMA will not be used */
-	if (drv_data->rx) {
-		buf = drv_data->rx;
-		drv_data->rx_dma = dma_map_single(
-					dev,
-					buf,
-					drv_data->len,
-					DMA_FROM_DEVICE);
-		if (dma_mapping_error(dev, drv_data->rx_dma))
-			return -1;
-		drv_data->rx_dma_needs_unmap = 1;
-	}
-
 	if (drv_data->tx == NULL) {
 		/* Read only message --> use drv_data->dummy_dma_buf for dummy
 		   writes to achive reads */
@@ -533,18 +519,31 @@ static int map_dma_buffers(struct driver
 					buf,
 					drv_data->tx_map_len,
 					DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, drv_data->tx_dma)) {
-		if (drv_data->rx_dma) {
-			dma_unmap_single(dev,
-					drv_data->rx_dma,
-					drv_data->len,
-					DMA_FROM_DEVICE);
-			drv_data->rx_dma_needs_unmap = 0;
-		}
+	if (dma_mapping_error(dev, drv_data->tx_dma))
 		return -1;
-	}
 	drv_data->tx_dma_needs_unmap = 1;
 
+	/* NULL rx means write-only transfer and no map needed
+	 * since rx DMA will not be used */
+	if (drv_data->rx) {
+		buf = drv_data->rx;
+		drv_data->rx_dma = dma_map_single(dev,
+						buf,
+						drv_data->len,
+						DMA_FROM_DEVICE);
+		if (dma_mapping_error(dev, drv_data->rx_dma)) {
+			if (drv_data->tx_dma) {
+				dma_unmap_single(dev,
+						drv_data->tx_dma,
+						drv_data->tx_map_len,
+						DMA_TO_DEVICE);
+				drv_data->tx_dma_needs_unmap = 0;
+			}
+			return -1;
+		}
+		drv_data->rx_dma_needs_unmap = 1;
+	}
+
 	return 0;
 }
 


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
