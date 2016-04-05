From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 2/7] spi: cadence: Remove _MASK and _OFFSET suffix
Date: Tue, 5 Apr 2016 23:37:49 +0530
Message-ID: <1459879674-13012-2-git-send-email-shubhraj@xilinx.com>
References: <1459879674-13012-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, <broonie@kernel.org>,
	Shubhrajyoti Datta <shubhraj@xilinx.com>
To: <linux-spi@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459879674-13012-1-git-send-email-shubhraj@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Remove the _MASK and _OFFSET from the macros.
It improves readability, removes some checkpatch
error for exceeding 80 chars  and also prevents some
linebreaks.

Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
---
 drivers/spi/spi-cadence.c |  161 +++++++++++++++++++++------------------------
 1 files changed, 74 insertions(+), 87 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 3acaac3..97a3bf6 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -25,17 +25,17 @@
 #define CDNS_SPI_NAME		"cdns-spi"
 
 /* Register offset definitions */
-#define CDNS_SPI_CR_OFFSET	0x00 /* Configuration  Register, RW */
-#define CDNS_SPI_ISR_OFFSET	0x04 /* Interrupt Status Register, RO */
-#define CDNS_SPI_IER_OFFSET	0x08 /* Interrupt Enable Register, WO */
-#define CDNS_SPI_IDR_OFFSET	0x0c /* Interrupt Disable Register, WO */
-#define CDNS_SPI_IMR_OFFSET	0x10 /* Interrupt Enabled Mask Register, RO */
-#define CDNS_SPI_ER_OFFSET	0x14 /* Enable/Disable Register, RW */
-#define CDNS_SPI_DR_OFFSET	0x18 /* Delay Register, RW */
-#define CDNS_SPI_TXD_OFFSET	0x1C /* Data Transmit Register, WO */
-#define CDNS_SPI_RXD_OFFSET	0x20 /* Data Receive Register, RO */
-#define CDNS_SPI_SICR_OFFSET	0x24 /* Slave Idle Count Register, RW */
-#define CDNS_SPI_THLD_OFFSET	0x28 /* Transmit FIFO Watermark Register,RW */
+#define CDNS_SPI_CR	0x00 /* Configuration  Register, RW */
+#define CDNS_SPI_ISR	0x04 /* Interrupt Status Register, RO */
+#define CDNS_SPI_IER	0x08 /* Interrupt Enable Register, WO */
+#define CDNS_SPI_IDR	0x0c /* Interrupt Disable Register, WO */
+#define CDNS_SPI_IMR	0x10 /* Interrupt Enabled Mask Register, RO */
+#define CDNS_SPI_ER	0x14 /* Enable/Disable Register, RW */
+#define CDNS_SPI_DR	0x18 /* Delay Register, RW */
+#define CDNS_SPI_TXD	0x1C /* Data Transmit Register, WO */
+#define CDNS_SPI_RXD	0x20 /* Data Receive Register, RO */
+#define CDNS_SPI_SICR	0x24 /* Slave Idle Count Register, RW */
+#define CDNS_SPI_THLD	0x28 /* Transmit FIFO Watermark Register,RW */
 
 /*
  * SPI Configuration Register bit Masks
@@ -43,20 +43,20 @@
  * This register contains various control bits that affect the operation
  * of the SPI controller
  */
