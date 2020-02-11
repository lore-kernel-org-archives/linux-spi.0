From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-geni-qcom: Grow a dev pointer to simplify code" to the spi tree
Date: Tue, 11 Feb 2020 15:51:53 +0000
Message-ID: <applied-20200204191206.97036-3-swboyd@chromium.org>
References: <20200204191206.97036-3-swboyd@chromium.org>
Cc: Alok Chauhan <alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Dilip Kota <dkota-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200204191206.97036-3-swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-geni-qcom: Grow a dev pointer to simplify code

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7

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

>From ea1e5b3354b1610ac16a780535fbdabfda9e6912 Mon Sep 17 00:00:00 2001
From: Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Date: Tue, 4 Feb 2020 11:12:05 -0800
Subject: [PATCH] spi: spi-geni-qcom: Grow a dev pointer to simplify code

Some lines are long here. Use a struct dev pointer to shorten lines and
simplify code. The clk_get() call can fail because of EPROBE_DEFER
problems too, so just remove the error print message because it isn't
useful.

Cc: Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Dilip Kota <dkota-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Alok Chauhan <alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Reviewed-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Link: https://lore.kernel.org/r/20200204191206.97036-3-swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
2.20.1
