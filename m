From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3] spi: sirf: add support for USP-based SPI
Date: Tue, 19 May 2015 14:41:12 +0000
Message-ID: <1432046472-2954-1-git-send-email-21cnbao@gmail.com>
Cc: workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>

USP is a general purpose serial port in SiRFSoC, which can work as SPI.
the most data flow of USP and pure SPI is same with main differences
in registers layout.
this patch moves registers layout to private data, and use flags to
differentiate other minor differences between prima2-spi, prima2-usp
and atlas7-usp for hardware configuration.

Signed-off-by: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
---
 -v3: rebase againest spi tree

 Documentation/devicetree/bindings/spi/spi-sirf.txt |   3 +-
 drivers/spi/spi-sirf.c                             | 792 +++++++++++++++------
 2 files changed, 586 insertions(+), 209 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-sirf.txt b/Documentation/devicetree/bindings/spi/spi-sirf.txt
index 4c7adb8f..ddd78ff 100644
--- a/Documentation/devicetree/bindings/spi/spi-sirf.txt
+++ b/Documentation/devicetree/bindings/spi/spi-sirf.txt
@@ -1,7 +1,8 @@
 * CSR SiRFprimaII Serial Peripheral Interface
 
 Required properties:
-- compatible : Should be "sirf,prima2-spi"
+- compatible : Should be "sirf,prima2-spi", "sirf,prima2-usp"
+               or "sirf,atlas7-usp"
 - reg : Offset and length of the register set for the device
 - interrupts : Should contain SPI interrupt
 - resets: phandle to the reset controller asserting this device in
diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index ae4bd11..dd87ba6f 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -26,28 +26,6 @@
 #include <linux/reset.h>
 
 #define DRIVER_NAME "sirfsoc_spi"
-
-#define SIRFSOC_SPI_CTRL		0x0000
-#define SIRFSOC_SPI_CMD			0x0004
-#define SIRFSOC_SPI_TX_RX_EN		0x0008
-#define SIRFSOC_SPI_INT_EN		0x000C
-#define SIRFSOC_SPI_INT_STATUS		0x0010
-#define SIRFSOC_SPI_TX_DMA_IO_CTRL	0x0100
-#define SIRFSOC_SPI_TX_DMA_IO_LEN	0x0104
-#define SIRFSOC_SPI_TXFIFO_CTRL		0x0108
-#define SIRFSOC_SPI_TXFIFO_LEVEL_CHK	0x010C
-#define SIRFSOC_SPI_TXFIFO_OP		0x0110
-#define SIRFSOC_SPI_TXFIFO_STATUS	0x0114
-#define SIRFSOC_SPI_TXFIFO_DATA		0x0118
-#define SIRFSOC_SPI_RX_DMA_IO_CTRL	0x0120
-#define SIRFSOC_SPI_RX_DMA_IO_LEN	0x0124
-#define SIRFSOC_SPI_RXFIFO_CTRL		0x0128
-#define SIRFSOC_SPI_RXFIFO_LEVEL_CHK	0x012C
-#define SIRFSOC_SPI_RXFIFO_OP		0x0130
-#define SIRFSOC_SPI_RXFIFO_STATUS	0x0134
-#define SIRFSOC_SPI_RXFIFO_DATA		0x0138
-#define SIRFSOC_SPI_DUMMY_DELAY_CTL	0x0144
-
 /* SPI CTRL register defines */
 #define SIRFSOC_SPI_SLV_MODE		BIT(16)
 #define SIRFSOC_SPI_CMD_MODE		BIT(17)
@@ -80,8 +58,6 @@
 #define SIRFSOC_SPI_TXFIFO_THD_INT_EN	BIT(9)
 #define SIRFSOC_SPI_FRM_END_INT_EN	BIT(10)
 
-#define SIRFSOC_SPI_INT_MASK_ALL	0x1FFF
-
 /* Interrupt status */
 #define SIRFSOC_SPI_RX_DONE		BIT(0)
 #define SIRFSOC_SPI_TX_DONE		BIT(1)
@@ -110,20 +86,66 @@
 #define SIRFSOC_SPI_FIFO_WIDTH_BYTE	(0 << 0)
 #define SIRFSOC_SPI_FIFO_WIDTH_WORD	(1 << 0)
 #define SIRFSOC_SPI_FIFO_WIDTH_DWORD	(2 << 0)
