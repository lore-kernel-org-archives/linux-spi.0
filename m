From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: gpio: Add local struct device pointer in spi_gpio_probe()" to the spi tree
Date: Wed,  3 Apr 2019 05:42:33 +0100 (BST)
Message-ID: <20190403044233.7DEDF440083@finisterre.ee.mobilebroadband>
References: <20190403040133.1459-3-andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403040133.1459-3-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: gpio: Add local struct device pointer in spi_gpio_probe()

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

>From 96cad6d78f7f8feac456002020971cba6073bff9 Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 2 Apr 2019 21:01:23 -0700
Subject: [PATCH] spi: gpio: Add local struct device pointer in
 spi_gpio_probe()

Use a local "struct device *dev" in spi_gpio_probe() for brevity. No
functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 675fd65ebf1d..2869af5ff936 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -379,6 +379,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	struct spi_master		*master;
 	struct spi_gpio			*spi_gpio;
 	struct spi_gpio_platform_data	*pdata;
+	struct device			*dev = &pdev->dev;
 	u16 master_flags = 0;
 	bool use_of = 0;
 
@@ -388,19 +389,19 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	if (status > 0)
 		use_of = 1;
 
-	pdata = dev_get_platdata(&pdev->dev);
+	pdata = dev_get_platdata(dev);
 #ifdef GENERIC_BITBANG
 	if (!pdata || (!use_of && !pdata->num_chipselect))
 		return -ENODEV;
 #endif
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*spi_gpio));
+	master = spi_alloc_master(dev, sizeof(*spi_gpio));
 	if (!master)
 		return -ENOMEM;
 
 	spi_gpio = spi_master_get_devdata(master);
 
-	spi_gpio->cs_gpios = devm_kcalloc(&pdev->dev,
+	spi_gpio->cs_gpios = devm_kcalloc(dev,
 				pdata->num_chipselect,
 				sizeof(*spi_gpio->cs_gpios),
 				GFP_KERNEL);
@@ -416,7 +417,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	if (pdata)
 		spi_gpio->pdata = *pdata;
 
-	status = spi_gpio_request(&pdev->dev, spi_gpio,
+	status = spi_gpio_request(dev, spi_gpio,
 				  pdata->num_chipselect, &master_flags);
 	if (status)
 		return status;
@@ -431,7 +432,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	master->setup = spi_gpio_setup;
 	master->cleanup = spi_gpio_cleanup;
 #ifdef CONFIG_OF
-	master->dev.of_node = pdev->dev.of_node;
+	master->dev.of_node = dev->of_node;
 #endif
 
 	spi_gpio->bitbang.master = master;
-- 
2.20.1
