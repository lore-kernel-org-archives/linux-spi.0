From: Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH RESEND] spi: spi-fsl-dspi: use IRQF_SHARED mode to request IRQ
Date: Mon, 29 Oct 2018 11:11:16 +0800
Message-ID: <20181029031116.37282-1-chuanhua.han@nxp.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuanhua Han <chuanhua.han@nxp.com>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Some SoC share one irq number between DSPI controllers.
For example, on the LX2160 board, DSPI0 and DSPI1 share one irq number.
In this case, only one DSPI controller can register successfully,
and others will fail.

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 3082e72e4f6c..5e10dc5c93a5 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1090,8 +1090,8 @@ static int dspi_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
-	ret = devm_request_irq(&pdev->dev, dspi->irq, dspi_interrupt, 0,
-			pdev->name, dspi);
+	ret = devm_request_irq(&pdev->dev, dspi->irq, dspi_interrupt,
+			       IRQF_SHARED, pdev->name, dspi);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to attach DSPI interrupt\n");
 		goto out_clk_put;
-- 
2.17.1