-
-/* FIFO Status */
-#define	SIRFSOC_SPI_FIFO_LEVEL_MASK	0xFF
-#define SIRFSOC_SPI_FIFO_FULL		BIT(8)
-#define SIRFSOC_SPI_FIFO_EMPTY		BIT(9)
-
-/* 256 bytes rx/tx FIFO */
-#define SIRFSOC_SPI_FIFO_SIZE		256
-#define SIRFSOC_SPI_DAT_FRM_LEN_MAX	(64 * 1024)
-
-#define SIRFSOC_SPI_FIFO_SC(x)		((x) & 0x3F)
-#define SIRFSOC_SPI_FIFO_LC(x)		(((x) & 0x3F) << 10)
-#define SIRFSOC_SPI_FIFO_HC(x)		(((x) & 0x3F) << 20)
-#define SIRFSOC_SPI_FIFO_THD(x)		(((x) & 0xFF) << 2)
+/* USP related */
+#define SIRFSOC_USP_SYNC_MODE		BIT(0)
+#define SIRFSOC_USP_SLV_MODE		BIT(1)
+#define SIRFSOC_USP_LSB			BIT(4)
+#define SIRFSOC_USP_EN			BIT(5)
+#define SIRFSOC_USP_RXD_FALLING_EDGE	BIT(6)
+#define SIRFSOC_USP_TXD_FALLING_EDGE	BIT(7)
+#define SIRFSOC_USP_CS_HIGH_VALID	BIT(9)
+#define SIRFSOC_USP_SCLK_IDLE_STAT	BIT(11)
+#define SIRFSOC_USP_TFS_IO_MODE		BIT(14)
+#define SIRFSOC_USP_TFS_IO_INPUT	BIT(19)
+
+#define SIRFSOC_USP_RXD_DELAY_LEN_MASK	0xFF
+#define SIRFSOC_USP_TXD_DELAY_LEN_MASK	0xFF
+#define SIRFSOC_USP_RXD_DELAY_OFFSET	0
+#define SIRFSOC_USP_TXD_DELAY_OFFSET	8
+#define SIRFSOC_USP_RXD_DELAY_LEN	1
+#define SIRFSOC_USP_TXD_DELAY_LEN	1
+#define SIRFSOC_USP_CLK_DIVISOR_OFFSET	21
+#define SIRFSOC_USP_CLK_DIVISOR_MASK	0x3FF
+#define SIRFSOC_USP_CLK_10_11_MASK	0x3
+#define SIRFSOC_USP_CLK_10_11_OFFSET	30
+#define SIRFSOC_USP_CLK_12_15_MASK	0xF
+#define SIRFSOC_USP_CLK_12_15_OFFSET	24
+
+#define SIRFSOC_USP_TX_DATA_OFFSET	0
+#define SIRFSOC_USP_TX_SYNC_OFFSET	8
+#define SIRFSOC_USP_TX_FRAME_OFFSET	16
+#define SIRFSOC_USP_TX_SHIFTER_OFFSET	24
+
+#define SIRFSOC_USP_TX_DATA_MASK	0xFF
+#define SIRFSOC_USP_TX_SYNC_MASK	0xFF
+#define SIRFSOC_USP_TX_FRAME_MASK	0xFF
+#define SIRFSOC_USP_TX_SHIFTER_MASK	0x1F
+
+#define SIRFSOC_USP_RX_DATA_OFFSET	0
+#define SIRFSOC_USP_RX_FRAME_OFFSET	8
+#define SIRFSOC_USP_RX_SHIFTER_OFFSET	16
+
+#define SIRFSOC_USP_RX_DATA_MASK	0xFF
+#define SIRFSOC_USP_RX_FRAME_MASK	0xFF
+#define SIRFSOC_USP_RX_SHIFTER_MASK	0x1F
+#define SIRFSOC_USP_CS_HIGH_VALUE	BIT(1)
+
+#define SIRFSOC_SPI_FIFO_SC_OFFSET	0
+#define SIRFSOC_SPI_FIFO_LC_OFFSET	10
+#define SIRFSOC_SPI_FIFO_HC_OFFSET	20
+
+#define SIRFSOC_SPI_FIFO_FULL_MASK(s)	(1 << ((s)->fifo_full_offset))
+#define SIRFSOC_SPI_FIFO_EMPTY_MASK(s)	(1 << ((s)->fifo_full_offset + 1))
+#define SIRFSOC_SPI_FIFO_THD_MASK(s)	((s)->fifo_size - 1)
+#define SIRFSOC_SPI_FIFO_THD_OFFSET	2
+#define SIRFSOC_SPI_FIFO_LEVEL_CHK_MASK(s, val)	\
+	((val) & (s)->fifo_level_chk_mask)
+
+enum sirf_spi_type {
+	SIRF_REAL_SPI,
+	SIRF_USP_SPI_P2,
+	SIRF_USP_SPI_A7,
+};
 
 /*
  * only if the rx/tx buffer and transfer size are 4-bytes aligned, we use dma
@@ -137,6 +159,123 @@
 #define SIRFSOC_MAX_CMD_BYTES	4
 #define SIRFSOC_SPI_DEFAULT_FRQ 1000000
 
+struct sirf_spi_register {
+	/*SPI and USP-SPI common*/
+	u32 tx_rx_en;
+	u32 int_en;
+	u32 int_st;
+	u32 tx_dma_io_ctrl;
+	u32 tx_dma_io_len;
+	u32 txfifo_ctrl;
+	u32 txfifo_level_chk;
+	u32 txfifo_op;
+	u32 txfifo_st;
+	u32 txfifo_data;
+	u32 rx_dma_io_ctrl;
+	u32 rx_dma_io_len;
+	u32 rxfifo_ctrl;
+	u32 rxfifo_level_chk;
+	u32 rxfifo_op;
+	u32 rxfifo_st;
+	u32 rxfifo_data;
+	/*SPI self*/
+	u32 spi_ctrl;
+	u32 spi_cmd;
+	u32 spi_dummy_delay_ctrl;
+	/*USP-SPI self*/
+	u32 usp_mode1;
+	u32 usp_mode2;
+	u32 usp_tx_frame_ctrl;
+	u32 usp_rx_frame_ctrl;
+	u32 usp_pin_io_data;
+	u32 usp_risc_dsp_mode;
+	u32 usp_async_param_reg;
+	u32 usp_irda_x_mode_div;
+	u32 usp_sm_cfg;
+	u32 usp_int_en_clr;
+};
+
+static const struct sirf_spi_register real_spi_register = {
+	.tx_rx_en		= 0x8,
+	.int_en		= 0xc,
+	.int_st		= 0x10,
+	.tx_dma_io_ctrl	= 0x100,
+	.tx_dma_io_len	= 0x104,
+	.txfifo_ctrl	= 0x108,
+	.txfifo_level_chk	= 0x10c,
+	.txfifo_op		= 0x110,
+	.txfifo_st		= 0x114,
+	.txfifo_data	= 0x118,
+	.rx_dma_io_ctrl	= 0x120,
+	.rx_dma_io_len	= 0x124,
+	.rxfifo_ctrl	= 0x128,
+	.rxfifo_level_chk	= 0x12c,
+	.rxfifo_op		= 0x130,
+	.rxfifo_st		= 0x134,
+	.rxfifo_data	= 0x138,
+	.spi_ctrl		= 0x0,
+	.spi_cmd		= 0x4,
+	.spi_dummy_delay_ctrl	= 0x144,
+};
+
+static const struct sirf_spi_register usp_spi_register = {
+	.tx_rx_en		= 0x10,
+	.int_en		= 0x14,
+	.int_st		= 0x18,
+	.tx_dma_io_ctrl	= 0x100,
+	.tx_dma_io_len	= 0x104,
+	.txfifo_ctrl	= 0x108,
+	.txfifo_level_chk	= 0x10c,
+	.txfifo_op		= 0x110,
+	.txfifo_st		= 0x114,
+	.txfifo_data	= 0x118,
+	.rx_dma_io_ctrl	= 0x120,
+	.rx_dma_io_len	= 0x124,
+	.rxfifo_ctrl	= 0x128,
+	.rxfifo_level_chk	= 0x12c,
+	.rxfifo_op		= 0x130,
+	.rxfifo_st		= 0x134,
+	.rxfifo_data	= 0x138,
+	.usp_mode1		= 0x0,
+	.usp_mode2		= 0x4,
+	.usp_tx_frame_ctrl	= 0x8,
+	.usp_rx_frame_ctrl	= 0xc,
+	.usp_pin_io_data	= 0x1c,
+	.usp_risc_dsp_mode	= 0x20,
+	.usp_async_param_reg	= 0x24,
+	.usp_irda_x_mode_div	= 0x28,
+	.usp_sm_cfg		= 0x2c,
+	.usp_int_en_clr		= 0x140,
+};
+
+struct sirf_spi_comp_data {
+	const struct sirf_spi_register *regs;
+	enum sirf_spi_type type;
+	unsigned int dat_max_frm_len;
+	unsigned int fifo_size;
+};
+
+static const struct sirf_spi_comp_data sirf_real_spi = {
+	.regs = &real_spi_register,
+	.type = SIRF_REAL_SPI,
+	.dat_max_frm_len = 64 * 1024,
+	.fifo_size = 256,
+};
+
+static const struct sirf_spi_comp_data sirf_usp_spi_p2 = {
+	.regs = &usp_spi_register,
+	.type = SIRF_USP_SPI_P2,
+	.dat_max_frm_len = 1024 * 1024,
+	.fifo_size = 128,
+};
+
+static const struct sirf_spi_comp_data sirf_usp_spi_a7 = {
+	.regs = &usp_spi_register,
+	.type = SIRF_USP_SPI_A7,
+	.dat_max_frm_len = 1024 * 1024,
+	.fifo_size = 512,
+};
+
 struct sirfsoc_spi {
 	struct spi_bitbang bitbang;
 	struct completion rx_done;
@@ -173,6 +312,14 @@ struct sirfsoc_spi {
 	 */
 	bool	tx_by_cmd;
 	bool	hw_cs;
+	enum sirf_spi_type type;
+	const struct sirf_spi_register *regs;
+	unsigned int fifo_size;
+	/* fifo empty offset is (fifo full offset + 1)*/
+	unsigned int fifo_full_offset;
+	/* fifo_level_chk_mask is (fifo_size/4 - 1) */
+	unsigned int fifo_level_chk_mask;
+	unsigned int dat_max_frm_len;
 };
 
 static void spi_sirfsoc_rx_word_u8(struct sirfsoc_spi *sspi)
@@ -180,7 +327,7 @@ static void spi_sirfsoc_rx_word_u8(struct sirfsoc_spi *sspi)
 	u32 data;
 	u8 *rx = sspi->rx;
 
-	data = readl(sspi->base + SIRFSOC_SPI_RXFIFO_DATA);
+	data = readl(sspi->base + sspi->regs->rxfifo_data);
 
 	if (rx) {
 		*rx++ = (u8) data;
@@ -199,8 +346,7 @@ static void spi_sirfsoc_tx_word_u8(struct sirfsoc_spi *sspi)
 		data = *tx++;
 		sspi->tx = tx;
 	}
-
-	writel(data, sspi->base + SIRFSOC_SPI_TXFIFO_DATA);
+	writel(data, sspi->base + sspi->regs->txfifo_data);
 	sspi->left_tx_word--;
 }
 
