From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] spi: spi-fsl-dspi: Fix copy-paste error in dspi_probe
Date: Thu, 21 Jun 2018 08:22:09 -0500
Message-ID: <20180621132209.GA27215@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Esben Haabendal <eha@deif.com>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

It seems that the proper structure field to use in this particular
case is *regmap_pushr* instead of regmap.

Addresses-Coverity-ID: 1470126 ("Copy-paste error")
Fixes: 58ba07ec79e6 ("spi: spi-fsl-dspi: Add support for XSPI mode registers")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/spi/spi-fsl-dspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 1f85dcd..ff7456b 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1066,7 +1066,7 @@ static int dspi_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"failed to init pushr regmap: %ld\n",
 				PTR_ERR(dspi->regmap_pushr));
-			ret = PTR_ERR(dspi->regmap);
+			ret = PTR_ERR(dspi->regmap_pushr);
 			goto out_master_put;
 		}
 	}
-- 
2.7.4
