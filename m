From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] pxa2xx_spi: Fix chip_info defaults
	and documentation.
Date: Fri, 12 Sep 2008 09:26:35 -0700
Message-ID: <200809120926.35980.david-b@pacbell.net>
References: <20080909211842.59176caf@vsauder-lx.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080909211842.59176caf-W37fpRALFaH6NKmgiXY+hA0JkcsJGQge@public.gmane.org>
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

From: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Make the chip info structure data optional by providing reasonable
defaults.  Improve corresponding documentation, and highlight the
drawback of not providing explicit chipselect control.

DMA can determine appropriate dma_burst_size and thresholds
automatically so use DMA even if dma_burst_size is not specified.

Signed-off-by: Vernon Sauder <VernonInHand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
Not essential for 2.6.27 ...

 Documentation/spi/pxa2xx |   34 +++++++++++++++++++++++-----------
 drivers/spi/pxa2xx_spi.c |   44 +++++++++++++++++++++++++++-----------------
 2 files changed, 50 insertions(+), 28 deletions(-)

--- a/Documentation/spi/pxa2xx
+++ b/Documentation/spi/pxa2xx
@@ -96,7 +96,7 @@ Each slave device attached to the PXA mu
 information via the structure "pxa2xx_spi_chip" found in
 "arch/arm/mach-pxa/include/mach/pxa2xx_spi.h".  The pxa2xx_spi master controller driver
 will uses the configuration whenever the driver communicates with the slave
-device.
+device. All fields are optional.
 
 struct pxa2xx_spi_chip {
 	u8 tx_threshold;
@@ -112,14 +112,17 @@ used to configure the SSP hardware fifo.
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
@@ -137,7 +140,13 @@ function for asserting/deasserting a sla
 NULL, the pxa2xx_spi master controller driver assumes that the SSP port is
 configured to use SSPFRM instead.
 
-NSSP SALVE SAMPLE
+NOTE: the SPI driver cannot control the chip select if SSPFRM is used, so the
+chipselect is dropped after each spi_transfer.  Most devices need chip select
+asserted around the complete message.  Use SSPFRM as a GPIO (through cs_control)
+to accomodate these chips.
+
+
+NSSP SLAVE SAMPLE
 -----------------
 The pxa2xx_spi_chip structure is passed to the pxa2xx_spi driver in the
 "spi_board_info.controller_data" field. Below is a sample configuration using
@@ -206,18 +215,21 @@ static void __init streetracer_init(void
 
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
 
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -47,6 +47,10 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 
 #define MAX_BUSES 3
 
+#define RX_THRESH_DFLT 	8
+#define TX_THRESH_DFLT 	8
+#define TIMOUT_DFLT		1000
+
 #define DMA_INT_MASK		(DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR)
 #define RESET_DMA_CHANNEL	(DCSR_NODESC | DMA_INT_MASK)
 #define IS_DMA_ALIGNED(x)	(((x) & 0x07) == 0)
@@ -1171,6 +1175,8 @@ static int setup(struct spi_device *spi)
 	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
 	struct ssp_device *ssp = drv_data->ssp;
 	unsigned int clk_div;
+	uint tx_thres = TX_THRESH_DFLT;
+	uint rx_thres = RX_THRESH_DFLT;
 
 	if (!spi->bits_per_word)
 		spi->bits_per_word = 8;
@@ -1209,8 +1215,7 @@ static int setup(struct spi_device *spi)
 
 		chip->cs_control = null_cs_control;
 		chip->enable_dma = 0;
-		chip->timeout = 1000;
-		chip->threshold = SSCR1_RxTresh(1) | SSCR1_TxTresh(1);
+		chip->timeout = TIMOUT_DFLT;
 		chip->dma_burst_size = drv_data->master_info->enable_dma ?
 					DCMD_BURST8 : 0;
 	}
@@ -1225,21 +1230,22 @@ static int setup(struct spi_device *spi)
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
@@ -1268,17 +1274,19 @@ static int setup(struct spi_device *spi)
 
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
@@ -1498,7 +1506,9 @@ static int __init pxa2xx_spi_probe(struc
 
 	/* Load default SSP configuration */
 	write_SSCR0(0, drv_data->ioaddr);
-	write_SSCR1(SSCR1_RxTresh(4) | SSCR1_TxTresh(12), drv_data->ioaddr);
+	write_SSCR1(SSCR1_RxTresh(RX_THRESH_DFLT) |
+				SSCR1_TxTresh(TX_THRESH_DFLT),
+				drv_data->ioaddr);
 	write_SSCR0(SSCR0_SerClkDiv(2)
 			| SSCR0_Motorola
 			| SSCR0_DataSize(8),

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