@@ -209,7 +355,7 @@ static void spi_sirfsoc_rx_word_u16(struct sirfsoc_spi *sspi)
 	u32 data;
 	u16 *rx = sspi->rx;
 
-	data = readl(sspi->base + SIRFSOC_SPI_RXFIFO_DATA);
+	data = readl(sspi->base + sspi->regs->rxfifo_data);
 
 	if (rx) {
 		*rx++ = (u16) data;
@@ -229,7 +375,7 @@ static void spi_sirfsoc_tx_word_u16(struct sirfsoc_spi *sspi)
 		sspi->tx = tx;
 	}
 
-	writel(data, sspi->base + SIRFSOC_SPI_TXFIFO_DATA);
+	writel(data, sspi->base + sspi->regs->txfifo_data);
 	sspi->left_tx_word--;
 }
 
@@ -238,7 +384,7 @@ static void spi_sirfsoc_rx_word_u32(struct sirfsoc_spi *sspi)
 	u32 data;
 	u32 *rx = sspi->rx;
 
-	data = readl(sspi->base + SIRFSOC_SPI_RXFIFO_DATA);
+	data = readl(sspi->base + sspi->regs->rxfifo_data);
 
 	if (rx) {
 		*rx++ = (u32) data;
@@ -259,41 +405,59 @@ static void spi_sirfsoc_tx_word_u32(struct sirfsoc_spi *sspi)
 		sspi->tx = tx;
 	}
 
