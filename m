From: Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH 2/2] spi: spi-geni-qcom: Simplify probe function
Date: Thu, 25 Oct 2018 22:10:29 +0530
Message-ID: <1540485629-5970-3-git-send-email-alokc@codeaurora.org>
References: <1540485629-5970-1-git-send-email-alokc@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>
To: swboyd@chromium.org, dianders@chromium.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540485629-5970-1-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Re-arrange existing APIs in probe function to
avoid using goto and remove redundant variables.

Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
---
 drivers/spi/spi-geni-qcom.c | 49 ++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index d1830fb..fdb7cb88 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -535,11 +535,30 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 
 static int spi_geni_probe(struct platform_device *pdev)
 {
-	int ret;
+	int ret, irq;
 	struct spi_master *spi;
 	struct spi_geni_master *mas;
 	struct resource *res;
-	struct geni_se *se;
+	void __iomem *base;
+	struct clk *clk;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Err getting IRQ %d\n", irq);
+		return irq;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk = devm_clk_get(&pdev->dev, "se");
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "Err getting SE Core clk %ld\n",
+						PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
 
 	spi = spi_alloc_master(&pdev->dev, sizeof(*mas));
 	if (!spi)
@@ -547,27 +566,15 @@ static int spi_geni_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, spi);
 	mas = spi_master_get_devdata(spi);
+	mas->irq = irq;
 	mas->dev = &pdev->dev;
 	mas->se.dev = &pdev->dev;
 	mas->se.wrapper = dev_get_drvdata(pdev->dev.parent);
-	se = &mas->se;
+	mas->se.base = base;
+	mas->se.clk = clk;
 
 	spi->bus_num = -1;
 	spi->dev.of_node = pdev->dev.of_node;
-	mas->se.clk = devm_clk_get(&pdev->dev, "se");
-	if (IS_ERR(mas->se.clk)) {
-		ret = PTR_ERR(mas->se.clk);
-		dev_err(&pdev->dev, "Err getting SE Core clk %d\n", ret);
-		goto spi_geni_probe_err;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	se->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(se->base)) {
-		ret = PTR_ERR(se->base);
-		goto spi_geni_probe_err;
-	}
-
 	spi->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_CS_HIGH;
 	spi->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	spi->num_chipselect = 4;
@@ -586,13 +593,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
 
-	mas->irq = platform_get_irq(pdev, 0);
-	if (mas->irq < 0) {
-		ret = mas->irq;
-		dev_err(&pdev->dev, "Err getting IRQ %d\n", ret);
-		goto spi_geni_probe_runtime_disable;
-	}
-
 	ret = request_irq(mas->irq, geni_spi_isr,
 			IRQF_TRIGGER_HIGH, "spi_geni", spi);
 	if (ret)
@@ -607,7 +607,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	free_irq(mas->irq, spi);
 spi_geni_probe_runtime_disable:
 	pm_runtime_disable(&pdev->dev);
-spi_geni_probe_err:
 	spi_master_put(spi);
 	return ret;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
