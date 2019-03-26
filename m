From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: stm32-qspi: add spi_master_put in release function" to the spi tree
Date: Tue, 26 Mar 2019 14:43:13 +0000 (GMT)
Message-ID: <20190326144313.E58A41121B57@debutante.sirena.org.uk>
References: <1553533300-29999-2-git-send-email-ludovic.Barre@st.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
To: Ludovic Barre <ludovic.barre@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553533300-29999-2-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: stm32-qspi: add spi_master_put in release function

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

>From a88eceb17ac7e8dc4ad9995681af61c8371668f4 Mon Sep 17 00:00:00 2001
From: Ludovic Barre <ludovic.barre@st.com>
Date: Mon, 25 Mar 2019 18:01:39 +0100
Subject: [PATCH] spi: stm32-qspi: add spi_master_put in release function

This patch adds spi_master_put in release function
to drop the controller's refcount.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32-qspi.c | 46 ++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 7879a523583c..9875139ef0cf 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -93,6 +93,7 @@ struct stm32_qspi_flash {
 
 struct stm32_qspi {
 	struct device *dev;
+	struct spi_controller *ctrl;
 	void __iomem *io_base;
 	void __iomem *mm_base;
 	resource_size_t mm_size;
@@ -400,6 +401,7 @@ static void stm32_qspi_release(struct stm32_qspi *qspi)
 	writel_relaxed(0, qspi->io_base + QSPI_CR);
 	mutex_destroy(&qspi->lock);
 	clk_disable_unprepare(qspi->clk);
+	spi_master_put(qspi->ctrl);
 }
 
 static int stm32_qspi_probe(struct platform_device *pdev)
@@ -416,43 +418,54 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	qspi = spi_controller_get_devdata(ctrl);
+	qspi->ctrl = ctrl;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi");
 	qspi->io_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(qspi->io_base))
-		return PTR_ERR(qspi->io_base);
+	if (IS_ERR(qspi->io_base)) {
+		ret = PTR_ERR(qspi->io_base);
+		goto err;
+	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_mm");
 	qspi->mm_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(qspi->mm_base))
-		return PTR_ERR(qspi->mm_base);
+	if (IS_ERR(qspi->mm_base)) {
+		ret = PTR_ERR(qspi->mm_base);
+		goto err;
+	}
 
 	qspi->mm_size = resource_size(res);
-	if (qspi->mm_size > STM32_QSPI_MAX_MMAP_SZ)
-		return -EINVAL;
+	if (qspi->mm_size > STM32_QSPI_MAX_MMAP_SZ) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(dev, irq, stm32_qspi_irq, 0,
 			       dev_name(dev), qspi);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
-		return ret;
+		goto err;
 	}
 
 	init_completion(&qspi->data_completion);
 
 	qspi->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(qspi->clk))
-		return PTR_ERR(qspi->clk);
+	if (IS_ERR(qspi->clk)) {
+		ret = PTR_ERR(qspi->clk);
+		goto err;
+	}
 
 	qspi->clk_rate = clk_get_rate(qspi->clk);
-	if (!qspi->clk_rate)
-		return -EINVAL;
+	if (!qspi->clk_rate) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	ret = clk_prepare_enable(qspi->clk);
 	if (ret) {
 		dev_err(dev, "can not enable the clock\n");
-		return ret;
+		goto err;
 	}
 
 	rstc = devm_reset_control_get_exclusive(dev, NULL);
@@ -475,14 +488,11 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	ctrl->dev.of_node = dev->of_node;
 
 	ret = devm_spi_register_master(dev, ctrl);
-	if (ret)
-		goto err_spi_register;
-
-	return 0;
+	if (!ret)
+		return 0;
 
-err_spi_register:
+err:
 	stm32_qspi_release(qspi);
-
 	return ret;
 }
 
-- 
2.20.1
