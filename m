From: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: pxa2xx_spi with SFRM
Date: Thu, 21 Aug 2008 18:08:26 -0400
Message-ID: <20080821180826.491ac70b@vsauder-lx.localdomain>
References: <1218182539.489bfd8b24a3d@webmail.whoi.edu>
	<489C1B23.6040804@cam.ac.uk> <48A0C35D.5010606@gmail.com>
	<48A44F77.1020908@whoi.edu> <48A4ED85.1030803@gmail.com>
	<48A5D44D.6040106@whoi.edu>
	<20080815223307.02db86aa@vsauder-lx.localdomain>
	<48A9C0D0.5050304@whoi.edu> <48AB6C8F.4040408@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48AB6C8F.4040408-/d+BM93fTQY@public.gmane.org>
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

Ned Forrester wrote:

>Ned Forrester wrote:
>> Vernon Sauder wrote:
>>> <opinion> As a user, it would seem that the SSP should work with
>>> minimum fuss. If there are values that enable 99% of devices to
>>> work, then why would you *not* want them to be the defaults? If the
>>> user needs to tweak the values because they need more performance,
>>> then they can. But if they only need a low bandwidth connection,
>>> causing transfers to hang because they did not provide a
>>> "know-able" value seems less than useful. I know it took me
>>> entirely too long to get this working. I am only trying to help the
>>> next user that needs this. </opinion>
>> 
>> I agree with your sentiment.  What I am not sure of is whether there
>> are even 90% of applications that could use a single group of
>> settings.  I think the DMA burst and the thresholds could likely be
>> set to reasonable defaults: burst = bits/word (for 8, 16, and 32 bit
>> words, this results in burst equaling half the FIFO), and thresholds
>> of 8/8 (again, half the FIFO).  For the timeout, I'm less sure of
>> the best approach; probably it should be very long, a millisecond or
>> more (if we know what that translates to on a PXA270), and let users
>> reduce it if they want faster response.  My main concern is the poor
>> documentation of this in the PXA developer's manuals.
>
>Vernon, have you had any more thoughts about this.  I am working on a
>patch to deal with problems that were discovered a while ago, and which
>finally tripped up another user (Re: [spi-devel-general] [PATCH]
>pxa2xx_spi: wait_rx_stall before deasserting CS on PIO mode).  I
>wondered if we are ready to converge on any changes.  On the one hand
>it would be easy to throw improvement in the defaults in the with the
>other changes, but on the other hand I think they are independent, and
>so they should probably be in separate patches.
>
>As a consequence of studying the driver for the other patch (regarding
>transfer delays and chip select), I have a new understanding of the
>timeout that simplifies the problems I discussed above.  I am now
>reasonably sure (but cannot test) that a timeout value that is "too
>short" will only result in excess interrupt service for unneeded
>timeouts, and not in early termination of a transfer.  In
>interrupt_transfer, acceptance of a timeout interrupt is conditioned on
>being able to retrieve all expected characters from the RX FIFO; in
>dma_transfer, acceptance is similarly conditioned on the whole transmit
>process being complete (and thus the receive process is done or will be
>in nsec).
>
>The result is that neither a too short, nor a too long timeout is
>fatal, and thus it IS reasonable to more firmly establish a default
>timeout, even it is short.
>

Would you be in favor of a patch like this? If the code does not
match the documentation, let me know if the documentation is correct. I
can then figure out what the code should do.

Regards,
Vern
---
pxa2xx_spi: Fix chip_info defaults and documentation.

Make the chip info structure data optional by providing reasonable
defaults. Improve corresponding documentation.

DMA can determine appropriate dma_burst_size and thresholds
automatically so use DMA even if dma_burst_size is not specified.

Signed-off-by: Vernon Sauder <VernonInHand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
--- linux-2.6.24.4/drivers/spi/pxa2xx_spi.c	2008-03-24 14:49:18.000000000 -0400
+++ src.cache/drivers/spi/pxa2xx_spi.c	2008-08-20 13:20:19.000000000 -0400
@@ -44,6 +44,10 @@
 
 #define MAX_BUSES 3
 
