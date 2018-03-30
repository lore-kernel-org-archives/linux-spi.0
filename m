From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] spi: stm32: Fix error handling in stm32_spi_probe()
Date: Fri, 30 Mar 2018 22:54:44 +0300
Message-ID: <1522439684-7510-1-git-send-email-khoroshilov@ispras.ru>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
To: Mark Brown <broonie@kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

clk_get_rate() is below clk_prepare_enable(), so
its error should lead to goto err_clk_disable, not to err_master_put.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index ba9743fa2326..ad1e55d3d5d5 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1129,7 +1129,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	if (!spi->clk_rate) {
 		dev_err(&pdev->dev, "clk rate = 0\n");
 		ret = -EINVAL;
-		goto err_master_put;
+		goto err_clk_disable;
 	}
 
 	spi->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-- 
2.7.4
