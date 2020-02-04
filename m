From: Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/3] spi: spi-geni-qcom: Grow a dev pointer to simplify code
Date: Tue,  4 Feb 2020 11:12:05 -0800
Message-ID: <20200204191206.97036-3-swboyd@chromium.org>
References: <20200204191206.97036-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Dilip Kota <dkota-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Alok Chauhan <alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200204191206.97036-1-swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Some lines are long here. Use a struct dev pointer to shorten lines and
simplify code. The clk_get() call can fail because of EPROBE_DEFER
problems too, so just remove the error print message because it isn't
useful.

Cc: Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Dilip Kota <dkota-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Alok Chauhan <alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/spi/spi-geni-qcom.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 46e501fc87f3..f0ca7f5ae714 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -536,6 +536,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	struct spi_geni_master *mas;
 	void __iomem *base;
 	struct clk *clk;
+	struct device *dev = &pdev->dev;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -545,28 +546,25 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk = devm_clk_get(&pdev->dev, "se");
-	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "Err getting SE Core clk %ld\n",
-						PTR_ERR(clk));
+	clk = devm_clk_get(dev, "se");
+	if (IS_ERR(clk))
 		return PTR_ERR(clk);
-	}
 
-	spi = spi_alloc_master(&pdev->dev, sizeof(*mas));
+	spi = spi_alloc_master(dev, sizeof(*mas));
 	if (!spi)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, spi);
 	mas = spi_master_get_devdata(spi);
 	mas->irq = irq;
-	mas->dev = &pdev->dev;
-	mas->se.dev = &pdev->dev;
-	mas->se.wrapper = dev_get_drvdata(pdev->dev.parent);
+	mas->dev = dev;
+	mas->se.dev = dev;
+	mas->se.wrapper = dev_get_drvdata(dev->parent);
 	mas->se.base = base;
 	mas->se.clk = clk;
 
 	spi->bus_num = -1;
-	spi->dev.of_node = pdev->dev.of_node;
+	spi->dev.of_node = dev->of_node;
 	spi->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_CS_HIGH;
 	spi->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	spi->num_chipselect = 4;
@@ -579,13 +577,13 @@ static int spi_geni_probe(struct platform_device *pdev)
 
 	init_completion(&mas->xfer_done);
 	spin_lock_init(&mas->lock);
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev);
 
 	ret = spi_geni_init(mas);
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
 
-	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(&pdev->dev), spi);
+	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
 
@@ -597,7 +595,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 spi_geni_probe_free_irq:
 	free_irq(mas->irq, spi);
 spi_geni_probe_runtime_disable:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
 	spi_master_put(spi);
 	return ret;
 }
-- 
Sent by a computer, using git, on the internet
