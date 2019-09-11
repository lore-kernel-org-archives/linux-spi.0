From: Luhua Xu <luhua.xu@mediatek.com>
Subject: [PATCH 3/3] spi: mediatek: support large PA
Date: Wed, 11 Sep 2019 05:55:31 -0400
Message-ID: <1568195731-3239-4-git-send-email-luhua.xu@mediatek.com>
References: <1568195731-3239-1-git-send-email-luhua.xu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-mediatek@lists.infradead.org, "luhua.xu" <luhua.xu@mediatek.com>,
 linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1568195731-3239-1-git-send-email-luhua.xu@mediatek.com>
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

From: "luhua.xu" <luhua.xu@mediatek.com>

Add spi large PA(max=64G) support for DMA transfer.

Signed-off-by: luhua.xu <luhua.xu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 3c73b71..ccc9bdb 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -17,6 +17,7 @@
 #include <linux/platform_data/spi-mt65xx.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
+#include <linux/dma-mapping.h>
 
 #define SPI_CFG0_REG                      0x0000
 #define SPI_CFG1_REG                      0x0004
@@ -28,6 +29,8 @@
 #define SPI_STATUS0_REG                   0x001c
 #define SPI_PAD_SEL_REG                   0x0024
 #define SPI_CFG2_REG                      0x0028
+#define SPI_TX_SRC_REG_64                 0x002c
+#define SPI_RX_DST_REG_64                 0x0030
 
 #define SPI_CFG0_SCK_HIGH_OFFSET          0
 #define SPI_CFG0_SCK_LOW_OFFSET           8
@@ -73,6 +76,10 @@
 
 #define MTK_SPI_MAX_FIFO_SIZE 32U
 #define MTK_SPI_PACKET_SIZE 1024
+#define MTK_SPI_32BITS_MASK  (0xffffffff)
+
+#define DMA_ADDR_EXT_BITS (36)
+#define DMA_ADDR_DEF_BITS (32)
 
 struct mtk_spi_compatible {
 	bool need_pad_sel;
@@ -80,6 +87,8 @@ struct mtk_spi_compatible {
 	bool must_tx;
 	/* some IC design adjust cfg register to enhance time accuracy */
 	bool enhance_timing;
+	/* some IC support DMA addr extension */
+	bool dma_ext;
 };
 
 struct mtk_spi {
@@ -106,6 +115,7 @@ static const struct mtk_spi_compatible mt6765_compat = {
 	.need_pad_sel = true,
 	.must_tx = true,
 	.enhance_timing = true,
+	.dma_ext = true,
 };
 
 static const struct mtk_spi_compatible mt7622_compat = {
@@ -380,10 +390,25 @@ static void mtk_spi_setup_dma_addr(struct spi_master *master,
 {
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
-	if (mdata->tx_sgl)
-		writel(xfer->tx_dma, mdata->base + SPI_TX_SRC_REG);
-	if (mdata->rx_sgl)
-		writel(xfer->rx_dma, mdata->base + SPI_RX_DST_REG);
+	if (mdata->tx_sgl) {
+		writel((u32)(xfer->tx_dma & MTK_SPI_32BITS_MASK),
+		       mdata->base + SPI_TX_SRC_REG);
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+		if (mdata->dev_comp->dma_ext)
+			writel((u32)(xfer->tx_dma >> 32),
+			       mdata->base + SPI_TX_SRC_REG_64);
+#endif
+	}
+
+	if (mdata->rx_sgl) {
+		writel((u32)(xfer->rx_dma & MTK_SPI_32BITS_MASK),
+		       mdata->base + SPI_RX_DST_REG);
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+		if (mdata->dev_comp->dma_ext)
+			writel((u32)(xfer->rx_dma >> 32),
+			       mdata->base + SPI_RX_DST_REG_64);
+#endif
+	}
 }
 
 static int mtk_spi_fifo_transfer(struct spi_master *master,
@@ -595,7 +620,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	struct mtk_spi *mdata;
 	const struct of_device_id *of_id;
 	struct resource *res;
-	int i, irq, ret;
+	int i, irq, ret, addr_bits;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*mdata));
 	if (!master) {
@@ -762,6 +787,15 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (mdata->dev_comp->dma_ext)
+		addr_bits = DMA_ADDR_EXT_BITS;
+	else
+		addr_bits = DMA_ADDR_DEF_BITS;
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(addr_bits));
+	if (ret)
+		dev_notice(&pdev->dev, "SPI dma_set_mask(%d) failed, ret:%d\n",
+			   addr_bits, ret);
+
 	return 0;
 
 err_disable_runtime_pm:
-- 
2.6.4