-#define CDNS_SPI_CR_MANSTRT_MASK	0x00010000 /* Manual TX Start */
-#define CDNS_SPI_CR_CPHA_MASK		0x00000004 /* Clock Phase Control */
-#define CDNS_SPI_CR_CPOL_MASK		0x00000002 /* Clock Polarity Control */
-#define CDNS_SPI_CR_SSCTRL_MASK		0x00003C00 /* Slave Select Mask */
-#define CDNS_SPI_CR_PERI_SEL_MASK	0x00000200 /* Peripheral Select Decode */
-#define CDNS_SPI_CR_BAUD_DIV_MASK	0x00000038 /* Baud Rate Divisor Mask */
-#define CDNS_SPI_CR_MSTREN_MASK		0x00000001 /* Master Enable Mask */
-#define CDNS_SPI_CR_MANSTRTEN_MASK	0x00008000 /* Manual TX Enable Mask */
-#define CDNS_SPI_CR_SSFORCE_MASK	0x00004000 /* Manual SS Enable Mask */
-#define CDNS_SPI_CR_BAUD_DIV_4_MASK	0x00000008 /* Default Baud Div Mask */
-#define CDNS_SPI_CR_DEFAULT_MASK	(CDNS_SPI_CR_MSTREN_MASK | \
-					CDNS_SPI_CR_SSCTRL_MASK | \
-					CDNS_SPI_CR_SSFORCE_MASK | \
-					CDNS_SPI_CR_BAUD_DIV_4_MASK)
+#define CDNS_SPI_CR_MANSTRT	0x00010000 /* Manual TX Start */
+#define CDNS_SPI_CR_CPHA		0x00000004 /* Clock Phase Control */
+#define CDNS_SPI_CR_CPOL		0x00000002 /* Clock Polarity Control */
+#define CDNS_SPI_CR_SSCTRL		0x00003C00 /* Slave Select Mask */
+#define CDNS_SPI_CR_PERI_SEL	0x00000200 /* Peripheral Select Decode */
+#define CDNS_SPI_CR_BAUD_DIV	0x00000038 /* Baud Rate Divisor Mask */
+#define CDNS_SPI_CR_MSTREN		0x00000001 /* Master Enable Mask */
+#define CDNS_SPI_CR_MANSTRTEN	0x00008000 /* Manual TX Enable Mask */
+#define CDNS_SPI_CR_SSFORCE	0x00004000 /* Manual SS Enable Mask */
+#define CDNS_SPI_CR_BAUD_DIV_4	0x00000008 /* Default Baud Div Mask */
+#define CDNS_SPI_CR_DEFAULT	(CDNS_SPI_CR_MSTREN | \
+					CDNS_SPI_CR_SSCTRL | \
+					CDNS_SPI_CR_SSFORCE | \
+					CDNS_SPI_CR_BAUD_DIV_4)
 
 /*
  * SPI Configuration Register - Baud rate and slave select
@@ -77,21 +77,21 @@
  * All the four interrupt registers (Status/Mask/Enable/Disable) have the same
  * bit definitions.
  */
-#define CDNS_SPI_IXR_TXOW_MASK	0x00000004 /* SPI TX FIFO Overwater */
-#define CDNS_SPI_IXR_MODF_MASK	0x00000002 /* SPI Mode Fault */
-#define CDNS_SPI_IXR_RXNEMTY_MASK 0x00000010 /* SPI RX FIFO Not Empty */
-#define CDNS_SPI_IXR_DEFAULT_MASK	(CDNS_SPI_IXR_TXOW_MASK | \
-					CDNS_SPI_IXR_MODF_MASK)
-#define CDNS_SPI_IXR_TXFULL_MASK	0x00000008 /* SPI TX Full */
-#define CDNS_SPI_IXR_ALL_MASK	0x0000007F /* SPI all interrupts */
+#define CDNS_SPI_IXR_TXOW	0x00000004 /* SPI TX FIFO Overwater */
+#define CDNS_SPI_IXR_MODF	0x00000002 /* SPI Mode Fault */
+#define CDNS_SPI_IXR_RXNEMTY 0x00000010 /* SPI RX FIFO Not Empty */
+#define CDNS_SPI_IXR_DEFAULT	(CDNS_SPI_IXR_TXOW | \
+					CDNS_SPI_IXR_MODF)
+#define CDNS_SPI_IXR_TXFULL	0x00000008 /* SPI TX Full */
+#define CDNS_SPI_IXR_ALL	0x0000007F /* SPI all interrupts */
 
 /*
  * SPI Enable Register bit Masks
  *
  * This register is used to enable or disable the SPI controller
  */
