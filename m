From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] spi/imx: simplify error handling to free gpios
Date: Mon, 05 Dec 2011 15:47:08 +0800
Message-ID: <1323071228.20963.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Simplify the error handling by moving the code to free gpios in one place.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/spi/spi-imx.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index c6e697f..31054e3 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -793,13 +793,8 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 
 		ret = gpio_request(spi_imx->chipselect[i], DRIVER_NAME);
 		if (ret) {
-			while (i > 0) {
-				i--;
-				if (spi_imx->chipselect[i] >= 0)
-					gpio_free(spi_imx->chipselect[i]);
-			}
 			dev_err(&pdev->dev, "can't get cs gpios\n");
-			goto out_master_put;
+			goto out_gpio_free;
 		}
 	}
 
@@ -881,10 +876,10 @@ out_iounmap:
 out_release_mem:
 	release_mem_region(res->start, resource_size(res));
 out_gpio_free:
-	for (i = 0; i < master->num_chipselect; i++)
+	while (--i >= 0) {
 		if (spi_imx->chipselect[i] >= 0)
 			gpio_free(spi_imx->chipselect[i]);
-out_master_put:
+	}
 	spi_master_put(master);
 	kfree(master);
 	platform_set_drvdata(pdev, NULL);
-- 
1.7.5.4
