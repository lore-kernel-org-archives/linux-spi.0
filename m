From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: [Patch 1/1] spi: Fix pxa2xx_spi.c transfer
 delay, cs change, transfer length
Date: Tue, 19 Aug 2008 23:35:42 -0400
Message-ID: <48AB910E.50400@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	Stephen Street <stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>

Applies to kernels 2.6.20 and later 
Created from 2.6.27-rc3, 
Tested to apply to 2.6.20 with fuzz

Fixes the following related bugs in spi driver pxa2xx_spi.c:

1. The spi_transfer.cs_change flag is honored before the 
spi_transfer.delay_usecs delay time, thus making the delay ineffective 
at holding chip select.

2. spi_transfer.delay_usecs is ignored on the last transfer of a 
message.

3. If spi_transfer.cs_change is set on the last transfer, the chip 
select is always disabled, instead of the intended meaning: optionally 
holding chip select enabled for the next message.

The first three bugs are fixed with a relocation of delays and chip 
select de-assertions.

4. If a message has the cs_change flag set on the last transfer, and 
had the chip select stayed enabled as requested (see 3, above), it 
would not have been disabled if the next message is for a different 
chip.  Fixed by dropping chip select regardless of cs_change at the 
end of a message, if there is no next message or if the next message 
is for a different chip.  

5. Zero length transfers are permitted for use to insert timing, but 
pxa2xx_spi.c will fail if this is requested in DMA mode.  Fixed by 
using programmed I/O (PIO) mode for zero-length transfers.

6. Transfers larger than 8191 are not permitted in DMA mode.  A test
for length rejects all large transfers regardless of DMA or PIO mode.  
Fixed by rejecting only large transfers with DMA mapped buffers, and 
forcing all other transfers larger than 8191 to use PIO mode.  A rate 
limited warning is issued for DMA transfers forced to PIO mode.

Except for 6, these bugs are in all versions of pxa2xx_spi.c.  bug 6 
was introduced in kernel 2.6.20.  This patch should apply to all 
kernels back to and including 2.6.20, it was test patched against 
2.6.20.  An additional patch would be required for older kernels, but 
those versions are very buggy anyway.  

Signed-off-by: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>

---

 drivers/spi/pxa2xx_spi.c |   87 ++++++++++++++++++++++++++++---------
 1 file changed, 68 insertions(+), 19 deletions(-)

diff -Nurp linux-2.6.27-rc3/drivers/spi/pxa2xx_spi.c linux-2.6.27-rc3_delay_patch/drivers/spi/pxa2xx_spi.c
--- linux-2.6.27-rc3/drivers/spi/pxa2xx_spi.c	2008-08-19 18:08:22.000000000 +0000
+++ linux-2.6.27-rc3_delay_patch/drivers/spi/pxa2xx_spi.c	2008-08-20 03:08:21.000000000 +0000
@@ -50,6 +50,7 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 #define DMA_INT_MASK (DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR)
 #define RESET_DMA_CHANNEL (DCSR_NODESC | DMA_INT_MASK)
 #define IS_DMA_ALIGNED(x) (((u32)(x)&0x07)==0)
+#define MAX_DMA_LEN (8191)
 
 /*
  * for testing SSCR1 changes that require SSP restart, basically
@@ -144,7 +145,6 @@ struct driver_data {
 	size_t tx_map_len;
 	u8 n_bytes;
 	u32 dma_width;
-	int cs_change;
 	int (*write)(struct driver_data *drv_data);
 	int (*read)(struct driver_data *drv_data);
 	irqreturn_t (*transfer_handler)(struct driver_data *drv_data);
@@ -406,8 +406,39 @@ static void giveback(struct driver_data 
 					struct spi_transfer,
 					transfer_list);
 
+	/* delay if requested before any change in chip select */
+	if (last_transfer->delay_usecs)
+		udelay(last_transfer->delay_usecs);
+	/* drop chip select UNLESS cs_change is true or we are returning
+	 * a message with an error, or next message is for another chip
+	 */
 	if (!last_transfer->cs_change)
 		drv_data->cs_control(PXA2XX_CS_DEASSERT);
+	else {
+		/* holding of cs was requested, but we need to make sure
+		 * that the next message is for the same chip; don't waste
+		 * time with the following tests unless this hold request has
+		 * been made; we cannot postpone this until pump_messages,
+		 * because after calling msg->complete, below, there is no
+		 * assurance that the driver that sent the current message
+		 * will remain loaded, and thus that the cs_control()
+		 * callback will remain valid.
+		 */
+		struct spi_message *next_msg;
+
+		/* get a pointer to the next message, if any */
+		spin_lock_irqsave(&drv_data->lock, flags);
+		if (list_empty(&drv_data->queue)) next_msg = NULL;
+		else next_msg = list_entry(drv_data->queue.next,
+					struct spi_message, queue);
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+		if (next_msg)
+			/* see if the next and current messages point
+			 * to the same chip */
+			if (next_msg->spi != msg->spi) next_msg = NULL;
+		if(!next_msg || msg->state == ERROR_STATE)
+				drv_data->cs_control(PXA2XX_CS_DEASSERT);
+	}
 
 	msg->state = NULL;
 	if (msg->complete)
