From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sprd: Add the SPI irq function for the SPI DMA mode" to the spi tree
Date: Wed, 13 Feb 2019 12:31:56 +0000 (GMT)
Message-ID: <20190213123156.8AC751128159@debutante.sirena.org.uk>
References: <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Lanqing Liu <lanqing.liu@unisoc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sprd: Add the SPI irq function for the SPI DMA mode

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From de082d866cced9e172ca909b084f91df631ae7fe Mon Sep 17 00:00:00 2001
From: Lanqing Liu <lanqing.liu@unisoc.com>
Date: Wed, 13 Feb 2019 15:36:09 +0800
Subject: [PATCH] spi: sprd: Add the SPI irq function for the SPI DMA mode

The SPI irq event will use to complete the SPI work in the SPI DMA mode,
so this patch is a preparation for the following DMA mode support.

Moreover the SPI interrupt can be fired when removing the SPI controller,
so we should make sure the SPI controller has stopped the queue in
remove function before freeing the SPI irq.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 8daa24eec624..06578412b04d 100644
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
@@ -573,6 +575,48 @@ static int sprd_spi_transfer_one(struct spi_controller *sctlr,
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
+
+		return IRQ_HANDLED;
+	}
+
+	if (val & SPRD_SPI_MASK_RX_END) {
+		writel_relaxed(SPRD_SPI_RX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
+		complete(&ss->xfer_completion);
+
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
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
@@ -633,11 +677,16 @@ static int sprd_spi_probe(struct platform_device *pdev)
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
@@ -688,6 +737,8 @@ static int sprd_spi_remove(struct platform_device *pdev)
 		return ret;
 	}
 
+	spi_controller_suspend(sctlr);
+
 	clk_disable_unprepare(ss->clk);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.20.1