-	writel(data, sspi->base + SIRFSOC_SPI_TXFIFO_DATA);
+	writel(data, sspi->base + sspi->regs->txfifo_data);
 	sspi->left_tx_word--;
 }
 
 static irqreturn_t spi_sirfsoc_irq(int irq, void *dev_id)
 {
 	struct sirfsoc_spi *sspi = dev_id;
-	u32 spi_stat = readl(sspi->base + SIRFSOC_SPI_INT_STATUS);
-	if (sspi->tx_by_cmd && (spi_stat & SIRFSOC_SPI_FRM_END)) {
+	u32 spi_stat;
+
+	spi_stat = readl(sspi->base + sspi->regs->int_st);
+	if (sspi->tx_by_cmd && sspi->type == SIRF_REAL_SPI
+		&& (spi_stat & SIRFSOC_SPI_FRM_END)) {
 		complete(&sspi->tx_done);
-		writel(0x0, sspi->base + SIRFSOC_SPI_INT_EN);
-		writel(SIRFSOC_SPI_INT_MASK_ALL,
-				sspi->base + SIRFSOC_SPI_INT_STATUS);
+		writel(0x0, sspi->base + sspi->regs->int_en);
+		writel(readl(sspi->base + sspi->regs->int_st),
+				sspi->base + sspi->regs->int_st);
 		return IRQ_HANDLED;
 	}
-
 	/* Error Conditions */
 	if (spi_stat & SIRFSOC_SPI_RX_OFLOW ||
 			spi_stat & SIRFSOC_SPI_TX_UFLOW) {
 		complete(&sspi->tx_done);
 		complete(&sspi->rx_done);
-		writel(0x0, sspi->base + SIRFSOC_SPI_INT_EN);
-		writel(SIRFSOC_SPI_INT_MASK_ALL,
-				sspi->base + SIRFSOC_SPI_INT_STATUS);
+		switch (sspi->type) {
+		case SIRF_REAL_SPI:
+		case SIRF_USP_SPI_P2:
+			writel(0x0, sspi->base + sspi->regs->int_en);
+			break;
+		case SIRF_USP_SPI_A7:
+			writel(~0UL, sspi->base + sspi->regs->usp_int_en_clr);
+			break;
+		}
+		writel(readl(sspi->base + sspi->regs->int_st),
+				sspi->base + sspi->regs->int_st);
 		return IRQ_HANDLED;
 	}
 	if (spi_stat & SIRFSOC_SPI_TXFIFO_EMPTY)
 		complete(&sspi->tx_done);
-	while (!(readl(sspi->base + SIRFSOC_SPI_INT_STATUS) &
+	while (!(readl(sspi->base + sspi->regs->int_st) &
 		SIRFSOC_SPI_RX_IO_DMA))
 		cpu_relax();
 	complete(&sspi->rx_done);
-	writel(0x0, sspi->base + SIRFSOC_SPI_INT_EN);
-	writel(SIRFSOC_SPI_INT_MASK_ALL,
-			sspi->base + SIRFSOC_SPI_INT_STATUS);
+	switch (sspi->type) {
+	case SIRF_REAL_SPI:
+	case SIRF_USP_SPI_P2:
+		writel(0x0, sspi->base + sspi->regs->int_en);
+		break;
+	case SIRF_USP_SPI_A7:
+		writel(~0UL, sspi->base + sspi->regs->usp_int_en_clr);
+		break;
+	}
+	writel(readl(sspi->base + sspi->regs->int_st),
+			sspi->base + sspi->regs->int_st);
 
 	return IRQ_HANDLED;
 }
@@ -313,8 +477,8 @@ static void spi_sirfsoc_cmd_transfer(struct spi_device *spi,
 	u32 cmd;
 
 	sspi = spi_master_get_devdata(spi->master);
-	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
-	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
+	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + sspi->regs->txfifo_op);
+	writel(SIRFSOC_SPI_FIFO_START, sspi->base + sspi->regs->txfifo_op);
 	memcpy(&cmd, sspi->tx, t->len);
 	if (sspi->word_width == 1 && !(spi->mode & SPI_LSB_FIRST))
 		cmd = cpu_to_be32(cmd) >>
@@ -322,11 +486,11 @@ static void spi_sirfsoc_cmd_transfer(struct spi_device *spi,
 	if (sspi->word_width == 2 && t->len == 4 &&
 			(!(spi->mode & SPI_LSB_FIRST)))
 		cmd = ((cmd & 0xffff) << 16) | (cmd >> 16);
-	writel(cmd, sspi->base + SIRFSOC_SPI_CMD);
+	writel(cmd, sspi->base + sspi->regs->spi_cmd);
 	writel(SIRFSOC_SPI_FRM_END_INT_EN,
-		sspi->base + SIRFSOC_SPI_INT_EN);
+		sspi->base + sspi->regs->int_en);
 	writel(SIRFSOC_SPI_CMD_TX_EN,
-		sspi->base + SIRFSOC_SPI_TX_RX_EN);
+		sspi->base + sspi->regs->tx_rx_en);
 	if (wait_for_completion_timeout(&sspi->tx_done, timeout) == 0) {
 		dev_err(&spi->dev, "cmd transfer timeout\n");
 		return;
@@ -342,25 +506,56 @@ static void spi_sirfsoc_dma_transfer(struct spi_device *spi,
 	int timeout = t->len * 10;
 
 	sspi = spi_master_get_devdata(spi->master);
-	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
-	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
-	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
-	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
-	writel(0, sspi->base + SIRFSOC_SPI_INT_EN);
-	writel(SIRFSOC_SPI_INT_MASK_ALL, sspi->base + SIRFSOC_SPI_INT_STATUS);
-	if (sspi->left_tx_word < SIRFSOC_SPI_DAT_FRM_LEN_MAX) {
-		writel(readl(sspi->base + SIRFSOC_SPI_CTRL) |
-			SIRFSOC_SPI_ENA_AUTO_CLR | SIRFSOC_SPI_MUL_DAT_MODE,
-			sspi->base + SIRFSOC_SPI_CTRL);
-		writel(sspi->left_tx_word - 1,
-				sspi->base + SIRFSOC_SPI_TX_DMA_IO_LEN);
-		writel(sspi->left_tx_word - 1,
-				sspi->base + SIRFSOC_SPI_RX_DMA_IO_LEN);
+	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + sspi->regs->rxfifo_op);
+	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + sspi->regs->txfifo_op);
+	switch (sspi->type) {
+	case SIRF_REAL_SPI:
+		writel(SIRFSOC_SPI_FIFO_START,
+			sspi->base + sspi->regs->rxfifo_op);
+		writel(SIRFSOC_SPI_FIFO_START,
+			sspi->base + sspi->regs->txfifo_op);
+		writel(0, sspi->base + sspi->regs->int_en);
+		break;
+	case SIRF_USP_SPI_P2:
+		writel(0x0, sspi->base + sspi->regs->rxfifo_op);
+		writel(0x0, sspi->base + sspi->regs->txfifo_op);
+		writel(0, sspi->base + sspi->regs->int_en);
+		break;
+	case SIRF_USP_SPI_A7:
+		writel(0x0, sspi->base + sspi->regs->rxfifo_op);
+		writel(0x0, sspi->base + sspi->regs->txfifo_op);
+		writel(~0UL, sspi->base + sspi->regs->usp_int_en_clr);
+		break;
+	}
+	writel(readl(sspi->base + sspi->regs->int_st),
+		sspi->base + sspi->regs->int_st);
+	if (sspi->left_tx_word < sspi->dat_max_frm_len) {
+		switch (sspi->type) {
+		case SIRF_REAL_SPI:
+			writel(readl(sspi->base + sspi->regs->spi_ctrl) |
+				SIRFSOC_SPI_ENA_AUTO_CLR |
+				SIRFSOC_SPI_MUL_DAT_MODE,
+				sspi->base + sspi->regs->spi_ctrl);
+			writel(sspi->left_tx_word - 1,
+				sspi->base + sspi->regs->tx_dma_io_len);
+			writel(sspi->left_tx_word - 1,
+				sspi->base + sspi->regs->rx_dma_io_len);
+			break;
+		case SIRF_USP_SPI_P2:
+		case SIRF_USP_SPI_A7:
+			/*USP simulate SPI, tx/rx_dma_io_len indicates bytes*/
+			writel(sspi->left_tx_word * sspi->word_width,
+				sspi->base + sspi->regs->tx_dma_io_len);
+			writel(sspi->left_tx_word * sspi->word_width,
+				sspi->base + sspi->regs->rx_dma_io_len);
+			break;
+		}
 	} else {
-		writel(readl(sspi->base + SIRFSOC_SPI_CTRL),
-			sspi->base + SIRFSOC_SPI_CTRL);
-		writel(0, sspi->base + SIRFSOC_SPI_TX_DMA_IO_LEN);
-		writel(0, sspi->base + SIRFSOC_SPI_RX_DMA_IO_LEN);
+		if (sspi->type == SIRF_REAL_SPI)
+			writel(readl(sspi->base + sspi->regs->spi_ctrl),
+				sspi->base + sspi->regs->spi_ctrl);
+		writel(0, sspi->base + sspi->regs->tx_dma_io_len);
+		writel(0, sspi->base + sspi->regs->rx_dma_io_len);
 	}
 	sspi->dst_start = dma_map_single(&spi->dev, sspi->rx, t->len,
 					(t->tx_buf != t->rx_buf) ?
@@ -385,7 +580,14 @@ static void spi_sirfsoc_dma_transfer(struct spi_device *spi,
 	dma_async_issue_pending(sspi->tx_chan);
 	dma_async_issue_pending(sspi->rx_chan);
 	writel(SIRFSOC_SPI_RX_EN | SIRFSOC_SPI_TX_EN,
-			sspi->base + SIRFSOC_SPI_TX_RX_EN);
+			sspi->base + sspi->regs->tx_rx_en);
+	if (sspi->type == SIRF_USP_SPI_P2 ||
+		sspi->type == SIRF_USP_SPI_A7) {
+		writel(SIRFSOC_SPI_FIFO_START,
+			sspi->base + sspi->regs->rxfifo_op);
+		writel(SIRFSOC_SPI_FIFO_START,
+			sspi->base + sspi->regs->txfifo_op);
+	}
 	if (wait_for_completion_timeout(&sspi->rx_done, timeout) == 0) {
 		dev_err(&spi->dev, "transfer timeout\n");
 		dmaengine_terminate_all(sspi->rx_chan);
@@ -398,15 +600,21 @@ static void spi_sirfsoc_dma_transfer(struct spi_device *spi,
 	 */
 	if (wait_for_completion_timeout(&sspi->tx_done, timeout) == 0) {
 		dev_err(&spi->dev, "transfer timeout\n");
+		if (sspi->type == SIRF_USP_SPI_P2 ||
+			sspi->type == SIRF_USP_SPI_A7)
+			writel(0, sspi->base + sspi->regs->tx_rx_en);
 		dmaengine_terminate_all(sspi->tx_chan);
 	}
 	dma_unmap_single(&spi->dev, sspi->src_start, t->len, DMA_TO_DEVICE);
 	dma_unmap_single(&spi->dev, sspi->dst_start, t->len, DMA_FROM_DEVICE);
 	/* TX, RX FIFO stop */
-	writel(0, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
-	writel(0, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
-	if (sspi->left_tx_word >= SIRFSOC_SPI_DAT_FRM_LEN_MAX)
-		writel(0, sspi->base + SIRFSOC_SPI_TX_RX_EN);
+	writel(0, sspi->base + sspi->regs->rxfifo_op);
+	writel(0, sspi->base + sspi->regs->txfifo_op);
+	if (sspi->left_tx_word >= sspi->dat_max_frm_len)
+		writel(0, sspi->base + sspi->regs->tx_rx_en);
+	if (sspi->type == SIRF_USP_SPI_P2 ||
+		sspi->type == SIRF_USP_SPI_A7)
+		writel(0, sspi->base + sspi->regs->tx_rx_en);
 }
 
 static void spi_sirfsoc_pio_transfer(struct spi_device *spi,
@@ -414,55 +622,103 @@ static void spi_sirfsoc_pio_transfer(struct spi_device *spi,
 {
 	struct sirfsoc_spi *sspi;
 	int timeout = t->len * 10;
+	unsigned int data_units;
 
 	sspi = spi_master_get_devdata(spi->master);
 	do {
 		writel(SIRFSOC_SPI_FIFO_RESET,
-			sspi->base + SIRFSOC_SPI_RXFIFO_OP);
+			sspi->base + sspi->regs->rxfifo_op);
 		writel(SIRFSOC_SPI_FIFO_RESET,
-			sspi->base + SIRFSOC_SPI_TXFIFO_OP);
-		writel(SIRFSOC_SPI_FIFO_START,
-			sspi->base + SIRFSOC_SPI_RXFIFO_OP);
-		writel(SIRFSOC_SPI_FIFO_START,
-			sspi->base + SIRFSOC_SPI_TXFIFO_OP);
-		writel(0, sspi->base + SIRFSOC_SPI_INT_EN);
-		writel(SIRFSOC_SPI_INT_MASK_ALL,
-			sspi->base + SIRFSOC_SPI_INT_STATUS);
-		writel(readl(sspi->base + SIRFSOC_SPI_CTRL) |
-			SIRFSOC_SPI_MUL_DAT_MODE | SIRFSOC_SPI_ENA_AUTO_CLR,
-			sspi->base + SIRFSOC_SPI_CTRL);
-		writel(min(sspi->left_tx_word, (u32)(256 / sspi->word_width))
-				- 1, sspi->base + SIRFSOC_SPI_TX_DMA_IO_LEN);
-		writel(min(sspi->left_rx_word, (u32)(256 / sspi->word_width))
-				- 1, sspi->base + SIRFSOC_SPI_RX_DMA_IO_LEN);
-		while (!((readl(sspi->base + SIRFSOC_SPI_TXFIFO_STATUS)
-			& SIRFSOC_SPI_FIFO_FULL)) && sspi->left_tx_word)
+			sspi->base + sspi->regs->txfifo_op);
+		switch (sspi->type) {
+		case SIRF_USP_SPI_P2:
+			writel(0x0, sspi->base + sspi->regs->rxfifo_op);
+			writel(0x0, sspi->base + sspi->regs->txfifo_op);
+			writel(0, sspi->base + sspi->regs->int_en);
+			writel(readl(sspi->base + sspi->regs->int_st),
+				sspi->base + sspi->regs->int_st);
+			writel(min((sspi->left_tx_word * sspi->word_width),
+				sspi->fifo_size),
+				sspi->base + sspi->regs->tx_dma_io_len);
+			writel(min((sspi->left_rx_word * sspi->word_width),
+				sspi->fifo_size),
+				sspi->base + sspi->regs->rx_dma_io_len);
+			break;
+		case SIRF_USP_SPI_A7:
+			writel(0x0, sspi->base + sspi->regs->rxfifo_op);
+			writel(0x0, sspi->base + sspi->regs->txfifo_op);
+			writel(~0UL, sspi->base + sspi->regs->usp_int_en_clr);
+			writel(readl(sspi->base + sspi->regs->int_st),
+				sspi->base + sspi->regs->int_st);
+			writel(min((sspi->left_tx_word * sspi->word_width),
+				sspi->fifo_size),
+				sspi->base + sspi->regs->tx_dma_io_len);
+			writel(min((sspi->left_rx_word * sspi->word_width),
+				sspi->fifo_size),
+				sspi->base + sspi->regs->rx_dma_io_len);
+			break;
+		case SIRF_REAL_SPI:
+			writel(SIRFSOC_SPI_FIFO_START,
+				sspi->base + sspi->regs->rxfifo_op);
+			writel(SIRFSOC_SPI_FIFO_START,
+				sspi->base + sspi->regs->txfifo_op);
+			writel(0, sspi->base + sspi->regs->int_en);
+			writel(readl(sspi->base + sspi->regs->int_st),
+				sspi->base + sspi->regs->int_st);
+			writel(readl(sspi->base + sspi->regs->spi_ctrl) |
+				SIRFSOC_SPI_MUL_DAT_MODE |
+				SIRFSOC_SPI_ENA_AUTO_CLR,
+				sspi->base + sspi->regs->spi_ctrl);
+			data_units = sspi->fifo_size / sspi->word_width;
+			writel(min(sspi->left_tx_word, data_units) - 1,
+				sspi->base + sspi->regs->tx_dma_io_len);
+			writel(min(sspi->left_rx_word, data_units) - 1,
+				sspi->base + sspi->regs->rx_dma_io_len);
+			break;
+		}
+		while (!((readl(sspi->base + sspi->regs->txfifo_st)
+			& SIRFSOC_SPI_FIFO_FULL_MASK(sspi))) &&
+			sspi->left_tx_word)
 			sspi->tx_word(sspi);
 		writel(SIRFSOC_SPI_TXFIFO_EMPTY_INT_EN |
 			SIRFSOC_SPI_TX_UFLOW_INT_EN |
 			SIRFSOC_SPI_RX_OFLOW_INT_EN |
 			SIRFSOC_SPI_RX_IO_DMA_INT_EN,
-			sspi->base + SIRFSOC_SPI_INT_EN);
+			sspi->base + sspi->regs->int_en);
 		writel(SIRFSOC_SPI_RX_EN | SIRFSOC_SPI_TX_EN,
-			sspi->base + SIRFSOC_SPI_TX_RX_EN);
+			sspi->base + sspi->regs->tx_rx_en);
+		if (sspi->type == SIRF_USP_SPI_P2 ||
+			sspi->type == SIRF_USP_SPI_A7) {
+			writel(SIRFSOC_SPI_FIFO_START,
+				sspi->base + sspi->regs->rxfifo_op);
+			writel(SIRFSOC_SPI_FIFO_START,
+				sspi->base + sspi->regs->txfifo_op);
+		}
 		if (!wait_for_completion_timeout(&sspi->tx_done, timeout) ||
 			!wait_for_completion_timeout(&sspi->rx_done, timeout)) {
 			dev_err(&spi->dev, "transfer timeout\n");
+			if (sspi->type == SIRF_USP_SPI_P2 ||
+				sspi->type == SIRF_USP_SPI_A7)
+				writel(0, sspi->base + sspi->regs->tx_rx_en);
 			break;
 		}
-		while (!((readl(sspi->base + SIRFSOC_SPI_RXFIFO_STATUS)
-			& SIRFSOC_SPI_FIFO_EMPTY)) && sspi->left_rx_word)
+		while (!((readl(sspi->base + sspi->regs->rxfifo_st)
+			& SIRFSOC_SPI_FIFO_EMPTY_MASK(sspi))) &&
+			sspi->left_rx_word)
 			sspi->rx_word(sspi);
-		writel(0, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
-		writel(0, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
+		if (sspi->type == SIRF_USP_SPI_P2 ||
+			sspi->type == SIRF_USP_SPI_A7)
+			writel(0, sspi->base + sspi->regs->tx_rx_en);
+		writel(0, sspi->base + sspi->regs->rxfifo_op);
+		writel(0, sspi->base + sspi->regs->txfifo_op);
 	} while (sspi->left_tx_word != 0 || sspi->left_rx_word != 0);
 }
 
 static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct sirfsoc_spi *sspi;
-	sspi = spi_master_get_devdata(spi->master);
 
+	sspi = spi_master_get_devdata(spi->master);
 	sspi->tx = t->tx_buf ? t->tx_buf : sspi->dummypage;
 	sspi->rx = t->rx_buf ? t->rx_buf : sspi->dummypage;
 	sspi->left_tx_word = sspi->left_rx_word = t->len / sspi->word_width;
@@ -473,7 +729,7 @@ static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_transfer *t)
 	 * null, just fill command data into command register and wait for its
 	 * completion.
 	 */
-	if (sspi->tx_by_cmd)
+	if (sspi->type == SIRF_REAL_SPI && sspi->tx_by_cmd)
 		spi_sirfsoc_cmd_transfer(spi, t);
 	else if (IS_DMA_VALID(t))
 		spi_sirfsoc_dma_transfer(spi, t);
@@ -488,22 +744,49 @@ static void spi_sirfsoc_chipselect(struct spi_device *spi, int value)
 	struct sirfsoc_spi *sspi = spi_master_get_devdata(spi->master);
 
 	if (sspi->hw_cs) {
-		u32 regval = readl(sspi->base + SIRFSOC_SPI_CTRL);
-		switch (value) {
-		case BITBANG_CS_ACTIVE:
-			if (spi->mode & SPI_CS_HIGH)
-				regval |= SIRFSOC_SPI_CS_IO_OUT;
-			else
-				regval &= ~SIRFSOC_SPI_CS_IO_OUT;
+		u32 regval;
+
+		switch (sspi->type) {
+		case SIRF_REAL_SPI:
+			regval = readl(sspi->base + sspi->regs->spi_ctrl);
+			switch (value) {
+			case BITBANG_CS_ACTIVE:
+				if (spi->mode & SPI_CS_HIGH)
+					regval |= SIRFSOC_SPI_CS_IO_OUT;
+				else
+					regval &= ~SIRFSOC_SPI_CS_IO_OUT;
+				break;
+			case BITBANG_CS_INACTIVE:
+				if (spi->mode & SPI_CS_HIGH)
+					regval &= ~SIRFSOC_SPI_CS_IO_OUT;
+				else
+					regval |= SIRFSOC_SPI_CS_IO_OUT;
+				break;
+			}
+			writel(regval, sspi->base + sspi->regs->spi_ctrl);
 			break;
-		case BITBANG_CS_INACTIVE:
-			if (spi->mode & SPI_CS_HIGH)
-				regval &= ~SIRFSOC_SPI_CS_IO_OUT;
-			else
-				regval |= SIRFSOC_SPI_CS_IO_OUT;
+		case SIRF_USP_SPI_P2:
+		case SIRF_USP_SPI_A7:
+			regval = readl(sspi->base +
+					sspi->regs->usp_pin_io_data);
+			switch (value) {
+			case BITBANG_CS_ACTIVE:
+				if (spi->mode & SPI_CS_HIGH)
+					regval |= SIRFSOC_USP_CS_HIGH_VALUE;
+				else
+					regval &= ~(SIRFSOC_USP_CS_HIGH_VALUE);
+				break;
+			case BITBANG_CS_INACTIVE:
+				if (spi->mode & SPI_CS_HIGH)
+					regval &= ~(SIRFSOC_USP_CS_HIGH_VALUE);
+				else
+					regval |= SIRFSOC_USP_CS_HIGH_VALUE;
+				break;
+			}
+			writel(regval,
+				sspi->base + sspi->regs->usp_pin_io_data);
 			break;
 		}
-		writel(regval, sspi->base + SIRFSOC_SPI_CTRL);
 	} else {
 		switch (value) {
 		case BITBANG_CS_ACTIVE:
@@ -518,27 +801,102 @@ static void spi_sirfsoc_chipselect(struct spi_device *spi, int value)
 	}
 }
 
+static int spi_sirfsoc_config_mode(struct spi_device *spi)
+{
+	struct sirfsoc_spi *sspi;
+	u32 regval, usp_mode1;
+
+	sspi = spi_master_get_devdata(spi->master);
+	regval = readl(sspi->base + sspi->regs->spi_ctrl);
+	usp_mode1 = readl(sspi->base + sspi->regs->usp_mode1);
+	if (!(spi->mode & SPI_CS_HIGH)) {
+		regval |= SIRFSOC_SPI_CS_IDLE_STAT;
+		usp_mode1 &= ~SIRFSOC_USP_CS_HIGH_VALID;
+	} else {
+		regval &= ~SIRFSOC_SPI_CS_IDLE_STAT;
+		usp_mode1 |= SIRFSOC_USP_CS_HIGH_VALID;
+	}
+	if (!(spi->mode & SPI_LSB_FIRST)) {
+		regval |= SIRFSOC_SPI_TRAN_MSB;
+		usp_mode1 &= ~SIRFSOC_USP_LSB;
+	} else {
+		regval &= ~SIRFSOC_SPI_TRAN_MSB;
+		usp_mode1 |= SIRFSOC_USP_LSB;
+	}
+	if (spi->mode & SPI_CPOL) {
+		regval |= SIRFSOC_SPI_CLK_IDLE_STAT;
+		usp_mode1 |= SIRFSOC_USP_SCLK_IDLE_STAT;
+	} else {
+		regval &= ~SIRFSOC_SPI_CLK_IDLE_STAT;
+		usp_mode1 &= ~SIRFSOC_USP_SCLK_IDLE_STAT;
+	}
+	/*
+	 * Data should be driven at least 1/2 cycle before the fetch edge
+	 * to make sure that data gets stable at the fetch edge.
+	 */
+	if (((spi->mode & SPI_CPOL) && (spi->mode & SPI_CPHA)) ||
+	    (!(spi->mode & SPI_CPOL) && !(spi->mode & SPI_CPHA))) {
+		regval &= ~SIRFSOC_SPI_DRV_POS_EDGE;
+		usp_mode1 |= (SIRFSOC_USP_TXD_FALLING_EDGE |
+				SIRFSOC_USP_RXD_FALLING_EDGE);
+	} else {
+		regval |= SIRFSOC_SPI_DRV_POS_EDGE;
+		usp_mode1 &= ~(SIRFSOC_USP_RXD_FALLING_EDGE |
+				SIRFSOC_USP_TXD_FALLING_EDGE);
+	}
+	writel((SIRFSOC_SPI_FIFO_LEVEL_CHK_MASK(sspi, sspi->fifo_size - 2) <<
+		SIRFSOC_SPI_FIFO_SC_OFFSET) |
+		(SIRFSOC_SPI_FIFO_LEVEL_CHK_MASK(sspi, sspi->fifo_size / 2) <<
+		SIRFSOC_SPI_FIFO_LC_OFFSET) |
+		(SIRFSOC_SPI_FIFO_LEVEL_CHK_MASK(sspi, 2) <<
+		SIRFSOC_SPI_FIFO_HC_OFFSET),
+		sspi->base + sspi->regs->txfifo_level_chk);
+	writel((SIRFSOC_SPI_FIFO_LEVEL_CHK_MASK(sspi, 2) <<
+		SIRFSOC_SPI_FIFO_SC_OFFSET) |
+		(SIRFSOC_SPI_FIFO_LEVEL_CHK_MASK(sspi, sspi->fifo_size / 2) <<
+		SIRFSOC_SPI_FIFO_LC_OFFSET) |
+		(SIRFSOC_SPI_FIFO_LEVEL_CHK_MASK(sspi, sspi->fifo_size - 2) <<
+		SIRFSOC_SPI_FIFO_HC_OFFSET),
+		sspi->base + sspi->regs->rxfifo_level_chk);
+	/*
+	 * it should never set to hardware cs mode because in hardware cs mode,
+	 * cs signal can't controlled by driver.
+	 */
+	switch (sspi->type) {
+	case SIRF_REAL_SPI:
+		regval |= SIRFSOC_SPI_CS_IO_MODE;
+		writel(regval, sspi->base + sspi->regs->spi_ctrl);
+		break;
+	case SIRF_USP_SPI_P2:
+	case SIRF_USP_SPI_A7:
+		usp_mode1 |= SIRFSOC_USP_SYNC_MODE;
+		usp_mode1 |= SIRFSOC_USP_TFS_IO_MODE;
+		usp_mode1 &= ~SIRFSOC_USP_TFS_IO_INPUT;
+		writel(usp_mode1, sspi->base + sspi->regs->usp_mode1);
+		break;
+	}
+
+	return 0;
+}
+
 static int
 spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct sirfsoc_spi *sspi;
 	u8 bits_per_word = 0;
 	int hz = 0;
-	u32 regval;
-	u32 txfifo_ctrl, rxfifo_ctrl;
-	u32 fifo_size = SIRFSOC_SPI_FIFO_SIZE / 4;
+	u32 regval, txfifo_ctrl, rxfifo_ctrl, tx_frm_ctl, rx_frm_ctl, usp_mode2;
 
 	sspi = spi_master_get_devdata(spi->master);
 
 	bits_per_word = (t) ? t->bits_per_word : spi->bits_per_word;
 	hz = t && t->speed_hz ? t->speed_hz : spi->max_speed_hz;
 
-	regval = (sspi->ctrl_freq / (2 * hz)) - 1;
+	usp_mode2 = regval = (sspi->ctrl_freq / (2 * hz)) - 1;
 	if (regval > 0xFFFF || regval < 0) {
 		dev_err(&spi->dev, "Speed %d not supported\n", hz);
 		return -EINVAL;
 	}
-
 	switch (bits_per_word) {
 	case 8:
 		regval |= SIRFSOC_SPI_TRAN_DAT_FORMAT_8;
@@ -562,69 +920,87 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 		dev_err(&spi->dev, "bpw %d not supported\n", bits_per_word);
 		return -EINVAL;
 	}
-
 	sspi->word_width = DIV_ROUND_UP(bits_per_word, 8);
-	txfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE / 2) |
-					   (sspi->word_width >> 1);
-	rxfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE / 2) |
-					   (sspi->word_width >> 1);
-
-	if (!(spi->mode & SPI_CS_HIGH))
-		regval |= SIRFSOC_SPI_CS_IDLE_STAT;
-	if (!(spi->mode & SPI_LSB_FIRST))
-		regval |= SIRFSOC_SPI_TRAN_MSB;
-	if (spi->mode & SPI_CPOL)
-		regval |= SIRFSOC_SPI_CLK_IDLE_STAT;
-
-	/*
-	 * Data should be driven at least 1/2 cycle before the fetch edge
-	 * to make sure that data gets stable at the fetch edge.
-	 */
-	if (((spi->mode & SPI_CPOL) && (spi->mode & SPI_CPHA)) ||
-	    (!(spi->mode & SPI_CPOL) && !(spi->mode & SPI_CPHA)))
-		regval &= ~SIRFSOC_SPI_DRV_POS_EDGE;
-	else
-		regval |= SIRFSOC_SPI_DRV_POS_EDGE;
-
-	writel(SIRFSOC_SPI_FIFO_SC(fifo_size - 2) |
-			SIRFSOC_SPI_FIFO_LC(fifo_size / 2) |
-			SIRFSOC_SPI_FIFO_HC(2),
-		sspi->base + SIRFSOC_SPI_TXFIFO_LEVEL_CHK);
-	writel(SIRFSOC_SPI_FIFO_SC(2) |
-			SIRFSOC_SPI_FIFO_LC(fifo_size / 2) |
-			SIRFSOC_SPI_FIFO_HC(fifo_size - 2),
-		sspi->base + SIRFSOC_SPI_RXFIFO_LEVEL_CHK);
-	writel(txfifo_ctrl, sspi->base + SIRFSOC_SPI_TXFIFO_CTRL);
-	writel(rxfifo_ctrl, sspi->base + SIRFSOC_SPI_RXFIFO_CTRL);
-
-	if (t && t->tx_buf && !t->rx_buf && (t->len <= SIRFSOC_MAX_CMD_BYTES)) {
-		regval |= (SIRFSOC_SPI_CMD_BYTE_NUM((t->len - 1)) |
-				SIRFSOC_SPI_CMD_MODE);
-		sspi->tx_by_cmd = true;
-	} else {
-		regval &= ~SIRFSOC_SPI_CMD_MODE;
-		sspi->tx_by_cmd = false;
+	txfifo_ctrl = (((sspi->fifo_size / 2) &
+			SIRFSOC_SPI_FIFO_THD_MASK(sspi))
+			<< SIRFSOC_SPI_FIFO_THD_OFFSET) |
+			(sspi->word_width >> 1);
+	rxfifo_ctrl = (((sspi->fifo_size / 2) &
+			SIRFSOC_SPI_FIFO_THD_MASK(sspi))
+			<< SIRFSOC_SPI_FIFO_THD_OFFSET) |
+			(sspi->word_width >> 1);
+	writel(txfifo_ctrl, sspi->base + sspi->regs->txfifo_ctrl);
+	writel(rxfifo_ctrl, sspi->base + sspi->regs->rxfifo_ctrl);
+	if (sspi->type == SIRF_USP_SPI_P2 ||
+		sspi->type == SIRF_USP_SPI_A7) {
+		tx_frm_ctl = 0;
+		tx_frm_ctl |= ((bits_per_word - 1) & SIRFSOC_USP_TX_DATA_MASK)
+				<< SIRFSOC_USP_TX_DATA_OFFSET;
+		tx_frm_ctl |= ((bits_per_word + 1 + SIRFSOC_USP_TXD_DELAY_LEN
+				- 1) & SIRFSOC_USP_TX_SYNC_MASK) <<
+				SIRFSOC_USP_TX_SYNC_OFFSET;
+		tx_frm_ctl |= ((bits_per_word + 1 + SIRFSOC_USP_TXD_DELAY_LEN
+				+ 2 - 1) & SIRFSOC_USP_TX_FRAME_MASK) <<
+				SIRFSOC_USP_TX_FRAME_OFFSET;
+		tx_frm_ctl |= ((bits_per_word - 1) &
+				SIRFSOC_USP_TX_SHIFTER_MASK) <<
+				SIRFSOC_USP_TX_SHIFTER_OFFSET;
+		rx_frm_ctl = 0;
+		rx_frm_ctl |= ((bits_per_word - 1) & SIRFSOC_USP_RX_DATA_MASK)
+				<< SIRFSOC_USP_RX_DATA_OFFSET;
+		rx_frm_ctl |= ((bits_per_word + 1 + SIRFSOC_USP_RXD_DELAY_LEN
+				+ 2 - 1) & SIRFSOC_USP_RX_FRAME_MASK) <<
+				SIRFSOC_USP_RX_FRAME_OFFSET;
+		rx_frm_ctl |= ((bits_per_word - 1)
+				& SIRFSOC_USP_RX_SHIFTER_MASK) <<
+				SIRFSOC_USP_RX_SHIFTER_OFFSET;
+		writel(tx_frm_ctl | (((usp_mode2 >> 10) &
+			SIRFSOC_USP_CLK_10_11_MASK) <<
+			SIRFSOC_USP_CLK_10_11_OFFSET),
+			sspi->base + sspi->regs->usp_tx_frame_ctrl);
+		writel(rx_frm_ctl | (((usp_mode2 >> 12) &
+			SIRFSOC_USP_CLK_12_15_MASK) <<
+			SIRFSOC_USP_CLK_12_15_OFFSET),
+			sspi->base + sspi->regs->usp_rx_frame_ctrl);
+		writel(readl(sspi->base + sspi->regs->usp_mode2) |
+			((usp_mode2 & SIRFSOC_USP_CLK_DIVISOR_MASK) <<
+			SIRFSOC_USP_CLK_DIVISOR_OFFSET) |
+			(SIRFSOC_USP_RXD_DELAY_LEN <<
+			 SIRFSOC_USP_RXD_DELAY_OFFSET) |
+			(SIRFSOC_USP_TXD_DELAY_LEN <<
+			 SIRFSOC_USP_TXD_DELAY_OFFSET),
+			sspi->base + sspi->regs->usp_mode2);
+	}
+	if (sspi->type == SIRF_REAL_SPI)
+		writel(regval, sspi->base + sspi->regs->spi_ctrl);
+	spi_sirfsoc_config_mode(spi);
+	if (sspi->type == SIRF_REAL_SPI) {
+		if (t && t->tx_buf && !t->rx_buf &&
+			(t->len <= SIRFSOC_MAX_CMD_BYTES)) {
+			sspi->tx_by_cmd = true;
+			writel(readl(sspi->base + sspi->regs->spi_ctrl) |
+				(SIRFSOC_SPI_CMD_BYTE_NUM((t->len - 1)) |
+				SIRFSOC_SPI_CMD_MODE),
+				sspi->base + sspi->regs->spi_ctrl);
+		} else {
+			sspi->tx_by_cmd = false;
+			writel(readl(sspi->base + sspi->regs->spi_ctrl) &
+				~SIRFSOC_SPI_CMD_MODE,
+				sspi->base + sspi->regs->spi_ctrl);
+		}
 	}
-	/*
-	 * it should never set to hardware cs mode because in hardware cs mode,
-	 * cs signal can't controlled by driver.
-	 */
-	regval |= SIRFSOC_SPI_CS_IO_MODE;
-	writel(regval, sspi->base + SIRFSOC_SPI_CTRL);
-
 	if (IS_DMA_VALID(t)) {
 		/* Enable DMA mode for RX, TX */
-		writel(0, sspi->base + SIRFSOC_SPI_TX_DMA_IO_CTRL);
+		writel(0, sspi->base + sspi->regs->tx_dma_io_ctrl);
 		writel(SIRFSOC_SPI_RX_DMA_FLUSH,
-			sspi->base + SIRFSOC_SPI_RX_DMA_IO_CTRL);
+			sspi->base + sspi->regs->rx_dma_io_ctrl);
 	} else {
 		/* Enable IO mode for RX, TX */
 		writel(SIRFSOC_SPI_IO_MODE_SEL,
-			sspi->base + SIRFSOC_SPI_TX_DMA_IO_CTRL);
+			sspi->base + sspi->regs->tx_dma_io_ctrl);
 		writel(SIRFSOC_SPI_IO_MODE_SEL,
-			sspi->base + SIRFSOC_SPI_RX_DMA_IO_CTRL);
+			sspi->base + sspi->regs->rx_dma_io_ctrl);
 	}
-
 	return 0;
 }
 
@@ -634,7 +1010,6 @@ static int spi_sirfsoc_setup(struct spi_device *spi)
 	int ret = 0;
 
 	sspi = spi_master_get_devdata(spi->master);
-
 	if (spi->cs_gpio == -ENOENT)
 		sspi->hw_cs = true;
 	else {
@@ -659,8 +1034,7 @@ static int spi_sirfsoc_setup(struct spi_device *spi)
 			spi_set_ctldata(spi, cs);
 		}
 	}
-	writel(readl(sspi->base + SIRFSOC_SPI_CTRL) | SIRFSOC_SPI_CS_IO_MODE,
-			sspi->base + SIRFSOC_SPI_CTRL);
+	spi_sirfsoc_config_mode(spi);
 	spi_sirfsoc_chipselect(spi, BITBANG_CS_INACTIVE);
 exit:
 	return ret;
@@ -674,13 +1048,23 @@ static void spi_sirfsoc_cleanup(struct spi_device *spi)
 	}
 }
 
