From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 08/16] Blackfin SPI Driver: add a few
	more debug messages in useful places
Date: Tue, 18 Nov 2008 15:52:32 +0800
Message-ID: <1226994760-4301-9-git-send-email-cooloney@kernel.org>
References: <1226994760-4301-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1226994760-4301-1-git-send-email-cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Signed-off-by: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index a7c8976..e293d19 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -559,9 +559,13 @@ static irqreturn_t dma_irq_handler(int irq, void *dev_id)
 	struct driver_data *drv_data = dev_id;
 	struct chip_data *chip = drv_data->cur_chip;
 	struct spi_message *msg = drv_data->cur_msg;
+	unsigned short dmastat = get_dma_curr_irqstat(drv_data->dma_channel);
 	u16 spistat = read_STAT(drv_data);
 
-	dev_dbg(&drv_data->pdev->dev, "in dma_irq_handler\n");
+	dev_dbg(&drv_data->pdev->dev,
+		"in dma_irq_handler dmastat:0x%x spistat:0x%x\n",
+		dmastat, spistat);
+
 	clear_dma_irqstat(drv_data->dma_channel);
 
 	/* Wait for DMA to complete */
@@ -631,6 +635,7 @@ static void pump_transfers(unsigned long data)
 
 	 /* Handle for abort */
 	if (message->state == ERROR_STATE) {
+		dev_dbg(&drv_data->pdev->dev, "transfer: we've hit an error\n");
 		message->status = -EIO;
 		giveback(drv_data);
 		return;
@@ -638,6 +643,7 @@ static void pump_transfers(unsigned long data)
 
 	/* Handle end of message */
 	if (message->state == DONE_STATE) {
+		dev_dbg(&drv_data->pdev->dev, "transfer: all done!\n");
 		message->status = 0;
 		giveback(drv_data);
 		return;
@@ -645,6 +651,7 @@ static void pump_transfers(unsigned long data)
 
 	/* Delay if requested at end of transfer */
 	if (message->state == RUNNING_STATE) {
+		dev_dbg(&drv_data->pdev->dev, "transfer: still running ...\n");
 		previous = list_entry(transfer->transfer_list.prev,
 				      struct spi_transfer, transfer_list);
 		if (previous->delay_usecs)
@@ -805,7 +812,8 @@ static void pump_transfers(unsigned long data)
 		dma_config = (RESTART | dma_width | DI_EN);
 		if (drv_data->rx != NULL) {
 			/* set transfer mode, and enable SPI */
-			dev_dbg(&drv_data->pdev->dev, "doing DMA in.\n");
+			dev_dbg(&drv_data->pdev->dev, "doing DMA in to %p (size %zx)\n",
+				drv_data->rx, drv_data->len_in_bytes);
 
 			/* invalidate caches, if needed */
 			if (bfin_addr_dcachable((unsigned long) drv_data->rx))
-- 
1.5.6.3

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
