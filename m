From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: imx: dynamic burst length adjust for PIO mode" to the spi tree
Date: Thu, 17 Aug 2017 18:14:05 +0100
Message-ID: <E1diOMv-0000MS-4p@debutante>
References: <20170810045008.7532-1-jiada_wang@mentor.com>
Cc: Jiada Wang <jiada_wang@mentor.com>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        s.hauer@pengutronix.de, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiada_wang@mentor.com,
        linux-spi@vger.kernel.org
To: jiada wang <jiada_wang@mentor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170810045008.7532-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: imx: dynamic burst length adjust for PIO mode

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1673c81d9435bcf758da6ccaa291513e34c1cb82 Mon Sep 17 00:00:00 2001
From: jiada wang <jiada_wang@mentor.com>
Date: Thu, 10 Aug 2017 13:50:08 +0900
Subject: [PATCH] spi: imx: dynamic burst length adjust for PIO mode

previously burst length (BURST_LENGTH) is always set to equal
to bits_per_word, causes a 10us gap between each word in
transfer, which significantly affects performance.

This patch uses 32 bits transfer to simulate lower bits transfer,
and adjusts burst length runtimely to use biggeest burst length
as possible to reduce the gaps in transfer for PIO mode.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 150 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 141 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 930e47597db3..cc808a1c765c 100644
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
2.13.3
