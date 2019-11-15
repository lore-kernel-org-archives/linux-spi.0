From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] spi: tegra20-slink: add missed clk_unprepare
Date: Fri, 15 Nov 2019 16:31:22 +0800
Message-ID: <20191115083122.12278-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The driver misses calling clk_unprepare in probe failure and remove.
Add the calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/spi/spi-tegra20-slink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 111fffc91435..374a2a32edcd 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1073,7 +1073,7 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	ret = clk_enable(tspi->clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Clock enable failed %d\n", ret);
-		goto exit_free_master;
+		goto exit_clk_unprepare;
 	}
 
 	spi_irq = platform_get_irq(pdev, 0);
@@ -1146,6 +1146,8 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	free_irq(spi_irq, tspi);
 exit_clk_disable:
 	clk_disable(tspi->clk);
+exit_clk_unprepare:
+	clk_unprepare(tspi->clk);
 exit_free_master:
 	spi_master_put(master);
 	return ret;
@@ -1159,6 +1161,7 @@ static int tegra_slink_remove(struct platform_device *pdev)
 	free_irq(tspi->irq, tspi);
 
 	clk_disable(tspi->clk);
+	clk_unprepare(tspi->clk);
 
 	if (tspi->tx_dma_chan)
 		tegra_slink_deinit_dma_param(tspi, false);
-- 
2.24.0
