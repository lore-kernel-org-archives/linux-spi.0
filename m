From: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] pxa2xx_spi: Fix chip_info defaults and
	documentation.
Date: Tue, 9 Sep 2008 21:18:42 -0400
Message-ID: <20080909211842.59176caf@vsauder-lx.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>,
	David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Make the chip info structure data optional by providing reasonable
defaults. Improve corresponding documentation.

DMA can determine appropriate dma_burst_size and thresholds
automatically so use DMA even if dma_burst_size is not specified.

Signed-off-by: Vernon Sauder <VernonInHand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
---
 Documentation/spi/pxa2xx |   31 ++++++++++++++++++++-----------
 drivers/spi/pxa2xx_spi.c |   44 +++++++++++++++++++++++++++-----------------
 2 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/Documentation/spi/pxa2xx b/Documentation/spi/pxa2xx
index bbe8dee..5bb4096 100644
--- a/Documentation/spi/pxa2xx
+++ b/Documentation/spi/pxa2xx
@@ -96,7 +96,7 @@ Each slave device attached to the PXA must provide slave specific configuration
 information via the structure "pxa2xx_spi_chip" found in
 "arch/arm/mach-pxa/include/mach/pxa2xx_spi.h".  The pxa2xx_spi master controller driver
 will uses the configuration whenever the driver communicates with the slave
-device.
+device. All fields are optional.
 
 struct pxa2xx_spi_chip {
 	u8 tx_threshold;
@@ -112,14 +112,17 @@ used to configure the SSP hardware fifo.  These fields are critical to the
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
@@ -135,7 +138,10 @@ testing.
 The "pxa2xx_spi_chip.cs_control" field is used to point to a board specific
 function for asserting/deasserting a slave device chip select.  If the field is
 NULL, the pxa2xx_spi master controller driver assumes that the SSP port is
-configured to use SSPFRM instead.
+configured to use SSPFRM instead. NOTE: the SPI driver cannot control the chip
+select if SSPFRM is used so each transfer will assert/deassert SSPFRM around it.
+Many devices need chip select asserted around the complete message. The 
+cs_control method could use the SSPFRM pin as a GPIO to accomodate these chips.
 
 NSSP SALVE SAMPLE
 -----------------
@@ -206,18 +212,21 @@ static void __init streetracer_init(void)
 
 DMA and PIO I/O Support
 -----------------------
-The pxa2xx_spi driver support both DMA and interrupt driven PIO message
-transfers.  The driver defaults to PIO mode and DMA transfers must enabled by
-setting the "enable_dma" flag in the "pxa2xx_spi_master" structure and
-ensuring that the "pxa2xx_spi_chip.dma_burst_size" field is non-zero.  The DMA
-mode support both coherent and stream based DMA mappings.
+The pxa2xx_spi driver supports both DMA and interrupt driven PIO message
+transfers.  The driver defaults to PIO mode and DMA transfers must be enabled
+by setting the "enable_dma" flag in the "pxa2xx_spi_master" structure.  The DMA
+mode supports both coherent and stream based DMA mappings.
 
 The following logic is used to determine the type of I/O to be used on
 a per "spi_transfer" basis:
 
-if !enable_dma or dma_burst_size == 0 then
+if !enable_dma then
 	always use PIO transfers
 
+if spi_message.len > 8191 then
+	print "rate limited" warning
+	use PIO transfers
+
 if spi_message.is_dma_mapped and rx_dma_buf != 0 and tx_dma_buf != 0 then
 	use coherent DMA mode
 
diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 34c7c98..de610e0 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -47,6 +47,10 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 
 #define MAX_BUSES 3
 
+#define RX_THRESH_DFLT 	8
+#define TX_THRESH_DFLT 	8
+#define TIMOUT_DFLT		1000
+
 #define DMA_INT_MASK (DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR)
 #define RESET_DMA_CHANNEL (DCSR_NODESC | DMA_INT_MASK)
 #define IS_DMA_ALIGNED(x) (((u32)(x)&0x07)==0)
@@ -1105,6 +1109,8 @@ static int setup(struct spi_device *spi)
 	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
 	struct ssp_device *ssp = drv_data->ssp;
 	unsigned int clk_div;
+	uint tx_thres = TX_THRESH_DFLT;
+	uint rx_thres = RX_THRESH_DFLT;
 
 	if (!spi->bits_per_word)
 		spi->bits_per_word = 8;
@@ -1143,8 +1149,7 @@ static int setup(struct spi_device *spi)
 
 		chip->cs_control = null_cs_control;
 		chip->enable_dma = 0;
-		chip->timeout = 1000;
-		chip->threshold = SSCR1_RxTresh(1) | SSCR1_TxTresh(1);
+		chip->timeout = TIMOUT_DFLT;
 		chip->dma_burst_size = drv_data->master_info->enable_dma ?
 					DCMD_BURST8 : 0;
 	}
