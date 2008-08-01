From: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] atmel_spi: Implement per-transfer
	protocol options
Date: Fri,  1 Aug 2008 17:17:16 +0200
Message-ID: <1217603836-21243-4-git-send-email-haavard.skinnemoen@atmel.com>
References: <1217603836-21243-1-git-send-email-haavard.skinnemoen@atmel.com>
	<1217603836-21243-2-git-send-email-haavard.skinnemoen@atmel.com>
	<1217603836-21243-3-git-send-email-haavard.skinnemoen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	kernel-o2ulR9ObcgE/ohRxsw7f2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1217603836-21243-3-git-send-email-haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
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

Allow drivers to set the bits_per_word and speed_hz fields of struct
spi_transfer to nonzero values. Doing this makes the transfers somewhat
more expensive as it prevents chaining and may require a division when
the transfer is submitted.

Signed-off-by: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/atmel_spi.c |  138 ++++++++++++++++++++++++++++++++++-------------
 1 files changed, 100 insertions(+), 38 deletions(-)

diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index f4d60ec..0bdb4d5 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -39,6 +39,7 @@ struct atmel_spi {
 	struct clk		*clk;
 	struct platform_device	*pdev;
 	struct spi_device	*stay;
+	unsigned long		base_hz;
 
 	u8			stopping;
 	struct list_head	queue;
@@ -102,6 +103,15 @@ static bool atmel_spi_is_v2(void)
  * field in CSR0 overrides all other CSRs.
  */
 
+static void atmel_spi_set_csr(struct atmel_spi *as,
+		struct spi_device *spi, u32 csr)
+{
+	if (atmel_spi_is_v2())
+		spi_writel(as, CSR0, csr);
+	else
+		spi_writel(as, CSR0 + 4 * spi->chip_select, csr);
+}
+
 static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 {
 	struct atmel_spi_device *asd = spi->controller_state;
@@ -113,7 +123,7 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 		 * switches to the correct idle polarity before we
 		 * toggle the CS.
 		 */
-		spi_writel(as, CSR0, asd->csr);
+		atmel_spi_set_csr(as, spi, asd->csr);
 		spi_writel(as, MR, SPI_BF(PCS, 0x0e) | SPI_BIT(MODFDIS)
 				| SPI_BIT(MSTR));
 		spi_readl(as, MR);
@@ -169,9 +179,15 @@ static inline int atmel_spi_xfer_is_last(struct spi_message *msg,
 	return msg->transfers.prev == &xfer->transfer_list;
 }
 
-static inline int atmel_spi_xfer_can_be_chained(struct spi_transfer *xfer)
+static inline bool atmel_spi_xfer_needs_preproc(struct spi_transfer *xfer)
 {
-	return xfer->delay_usecs == 0 && !xfer->cs_change;
+	return xfer->bits_per_word || xfer->speed_hz;
+}
+
+static inline bool atmel_spi_xfer_needs_postproc(struct spi_transfer *xfer)
+{
+	return xfer->delay_usecs == 0 || xfer->cs_change
+		|| xfer->bits_per_word || xfer->speed_hz;
 }
 
 static void atmel_spi_next_xfer_data(struct spi_master *master,
@@ -228,6 +244,28 @@ static void atmel_spi_next_xfer(struct spi_master *master,
 		xfer = NULL;
 
 	if (xfer) {
+		/*
+		 * Per-transfer overrides prevent chaining before and
+		 * after, so it should be safe to alter the CSR
+		 * registers here.
+		 */
+		if (atmel_spi_xfer_needs_preproc(xfer)) {
+			struct spi_device *spi = msg->spi;
+			struct atmel_spi_device *asd = spi->controller_state;
+			unsigned int bits = xfer->bits_per_word;
+			u32 csr = asd->csr;
+
+			if (bits)
+				csr = SPI_BFINS(BITS, csr, bits - 8);
+			if (xfer->speed_hz) {
+				u32 scbr = DIV_ROUND_UP(as->base_hz,
+						xfer->speed_hz);
+				csr = SPI_BFINS(SCBR, csr, scbr);
+			}
+
+			atmel_spi_set_csr(as, spi, csr);
+		}
+
 		spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
 
 		len = xfer->len;
@@ -257,10 +295,12 @@ static void atmel_spi_next_xfer(struct spi_master *master,
 	if (remaining > 0)
 		len = remaining;
 	else if (!atmel_spi_xfer_is_last(msg, xfer)
-			&& atmel_spi_xfer_can_be_chained(xfer)) {
+			&& !atmel_spi_xfer_needs_postproc(xfer)) {
 		xfer = list_entry(xfer->transfer_list.next,
 				struct spi_transfer, transfer_list);
 		len = xfer->len;
+		if (atmel_spi_xfer_needs_preproc(xfer))
+			xfer = NULL;
 	} else
 		xfer = NULL;
 
@@ -409,6 +449,45 @@ atmel_spi_msg_done(struct spi_master *master, struct atmel_spi *as,
 		atmel_spi_next_message(master);
 }
 
+static void atmel_spi_xfer_done(struct spi_master *master,
+		struct spi_transfer *xfer, struct spi_message *msg)
+{
+	struct atmel_spi *as = spi_master_get_devdata(master);
+	msg->actual_length += xfer->len;
+
+	if (!msg->is_dma_mapped)
+		atmel_spi_dma_unmap_xfer(master, xfer);
+
+	/* REVISIT: udelay in irq is unfriendly */
+	if (xfer->delay_usecs)
+		udelay(xfer->delay_usecs);
+
+	if (xfer->bits_per_word || xfer->speed_hz) {
+		/*
+		 * Protocol options were overridden by this transfer;
+		 * revert to default settings.
+		 */
+		struct spi_device *spi = msg->spi;
+		struct atmel_spi_device *asd = spi->controller_state;
+
+		atmel_spi_set_csr(as, spi, asd->csr);
+	}
+
+	if (atmel_spi_xfer_is_last(msg, xfer)) {
+		/* report completed message */
+		atmel_spi_msg_done(master, as, msg, 0, xfer->cs_change);
+	} else {
+		if (xfer->cs_change) {
+			cs_deactivate(as, msg->spi);
+			udelay(1);
+			cs_activate(as, msg->spi);
+		}
+
+		/* Not done yet. Submit the next transfer. */
+		atmel_spi_next_xfer(master, msg);
+	}
+}
+
 static irqreturn_t
 atmel_spi_interrupt(int irq, void *dev_id)
 {
@@ -484,41 +563,14 @@ atmel_spi_interrupt(int irq, void *dev_id)
 
 		spi_writel(as, IDR, pending);
 
-		if (as->current_remaining_bytes == 0) {
-			msg->actual_length += xfer->len;
-
-			if (!msg->is_dma_mapped)
-				atmel_spi_dma_unmap_xfer(master, xfer);
-
-			/* REVISIT: udelay in irq is unfriendly */
-			if (xfer->delay_usecs)
-				udelay(xfer->delay_usecs);
-
-			if (atmel_spi_xfer_is_last(msg, xfer)) {
-				/* report completed message */
-				atmel_spi_msg_done(master, as, msg, 0,
-						xfer->cs_change);
-			} else {
-				if (xfer->cs_change) {
-					cs_deactivate(as, msg->spi);
-					udelay(1);
-					cs_activate(as, msg->spi);
-				}
-
-				/*
-				 * Not done yet. Submit the next transfer.
-				 *
-				 * FIXME handle protocol options for xfer
-				 */
-				atmel_spi_next_xfer(master, msg);
-			}
-		} else {
+		if (as->current_remaining_bytes == 0)
+			atmel_spi_xfer_done(master, xfer, msg);
+		else
 			/*
 			 * Keep going, we still have data to send in
 			 * the current transfer.
 			 */
 			atmel_spi_next_xfer(master, msg);
-		}
 	}
 
 	spin_unlock(&as->lock);
@@ -578,6 +630,7 @@ static int atmel_spi_setup(struct spi_device *spi)
 	bus_hz = clk_get_rate(as->clk);
 	if (!atmel_spi_is_v2())
 		bus_hz /= 2;
+	as->base_hz = bus_hz;
 
 	if (spi->max_speed_hz) {
 		/*
@@ -679,10 +732,19 @@ static int atmel_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 			return -EINVAL;
 		}
 
-		/* FIXME implement these protocol options!! */
-		if (xfer->bits_per_word || xfer->speed_hz) {
-			dev_dbg(&spi->dev, "no protocol options yet\n");
-			return -ENOPROTOOPT;
+		if (xfer->bits_per_word && (xfer->bits_per_word < 8
+					|| xfer->bits_per_word > 16)) {
+			dev_dbg(&spi->dev, "unsupported bits_per_word\n");
+			return -EINVAL;
+		}
+		if (xfer->speed_hz) {
+			unsigned long divider;
+			divider = DIV_ROUND_UP(as->base_hz, xfer->speed_hz);
+
+			if (divider > 255) {
+				dev_dbg(&spi->dev, "speed_hz too low\n");
+				return -EINVAL;
+			}
 		}
 
 		/*
-- 
1.5.6.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
