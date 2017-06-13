From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH linux-next v4 1/1] spi: imx: dynamic burst length adjust for PIO mode
Date: Tue, 13 Jun 2017 17:34:02 +0900
Message-ID: <20170613083402.22324-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
index e544f45..c692a3f 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -56,6 +56,7 @@
 
 /* The maximum  bytes that a sdma BD can transfer.*/
 #define MAX_SDMA_BD_BYTES  (1 << 15)
+#define MX51_ECSPI_CTRL_MAX_BURST	512
 
 enum spi_imx_devtype {
 	IMX1_CSPI,
@@ -74,6 +75,7 @@ struct spi_imx_devtype_data {
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
 	void (*reset)(struct spi_imx_data *);
+	bool dynamic_burst;
 	enum spi_imx_devtype devtype;
 };
 
@@ -94,12 +96,14 @@ struct spi_imx_data {
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
@@ -228,6 +232,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 		return false;
 
 	spi_imx->wml = i;
+	spi_imx->dynamic_burst = 0;
 
 	return true;
 }
@@ -242,6 +247,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_CTRL_PREDIV_OFFSET	12
 #define MX51_ECSPI_CTRL_CS(cs)		((cs) << 18)
 #define MX51_ECSPI_CTRL_BL_OFFSET	20
+#define MX51_ECSPI_CTRL_BL_MASK		(0xfff << 20)
 
 #define MX51_ECSPI_CONFIG	0x0c
 #define MX51_ECSPI_CONFIG_SCLKPHA(cs)	(1 << ((cs) +  0))
@@ -269,6 +275,102 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
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
+			val = MX51_ECSPI_CTRL_MAX_BURST;
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
@@ -693,6 +795,7 @@ static struct spi_imx_devtype_data imx1_cspi_devtype_data = {
 	.trigger = mx1_trigger,
 	.rx_available = mx1_rx_available,
 	.reset = mx1_reset,
+	.dynamic_burst = false,
 	.devtype = IMX1_CSPI,
 };
 
@@ -702,6 +805,7 @@ static struct spi_imx_devtype_data imx21_cspi_devtype_data = {
 	.trigger = mx21_trigger,
 	.rx_available = mx21_rx_available,
 	.reset = mx21_reset,
+	.dynamic_burst = false,
 	.devtype = IMX21_CSPI,
 };
 
@@ -712,6 +816,7 @@ static struct spi_imx_devtype_data imx27_cspi_devtype_data = {
 	.trigger = mx21_trigger,
 	.rx_available = mx21_rx_available,
 	.reset = mx21_reset,
+	.dynamic_burst = false,
 	.devtype = IMX27_CSPI,
 };
 
@@ -721,6 +826,7 @@ static struct spi_imx_devtype_data imx31_cspi_devtype_data = {
 	.trigger = mx31_trigger,
 	.rx_available = mx31_rx_available,
 	.reset = mx31_reset,
+	.dynamic_burst = false,
 	.devtype = IMX31_CSPI,
 };
 
@@ -731,6 +837,7 @@ static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
 	.trigger = mx31_trigger,
 	.rx_available = mx31_rx_available,
 	.reset = mx31_reset,
+	.dynamic_burst = false,
 	.devtype = IMX35_CSPI,
 };
 
@@ -740,6 +847,7 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.trigger = mx51_ecspi_trigger,
 	.rx_available = mx51_ecspi_rx_available,
 	.reset = mx51_ecspi_reset,
+	.dynamic_burst = true,
 	.devtype = IMX51_ECSPI,
 };
 
@@ -794,6 +902,8 @@ static void spi_imx_push(struct spi_imx_data *spi_imx)
 	while (spi_imx->txfifo < spi_imx_get_fifosize(spi_imx)) {
 		if (!spi_imx->count)
 			break;
+		if (spi_imx->txfifo && (spi_imx->count == spi_imx->remainder))
+			break;
 		spi_imx->tx(spi_imx);
 		spi_imx->txfifo++;
 	}
@@ -887,15 +997,37 @@ static int spi_imx_setupxfer(struct spi_device *spi,
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
+		mask = (1 << config.bpw) - 1;
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
