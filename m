From: Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH] spi: mediatek: add SPI_LSB_FIRST support
Date: Wed, 5 Jun 2019 11:07:04 +0800
Message-ID: <1559704024-5369-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <fparent@baylibre.com>, Leilk Liu <leilk.liu@mediatek.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

this patch add SPI_LSB_FIRST feature support.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c                 |   15 ++++++---------
 include/linux/platform_data/spi-mt65xx.h |    2 --
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 0cce6f0..7f4dc18 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -131,8 +131,6 @@ struct mtk_spi {
  * supplies it.
  */
 static const struct mtk_chip_config mtk_default_chip_info = {
-	.rx_mlsb = 1,
-	.tx_mlsb = 1,
 	.cs_pol = 0,
 	.sample_sel = 0,
 };
@@ -203,14 +201,13 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 		reg_val &= ~SPI_CMD_CPOL;
 
 	/* set the mlsbx and mlsbtx */
-	if (chip_config->tx_mlsb)
-		reg_val |= SPI_CMD_TXMSBF;
-	else
+	if (spi->mode & SPI_LSB_FIRST) {
 		reg_val &= ~SPI_CMD_TXMSBF;
-	if (chip_config->rx_mlsb)
-		reg_val |= SPI_CMD_RXMSBF;
-	else
 		reg_val &= ~SPI_CMD_RXMSBF;
+	} else {
+		reg_val |= SPI_CMD_TXMSBF;
+		reg_val |= SPI_CMD_RXMSBF;
+	}
 
 	/* set the tx/rx endian */
 #ifdef __LITTLE_ENDIAN
@@ -607,7 +604,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	master->auto_runtime_pm = true;
 	master->dev.of_node = pdev->dev.of_node;
-	master->mode_bits = SPI_CPOL | SPI_CPHA;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
 
 	master->set_cs = mtk_spi_set_cs;
 	master->prepare_message = mtk_spi_prepare_message;
diff --git a/include/linux/platform_data/spi-mt65xx.h b/include/linux/platform_data/spi-mt65xx.h
index ba4e4bb..8d5df58 100644
--- a/include/linux/platform_data/spi-mt65xx.h
+++ b/include/linux/platform_data/spi-mt65xx.h
@@ -14,8 +14,6 @@
 
 /* Board specific platform_data */
 struct mtk_chip_config {
-	u32 tx_mlsb;
-	u32 rx_mlsb;
 	u32 cs_pol;
 	u32 sample_sel;
 };
-- 
1.7.9.5
