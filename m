From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH linux-next v5 1/1] spi: imx: dynamic burst length adjust for PIO mode
Date: Thu, 10 Aug 2017 13:50:08 +0900
Message-ID: <20170810045008.7532-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

previously burst length (BURST_LENGTH) is always set to equal
to bits_per_word, causes a 10us gap between each word in
transfer, which significantly affects performance.

This patch uses 32 bits transfer to simulate lower bits transfer,
and adjusts burst length runtimely to use biggeest burst length
as possible to reduce the gaps in transfer for PIO mode.

Signed-off-by: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
---
Changes in v5:
* Rebased on latest linux-next tree
* corrected burst_length value in spi_imx_buf_tx_swap()
* fixed compile error issue caused by incorrect code rebase in v4

Changes in v4:
* Rebased to latest linux-next tree
* Added support to bits_per_word other than 8,16,32 as well
* Renamed several variables
* Added dynamic_burst to spi_imx_devtype_data
* Removed change from mx51_ecspi_config()

Changes in v3:
* Only allow dynamic burst in PIO mode
* Avoid direct manipulation of tx_buf & rx_buf

Changes in v2:
* used cpu_to_* functions to ensure this patch works for both
  little & big endian kernel.

 drivers/spi/spi-imx.c | 150 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 141 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 930e475..cc808a1 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -56,6 +56,7 @@
 
 /* The maximum  bytes that a sdma BD can transfer.*/
 #define MAX_SDMA_BD_BYTES  (1 << 15)
+#define MX51_ECSPI_CTRL_MAX_BURST	512
 
 enum spi_imx_devtype {
 	IMX1_CSPI,
@@ -77,6 +78,7 @@ struct spi_imx_devtype_data {
 	void (*reset)(struct spi_imx_data *);
 	bool has_dmamode;
 	unsigned int fifo_size;
+	bool dynamic_burst;
 	enum spi_imx_devtype devtype;
 };
 
@@ -97,12 +99,14 @@ struct spi_imx_data {
 	unsigned int bits_per_word;
 	unsigned int spi_drctl;
 
-	unsigned int count;
+	unsigned int count, remainder;
 	void (*tx)(struct spi_imx_data *);
 	void (*rx)(struct spi_imx_data *);
 	void *rx_buf;
 	const void *tx_buf;
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
+	unsigned int dynamic_burst, read_u32;
+	unsigned int word_mask;
 
 	/* DMA */
 	bool usedma;
@@ -231,6 +235,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 		return false;
 
 	spi_imx->wml = i;
+	spi_imx->dynamic_burst = 0;
 
 	return true;
 }
@@ -245,6 +250,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_CTRL_PREDIV_OFFSET	12
 #define MX51_ECSPI_CTRL_CS(cs)		((cs) << 18)
 #define MX51_ECSPI_CTRL_BL_OFFSET	20
+#define MX51_ECSPI_CTRL_BL_MASK		(0xfff << 20)
 
 #define MX51_ECSPI_CONFIG	0x0c
 #define MX51_ECSPI_CONFIG_SCLKPHA(cs)	(1 << ((cs) +  0))
@@ -272,6 +278,102 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_TESTREG	0x20
 #define MX51_ECSPI_TESTREG_LBC	BIT(31)
 
+static void spi_imx_buf_rx_swap_u32(struct spi_imx_data *spi_imx)
+{
+	unsigned int val = readl(spi_imx->base + MXC_CSPIRXDATA);
+	unsigned int bytes_per_word;
+
+	if (spi_imx->rx_buf) {
+#ifdef __LITTLE_ENDIAN
+		bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
+		if (bytes_per_word == 1)
+			val = cpu_to_be32(val);
+		else if (bytes_per_word == 2)
+			val = (val << 16) | (val >> 16);
+#endif
+		val &= spi_imx->word_mask;
+		*(u32 *)spi_imx->rx_buf = val;
+		spi_imx->rx_buf += sizeof(u32);
+	}
+}
+
+static void spi_imx_buf_rx_swap(struct spi_imx_data *spi_imx)
+{
+	unsigned int bytes_per_word;
+
+	bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
+	if (spi_imx->read_u32) {
+		spi_imx_buf_rx_swap_u32(spi_imx);
+		return;
+	}
+
+	if (bytes_per_word == 1)
+		spi_imx_buf_rx_u8(spi_imx);
+	else if (bytes_per_word == 2)
+		spi_imx_buf_rx_u16(spi_imx);
+}
+
+static void spi_imx_buf_tx_swap_u32(struct spi_imx_data *spi_imx)
+{
+	u32 val = 0;
+	unsigned int bytes_per_word;
+
+	if (spi_imx->tx_buf) {
+		val = *(u32 *)spi_imx->tx_buf;
+		val &= spi_imx->word_mask;
+		spi_imx->tx_buf += sizeof(u32);
+	}
+
+	spi_imx->count -= sizeof(u32);
+#ifdef __LITTLE_ENDIAN
+	bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
+
+	if (bytes_per_word == 1)
+		val = cpu_to_be32(val);
+	else if (bytes_per_word == 2)
+		val = (val << 16) | (val >> 16);
+#endif
+	writel(val, spi_imx->base + MXC_CSPITXDATA);
+}
+
+static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
+{
+	u32 ctrl, val;
+	unsigned int bytes_per_word;
+
+	if (spi_imx->count == spi_imx->remainder) {
+		ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
+		ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
+		if (spi_imx->count > MX51_ECSPI_CTRL_MAX_BURST) {
+			spi_imx->remainder = spi_imx->count %
+					     MX51_ECSPI_CTRL_MAX_BURST;
+			val = MX51_ECSPI_CTRL_MAX_BURST * 8 - 1;
+		} else if (spi_imx->count >= sizeof(u32)) {
+			spi_imx->remainder = spi_imx->count % sizeof(u32);
+			val = (spi_imx->count - spi_imx->remainder) * 8 - 1;
+		} else {
+			spi_imx->remainder = 0;
+			val = spi_imx->bits_per_word - 1;
+			spi_imx->read_u32 = 0;
+		}
+
+		ctrl |= (val << MX51_ECSPI_CTRL_BL_OFFSET);
+		writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
+	}
+
+	if (spi_imx->count >= sizeof(u32)) {
+		spi_imx_buf_tx_swap_u32(spi_imx);
+		return;
+	}
+
+	bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
+
+	if (bytes_per_word == 1)
+		spi_imx_buf_tx_u8(spi_imx);
+	else if (bytes_per_word == 2)
+		spi_imx_buf_tx_u16(spi_imx);
+}
+
 /* MX51 eCSPI */
 static unsigned int mx51_ecspi_clkdiv(struct spi_imx_data *spi_imx,
 				      unsigned int fspi, unsigned int *fres)
@@ -698,6 +800,7 @@ static struct spi_imx_devtype_data imx1_cspi_devtype_data = {
 	.reset = mx1_reset,
 	.fifo_size = 8,
 	.has_dmamode = false,
+	.dynamic_burst = false,
 	.devtype = IMX1_CSPI,
 };
 
@@ -709,6 +812,7 @@ static struct spi_imx_devtype_data imx21_cspi_devtype_data = {
 	.reset = mx21_reset,
 	.fifo_size = 8,
 	.has_dmamode = false,
+	.dynamic_burst = false,
 	.devtype = IMX21_CSPI,
 };
 
@@ -721,6 +825,7 @@ static struct spi_imx_devtype_data imx27_cspi_devtype_data = {
 	.reset = mx21_reset,
 	.fifo_size = 8,
 	.has_dmamode = false,
+	.dynamic_burst = false,
 	.devtype = IMX27_CSPI,
 };
 
@@ -732,6 +837,7 @@ static struct spi_imx_devtype_data imx31_cspi_devtype_data = {
 	.reset = mx31_reset,
 	.fifo_size = 8,
 	.has_dmamode = false,
+	.dynamic_burst = false,
 	.devtype = IMX31_CSPI,
 };
 
@@ -744,6 +850,7 @@ static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
 	.reset = mx31_reset,
 	.fifo_size = 8,
 	.has_dmamode = true,
+	.dynamic_burst = false,
 	.devtype = IMX35_CSPI,
 };
 