-#define CDNS_SPI_ER_ENABLE_MASK	0x00000001 /* SPI Enable Bit Mask */
-#define CDNS_SPI_ER_DISABLE_MASK	0x0 /* SPI Disable Bit Mask */
+#define CDNS_SPI_ER_ENABLE	0x00000001 /* SPI Enable Bit Mask */
+#define CDNS_SPI_ER_DISABLE	0x0 /* SPI Disable Bit Mask */
 
 /* SPI FIFO depth in bytes */
 #define CDNS_SPI_FIFO_DEPTH	128
@@ -149,26 +149,21 @@ static inline void cdns_spi_write(struct cdns_spi *xspi, u32 offset, u32 val)
  */
 static void cdns_spi_init_hw(struct cdns_spi *xspi)
 {
-	u32 ctrl_reg = CDNS_SPI_CR_DEFAULT_MASK;
+	u32 ctrl_reg = CDNS_SPI_CR_DEFAULT;
 
 	if (xspi->is_decoded_cs)
-		ctrl_reg |= CDNS_SPI_CR_PERI_SEL_MASK;
+		ctrl_reg |= CDNS_SPI_CR_PERI_SEL;
 
-	cdns_spi_write(xspi, CDNS_SPI_ER_OFFSET,
-		       CDNS_SPI_ER_DISABLE_MASK);
-	cdns_spi_write(xspi, CDNS_SPI_IDR_OFFSET,
-		       CDNS_SPI_IXR_ALL_MASK);
+	cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
+	cdns_spi_write(xspi, CDNS_SPI_IDR, CDNS_SPI_IXR_ALL);
 
 	/* Clear the RX FIFO */
-	while (cdns_spi_read(xspi, CDNS_SPI_ISR_OFFSET) &
-	       CDNS_SPI_IXR_RXNEMTY_MASK)
-		cdns_spi_read(xspi, CDNS_SPI_RXD_OFFSET);
-
-	cdns_spi_write(xspi, CDNS_SPI_ISR_OFFSET,
-		       CDNS_SPI_IXR_ALL_MASK);
-	cdns_spi_write(xspi, CDNS_SPI_CR_OFFSET, ctrl_reg);
-	cdns_spi_write(xspi, CDNS_SPI_ER_OFFSET,
-		       CDNS_SPI_ER_ENABLE_MASK);
+	while (cdns_spi_read(xspi, CDNS_SPI_ISR) & CDNS_SPI_IXR_RXNEMTY)
+		cdns_spi_read(xspi, CDNS_SPI_RXD);
+
+	cdns_spi_write(xspi, CDNS_SPI_ISR, CDNS_SPI_IXR_ALL);
+	cdns_spi_write(xspi, CDNS_SPI_CR, ctrl_reg);
+	cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_ENABLE);
 }
 
 /**
@@ -181,24 +176,24 @@ static void cdns_spi_chipselect(struct spi_device *spi, bool is_high)
 	struct cdns_spi *xspi = spi_master_get_devdata(spi->master);
 	u32 ctrl_reg;
 
-	ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR_OFFSET);
+	ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
 
 	if (is_high) {
 		/* Deselect the slave */
-		ctrl_reg |= CDNS_SPI_CR_SSCTRL_MASK;
+		ctrl_reg |= CDNS_SPI_CR_SSCTRL;
 	} else {
 		/* Select the slave */
-		ctrl_reg &= ~CDNS_SPI_CR_SSCTRL_MASK;
+		ctrl_reg &= ~CDNS_SPI_CR_SSCTRL;
 		if (!(xspi->is_decoded_cs))
 			ctrl_reg |= ((~(CDNS_SPI_SS0 << spi->chip_select)) <<
 				     CDNS_SPI_SS_SHIFT) &
-				     CDNS_SPI_CR_SSCTRL_MASK;
+				     CDNS_SPI_CR_SSCTRL;
 		else
 			ctrl_reg |= (spi->chip_select << CDNS_SPI_SS_SHIFT) &
-				     CDNS_SPI_CR_SSCTRL_MASK;
+				     CDNS_SPI_CR_SSCTRL;
 	}
 
