From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: mediatek: support large PA" to the spi tree
Date: Fri, 13 Sep 2019 10:42:21 +0100 (BST)
Message-ID: <20190913094221.888D0D00DD9@fitzroy.sirena.org.uk>
References: <1568195731-3239-4-git-send-email-luhua.xu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
To: luhua.xu <luhua.xu@mediatek.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1568195731-3239-4-git-send-email-luhua.xu@mediatek.com>
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

   spi: mediatek: support large PA

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

>From fdeae8f5a2e5eb3fcc9c295bfb28503c3abd4d6e Mon Sep 17 00:00:00 2001
From: "luhua.xu" <luhua.xu@mediatek.com>
Date: Wed, 11 Sep 2019 05:55:31 -0400
Subject: [PATCH] spi: mediatek: support large PA

Add spi large PA(max=64G) support for DMA transfer.

Signed-off-by: luhua.xu <luhua.xu@mediatek.com>
Link: https://lore.kernel.org/r/1568195731-3239-4-git-send-email-luhua.xu@mediatek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mt65xx.c | 44 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index c70911e2a6e1..6888a4dcff6d 100644
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
@@ -761,6 +786,15 @@ static int mtk_spi_probe(struct platform_device *pdev)
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
2.20.1
