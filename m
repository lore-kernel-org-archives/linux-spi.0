From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [Patch 0/1] spi: Fix pxa2xx_spi.c transfer
	delay, cs change, transfer length
Date: Mon, 8 Sep 2008 16:44:25 -0700
Message-ID: <200809081644.26081.david-b@pacbell.net>
References: <48BFEBF7.1080902@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48BFEBF7.1080902-/d+BM93fTQY@public.gmane.org>
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

On Thursday 04 September 2008, Ned Forrester wrote:
> I think enough time has elapsed for any objections to surface. =A0Is there
> still time to push this patch for 2.6.27? =


I enclose a slightly cleaned-up version.  Comments, checkpath.pl,
and so on.  Could you eyeball make sure it still behaves?

Also, this is too much for one patch.  The transfer_delay and
cs_change stuff (fixing bugs #1-4) are plausibly one patch.
And the DMA stuff (#5-6) is plausibly a different patch.

Could you split those two out?  Then I'll submit them.

There should still be time; thanks for the ping.


> Also, the patch should be directed at the stable maintainers for
> addition to any kernel as far back as 2.6.20. I'm not sure how to do
> direct that, but I expect that you do.

One just cc's stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org ... I don't think the stable
team maintains anything that old though.  I cc'd Eric (at Marvell)
who is probably worth keeping in the loop in terms of PXA fixes.
The PXA platform is now getting an overhaul to help make the
PXA3xx changes work better ... yay!

- Dave

p.s. Eric, it seems the pxa2xx_spi driver is in need of more
     active maintaining than it's got.  I seem to have a few
     other patches for it in my mailbox too...

=3D=3D=3D=3D=3D=3D=3D=3D=3D CUT HERE
From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>

Fixes several related bugs in the pxa2xx_spi driver.  These
bugs are in all versions of this driver (except for #6, which
was introduced in the 2.6.20 kernel) and prevent using it
with chips like m25p16 flash.

 1. The spi_transfer.cs_change flag is handled too early:
    before spi_transfer.delay_usecs applies, thus making the
    delay ineffective at holding chip select.

 2. spi_transfer.delay_usecs is ignored on the last transfer
    of a message (likewise not holding chipselect long enough).

 3. If spi_transfer.cs_change is set on the last transfer, the
    chip select is always disabled, instead of the intended
    meaning: optionally holding chip select enabled for the
    next message.  (Impact at least MMC-over-SPI.)

Those first three bugs were fixed with a relocation of delays
and chip select de-assertions.

 4. If a message has the cs_change flag set on the last transfer,
    and had the chip select stayed enabled as requested (see 3,
    above), it would not have been disabled if the next message is
    for a different chip.  Fixed by dropping chip select regardless
    of cs_change at end of a message, if there is no next message
    or if the next message is for a different chip.  =


 5. Zero length transfers are permitted for use to insert timing,
    but pxa2xx_spi.c will fail if this is requested in DMA mode.
    Fixed by using programmed I/O (PIO) mode for such transfers.

 6. Transfers larger than 8191 are not permitted in DMA mode.  A
    test for length rejects all large transfers regardless of DMA
    or PIO mode.  Worked around by rejecting only large transfers
    with DMA mapped buffers, and forcing all other transfers larger than 81=
91
    to use PIO mode.  A rate limited warning is issued for DMA
    transfers forced to PIO mode.

This patch should apply to all kernels back to and including 2.6.20;
it was test patched against 2.6.20.  An additional patch would be
required for older kernels, but those versions are very buggy anyway.  =


There are some additional issues when GPIOs aren't being used as
chipselects.  Probably the SSFRM support should be removed, and
the GPIO support switched over to use standard GPIO calls (and to
support SPI_CS_HIGH).

Signed-off-by: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Cc: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
# NYET-Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/pxa2xx_spi.c |  116 +++++++++++++++++++++++++++++++++++-------=
---
 1 file changed, 91 insertions(+), 25 deletions(-)

--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -47,9 +47,10 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 =

 #define MAX_BUSES 3
 =

-#define DMA_INT_MASK (DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR)
-#define RESET_DMA_CHANNEL (DCSR_NODESC | DMA_INT_MASK)
-#define IS_DMA_ALIGNED(x) (((u32)(x)&0x07)=3D=3D0)
+#define DMA_INT_MASK		(DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR)
+#define RESET_DMA_CHANNEL	(DCSR_NODESC | DMA_INT_MASK)
+#define IS_DMA_ALIGNED(x)	(((x) & 0x07) =3D=3D 0)
+#define MAX_DMA_LEN		8191
 =

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
@@ -406,8 +406,45 @@ static void giveback(struct driver_data =

 					struct spi_transfer,
 					transfer_list);
 =

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
+			next_msg =3D NULL;
+		else
+			next_msg =3D list_entry(drv_data->queue.next,
+					struct spi_message, queue);
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+
+		/* see if the next and current messages point
+		 * to the same chip
+		 */
+		if (next_msg && next_msg->spi !=3D msg->spi)
+			next_msg =3D NULL;
+		if (!next_msg || msg->state =3D=3D ERROR_STATE)
+			drv_data->cs_control(PXA2XX_CS_DEASSERT);
+	}
 =

 	msg->state =3D NULL;
 	if (msg->complete)
@@ -490,10 +527,9 @@ static void dma_transfer_complete(struct
 	msg->actual_length +=3D drv_data->len -
 				(drv_data->rx_end - drv_data->rx);
 =

-	/* Release chip select if requested, transfer delays are
-	 * handled in pump_transfers */
-	if (drv_data->cs_change)
-		drv_data->cs_control(PXA2XX_CS_DEASSERT);
+	/* Transfer delays and chip select release are
+	 * handled in pump_transfers or giveback
+	 */
 =

 	/* Move to next transfer */
 	msg->state =3D next_transfer(drv_data);
@@ -602,10 +638,9 @@ static void int_transfer_complete(struct
 	drv_data->cur_msg->actual_length +=3D drv_data->len -
 				(drv_data->rx_end - drv_data->rx);
 =

-	/* Release chip select if requested, transfer delays are
-	 * handled in pump_transfers */
-	if (drv_data->cs_change)
-		drv_data->cs_control(PXA2XX_CS_DEASSERT);
+	/* Transfer delays and chip select release are
+	 * handled in pump_transfers or giveback
+	 */
 =

 	/* Move to next transfer */
 	drv_data->cur_msg->state =3D next_transfer(drv_data);
@@ -840,23 +875,40 @@ static void pump_transfers(unsigned long
 		return;
 	}
 =

-	/* Delay if requested at end of transfer*/
+	/* Delay if requested at end of transfer before CS change */
 	if (message->state =3D=3D RUNNING_STATE) {
 		previous =3D list_entry(transfer->transfer_list.prev,
 					struct spi_transfer,
 					transfer_list);
 		if (previous->delay_usecs)
 			udelay(previous->delay_usecs);
+
+		/* Drop chip select only if cs_change is requested */
+		if (previous->cs_change)
+			drv_data->cs_control(PXA2XX_CS_DEASSERT);
 	}
 =

-	/* Check transfer length */
-	if (transfer->len > 8191)
-	{
-		dev_warn(&drv_data->pdev->dev, "pump_transfers: transfer "
-				"length greater than 8191\n");
-		message->status =3D -EINVAL;
-		giveback(drv_data);
-		return;
+	/* Check for transfers that need multiple DMA segments */
+	if (transfer->len > MAX_DMA_LEN && chip->enable_dma) {
+
+		/* reject already-mapped transfers; PIO won't always work */
+		if (message->is_dma_mapped
+				|| transfer->rx_dma || transfer->tx_dma) {
+			dev_err(&drv_data->pdev->dev,
+				"pump_transfers: mapped transfer length "
+				"of %lu is greater than %d\n",
+				transfer->len, MAX_DMA_LEN);
+			message->status =3D -EINVAL;
+			giveback(drv_data);
+			return;
+		}
+
+		/* warn ... we force this to PIO mode */
+		if (printk_ratelimit())
+			dev_warn(&message->spi->dev, "pump_transfers: "
+				"DMA disabled for transfer length %ld "
+				"greater than %d\n",
+				(long)drv_data->len, MAX_DMA_LEN);
 	}
 =

 	/* Setup the transfer state based on the type of transfer */
@@ -878,7 +930,6 @@ static void pump_transfers(unsigned long
 	drv_data->len =3D transfer->len & DCMD_LENGTH;
 	drv_data->write =3D drv_data->tx ? chip->write : null_writer;
 	drv_data->read =3D drv_data->rx ? chip->read : null_reader;
-	drv_data->cs_change =3D transfer->cs_change;
 =

 	/* Change speed and bit per word on a per transfer */
 	cr0 =3D chip->cr0;
@@ -925,7 +976,7 @@ static void pump_transfers(unsigned long
 							&dma_thresh))
 				if (printk_ratelimit())
 					dev_warn(&message->spi->dev,
-						"pump_transfer: "
+						"pump_transfers: "
 						"DMA burst size reduced to "
 						"match bits_per_word\n");
 		}
@@ -939,8 +990,23 @@ static void pump_transfers(unsigned long
 =

 	message->state =3D RUNNING_STATE;
 =

-	/* Try to map dma buffer and do a dma transfer if successful */
-	if ((drv_data->dma_mapped =3D map_dma_buffers(drv_data))) {
+	/* Try to map dma buffer and do a dma transfer if successful, but
+	 * only if the length is non-zero and less than MAX_DMA_LEN.
+	 *
+	 * Zero-length non-descriptor DMA is illegal on PXA2xx; force use
+	 * of PIO instead.  Care is needed above because the transfer may
+	 * have have been passed with buffers that are already dma mapped.
+	 * A zero-length transfer in PIO mode will not try to write/read
+	 * to/from the buffers
+	 *
+	 * REVISIT large transfers are exactly where we most want to be
+	 * using DMA.  If this happens much, split those transfers into
+	 * multiple DMA segments rather than forcing PIO.
+	 */
+	drv_data->dma_mapped =3D 0;
+	if (drv_data->len > 0 && drv_data->len <=3D MAX_DMA_LEN)
+		drv_data->dma_mapped =3D map_dma_buffers(drv_data);
+	if (drv_data->dma_mapped) {
 =

 		/* Ensure we have the correct interrupt handler */
 		drv_data->transfer_handler =3D dma_transfer;


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