-	cdns_spi_write(xspi, CDNS_SPI_CR_OFFSET, ctrl_reg);
+	cdns_spi_write(xspi, CDNS_SPI_CR, ctrl_reg);
 }
 
 /**
@@ -212,14 +207,14 @@ static void cdns_spi_config_clock_mode(struct spi_device *spi)
 	struct cdns_spi *xspi = spi_master_get_devdata(spi->master);
 	u32 ctrl_reg, new_ctrl_reg;
 
-	new_ctrl_reg = ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR_OFFSET);
+	new_ctrl_reg = ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
 
 	/* Set the SPI clock phase and clock polarity */
-	new_ctrl_reg &= ~(CDNS_SPI_CR_CPHA_MASK | CDNS_SPI_CR_CPOL_MASK);
+	new_ctrl_reg &= ~(CDNS_SPI_CR_CPHA | CDNS_SPI_CR_CPOL);
 	if (spi->mode & SPI_CPHA)
-		new_ctrl_reg |= CDNS_SPI_CR_CPHA_MASK;
+		new_ctrl_reg |= CDNS_SPI_CR_CPHA;
 	if (spi->mode & SPI_CPOL)
-		new_ctrl_reg |= CDNS_SPI_CR_CPOL_MASK;
+		new_ctrl_reg |= CDNS_SPI_CR_CPOL;
 
 	if (new_ctrl_reg != ctrl_reg) {
 		/*
@@ -228,11 +223,9 @@ static void cdns_spi_config_clock_mode(struct spi_device *spi)
 		 * polarity as it will cause the SPI slave to see spurious clock
 		 * transitions. To workaround the issue toggle the ER register.
 		 */
-		cdns_spi_write(xspi, CDNS_SPI_ER_OFFSET,
-				   CDNS_SPI_ER_DISABLE_MASK);
-		cdns_spi_write(xspi, CDNS_SPI_CR_OFFSET, new_ctrl_reg);
-		cdns_spi_write(xspi, CDNS_SPI_ER_OFFSET,
-				   CDNS_SPI_ER_ENABLE_MASK);
+		cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
+		cdns_spi_write(xspi, CDNS_SPI_CR, new_ctrl_reg);
+		cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_ENABLE);
 	}
 }
 
@@ -259,7 +252,7 @@ static void cdns_spi_config_clock_freq(struct spi_device *spi,
 
 	frequency = clk_get_rate(xspi->ref_clk);
 
-	ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR_OFFSET);
+	ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
 
 	/* Set the clock frequency */
 	if (xspi->speed_hz != transfer->speed_hz) {
@@ -269,12 +262,12 @@ static void cdns_spi_config_clock_freq(struct spi_device *spi,
 		       (frequency / (2 << baud_rate_val)) > transfer->speed_hz)
 			baud_rate_val++;
 
-		ctrl_reg &= ~CDNS_SPI_CR_BAUD_DIV_MASK;
+		ctrl_reg &= ~CDNS_SPI_CR_BAUD_DIV;
 		ctrl_reg |= baud_rate_val << CDNS_SPI_BAUD_DIV_SHIFT;
 
 		xspi->speed_hz = frequency / (2 << baud_rate_val);
 	}
-	cdns_spi_write(xspi, CDNS_SPI_CR_OFFSET, ctrl_reg);
+	cdns_spi_write(xspi, CDNS_SPI_CR, ctrl_reg);
 }
 
 /**
@@ -313,10 +306,9 @@ static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi)
 	while ((trans_cnt < CDNS_SPI_FIFO_DEPTH) &&
 	       (xspi->tx_bytes > 0)) {
 		if (xspi->txbuf)
-			cdns_spi_write(xspi, CDNS_SPI_TXD_OFFSET,
-				       *xspi->txbuf++);
+			cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);
 		else
-			cdns_spi_write(xspi, CDNS_SPI_TXD_OFFSET, 0);
+			cdns_spi_write(xspi, CDNS_SPI_TXD, 0);
 
 		xspi->tx_bytes--;
 		trans_cnt++;
@@ -344,19 +336,18 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 	u32 intr_status, status;
 
 	status = IRQ_NONE;
-	intr_status = cdns_spi_read(xspi, CDNS_SPI_ISR_OFFSET);
-	cdns_spi_write(xspi, CDNS_SPI_ISR_OFFSET, intr_status);
+	intr_status = cdns_spi_read(xspi, CDNS_SPI_ISR);
+	cdns_spi_write(xspi, CDNS_SPI_ISR, intr_status);
 
-	if (intr_status & CDNS_SPI_IXR_MODF_MASK) {
+	if (intr_status & CDNS_SPI_IXR_MODF) {
 		/* Indicate that transfer is completed, the SPI subsystem will
 		 * identify the error as the remaining bytes to be
 		 * transferred is non-zero
 		 */
