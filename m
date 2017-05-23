From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] Revert "spi: imx: dynamic burst length adjust for PIO mode"
Date: Tue, 23 May 2017 14:38:27 +0200
Message-ID: <20170523123827.22408-1-s.hauer@pengutronix.de>
Cc: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This reverts commits 8d4a6cad7adb3ddac32cd52635f20e11de11a658 and
179547e143e773f9f866ad3536275ab627711f3a.

Besides the problems already found with this patch it also modifies
the spi transfer tx_buf in spi_imx_u32_swap_u8() and spi_imx_u32_swap_u16().
This is hidden from the compiler with an explicit cast from const void*
to u32*, so no warning is issued.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/spi-imx.c | 163 +++-----------------------------------------------
 1 file changed, 8 insertions(+), 155 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 19b30cf7d2b7..b402530a7a9a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -56,11 +56,9 @@
 
 /* The maximum  bytes that a sdma BD can transfer.*/
 #define MAX_SDMA_BD_BYTES  (1 << 15)
-#define MX51_ECSPI_CTRL_MAX_BURST	512
 struct spi_imx_config {
 	unsigned int speed_hz;
 	unsigned int bpw;
-	unsigned int len;
 };
 
 enum spi_imx_devtype {
@@ -99,14 +97,12 @@ struct spi_imx_data {
 	unsigned int bytes_per_word;
 	unsigned int spi_drctl;
 
-	unsigned int count, count_index;
+	unsigned int count;
 	void (*tx)(struct spi_imx_data *);
 	void (*rx)(struct spi_imx_data *);
 	void *rx_buf;
 	const void *tx_buf;
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
-	unsigned int dynamic_burst, bpw_rx;
-	unsigned int bpw_w;
 
 	/* DMA */
 	bool usedma;
@@ -256,7 +252,6 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_CTRL_PREDIV_OFFSET	12
 #define MX51_ECSPI_CTRL_CS(cs)		((cs) << 18)
 #define MX51_ECSPI_CTRL_BL_OFFSET	20
-#define MX51_ECSPI_CTRL_BL_MASK		(0xfff << 20)
 
 #define MX51_ECSPI_CONFIG	0x0c
 #define MX51_ECSPI_CONFIG_SCLKPHA(cs)	(1 << ((cs) +  0))
@@ -284,77 +279,6 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_TESTREG	0x20
 #define MX51_ECSPI_TESTREG_LBC	BIT(31)
 
-static void spi_imx_u32_swap_u8(struct spi_transfer *transfer, u32 *buf)
-{
-	int i;
-
-	if (!buf)
-		return;
-
-	for (i = 0; i < transfer->len / 4; i++)
-		*(buf + i) = cpu_to_be32(*(buf + i));
-}
-
-static void spi_imx_u32_swap_u16(struct spi_transfer *transfer, u32 *buf)
-{
-	int i;
-
-	if (!buf)
-		return;
-
-	for (i = 0; i < transfer->len / 4; i++) {
-		u16 *temp = (u16 *)buf;
-
-		*(temp + i * 2) = cpu_to_be16(*(temp + i * 2));
-		*(temp + i * 2 + 1) = cpu_to_be16(*(temp + i * 2 + 1));
-
-		*(buf + i) = cpu_to_be32(*(buf + i));
-	}
-}
-
-static void spi_imx_buf_rx_swap(struct spi_imx_data *spi_imx)
-{
-	if (!spi_imx->bpw_rx) {
-		spi_imx_buf_rx_u32(spi_imx);
-		return;
-	}
-
-	if (spi_imx->bpw_w == 1)
-		spi_imx_buf_rx_u8(spi_imx);
-	else if (spi_imx->bpw_w == 2)
-		spi_imx_buf_rx_u16(spi_imx);
-}
-
-static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
-{
-	u32 ctrl, val;
-
-	if (spi_imx->count == spi_imx->count_index) {
-		spi_imx->count_index = spi_imx->count > sizeof(u32) ?
-					spi_imx->count % sizeof(u32) : 0;
-		ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
-		ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
-		if (spi_imx->count >= sizeof(u32)) {
-			val = spi_imx->count - spi_imx->count_index;
-		} else {
-			val = spi_imx->bpw_w;
-			spi_imx->bpw_rx = 1;
-		}
-		ctrl |= ((val * 8 - 1) << MX51_ECSPI_CTRL_BL_OFFSET);
-		writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
-	}
-
-	if (spi_imx->count >= sizeof(u32)) {
-		spi_imx_buf_tx_u32(spi_imx);
-		return;
-	}
-
-	if (spi_imx->bpw_w == 1)
-		spi_imx_buf_tx_u8(spi_imx);
-	else if (spi_imx->bpw_w == 2)
-		spi_imx_buf_tx_u16(spi_imx);
-}
-
 /* MX51 eCSPI */
 static unsigned int mx51_ecspi_clkdiv(struct spi_imx_data *spi_imx,
 				      unsigned int fspi, unsigned int *fres)
@@ -446,15 +370,7 @@ static int mx51_ecspi_config(struct spi_device *spi,
 	/* set chip select to use */
 	ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);
 
-	if (spi_imx->dynamic_burst) {
-		if (config->len > MX51_ECSPI_CTRL_MAX_BURST)
-			ctrl |= MX51_ECSPI_CTRL_BL_MASK;
-		else
-			ctrl |= (((config->len - config->len % 4) * 8 - 1) <<
-				MX51_ECSPI_CTRL_BL_OFFSET);
-	} else {
-		ctrl |= (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
-	}
+	ctrl |= (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
 
 	cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
 
@@ -889,8 +805,6 @@ static void spi_imx_push(struct spi_imx_data *spi_imx)
 	while (spi_imx->txfifo < spi_imx_get_fifosize(spi_imx)) {
 		if (!spi_imx->count)
 			break;
-		if (spi_imx->txfifo && (spi_imx->count == spi_imx->count_index))
-			break;
 		spi_imx->tx(spi_imx);
 		spi_imx->txfifo++;
 	}
@@ -981,12 +895,8 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	struct spi_imx_config config;
 	int ret;
 
-	spi_imx->dynamic_burst = 0;
-	spi_imx->bpw_rx = 0;
-
 	config.bpw = t ? t->bits_per_word : spi->bits_per_word;
 	config.speed_hz  = t ? t->speed_hz : spi->max_speed_hz;
-	config.len = t->len;
 
 	if (!config.speed_hz)
 		config.speed_hz = spi->max_speed_hz;
@@ -995,32 +905,14 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 
 	/* Initialize the functions for transfer */
 	if (config.bpw <= 8) {
-		if (t->len >= sizeof(u32) && is_imx51_ecspi(spi_imx)) {
-			spi_imx->dynamic_burst = 1;
-			spi_imx->rx = spi_imx_buf_rx_swap;
-			spi_imx->tx = spi_imx_buf_tx_swap;
-		} else {
-			spi_imx->rx = spi_imx_buf_rx_u8;
-			spi_imx->tx = spi_imx_buf_tx_u8;
-		}
+		spi_imx->rx = spi_imx_buf_rx_u8;
+		spi_imx->tx = spi_imx_buf_tx_u8;
 	} else if (config.bpw <= 16) {
-		if (t->len >= sizeof(u32) && is_imx51_ecspi(spi_imx)) {
-			spi_imx->dynamic_burst = 1;
-			spi_imx->rx = spi_imx_buf_rx_swap;
-			spi_imx->tx = spi_imx_buf_tx_swap;
-		} else {
-			spi_imx->rx = spi_imx_buf_rx_u16;
-			spi_imx->tx = spi_imx_buf_tx_u16;
-		}
+		spi_imx->rx = spi_imx_buf_rx_u16;
+		spi_imx->tx = spi_imx_buf_tx_u16;
 	} else {
-		if (is_imx51_ecspi(spi_imx)) {
-			spi_imx->dynamic_burst = 1;
-			spi_imx->rx = spi_imx_buf_rx_swap;
-			spi_imx->tx = spi_imx_buf_tx_swap;
-		} else {
-			spi_imx->rx = spi_imx_buf_rx_u32;
-			spi_imx->tx = spi_imx_buf_tx_u32;
-		}
+		spi_imx->rx = spi_imx_buf_rx_u32;
+		spi_imx->tx = spi_imx_buf_tx_u32;
 	}
 
 	if (spi_imx_can_dma(spi_imx->bitbang.master, spi, t))
@@ -1028,8 +920,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	else
 		spi_imx->usedma = 0;
 
-	spi_imx->bpw_w = DIV_ROUND_UP(config.bpw, 8);
-
 	if (spi_imx->usedma) {
 		ret = spi_imx_dma_configure(spi->master,
 					    spi_imx_bytes_per_word(config.bpw));
@@ -1204,27 +1094,6 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 	spi_imx->count = transfer->len;
 	spi_imx->txfifo = 0;
 
-	if (spi_imx->dynamic_burst) {
-		if (spi_imx->count > MX51_ECSPI_CTRL_MAX_BURST)
-			spi_imx->count_index = spi_imx->count %
-					       MX51_ECSPI_CTRL_MAX_BURST;
-		else
-			spi_imx->count_index = spi_imx->count % sizeof(u32);
-
-		switch (spi_imx->bpw_w) {
-		case 1:
-			spi_imx_u32_swap_u8(transfer,
-					    (u32 *)transfer->tx_buf);
-			break;
-		case 2:
-			spi_imx_u32_swap_u16(transfer,
-					     (u32 *)transfer->tx_buf);
-			break;
-		default:
-			break;
-		}
-	}
-
 	reinit_completion(&spi_imx->xfer_done);
 
 	spi_imx_push(spi_imx);
@@ -1241,22 +1110,6 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 		return -ETIMEDOUT;
 	}
 
-	if (spi_imx->dynamic_burst) {
-		switch (spi_imx->bpw_w) {
-		case 1:
-			spi_imx_u32_swap_u8(transfer,
-					    (u32 *)transfer->rx_buf);
-			break;
-		case 2:
-			spi_imx_u32_swap_u16(transfer,
-					     (u32 *)transfer->rx_buf);
-			break;
-		default:
-			break;
-		}
-		spi_imx->dynamic_burst = 0;
-	}
-
 	return transfer->len;
 }
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