@@ -755,6 +862,7 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.reset = mx51_ecspi_reset,
 	.fifo_size = 64,
 	.has_dmamode = true,
+	.dynamic_burst = true,
 	.devtype = IMX51_ECSPI,
 };
 
@@ -827,6 +935,8 @@ static void spi_imx_push(struct spi_imx_data *spi_imx)
 	while (spi_imx->txfifo < spi_imx->devtype_data->fifo_size) {
 		if (!spi_imx->count)
 			break;
+		if (spi_imx->txfifo && (spi_imx->count == spi_imx->remainder))
+			break;
 		spi_imx->tx(spi_imx);
 		spi_imx->txfifo++;
 	}
@@ -920,15 +1030,37 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	spi_imx->speed_hz  = t->speed_hz;
 
 	/* Initialize the functions for transfer */
-	if (spi_imx->bits_per_word <= 8) {
-		spi_imx->rx = spi_imx_buf_rx_u8;
-		spi_imx->tx = spi_imx_buf_tx_u8;
-	} else if (spi_imx->bits_per_word <= 16) {
-		spi_imx->rx = spi_imx_buf_rx_u16;
-		spi_imx->tx = spi_imx_buf_tx_u16;
+	if (spi_imx->devtype_data->dynamic_burst) {
+		u32 mask;
+
+		spi_imx->dynamic_burst = 0;
+		spi_imx->remainder = 0;
+		spi_imx->read_u32  = 1;
+
+		mask = (1 << spi_imx->bits_per_word) - 1;
+		spi_imx->rx = spi_imx_buf_rx_swap;
+		spi_imx->tx = spi_imx_buf_tx_swap;
+		spi_imx->dynamic_burst = 1;
+		spi_imx->remainder = t->len;
+
+		if (spi_imx->bits_per_word <= 8)
+			spi_imx->word_mask = mask << 24 | mask << 16
+					     | mask << 8 | mask;
+		else if (spi_imx->bits_per_word <= 16)
+			spi_imx->word_mask = mask << 16 | mask;
+		else
+			spi_imx->word_mask = mask;
 	} else {
-		spi_imx->rx = spi_imx_buf_rx_u32;
-		spi_imx->tx = spi_imx_buf_tx_u32;
+		if (spi_imx->bits_per_word <= 8) {
+			spi_imx->rx = spi_imx_buf_rx_u8;
+			spi_imx->tx = spi_imx_buf_tx_u8;
+		} else if (spi_imx->bits_per_word <= 16) {
+			spi_imx->rx = spi_imx_buf_rx_u16;
+			spi_imx->tx = spi_imx_buf_tx_u16;
+		} else {
+			spi_imx->rx = spi_imx_buf_rx_u32;
+			spi_imx->tx = spi_imx_buf_tx_u32;
+		}
 	}
 
 	if (spi_imx_can_dma(spi_imx->bitbang.master, spi, t))
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
