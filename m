From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] spi: spi-axi: Free resources on error path
Date: Mon,  9 Jan 2017 01:02:47 +0100
Message-ID: <20170109000247.3215-1-christophe.jaillet@wanadoo.fr>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

We should go to 'err_put_master' here instead of returning directly.
Otherwise a call to 'spi_master_put' is missing.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spi-axi-spi-engine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 319225d7e761..6ab4c7700228 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -494,7 +494,8 @@ static int spi_engine_probe(struct platform_device *pdev)
 			SPI_ENGINE_VERSION_MAJOR(version),
 			SPI_ENGINE_VERSION_MINOR(version),
 			SPI_ENGINE_VERSION_PATCH(version));
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_put_master;
 	}
 
 	spi_engine->clk = devm_clk_get(&pdev->dev, "s_axi_aclk");
-- 
2.9.3
