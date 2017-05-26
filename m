From: <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH linux-next v3 1/1] spi: imx: dynamic burst length adjust for PIO mode
Date: Thu, 25 May 2017 22:02:42 -0700
Message-ID: <1495774962-2981-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>

previously burst length (BURST_LENGTH) is always set to equal
to bits_per_word, causes a 10us gap between each word in
transfer, which significantly affects performance.

This patch uses 32 bits transfer to simulate lower bits transfer,
and adjusts burst length runtimely to use biggeest burst length
as possible to reduce the gaps in transfer for PIO mode.

Signed-off-by: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
---

Changes in v2:
* used cpu_to_* functions to ensure this patch works for both
  little & big endian kernel.

Changes in v3:
* Only allow dynamic burst in PIO mode
* Avoid direct manipulation of tx_buf & rx_buf

 drivers/spi/spi-imx.c | 156 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 148 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b402530..54f7c31 100644
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
@@ -97,12 +99,14 @@ struct spi_imx_data {
 	unsigned int bytes_per_word;
 	unsigned int spi_drctl;
 
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
@@ -238,6 +242,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 		return false;
 
 	spi_imx->wml = i;
+	spi_imx->dynamic_burst = 0;
 
 	return true;
 }
@@ -252,6 +257,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_CTRL_PREDIV_OFFSET	12
 #define MX51_ECSPI_CTRL_CS(cs)		((cs) << 18)
 #define MX51_ECSPI_CTRL_BL_OFFSET	20
+#define MX51_ECSPI_CTRL_BL_MASK		(0xfff << 20)
 
 #define MX51_ECSPI_CONFIG	0x0c
 #define MX51_ECSPI_CONFIG_SCLKPHA(cs)	(1 << ((cs) +  0))
@@ -279,6 +285,95 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_TESTREG	0x20
 #define MX51_ECSPI_TESTREG_LBC	BIT(31)
 
+static u32 spi_imx_u32_swap_u16(u32 val)
+{
+	u32 data = val;
+	u16 *temp = (u16 *)&data;
+
+	*temp = cpu_to_be16(*temp);
+	*(temp + 1) = cpu_to_be16(*(temp + 1));
+
+	data = cpu_to_be32(data);
+
+	return data;
+}
+
+static void spi_imx_buf_rx_swap_u32(struct spi_imx_data *spi_imx)
+{
+	unsigned int val = readl(spi_imx->base + MXC_CSPIRXDATA);
+
+	if (spi_imx->rx_buf) {
+		if (spi_imx->bpw_w == 1)
+			val = cpu_to_be32(val);
+		else if (spi_imx->bpw_w == 2)
+			val = spi_imx_u32_swap_u16(val);
+
+		*(u32 *)spi_imx->rx_buf = val;
+		spi_imx->rx_buf += sizeof(u32);
+	}
+}
+
+static void spi_imx_buf_rx_swap(struct spi_imx_data *spi_imx)
+{
+	if (!spi_imx->bpw_rx) {
+		spi_imx_buf_rx_swap_u32(spi_imx);
+		return;
+	}
+
+	if (spi_imx->bpw_w == 1)
+		spi_imx_buf_rx_u8(spi_imx);
+	else if (spi_imx->bpw_w == 2)
+		spi_imx_buf_rx_u16(spi_imx);
+}
+
+static void spi_imx_buf_tx_swap_u32(struct spi_imx_data *spi_imx)
+{
+	u32 val = 0;
+
+	if (spi_imx->tx_buf) {
+		val = *(u32 *)spi_imx->tx_buf;
+		spi_imx->tx_buf += sizeof(u32);
+	}
+
+	spi_imx->count -= sizeof(u32);
+	if (spi_imx->bpw_w == 1)
+		val = cpu_to_be32(val);
+	else if (spi_imx->bpw_w == 2)
+		val = spi_imx_u32_swap_u16(val);
+
+	writel(val, spi_imx->base + MXC_CSPITXDATA);
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
+		if (spi_imx->count >= sizeof(u32)) {
+			val = spi_imx->count - spi_imx->count_index;
+		} else {
+			val = spi_imx->bpw_w;
+			spi_imx->bpw_rx = 1;
+		}
+		ctrl |= ((val * 8 - 1) << MX51_ECSPI_CTRL_BL_OFFSET);
+		writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
+	}
+
+	if (spi_imx->count >= sizeof(u32)) {
+		spi_imx_buf_tx_swap_u32(spi_imx);
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
@@ -370,7 +465,15 @@ static int mx51_ecspi_config(struct spi_device *spi,
 	/* set chip select to use */
 	ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);
 
-	ctrl |= (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
+	if (spi_imx->dynamic_burst) {
+		if (config->len > MX51_ECSPI_CTRL_MAX_BURST)
+			ctrl |= MX51_ECSPI_CTRL_BL_MASK;
+		else
+			ctrl |= (((config->len - config->len % 4) * 8 - 1) <<
+				MX51_ECSPI_CTRL_BL_OFFSET);
+	} else {
+		ctrl |= (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
+	}
 
 	cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
 
@@ -805,6 +908,8 @@ static void spi_imx_push(struct spi_imx_data *spi_imx)
 	while (spi_imx->txfifo < spi_imx_get_fifosize(spi_imx)) {
 		if (!spi_imx->count)
 			break;
+		if (spi_imx->txfifo && (spi_imx->count == spi_imx->count_index))
+			break;
 		spi_imx->tx(spi_imx);
 		spi_imx->txfifo++;
 	}
@@ -895,8 +1000,12 @@ static int spi_imx_setupxfer(struct spi_device *spi,
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
@@ -905,14 +1014,32 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 
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
@@ -920,6 +1047,8 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	else
 		spi_imx->usedma = 0;
 
+	spi_imx->bpw_w = DIV_ROUND_UP(config.bpw, 8);
+
 	if (spi_imx->usedma) {
 		ret = spi_imx_dma_configure(spi->master,
 					    spi_imx_bytes_per_word(config.bpw));
@@ -1094,6 +1223,14 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 	spi_imx->count = transfer->len;
 	spi_imx->txfifo = 0;
 
+	if (spi_imx->dynamic_burst) {
+		if (spi_imx->count > MX51_ECSPI_CTRL_MAX_BURST)
+			spi_imx->count_index = spi_imx->count %
+					       MX51_ECSPI_CTRL_MAX_BURST;
+		else
+			spi_imx->count_index = spi_imx->count % sizeof(u32);
+	}
+
 	reinit_completion(&spi_imx->xfer_done);
 
 	spi_imx_push(spi_imx);
@@ -1110,6 +1247,9 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 		return -ETIMEDOUT;
 	}
 
+	if (spi_imx->dynamic_burst)
+		spi_imx->dynamic_burst = 0;
+
 	return transfer->len;
 }
 
-- 
2.7.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
