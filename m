From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 1/2] spi: imx: dynamic burst length adjust for PIO mode
Date: Wed, 8 Feb 2017 15:20:27 +0900
Message-ID: <20170208062028.22313-2-jiada_wang@mentor.com>
References: <20170208062028.22313-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <fixed-term.Oleksij.Rempel@de.bosch.com>, <jiada_wang@mentor.com>
To: <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170208062028.22313-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

previously burst length (BURST_LENGTH) is always set to equal
to bits_per_word, causes a 10us gap between each word in
transfer, which significantly affects performance.

This patch uses 32 bits transfer to simulate lower bits transfer,
and adjusts burst length runtimely to use biggeest burst length
as possible to reduce the gaps in transfer for PIO mode.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/spi/spi-imx.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 143 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 9a7c62f..04b4ea8 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -56,9 +56,11 @@
 
 /* The maximum  bytes that a sdma BD can transfer.*/
 #define MAX_SDMA_BD_BYTES  (1 << 15)
+#define MX51_ECSPI_CTRL_MAX_BURST	512
 struct spi_imx_config {
 	unsigned int speed_hz;
 	unsigned int bpw;
+	unsigned int len;
 };
 
 enum spi_imx_devtype {
@@ -96,12 +98,14 @@ struct spi_imx_data {
 
 	unsigned int bytes_per_word;
 
-	unsigned int count;
+	unsigned int count, count_index;
 	void (*tx)(struct spi_imx_data *);
 	void (*rx)(struct spi_imx_data *);
 	void *rx_buf;
 	const void *tx_buf;
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
+	unsigned int dynamic_burst, bpw_rx;
+	unsigned int bpw_w;
 
 	/* DMA */
 	bool usedma;
@@ -250,6 +254,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_CTRL_PREDIV_OFFSET	12
 #define MX51_ECSPI_CTRL_CS(cs)		((cs) << 18)
 #define MX51_ECSPI_CTRL_BL_OFFSET	20
+#define MX51_ECSPI_CTRL_BL_MASK		(0xfff << 20)
 
 #define MX51_ECSPI_CONFIG	0x0c
 #define MX51_ECSPI_CONFIG_SCLKPHA(cs)	(1 << ((cs) +  0))
@@ -277,6 +282,79 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_TESTREG	0x20
 #define MX51_ECSPI_TESTREG_LBC	BIT(31)
 
+static void spi_imx_u32_swap_u8(struct spi_transfer *transfer, u8 *buf)
+{
+	int i;
+
+	for (i = 0; i < transfer->len / 4; i++) {
+		u8 temp;
+
+		temp = *(buf + i * 4);
+		*(buf + i * 4) = *(buf + i * 4 + 3);
+		*(buf + i * 4 + 3) = temp;
+
+		temp = *(buf + i * 4 + 1);
+		*(u8 *)(buf + i * 4 + 1) = *(buf + i * 4 + 2);
+		*(buf + i * 4 + 2) = temp;
+	}
+}
+
+static void spi_imx_u32_swap_u16(struct spi_transfer *transfer, u16 *buf)
+{
+	int i;
+
+	for (i = 0; i < transfer->len / 4; i++) {
+		u16 temp;
+
+		temp = *(buf + i * 2);
+		*(buf + i * 2) = *(buf + i * 2 + 1);
+		*(buf + i * 2 + 1) = temp;
+	}
+}
+
+static void spi_imx_buf_rx_swap(struct spi_imx_data *spi_imx)
+{
+	if (!spi_imx->bpw_rx) {
+		spi_imx_buf_rx_u32(spi_imx);
+		return;
+	}
+
+	if (spi_imx->bpw_w == 1)
+		spi_imx_buf_rx_u8(spi_imx);
+	else if (spi_imx->bpw_w == 2)
+		spi_imx_buf_rx_u16(spi_imx);
+}
+
+static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
+{
+	u32 ctrl, val;
+
+	if (spi_imx->count == spi_imx->count_index) {
+		spi_imx->count_index = spi_imx->count > sizeof(u32) ?
+					spi_imx->count % sizeof(u32) : 0;
+		ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
+		ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
+		if (spi_imx->count >= sizeof(u32))
+			val = spi_imx->count - spi_imx->count_index;
+		else {
+			val = spi_imx->bpw_w;
+			spi_imx->bpw_rx = 1;
+		}
+		ctrl |= ((val * 8 - 1) << MX51_ECSPI_CTRL_BL_OFFSET);
+		writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
+	}
+
+	if (spi_imx->count >= sizeof(u32)) {
+		spi_imx_buf_tx_u32(spi_imx);
+		return;
+	}
+
+	if (spi_imx->bpw_w == 1)
+		spi_imx_buf_tx_u8(spi_imx);
+	else if (spi_imx->bpw_w == 2)
+		spi_imx_buf_tx_u16(spi_imx);
+}
+
 /* MX51 eCSPI */
 static unsigned int mx51_ecspi_clkdiv(struct spi_imx_data *spi_imx,
 				      unsigned int fspi, unsigned int *fres)
@@ -362,7 +440,14 @@ static int mx51_ecspi_config(struct spi_device *spi,
 	/* set chip select to use */
 	ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);
 
-	ctrl |= (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
+	if (spi_imx->dynamic_burst) {
+		if (config->len > MX51_ECSPI_CTRL_MAX_BURST)
+			ctrl |= MX51_ECSPI_CTRL_BL_MASK;
+		else
+			ctrl |= (((config->len - config->len % 4) * 8 - 1) <<
+				MX51_ECSPI_CTRL_BL_OFFSET);
+	} else
+		ctrl |= (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
 
 	cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
 
@@ -797,6 +882,8 @@ static void spi_imx_push(struct spi_imx_data *spi_imx)
 	while (spi_imx->txfifo < spi_imx_get_fifosize(spi_imx)) {
 		if (!spi_imx->count)
 			break;
+		if (spi_imx->txfifo && (spi_imx->count == spi_imx->count_index))
+			break;
 		spi_imx->tx(spi_imx);
 		spi_imx->txfifo++;
 	}
@@ -887,8 +974,12 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	struct spi_imx_config config;
 	int ret;
 
+	spi_imx->dynamic_burst = 0;
+	spi_imx->bpw_rx = 0;
+
 	config.bpw = t ? t->bits_per_word : spi->bits_per_word;
 	config.speed_hz  = t ? t->speed_hz : spi->max_speed_hz;
+	config.len = t->len;
 
 	if (!config.speed_hz)
 		config.speed_hz = spi->max_speed_hz;
@@ -897,14 +988,32 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 
 	/* Initialize the functions for transfer */
 	if (config.bpw <= 8) {
-		spi_imx->rx = spi_imx_buf_rx_u8;
-		spi_imx->tx = spi_imx_buf_tx_u8;
+		if (t->len >= sizeof(u32) && is_imx51_ecspi(spi_imx)) {
+			spi_imx->dynamic_burst = 1;
+			spi_imx->rx = spi_imx_buf_rx_swap;
+			spi_imx->tx = spi_imx_buf_tx_swap;
+		} else {
+			spi_imx->rx = spi_imx_buf_rx_u8;
+			spi_imx->tx = spi_imx_buf_tx_u8;
+		}
 	} else if (config.bpw <= 16) {
-		spi_imx->rx = spi_imx_buf_rx_u16;
-		spi_imx->tx = spi_imx_buf_tx_u16;
+		if (t->len >= sizeof(u32) && is_imx51_ecspi(spi_imx)) {
+			spi_imx->dynamic_burst = 1;
+			spi_imx->rx = spi_imx_buf_rx_swap;
+			spi_imx->tx = spi_imx_buf_tx_swap;
+		} else {
+			spi_imx->rx = spi_imx_buf_rx_u16;
+			spi_imx->tx = spi_imx_buf_tx_u16;
+		}
 	} else {
-		spi_imx->rx = spi_imx_buf_rx_u32;
-		spi_imx->tx = spi_imx_buf_tx_u32;
+		if (is_imx51_ecspi(spi_imx)) {
+			spi_imx->dynamic_burst = 1;
+			spi_imx->rx = spi_imx_buf_rx_swap;
+			spi_imx->tx = spi_imx_buf_tx_swap;
+		} else {
+			spi_imx->rx = spi_imx_buf_rx_u32;
+			spi_imx->tx = spi_imx_buf_tx_u32;
+		}
 	}
 
 	if (spi_imx_can_dma(spi_imx->bitbang.master, spi, t))
@@ -912,6 +1021,8 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	else
 		spi_imx->usedma = 0;
 
+	spi_imx->bpw_w = DIV_ROUND_UP(config.bpw, 8);
+
 	if (spi_imx->usedma) {
 		ret = spi_imx_dma_configure(spi->master,
 					    spi_imx_bytes_per_word(config.bpw));
@@ -1086,6 +1197,20 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 	spi_imx->count = transfer->len;
 	spi_imx->txfifo = 0;
 
+	if (spi_imx->dynamic_burst) {
+		spi_imx->count_index =
+				spi_imx->count > MX51_ECSPI_CTRL_MAX_BURST ?
+				spi_imx->count % MX51_ECSPI_CTRL_MAX_BURST :
+				spi_imx->count % sizeof(u32);
+
+		if (spi_imx->bpw_w == 1)
+			spi_imx_u32_swap_u8(transfer,
+					(u8 *)transfer->tx_buf);
+		else if (spi_imx->bpw_w == 2)
+			spi_imx_u32_swap_u16(transfer,
+					(u16 *)transfer->tx_buf);
+	}
+
 	reinit_completion(&spi_imx->xfer_done);
 
 	spi_imx_push(spi_imx);
@@ -1102,6 +1227,16 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 		return -ETIMEDOUT;
 	}
 
+	if (spi_imx->dynamic_burst) {
+		if (spi_imx->bpw_w == 1)
+			spi_imx_u32_swap_u8(transfer,
+					(u8 *)transfer->rx_buf);
+		else if (spi_imx->bpw_w == 2)
+			spi_imx_u32_swap_u16(transfer,
+					(u16 *)transfer->rx_buf);
+		spi_imx->dynamic_burst = 0;
+	}
+
 	return transfer->len;
 }
 
-- 
2.9.3
