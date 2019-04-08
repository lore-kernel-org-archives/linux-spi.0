From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: gpio: Make sure spi_master_put() is called in every error path" to the spi tree
Date: Mon,  8 Apr 2019 14:32:33 +0700 (+07)
Message-ID: <20190408073233.0EFC6441D3B@finisterre.ee.mobilebroadband>
References: <20190403040133.1459-11-andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403040133.1459-11-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: gpio: Make sure spi_master_put() is called in every error path

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

>From 8b797490b4db09492acda4b4a4a4355d2311a614 Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 2 Apr 2019 21:01:31 -0700
Subject: [PATCH] spi: gpio: Make sure spi_master_put() is called in every
 error path

There's a number of failure paths in spi_gpio_probe() that do not call
spi_master_put() potentially leaking memory. Fix this problem by
registering a cleanup funciont via devm_add_action_or_reset() right
after SPI controller is allocated.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 5ac9ae192ddf..d4a22f22b04c 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -362,6 +362,11 @@ static int spi_gpio_probe_pdata(struct platform_device *pdev,
 	return 0;
 }
 
+static void spi_gpio_put(void *data)
+{
+	spi_master_put(data);
+}
+
 static int spi_gpio_probe(struct platform_device *pdev)
 {
 	int				status;
@@ -377,6 +382,10 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
+	status = devm_add_action_or_reset(&pdev->dev, spi_gpio_put, master);
+	if (status)
+		return status;
+
 	if (of_id)
 		status = spi_gpio_probe_dt(pdev, master);
 	else
@@ -428,11 +437,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	}
 	bb->setup_transfer = spi_bitbang_setup_transfer;
 
-	status = spi_bitbang_start(&spi_gpio->bitbang);
-	if (status)
-		spi_master_put(master);
-
-	return status;
+	return spi_bitbang_start(&spi_gpio->bitbang);
 }
 
 static int spi_gpio_remove(struct platform_device *pdev)
@@ -444,8 +449,6 @@ static int spi_gpio_remove(struct platform_device *pdev)
 	/* stop() unregisters child devices too */
 	spi_bitbang_stop(&spi_gpio->bitbang);
 
-	spi_master_put(spi_gpio->bitbang.master);
-
 	return 0;
 }
 
-- 
2.20.1
