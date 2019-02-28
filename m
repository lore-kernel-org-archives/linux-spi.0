From: Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH 2/2] spi: dw: Add support for an optional interface clock
Date: Thu, 28 Feb 2019 13:25:42 +0000
Message-ID: <1551360342-23981-3-git-send-email-gareth.williams.jx@renesas.com>
References: <1551360342-23981-1-git-send-email-gareth.williams.jx@renesas.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551360342-23981-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

The Synopsys SSI Controller has an interface clock, but most SoCs hide 
this away. However, on some SoCs you need to explicity enable the 
interface clock in order to access the registers. Therefore, add 
support for an optional interface clock.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
---
 drivers/spi/spi-dw-mmio.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 4bd59a9..7cbc173 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -30,6 +30,7 @@
 struct dw_spi_mmio {
 	struct dw_spi  dws;
 	struct clk     *clk;
+	struct clk     *pclk;
 	void           *priv;
 };
 
@@ -172,6 +173,14 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Optional interface clock */
+	dwsmmio->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
+	if (IS_ERR(dwsmmio->pclk))
+		return PTR_ERR(dwsmmio->pclk);
+	ret = clk_prepare_enable(dwsmmio->pclk);
+	if (ret)
+		goto out_clk;
+
 	dws->bus_num = pdev->id;
 
 	dws->max_freq = clk_get_rate(dwsmmio->clk);
@@ -199,6 +208,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	return 0;
 
 out:
+	clk_disable_unprepare(dwsmmio->pclk);
+out_clk:
 	clk_disable_unprepare(dwsmmio->clk);
 	return ret;
 }
@@ -208,6 +219,7 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
 	struct dw_spi_mmio *dwsmmio = platform_get_drvdata(pdev);
 
 	dw_spi_remove_host(&dwsmmio->dws);
+	clk_disable_unprepare(dwsmmio->pclk);
 	clk_disable_unprepare(dwsmmio->clk);
 
 	return 0;
-- 
2.7.4
