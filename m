From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: tegra20-slink: explicitly enable/disable clock" to the spi tree
Date: Mon,  3 Sep 2018 14:47:24 +0100 (BST)
Message-ID: <20180903134724.C235111227AE@debutante.sirena.org.uk>
References: <20180829064757.16349-1-marcel@ziswiler.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-spi@vger.kernel.org
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180829064757.16349-1-marcel@ziswiler.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: tegra20-slink: explicitly enable/disable clock

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

>From 7001cab1dabc0b72b2b672ef58a90ab64f5e2343 Mon Sep 17 00:00:00 2001
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Date: Wed, 29 Aug 2018 08:47:57 +0200
Subject: [PATCH] spi: tegra20-slink: explicitly enable/disable clock

Depending on the SPI instance one may get an interrupt storm upon
requesting resp. interrupt unless the clock is explicitly enabled
beforehand. This has been observed trying to bring up instance 4 on
T20.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-tegra20-slink.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 6f7b946b5ced..1427f343b39a 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1063,6 +1063,24 @@ static int tegra_slink_probe(struct platform_device *pdev)
 		goto exit_free_master;
 	}
 
+	/* disabled clock may cause interrupt storm upon request */
+	tspi->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(tspi->clk)) {
+		ret = PTR_ERR(tspi->clk);
+		dev_err(&pdev->dev, "Can not get clock %d\n", ret);
+		goto exit_free_master;
+	}
+	ret = clk_prepare(tspi->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Clock prepare failed %d\n", ret);
+		goto exit_free_master;
+	}
+	ret = clk_enable(tspi->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Clock enable failed %d\n", ret);
+		goto exit_free_master;
+	}
+
 	spi_irq = platform_get_irq(pdev, 0);
 	tspi->irq = spi_irq;
 	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,
@@ -1071,14 +1089,7 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
 					tspi->irq);
-		goto exit_free_master;
-	}
-
-	tspi->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(tspi->clk)) {
-		dev_err(&pdev->dev, "can not get clock\n");
-		ret = PTR_ERR(tspi->clk);
-		goto exit_free_irq;
+		goto exit_clk_disable;
 	}
 
 	tspi->rst = devm_reset_control_get_exclusive(&pdev->dev, "spi");
@@ -1138,6 +1149,8 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	tegra_slink_deinit_dma_param(tspi, true);
 exit_free_irq:
 	free_irq(spi_irq, tspi);
+exit_clk_disable:
+	clk_disable(tspi->clk);
 exit_free_master:
 	spi_master_put(master);
 	return ret;
@@ -1150,6 +1163,8 @@ static int tegra_slink_remove(struct platform_device *pdev)
 
 	free_irq(tspi->irq, tspi);
 
+	clk_disable(tspi->clk);
+
 	if (tspi->tx_dma_chan)
 		tegra_slink_deinit_dma_param(tspi, false);
 
-- 
2.19.0.rc1