@@ -1159,21 +1164,22 @@ static int setup(struct spi_device *spi)
 		if (chip_info->cs_control)
 			chip->cs_control = chip_info->cs_control;
 
-		chip->timeout = chip_info->timeout;
-
-		chip->threshold = (SSCR1_RxTresh(chip_info->rx_threshold) &
-								SSCR1_RFT) |
-				(SSCR1_TxTresh(chip_info->tx_threshold) &
-								SSCR1_TFT);
-
-		chip->enable_dma = chip_info->dma_burst_size != 0
-					&& drv_data->master_info->enable_dma;
+		if (chip_info->timeout)
+			chip->timeout = chip_info->timeout;
+		if (chip_info->tx_threshold)
+			tx_thres = chip_info->tx_threshold;
+		if (chip_info->rx_threshold)
+			rx_thres = chip_info->rx_threshold;
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
@@ -1202,17 +1208,19 @@ static int setup(struct spi_device *spi)
 
 	/* NOTE:  PXA25x_SSP _could_ use external clocking ... */
 	if (drv_data->ssp_type != PXA25x_SSP)
-		dev_dbg(&spi->dev, "%d bits/word, %ld Hz, mode %d\n",
+		dev_dbg(&spi->dev, "%d bits/word, %ld Hz, mode %d, %s\n",
 				spi->bits_per_word,
 				clk_get_rate(ssp->clk)
 					/ (1 + ((chip->cr0 & SSCR0_SCR) >> 8)),
-				spi->mode & 0x3);
+				spi->mode & 0x3,
+				chip->enable_dma ? "DMA" : "PIO");
 	else
-		dev_dbg(&spi->dev, "%d bits/word, %ld Hz, mode %d\n",
+		dev_dbg(&spi->dev, "%d bits/word, %ld Hz, mode %d, %s\n",
 				spi->bits_per_word,
-				clk_get_rate(ssp->clk)
+				clk_get_rate(ssp->clk) / 2
 					/ (1 + ((chip->cr0 & SSCR0_SCR) >> 8)),
-				spi->mode & 0x3);
+				spi->mode & 0x3,
+				chip->enable_dma ? "DMA" : "PIO");
 
 	if (spi->bits_per_word <= 8) {
 		chip->n_bytes = 1;
@@ -1432,7 +1440,9 @@ static int __init pxa2xx_spi_probe(struct platform_device *pdev)
 
 	/* Load default SSP configuration */
 	write_SSCR0(0, drv_data->ioaddr);
-	write_SSCR1(SSCR1_RxTresh(4) | SSCR1_TxTresh(12), drv_data->ioaddr);
+	write_SSCR1(SSCR1_RxTresh(RX_THRESH_DFLT) |
+				SSCR1_TxTresh(TX_THRESH_DFLT),
+				drv_data->ioaddr);
 	write_SSCR0(SSCR0_SerClkDiv(2)
 			| SSCR0_Motorola
 			| SSCR0_DataSize(8),
-- 
1.5.2.4


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
