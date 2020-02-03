From: <patrice.chotard@st.com>
Subject: [PATCH 2/2] spi: stm32-qspi: properly manage probe errors
Date: Mon, 3 Feb 2020 14:50:48 +0100
Message-ID: <20200203135048.1299-3-patrice.chotard@st.com>
References: <20200203135048.1299-1-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <patrice.chotard@st.com>, <christophe.kerello@st.com>,
        Lionel Debieve <lionel.debieve@st.com>,
        Etienne Carriere <etienne.carriere@st.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200203135048.1299-1-patrice.chotard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Lionel Debieve <lionel.debieve@st.com>

Fix resource release issues when driver probe operation fails.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/spi/spi-stm32-qspi.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 13bb64bf4c8f..d066f5144c3e 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -565,7 +565,7 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	qspi->io_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(qspi->io_base)) {
 		ret = PTR_ERR(qspi->io_base);
-		goto err;
+		goto err_master_put;
 	}
 
 	qspi->phys_base = res->start;
@@ -574,24 +574,26 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	qspi->mm_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(qspi->mm_base)) {
 		ret = PTR_ERR(qspi->mm_base);
-		goto err;
+		goto err_master_put;
 	}
 
 	qspi->mm_size = resource_size(res);
 	if (qspi->mm_size > STM32_QSPI_MAX_MMAP_SZ) {
 		ret = -EINVAL;
-		goto err;
+		goto err_master_put;
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto err_master_put;
+	}
 
 	ret = devm_request_irq(dev, irq, stm32_qspi_irq, 0,
 			       dev_name(dev), qspi);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
-		goto err;
+		goto err_master_put;
 	}
 
 	init_completion(&qspi->data_completion);
@@ -599,26 +601,26 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	qspi->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(qspi->clk)) {
 		ret = PTR_ERR(qspi->clk);
-		goto err;
+		goto err_master_put;
 	}
 
 	qspi->clk_rate = clk_get_rate(qspi->clk);
 	if (!qspi->clk_rate) {
 		ret = -EINVAL;
-		goto err;
+		goto err_master_put;
 	}
 
 	ret = clk_prepare_enable(qspi->clk);
 	if (ret) {
 		dev_err(dev, "can not enable the clock\n");
-		goto err;
+		goto err_master_put;
 	}
 
 	rstc = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(rstc)) {
 		ret = PTR_ERR(rstc);
 		if (ret == -EPROBE_DEFER)
-			goto err;
+			goto err_qspi_release;
 	} else {
 		reset_control_assert(rstc);
 		udelay(2);
@@ -629,7 +631,7 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, qspi);
 	ret = stm32_qspi_dma_setup(qspi);
 	if (ret)
-		goto err;
+		goto err_qspi_release;
 
 	mutex_init(&qspi->lock);
 
@@ -645,8 +647,9 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	if (!ret)
 		return 0;
 
-err:
+err_qspi_release:
 	stm32_qspi_release(qspi);
+err_master_put:
 	spi_master_put(qspi->ctrl);
 
 	return ret;
-- 
2.17.1
