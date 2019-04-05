From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: gpio: Drop unused pdev field in struct spi_gpio" to the spi tree
Date: Fri,  5 Apr 2019 10:26:31 +0700 (+07)
Message-ID: <20190405032631.AAA1C441D3B@finisterre.ee.mobilebroadband>
References: <20190403040133.1459-10-andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403040133.1459-10-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: gpio: Drop unused pdev field in struct spi_gpio

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

>From 45f7718ae713e52def029c071cdba19a8045ac52 Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 2 Apr 2019 21:01:30 -0700
Subject: [PATCH] spi: gpio: Drop unused pdev field in struct spi_gpio

There's no code using 'pdev' field in struct spi_gpio. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 4b2a80abf36e..5ac9ae192ddf 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -41,7 +41,6 @@
 
 struct spi_gpio {
 	struct spi_bitbang		bitbang;
-	struct platform_device		*pdev;
 	struct gpio_desc		*sck;
 	struct gpio_desc		*miso;
 	struct gpio_desc		*mosi;
@@ -390,8 +389,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, spi_gpio);
 
-	spi_gpio->pdev = pdev;
-
 	status = spi_gpio_request(dev, spi_gpio);
 	if (status)
 		return status;
-- 
2.20.1
