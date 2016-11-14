From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] spi: atmel: fix indenting in atmel_spi_gpio_cs()
Date: Mon, 14 Nov 2016 17:26:44 +0300
Message-ID: <20161114142644.GA6179@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

These lines were indented one extra tab.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index d3affa6..b293149 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1510,15 +1510,15 @@ static int atmel_spi_gpio_cs(struct platform_device *pdev)
 		int cs_gpio = of_get_named_gpio(pdev->dev.of_node,
 						"cs-gpios", i);
 
-			if (cs_gpio == -EPROBE_DEFER)
-				return cs_gpio;
-
-			if (gpio_is_valid(cs_gpio)) {
-				ret = devm_gpio_request(&pdev->dev, cs_gpio,
-							dev_name(&pdev->dev));
-				if (ret)
-					return ret;
-			}
+		if (cs_gpio == -EPROBE_DEFER)
+			return cs_gpio;
+
+		if (gpio_is_valid(cs_gpio)) {
+			ret = devm_gpio_request(&pdev->dev, cs_gpio,
+						dev_name(&pdev->dev));
+			if (ret)
+				return ret;
+		}
 	}
 
 	return 0;
