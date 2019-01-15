From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 2/4] spi: sprd: Add the SPI irq function for the SPI DMA mode
Date: Tue, 15 Jan 2019 21:46:51 +0800
Message-ID: <ec1741f29c44c436c1086877ff5b208e6b8af45d.1547559542.git.baolin.wang@linaro.org>
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
In-Reply-To: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Lanqing Liu <lanqing.liu@spreadtrum.com>

The SPI irq event will use to complete the SPI work in the SPI DMA mode,
so this patch is a preparation for the following DMA mode support.

Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index fa324ce..bfba30b 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -133,6 +133,7 @@ struct sprd_spi {
 	void __iomem *base;
 	struct device *dev;
 	struct clk *clk;
+	int irq;
 	u32 src_clk;
 	u32 hw_mode;
 	u32 trans_len;
@@ -141,6 +142,7 @@ struct sprd_spi {
 	u32 hw_speed_hz;
 	u32 len;
 	int status;
+	struct completion xfer_completion;
 	const void *tx_buf;
 	void *rx_buf;
 	int (*read_bufs)(struct sprd_spi *ss, u32 len);
@@ -575,6 +577,45 @@ static int sprd_spi_transfer_one(struct spi_controller *sctlr,
 	return ret;
 }
 
+static irqreturn_t sprd_spi_handle_irq(int irq, void *data)
+{
+	struct sprd_spi *ss = (struct sprd_spi *)data;
+	u32 val = readl_relaxed(ss->base + SPRD_SPI_INT_MASK_STS);
+
+	if (val & SPRD_SPI_MASK_TX_END) {
+		writel_relaxed(SPRD_SPI_TX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
+		if (!(ss->trans_mode & SPRD_SPI_RX_MODE))
+			complete(&ss->xfer_completion);
+		return IRQ_HANDLED;
+	}
+
+	if (val & SPRD_SPI_MASK_RX_END) {
+		writel_relaxed(SPRD_SPI_RX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
+		complete(&ss->xfer_completion);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int sprd_spi_irq_init(struct platform_device *pdev, struct sprd_spi *ss)
+{
+	int ret;
+
+	ss->irq = platform_get_irq(pdev, 0);
+	if (ss->irq < 0) {
+		dev_err(&pdev->dev, "failed to get irq resource\n");
+		return ss->irq;
+	}
+
+	ret = devm_request_irq(&pdev->dev, ss->irq, sprd_spi_handle_irq,
+				0, pdev->name, ss);
+	if (ret)
+		dev_err(&pdev->dev, "failed to request spi irq %d, ret = %d\n",
+			ss->irq, ret);
+
+	return ret;
+}
+
 static int sprd_spi_clk_init(struct platform_device *pdev, struct sprd_spi *ss)
 {
 	struct clk *clk_spi, *clk_parent;
@@ -635,11 +676,16 @@ static int sprd_spi_probe(struct platform_device *pdev)
 	sctlr->max_speed_hz = min_t(u32, ss->src_clk >> 1,
 				    SPRD_SPI_MAX_SPEED_HZ);
 
+	init_completion(&ss->xfer_completion);
 	platform_set_drvdata(pdev, sctlr);
 	ret = sprd_spi_clk_init(pdev, ss);
 	if (ret)
 		goto free_controller;
 
+	ret = sprd_spi_irq_init(pdev, ss);
+	if (ret)
+		goto free_controller;
+
 	ret = clk_prepare_enable(ss->clk);
 	if (ret)
 		goto free_controller;
-- 
1.7.9.5