+#define RX_THRESH_DFLT 	8
+#define TX_THRESH_DFLT 	8
+#define TIMOUT_DFLT		1000
+
 #define DMA_INT_MASK (DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR)
 #define RESET_DMA_CHANNEL (DCSR_NODESC | DMA_INT_MASK)
 #define IS_DMA_ALIGNED(x) (((u32)(x)&0x07)==0)
@@ -1126,8 +1130,7 @@
 
 		chip->cs_control = null_cs_control;
 		chip->enable_dma = 0;
-		chip->timeout = 1000;
-		chip->threshold = SSCR1_RxTresh(1) | SSCR1_TxTresh(1);
+		chip->timeout = TIMOUT_DFLT;
 		chip->dma_burst_size = drv_data->master_info->enable_dma ?
 					DCMD_BURST8 : 0;
 	}
@@ -1138,25 +1141,28 @@
 
 	/* chip_info isn't always needed */
 	chip->cr1 = 0;
+	uint tx_thres = TX_THRESH_DFLT;
+	uint rx_thres = RX_THRESH_DFLT;
 	if (chip_info) {
 		if (chip_info->cs_control)
 			chip->cs_control = chip_info->cs_control;
-
- 		chip->timeout = chip_info->timeout;
+		if (chip_info->timeout)
+ 			chip->timeout = chip_info->timeout;
+		if (chip_info->tx_threshold)
+			tx_thres = chip_info->tx_threshold;
+		if (chip_info->rx_threshold)
+			rx_thres = chip_info->rx_threshold;
 
-		chip->threshold = (SSCR1_RxTresh(chip_info->rx_threshold) &
-								SSCR1_RFT) |
-				(SSCR1_TxTresh(chip_info->tx_threshold) &
-								SSCR1_TFT);
-
-		chip->enable_dma = chip_info->dma_burst_size != 0
-					&& drv_data->master_info->enable_dma;
+		chip->enable_dma = drv_data->master_info->enable_dma;
 		chip->dma_threshold = 0;
 
 		if (chip_info->enable_loopback)
 			chip->cr1 = SSCR1_LBM;
 	}
 
+	chip->threshold = (SSCR1_RxTresh(rx_thres) & SSCR1_RFT) |
+			(SSCR1_TxTresh(tx_thres) & SSCR1_TFT);
+
 	/* set dma burst and threshold outside of chip_info path so that if
 	 * chip_info goes away after setting chip->enable_dma, the
 	 * burst and threshold can still respond to changes in bits_per_word */
@@ -1196,17 +1202,19 @@
 
 	/* NOTE:  PXA25x_SSP _could_ use external clocking ... */
 	if (drv_data->ssp_type != PXA25x_SSP)
-		dev_dbg(&spi->dev, "%d bits/word, %d Hz, mode %d\n",
+		dev_dbg(&spi->dev, "%d bits/word, %d Hz, mode %d, %s\n",
 				spi->bits_per_word,
 				(CLOCK_SPEED_HZ)
 					/ (1 + ((chip->cr0 & SSCR0_SCR) >> 8)),
-				spi->mode & 0x3);
+				spi->mode & 0x3,
+				chip->enable_dma ? "DMA" : "PIO");
 	else
