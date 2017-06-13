From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: mediatek: adjust register to enhance time accuracy" to
 the spi tree
Date: Tue, 13 Jun 2017 22:09:42 +0100
Message-ID: <E1dKt4I-0000o9-CL@debutante>
References: <1497069989-30584-2-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, sean.wang@mediatek.com,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
To: Leilk Liu <leilk.liu@mediatek.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1497069989-30584-2-git-send-email-leilk.liu@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: mediatek: adjust register to enhance time accuracy

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

>From 058fe49da3b6ab71b57effd49dcc5d007071eea5 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Mon, 12 Jun 2017 09:24:39 +0800
Subject: [PATCH] spi: mediatek: adjust register to enhance time accuracy

this patch adjust register to enhance time accuracy.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mt65xx.c                 | 45 ++++++++++++++++++++++++++++----
 include/linux/platform_data/spi-mt65xx.h |  2 ++
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 278867a31950..eae73b58248b 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -35,11 +35,15 @@
 #define SPI_CMD_REG                       0x0018
 #define SPI_STATUS0_REG                   0x001c
 #define SPI_PAD_SEL_REG                   0x0024
+#define SPI_CFG2_REG                      0x0028
 
 #define SPI_CFG0_SCK_HIGH_OFFSET          0
 #define SPI_CFG0_SCK_LOW_OFFSET           8
 #define SPI_CFG0_CS_HOLD_OFFSET           16
 #define SPI_CFG0_CS_SETUP_OFFSET          24
+#define SPI_ADJUST_CFG0_SCK_LOW_OFFSET    16
+#define SPI_ADJUST_CFG0_CS_HOLD_OFFSET    0
+#define SPI_ADJUST_CFG0_CS_SETUP_OFFSET   16
 
 #define SPI_CFG1_CS_IDLE_OFFSET           0
 #define SPI_CFG1_PACKET_LOOP_OFFSET       8
@@ -55,6 +59,8 @@
 #define SPI_CMD_RST                  BIT(2)
 #define SPI_CMD_PAUSE_EN             BIT(4)
 #define SPI_CMD_DEASSERT             BIT(5)
+#define SPI_CMD_SAMPLE_SEL           BIT(6)
+#define SPI_CMD_CS_POL               BIT(7)
 #define SPI_CMD_CPHA                 BIT(8)
 #define SPI_CMD_CPOL                 BIT(9)
 #define SPI_CMD_RX_DMA               BIT(10)
@@ -80,6 +86,8 @@ struct mtk_spi_compatible {
 	bool need_pad_sel;
 	/* Must explicitly send dummy Tx bytes to do Rx only transfer */
 	bool must_tx;
+	/* some IC design adjust cfg register to enhance time accuracy */
+	bool enhance_timing;
 };
 
 struct mtk_spi {
@@ -108,6 +116,8 @@ static const struct mtk_spi_compatible mt8173_compat = {
 static const struct mtk_chip_config mtk_default_chip_info = {
 	.rx_mlsb = 1,
 	.tx_mlsb = 1,
+	.cs_pol = 0,
+	.sample_sel = 0,
 };
 
 static const struct of_device_id mtk_spi_of_match[] = {
@@ -182,6 +192,17 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 	reg_val |= SPI_CMD_RX_ENDIAN;
 #endif
 
+	if (mdata->dev_comp->enhance_timing) {
+		if (chip_config->cs_pol)
+			reg_val |= SPI_CMD_CS_POL;
+		else
+			reg_val &= ~SPI_CMD_CS_POL;
+		if (chip_config->sample_sel)
+			reg_val |= SPI_CMD_SAMPLE_SEL;
+		else
+			reg_val &= ~SPI_CMD_SAMPLE_SEL;
+	}
+
 	/* set finish and pause interrupt always enable */
 	reg_val |= SPI_CMD_FINISH_IE | SPI_CMD_PAUSE_IE;
 
@@ -233,11 +254,25 @@ static void mtk_spi_prepare_transfer(struct spi_master *master,
 	sck_time = (div + 1) / 2;
 	cs_time = sck_time * 2;
 
-	reg_val |= (((sck_time - 1) & 0xff) << SPI_CFG0_SCK_HIGH_OFFSET);
-	reg_val |= (((sck_time - 1) & 0xff) << SPI_CFG0_SCK_LOW_OFFSET);
-	reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
-	reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_SETUP_OFFSET);
-	writel(reg_val, mdata->base + SPI_CFG0_REG);
+	if (mdata->dev_comp->enhance_timing) {
+		reg_val |= (((sck_time - 1) & 0xffff)
+			   << SPI_CFG0_SCK_HIGH_OFFSET);
+		reg_val |= (((sck_time - 1) & 0xffff)
+			   << SPI_ADJUST_CFG0_SCK_LOW_OFFSET);
+		writel(reg_val, mdata->base + SPI_CFG2_REG);
+		reg_val |= (((cs_time - 1) & 0xffff)
+			   << SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
+		reg_val |= (((cs_time - 1) & 0xffff)
+			   << SPI_ADJUST_CFG0_CS_SETUP_OFFSET);
+		writel(reg_val, mdata->base + SPI_CFG0_REG);
+	} else {
+		reg_val |= (((sck_time - 1) & 0xff)
+			   << SPI_CFG0_SCK_HIGH_OFFSET);
+		reg_val |= (((sck_time - 1) & 0xff) << SPI_CFG0_SCK_LOW_OFFSET);
+		reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
+		reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_SETUP_OFFSET);
+		writel(reg_val, mdata->base + SPI_CFG0_REG);
+	}
 
 	reg_val = readl(mdata->base + SPI_CFG1_REG);
 	reg_val &= ~SPI_CFG1_CS_IDLE_MASK;
diff --git a/include/linux/platform_data/spi-mt65xx.h b/include/linux/platform_data/spi-mt65xx.h
index 54b04483976c..ba4e4bb70262 100644
--- a/include/linux/platform_data/spi-mt65xx.h
+++ b/include/linux/platform_data/spi-mt65xx.h
@@ -16,5 +16,7 @@
 struct mtk_chip_config {
 	u32 tx_mlsb;
 	u32 rx_mlsb;
+	u32 cs_pol;
+	u32 sample_sel;
 };
 #endif
-- 
2.11.0
