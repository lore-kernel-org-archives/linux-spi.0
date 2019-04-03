From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 12/12] spi: gpio: Use devm_spi_register_master()
Date: Tue,  2 Apr 2019 21:01:33 -0700
Message-ID: <20190403040133.1459-13-andrew.smirnov@gmail.com>
References: <20190403040133.1459-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403040133.1459-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Replace spi_bitbang_start() with a combination of spi_bitbang_init()
and devm_spi_register_master() and drop all of the explicit
cleanup-related code that's no longer necessary.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 668f2cd82d98..674432bbbbc2 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -397,8 +397,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 
 	spi_gpio = spi_master_get_devdata(master);
 
-	platform_set_drvdata(pdev, spi_gpio);
-
 	status = spi_gpio_request(dev, spi_gpio);
 	if (status)
 		return status;
@@ -438,19 +436,11 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	}
 	bb->setup_transfer = spi_bitbang_setup_transfer;
 
-	return spi_bitbang_start(&spi_gpio->bitbang);
-}
-
-static int spi_gpio_remove(struct platform_device *pdev)
-{
-	struct spi_gpio			*spi_gpio;
-
-	spi_gpio = platform_get_drvdata(pdev);
-
-	/* stop() unregisters child devices too */
-	spi_bitbang_stop(&spi_gpio->bitbang);
+	status = spi_bitbang_init(&spi_gpio->bitbang);
+	if (status)
+		return status;
 
-	return 0;
+	return devm_spi_register_master(&pdev->dev, spi_master_get(master));
 }
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
@@ -461,7 +451,6 @@ static struct platform_driver spi_gpio_driver = {
 		.of_match_table = of_match_ptr(spi_gpio_dt_ids),
 	},
 	.probe		= spi_gpio_probe,
-	.remove		= spi_gpio_remove,
 };
 module_platform_driver(spi_gpio_driver);
 
-- 
2.20.1
