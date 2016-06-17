From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH 5/5] spi: s3c63xx: simplify if statement in prepare_transfer
 function
Date: Fri, 17 Jun 2016 16:57:25 +0900
Message-ID: <1466150245-2648-6-git-send-email-andi.shyti@samsung.com>
References: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-kernel@vger.kernel.org,
 Andi Shyti <andi.shyti@samsung.com>, linux-spi@vger.kernel.org,
 Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
 linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
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

The whole function is in an if statement ("!is_polling(sdd)").
Check the opposite of that statement at the beginning and exit,
this way we can have a level less of indentation.

Remove the goto paths as they are redundant.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 50 +++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index a98930a..c45c88c 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -341,38 +341,32 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 	dma_filter_fn filter = sdd->cntrlr_info->filter;
 	struct device *dev = &sdd->pdev->dev;
 	dma_cap_mask_t mask;
-	int ret;
 
-	if (!is_polling(sdd)) {
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-
-		/* Acquire DMA channels */
-		sdd->rx_dma.ch = dma_request_slave_channel_compat(mask, filter,
-				   sdd->cntrlr_info->dma_rx, dev, "rx");
-		if (!sdd->rx_dma.ch) {
-			dev_err(dev, "Failed to get RX DMA channel\n");
-			ret = -EBUSY;
-			goto out;
-		}
-		spi->dma_rx = sdd->rx_dma.ch;
-
-		sdd->tx_dma.ch = dma_request_slave_channel_compat(mask, filter,
-				   sdd->cntrlr_info->dma_tx, dev, "tx");
-		if (!sdd->tx_dma.ch) {
-			dev_err(dev, "Failed to get TX DMA channel\n");
-			ret = -EBUSY;
-			goto out_rx;
-		}
-		spi->dma_tx = sdd->tx_dma.ch;
+	if (is_polling(sdd))
+		return 0;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	/* Acquire DMA channels */
+	sdd->rx_dma.ch = dma_request_slave_channel_compat(mask, filter,
+			   sdd->cntrlr_info->dma_rx, dev, "rx");
+	if (!sdd->rx_dma.ch) {
+		dev_err(dev, "Failed to get RX DMA channel\n");
+		return -EBUSY;
 	}
+	spi->dma_rx = sdd->rx_dma.ch;
 
-	return 0;
+	sdd->tx_dma.ch = dma_request_slave_channel_compat(mask, filter,
+			   sdd->cntrlr_info->dma_tx, dev, "tx");
+	if (!sdd->tx_dma.ch) {
+		dev_err(dev, "Failed to get TX DMA channel\n");
+		dma_release_channel(sdd->rx_dma.ch);
+		return -EBUSY;
+	}
+	spi->dma_tx = sdd->tx_dma.ch;
 
-out_rx:
-	dma_release_channel(sdd->rx_dma.ch);
-out:
-	return ret;
+	return 0;
 }
 
 static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
-- 
2.8.1
