From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.25] spi_bfin5xx use PIO for full
	duplex, not DMA
Date: Wed, 30 Apr 2008 15:47:46 -0700
Message-ID: <200804301547.46579.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Vitja Makarov <vitja.makarov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Vitja Makarov <vitja.makarov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Use PIO for full-duplex transfers, instead of DMA.

Signed-off-by: Vitja Makarov <vitja.makarov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- at91.orig/drivers/spi/spi_bfin5xx.c	2008-04-15 10:29:21.000000000 -0700
+++ at91/drivers/spi/spi_bfin5xx.c	2008-04-30 15:44:26.000000000 -0700
@@ -608,6 +608,7 @@ static void pump_transfers(unsigned long
 	u8 width;
 	u16 cr, dma_width, dma_config;
 	u32 tranf_success = 1;
+	u8 full_duplex = 0;
 
 	/* Get current state information */
 	message = drv_data->cur_msg;
@@ -658,6 +659,7 @@ static void pump_transfers(unsigned long
 	}
 
 	if (transfer->rx_buf != NULL) {
+		full_duplex = transfer->tx_buf != NULL;
 		drv_data->rx = transfer->rx_buf;
 		drv_data->rx_end = drv_data->rx + transfer->len;
 		dev_dbg(&drv_data->pdev->dev, "rx_buf is %p, rx_end is %p\n",
@@ -740,7 +742,8 @@ static void pump_transfers(unsigned long
 	 * successful use different way to r/w according to
 	 * drv_data->cur_chip->enable_dma
 	 */
-	if (drv_data->cur_chip->enable_dma && drv_data->len > 6) {
+	if (!full_duplex && drv_data->cur_chip->enable_dma
+				&& drv_data->len > 6) {
 
 		disable_dma(drv_data->dma_channel);
 		clear_dma_irqstat(drv_data->dma_channel);
@@ -828,7 +831,7 @@ static void pump_transfers(unsigned long
 		/* IO mode write then read */
 		dev_dbg(&drv_data->pdev->dev, "doing IO transfer\n");
 
-		if (drv_data->tx != NULL && drv_data->rx != NULL) {
+		if (full_duplex) {
 			/* full duplex mode */
 			BUG_ON((drv_data->tx_end - drv_data->tx) !=
 			       (drv_data->rx_end - drv_data->rx));

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