@@ -490,10 +521,8 @@ static void dma_transfer_complete(struct
 	msg->actual_length += drv_data->len -
 				(drv_data->rx_end - drv_data->rx);
 
-	/* Release chip select if requested, transfer delays are
-	 * handled in pump_transfers */
-	if (drv_data->cs_change)
-		drv_data->cs_control(PXA2XX_CS_DEASSERT);
+	/* transfer delays and chip select release are
+	 * handled in pump_transfers or giveback */
 
 	/* Move to next transfer */
 	msg->state = next_transfer(drv_data);
@@ -602,10 +631,8 @@ static void int_transfer_complete(struct
 	drv_data->cur_msg->actual_length += drv_data->len -
 				(drv_data->rx_end - drv_data->rx);
 
-	/* Release chip select if requested, transfer delays are
-	 * handled in pump_transfers */
-	if (drv_data->cs_change)
-		drv_data->cs_control(PXA2XX_CS_DEASSERT);
+	/* transfer delays and chip select release are
+	 * handled in pump_transfers or giveback */
 
 	/* Move to next transfer */
 	drv_data->cur_msg->state = next_transfer(drv_data);
@@ -840,24 +867,38 @@ static void pump_transfers(unsigned long
 		return;
 	}
 
-	/* Delay if requested at end of transfer*/
+	/* Delay if requested at end of transfer before CS change */
 	if (message->state == RUNNING_STATE) {
 		previous = list_entry(transfer->transfer_list.prev,
 					struct spi_transfer,
 					transfer_list);
 		if (previous->delay_usecs)
 			udelay(previous->delay_usecs);
+		/* drop chip select only if cs_change is requested */
+		if (previous->cs_change)
+			drv_data->cs_control(PXA2XX_CS_DEASSERT);
 	}
 
-	/* Check transfer length */
-	if (transfer->len > 8191)
-	{
-		dev_warn(&drv_data->pdev->dev, "pump_transfers: transfer "
-				"length greater than 8191\n");
+	/* Check transfer length, for any DMA transfer that is already mapped */
+	if (transfer->len > MAX_DMA_LEN && chip->enable_dma
+				&& (message->is_dma_mapped
+				|| transfer->rx_dma || transfer->tx_dma)) {
+		dev_err(&drv_data->pdev->dev, "pump_transfers: DMA mapped "
+			"transfer has length of %ld greater than %d\n",
+				(long)transfer->len, MAX_DMA_LEN);
 		message->status = -EINVAL;
 		giveback(drv_data);
 		return;
 	}
+	/* else warn if dma enabled but we will process transfer in PIO mode */
+	if (drv_data->len > MAX_DMA_LEN && chip->enable_dma)
+		/* but we must have checked above for a long transfer passed
+		 * with mapped buffers, it must be rejected */
+		if (printk_ratelimit())
+			dev_warn(&message->spi->dev, "pump_transfers: "
+				"DMA disabled for transfer length %ld "
+				"greater than %d\n",
+				(long)drv_data->len, MAX_DMA_LEN);
 
 	/* Setup the transfer state based on the type of transfer */
 	if (flush(drv_data) == 0) {
@@ -878,7 +919,6 @@ static void pump_transfers(unsigned long
 	drv_data->len = transfer->len & DCMD_LENGTH;
 	drv_data->write = drv_data->tx ? chip->write : null_writer;
 	drv_data->read = drv_data->rx ? chip->read : null_reader;
-	drv_data->cs_change = transfer->cs_change;
 
 	/* Change speed and bit per word on a per transfer */
 	cr0 = chip->cr0;
@@ -925,7 +965,7 @@ static void pump_transfers(unsigned long
 							&dma_thresh))
 				if (printk_ratelimit())
 					dev_warn(&message->spi->dev,
-						"pump_transfer: "
+						"pump_transfers: "
 						"DMA burst size reduced to "
 						"match bits_per_word\n");
 		}
@@ -939,8 +979,17 @@ static void pump_transfers(unsigned long
 
 	message->state = RUNNING_STATE;
 
-	/* Try to map dma buffer and do a dma transfer if successful */
-	if ((drv_data->dma_mapped = map_dma_buffers(drv_data))) {
+	/* Try to map dma buffer and do a dma transfer if successful, but
+	 * only if the length is non-zero and less than MAX_DMA_LEN,
+	 * zero-length non-descriptor DMA is illegal on PXA2xx; force use
+	 * of PIO instead; care is needed above because the transfer may
+	 * have have been passed with buffers that are already dma mapped;
+	 * a zero-length transfer in PIO mode will not try to write/read
+	 * to/from the buffers */
+	drv_data->dma_mapped = 0;
+	if (drv_data->len > 0 && drv_data->len <= MAX_DMA_LEN)
+			drv_data->dma_mapped = map_dma_buffers(drv_data);
+	if (drv_data->dma_mapped) {
 
 		/* Ensure we have the correct interrupt handler */
 		drv_data->transfer_handler = dma_transfer;

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
