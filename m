From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: gpio: Use devm_spi_register_master()" to the spi tree
Date: Mon,  8 Apr 2019 14:32:15 +0700 (+07)
Message-ID: <20190408073215.70AD5441D3B@finisterre.ee.mobilebroadband>
References: <20190403040133.1459-13-andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403040133.1459-13-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: gpio: Use devm_spi_register_master()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 79567c1a321e7396e734135d56950311dde07db2 Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 2 Apr 2019 21:01:33 -0700
Subject: [PATCH] spi: gpio: Use devm_spi_register_master()

Replace spi_bitbang_start() with a combination of spi_bitbang_init()
and devm_spi_register_master() and drop all of the explicit
cleanup-related code that's no longer necessary.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index d4a22f22b04c..487ee55d26f7 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -396,8 +396,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 
 	spi_gpio = spi_master_get_devdata(master);
 
-	platform_set_drvdata(pdev, spi_gpio);
-
 	status = spi_gpio_request(dev, spi_gpio);
 	if (status)
 		return status;
@@ -437,19 +435,11 @@ static int spi_gpio_probe(struct platform_device *pdev)
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
@@ -460,7 +450,6 @@ static struct platform_driver spi_gpio_driver = {
 		.of_match_table = of_match_ptr(spi_gpio_dt_ids),
 	},
 	.probe		= spi_gpio_probe,
-	.remove		= spi_gpio_remove,
 };
 module_platform_driver(spi_gpio_driver);
 
-- 
2.20.1
