From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.27-rc6] pxa2xx_spi: chipselect
	bugfixes
Date: Wed, 10 Sep 2008 17:38:44 -0700
Message-ID: <200809101738.45326.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>

Fixes several chipselect bugs in the pxa2xx_spi driver.  These bugs
are in all versions of this driver and prevent using it with chips
like m25p16 flash.

 1. The spi_transfer.cs_change flag is handled too early:
    before spi_transfer.delay_usecs applies, thus making the
    delay ineffective at holding chip select.

 2. spi_transfer.delay_usecs is ignored on the last transfer
    of a message (likewise not holding chipselect long enough).

 3. If spi_transfer.cs_change is set on the last transfer, the
    chip select is always disabled, instead of the intended
    meaning: optionally holding chip select enabled for the
    next message.

Those first three bugs were fixed with a relocation of delays
and chip select de-assertions.

 4. If a message has the cs_change flag set on the last transfer,
    and had the chip select stayed enabled as requested (see 3,
    above), it would not have been disabled if the next message is
    for a different chip.  Fixed by dropping chip select regardless
    of cs_change at end of a message, if there is no next message
    or if the next message is for a different chip.

This patch should apply to all kernels back to and including 2.6.20;
it was test patched against 2.6.20.  An additional patch would be
required for older kernels, but those versions are very buggy anyway.

Signed-off-by: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Cc: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/pxa2xx_spi.c |   59 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 11 deletions(-)

--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -144,7 +144,6 @@ struct driver_data {
 	size_t tx_map_len;
 	u8 n_bytes;
 	u32 dma_width;
-	int cs_change;
 	int (*write)(struct driver_data *drv_data);
 	int (*read)(struct driver_data *drv_data);
 	irqreturn_t (*transfer_handler)(struct driver_data *drv_data);
@@ -406,8 +405,45 @@ static void giveback(struct driver_data 
 					struct spi_transfer,
 					transfer_list);
 
+	/* Delay if requested before any change in chip select */
+	if (last_transfer->delay_usecs)
+		udelay(last_transfer->delay_usecs);
+
+	/* Drop chip select UNLESS cs_change is true or we are returning
+	 * a message with an error, or next message is for another chip
+	 */
 	if (!last_transfer->cs_change)
 		drv_data->cs_control(PXA2XX_CS_DEASSERT);
+	else {
+		struct spi_message *next_msg;
+
+		/* Holding of cs was hinted, but we need to make sure
+		 * the next message is for the same chip.  Don't waste
+		 * time with the following tests unless this was hinted.
+		 *
+		 * We cannot postpone this until pump_messages, because
+		 * after calling msg->complete (below) the driver that
+		 * sent the current message could be unloaded, which
+		 * could invalidate the cs_control() callback...
+		 */
+
+		/* get a pointer to the next message, if any */
+		spin_lock_irqsave(&drv_data->lock, flags);
+		if (list_empty(&drv_data->queue))
+			next_msg = NULL;
+		else
+			next_msg = list_entry(drv_data->queue.next,
+					struct spi_message, queue);
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+
+		/* see if the next and current messages point
+		 * to the same chip
+		 */
+		if (next_msg && next_msg->spi != msg->spi)
+			next_msg = NULL;
+		if (!next_msg || msg->state == ERROR_STATE)
+			drv_data->cs_control(PXA2XX_CS_DEASSERT);
+	}
 
 	msg->state = NULL;
 	if (msg->complete)
@@ -490,10 +526,9 @@ static void dma_transfer_complete(struct
 	msg->actual_length += drv_data->len -
 				(drv_data->rx_end - drv_data->rx);
 
-	/* Release chip select if requested, transfer delays are
-	 * handled in pump_transfers */
-	if (drv_data->cs_change)
-		drv_data->cs_control(PXA2XX_CS_DEASSERT);
+	/* Transfer delays and chip select release are
+	 * handled in pump_transfers or giveback
+	 */
 
 	/* Move to next transfer */
 	msg->state = next_transfer(drv_data);
@@ -602,10 +637,9 @@ static void int_transfer_complete(struct
 	drv_data->cur_msg->actual_length += drv_data->len -
 				(drv_data->rx_end - drv_data->rx);
 
-	/* Release chip select if requested, transfer delays are
-	 * handled in pump_transfers */
-	if (drv_data->cs_change)
-		drv_data->cs_control(PXA2XX_CS_DEASSERT);
+	/* Transfer delays and chip select release are
+	 * handled in pump_transfers or giveback
+	 */
 
 	/* Move to next transfer */
 	drv_data->cur_msg->state = next_transfer(drv_data);
@@ -840,13 +874,17 @@ static void pump_transfers(unsigned long
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
+
+		/* Drop chip select only if cs_change is requested */
+		if (previous->cs_change)
+			drv_data->cs_control(PXA2XX_CS_DEASSERT);
 	}
 
 	/* Check transfer length */
@@ -878,7 +916,6 @@ static void pump_transfers(unsigned long
 	drv_data->len = transfer->len & DCMD_LENGTH;
 	drv_data->write = drv_data->tx ? chip->write : null_writer;
 	drv_data->read = drv_data->rx ? chip->read : null_reader;
-	drv_data->cs_change = transfer->cs_change;
 
 	/* Change speed and bit per word on a per transfer */
 	cr0 = chip->cr0;

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