+static const struct of_device_id spi_sirfsoc_of_match[] = {
+	{ .compatible = "sirf,prima2-spi", .data = &sirf_real_spi},
+	{ .compatible = "sirf,prima2-usp-spi", .data = &sirf_usp_spi_p2},
+	{ .compatible = "sirf,atlas7-usp-spi", .data = &sirf_usp_spi_a7},
+	{}
+};
+MODULE_DEVICE_TABLE(of, spi_sirfsoc_of_match);
+
 static int spi_sirfsoc_probe(struct platform_device *pdev)
 {
 	struct sirfsoc_spi *sspi;
 	struct spi_master *master;
 	struct resource *mem_res;
+	struct sirf_spi_comp_data *spi_comp_data;
 	int irq;
 	int ret;
+	const struct of_device_id *match;
 
 	ret = device_reset(&pdev->dev);
 	if (ret) {
@@ -693,16 +1077,22 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Unable to allocate SPI master\n");
 		return -ENOMEM;
 	}
+	match = of_match_node(spi_sirfsoc_of_match, pdev->dev.of_node);
 	platform_set_drvdata(pdev, master);
 	sspi = spi_master_get_devdata(master);
-
+	sspi->fifo_full_offset = ilog2(sspi->fifo_size);
+	spi_comp_data = (struct sirf_spi_comp_data *)match->data;
+	sspi->regs = spi_comp_data->regs;
+	sspi->type = spi_comp_data->type;
+	sspi->fifo_level_chk_mask = (sspi->fifo_size / 4) - 1;
+	sspi->dat_max_frm_len = spi_comp_data->dat_max_frm_len;
+	sspi->fifo_size = spi_comp_data->fifo_size;
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sspi->base = devm_ioremap_resource(&pdev->dev, mem_res);
 	if (IS_ERR(sspi->base)) {
 		ret = PTR_ERR(sspi->base);
 		goto free_master;
 	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = -ENXIO;
@@ -751,13 +1141,6 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	init_completion(&sspi->rx_done);
 	init_completion(&sspi->tx_done);
 
-	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
-	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
-	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
-	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
-	/* We are not using dummy delay between command and data */
-	writel(0, sspi->base + SIRFSOC_SPI_DUMMY_DELAY_CTL);
-
 	sspi->dummypage = devm_kzalloc(&pdev->dev, 2 * PAGE_SIZE, GFP_KERNEL);
 	if (!sspi->dummypage) {
 		ret = -ENOMEM;
@@ -790,7 +1173,6 @@ static int  spi_sirfsoc_remove(struct platform_device *pdev)
 
 	master = platform_get_drvdata(pdev);
 	sspi = spi_master_get_devdata(master);
-
 	spi_bitbang_stop(&sspi->bitbang);
 	clk_disable_unprepare(sspi->clk);
 	clk_put(sspi->clk);
@@ -821,24 +1203,17 @@ static int spi_sirfsoc_resume(struct device *dev)
 	struct sirfsoc_spi *sspi = spi_master_get_devdata(master);
 
 	clk_enable(sspi->clk);
-	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
-	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
-	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
-	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
-
-	return spi_master_resume(master);
+	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + sspi->regs->txfifo_op);
+	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + sspi->regs->rxfifo_op);
+	writel(SIRFSOC_SPI_FIFO_START, sspi->base + sspi->regs->txfifo_op);
+	writel(SIRFSOC_SPI_FIFO_START, sspi->base + sspi->regs->rxfifo_op);
+	return 0;
 }
 #endif
 
 static SIMPLE_DEV_PM_OPS(spi_sirfsoc_pm_ops, spi_sirfsoc_suspend,
 			 spi_sirfsoc_resume);
 
-static const struct of_device_id spi_sirfsoc_of_match[] = {
-	{ .compatible = "sirf,prima2-spi", },
-	{}
-};
-MODULE_DEVICE_TABLE(of, spi_sirfsoc_of_match);
-
 static struct platform_driver spi_sirfsoc_driver = {
 	.driver = {
 		.name = DRIVER_NAME,
@@ -852,4 +1227,5 @@ module_platform_driver(spi_sirfsoc_driver);
 MODULE_DESCRIPTION("SiRF SoC SPI master driver");
 MODULE_AUTHOR("Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>");
 MODULE_AUTHOR("Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>");
+MODULE_AUTHOR("Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
