From: cezary.gapinski@gmail.com
Subject: [PATCH v2 02/14] spi: stm32: use NULL pointer instead of plain integer
Date: Mon, 24 Dec 2018 23:00:28 +0100
Message-ID: <1545688840-23992-3-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Patch fixes sparse warning: Using plain integer as NULL pointer. Replaces
second argument of function devm_clk_get from 0 to NULL.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 5f30578..51d7f72 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1100,7 +1100,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_master_put;
 	}
 
-	spi->clk = devm_clk_get(&pdev->dev, 0);
+	spi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(spi->clk)) {
 		ret = PTR_ERR(spi->clk);
 		dev_err(&pdev->dev, "clk get failed: %d\n", ret);
-- 
2.7.4