-		cdns_spi_write(xspi, CDNS_SPI_IDR_OFFSET,
-			       CDNS_SPI_IXR_DEFAULT_MASK);
+		cdns_spi_write(xspi, CDNS_SPI_IDR, CDNS_SPI_IXR_DEFAULT);
 		spi_finalize_current_transfer(master);
 		status = IRQ_HANDLED;
-	} else if (intr_status & CDNS_SPI_IXR_TXOW_MASK) {
+	} else if (intr_status & CDNS_SPI_IXR_TXOW) {
 		unsigned long trans_cnt;
 
 		trans_cnt = xspi->rx_bytes - xspi->tx_bytes;
@@ -365,7 +356,7 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 		while (trans_cnt) {
 			u8 data;
 
-			data = cdns_spi_read(xspi, CDNS_SPI_RXD_OFFSET);
+			data = cdns_spi_read(xspi, CDNS_SPI_RXD);
 			if (xspi->rxbuf)
 				*xspi->rxbuf++ = data;
 
@@ -378,8 +369,8 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 			cdns_spi_fill_tx_fifo(xspi);
 		} else {
 			/* Transfer is completed */
-			cdns_spi_write(xspi, CDNS_SPI_IDR_OFFSET,
-				       CDNS_SPI_IXR_DEFAULT_MASK);
+			cdns_spi_write(xspi, CDNS_SPI_IDR,
+				       CDNS_SPI_IXR_DEFAULT);
 			spi_finalize_current_transfer(master);
 		}
 		status = IRQ_HANDLED;
@@ -421,8 +412,7 @@ static int cdns_transfer_one(struct spi_master *master,
 
 	cdns_spi_fill_tx_fifo(xspi);
 
-	cdns_spi_write(xspi, CDNS_SPI_IER_OFFSET,
-		       CDNS_SPI_IXR_DEFAULT_MASK);
+	cdns_spi_write(xspi, CDNS_SPI_IER, CDNS_SPI_IXR_DEFAULT);
 	return transfer->len;
 }
 
@@ -439,8 +429,7 @@ static int cdns_prepare_transfer_hardware(struct spi_master *master)
 {
 	struct cdns_spi *xspi = spi_master_get_devdata(master);
 
-	cdns_spi_write(xspi, CDNS_SPI_ER_OFFSET,
-		       CDNS_SPI_ER_ENABLE_MASK);
+	cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_ENABLE);
 
 	return 0;
 }
@@ -458,8 +447,7 @@ static int cdns_unprepare_transfer_hardware(struct spi_master *master)
 {
 	struct cdns_spi *xspi = spi_master_get_devdata(master);
 
-	cdns_spi_write(xspi, CDNS_SPI_ER_OFFSET,
-		       CDNS_SPI_ER_DISABLE_MASK);
+	cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
 
 	return 0;
 }
@@ -595,8 +583,7 @@ static int cdns_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct cdns_spi *xspi = spi_master_get_devdata(master);
 
-	cdns_spi_write(xspi, CDNS_SPI_ER_OFFSET,
-		       CDNS_SPI_ER_DISABLE_MASK);
+	cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
 
 	clk_disable_unprepare(xspi->ref_clk);
 	clk_disable_unprepare(xspi->pclk);
-- 
1.7.1