-		dev_dbg(&spi->dev, "%d bits/word, %d Hz, mode %d\n",
+		dev_dbg(&spi->dev, "%d bits/word, %d Hz, mode %d, %s\n",
 				spi->bits_per_word,
 				(CLOCK_SPEED_HZ/2)
 					/ (1 + ((chip->cr0 & SSCR0_SCR) >> 8)),
-				spi->mode & 0x3);
+				spi->mode & 0x3,
+				chip->enable_dma ? "DMA" : "PIO");
 
 	if (spi->bits_per_word <= 8) {
 		chip->n_bytes = 1;
@@ -1457,7 +1465,8 @@
 
 	/* Load default SSP configuration */
 	write_SSCR0(0, drv_data->ioaddr);
-	write_SSCR1(SSCR1_RxTresh(4) | SSCR1_TxTresh(12), drv_data->ioaddr);
+	write_SSCR1(SSCR1_RxTresh(RX_THRESH_DFLT) | SSCR1_TxTresh(TX_THRESH_DFLT),
+				drv_data->ioaddr);
 	write_SSCR0(SSCR0_SerClkDiv(2)
 			| SSCR0_Motorola
 			| SSCR0_DataSize(8),
--- linux-2.6.24.4/Documentation/spi/pxa2xx	2008-03-24 14:49:18.000000000 -0400
+++ src.cache/Documentation/spi/pxa2xx	2008-08-20 13:14:01.000000000 -0400
@@ -96,7 +96,7 @@
 information via the structure "pxa2xx_spi_chip" found in
 "include/asm-arm/arch-pxa/pxa2xx_spi.h".  The pxa2xx_spi master controller driver
 will uses the configuration whenever the driver communicates with the slave
-device.
+device. All fields are optional.
 
 struct pxa2xx_spi_chip {
 	u8 tx_threshold;
@@ -112,14 +112,17 @@
 performance of pxa2xx_spi driver and misconfiguration will result in rx
 fifo overruns (especially in PIO mode transfers). Good default values are
 
-	.tx_threshold = 12,
-	.rx_threshold = 4,
+	.tx_threshold = 8,
+	.rx_threshold = 8,
+
+The range is 1 to 16 where zero indicates "use default".
 
 The "pxa2xx_spi_chip.dma_burst_size" field is used to configure PXA2xx DMA
 engine and is related the "spi_device.bits_per_word" field.  Read and understand
 the PXA2xx "Developer Manual" sections on the DMA controller and SSP Controllers
 to determine the correct value. An SSP configured for byte-wide transfers would
-use a value of 8.
+use a value of 8. The driver will determine a reasonable default if
+dma_burst_size == 0.
 
 The "pxa2xx_spi_chip.timeout" fields is used to efficiently handle
 trailing bytes in the SSP receiver fifo.  The correct value for this field is
@@ -135,7 +138,10 @@
 The "pxa2xx_spi_chip.cs_control" field is used to point to a board specific
 function for asserting/deasserting a slave device chip select.  If the field is
 NULL, the pxa2xx_spi master controller driver assumes that the SSP port is
-configured to use SSPFRM instead.
+configured to use SSPFRM instead. NOTE: the SPI driver cannot control the chip
+select if SSPFRM is used so each transfer will assert/deassert SSPFRM around it.
+Many devices need chip select asserted around the complete message. The 
+cs_control method should use the SSPFRM pin as a GPIO to accomodate these chips.
 
 NSSP SALVE SAMPLE
 -----------------
@@ -206,16 +212,15 @@
 
 DMA and PIO I/O Support
 -----------------------
-The pxa2xx_spi driver support both DMA and interrupt driven PIO message
+The pxa2xx_spi driver supports both DMA and interrupt driven PIO message
 transfers.  The driver defaults to PIO mode and DMA transfers must enabled by
-setting the "enable_dma" flag in the "pxa2xx_spi_master" structure and
-ensuring that the "pxa2xx_spi_chip.dma_burst_size" field is non-zero.  The DMA
+setting the "enable_dma" flag in the "pxa2xx_spi_master" structure.  The DMA
 mode support both coherent and stream based DMA mappings.
 
 The following logic is used to determine the type of I/O to be used on
 a per "spi_transfer" basis:
 
-if !enable_dma or dma_burst_size == 0 then
+if !enable_dma then
 	always use PIO transfers
 
 if spi_message.is_dma_mapped and rx_dma_buf != 0 and tx_dma_buf != 0 then

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
