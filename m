From: Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] spi: lpspi: fix memory leak in fsl_lpspi_probe
Date: Sun, 29 Sep 2019 22:46:01 -0500
Message-ID: <20190930034602.1467-1-navid.emamdoost@gmail.com>
Cc: emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

In fsl_lpspi_probe an SPI controller is allocated either via
spi_alloc_slave or spi_alloc_master. In all but one error cases this
controller is put by going to error handling code. This commit fixes the
case when pm_runtime_get_sync fails and it should go to the error
handling path.

Fixes: 944c01a889d9 ("spi: lpspi: enable runtime pm for lpspi")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index d08e9324140e..3528ed5eea9b 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -938,7 +938,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(fsl_lpspi->dev);
 	if (ret < 0) {
 		dev_err(fsl_lpspi->dev, "failed to enable clock\n");
-		return ret;
+		goto out_controller_put;
 	}
 
 	temp = readl(fsl_lpspi->base + IMX7ULP_PARAM);
-- 
2.17.1
