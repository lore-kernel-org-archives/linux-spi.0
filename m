From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 10/12] spi: gpio: Make sure spi_master_put() is called in every error path
Date: Tue,  2 Apr 2019 21:01:31 -0700
Message-ID: <20190403040133.1459-11-andrew.smirnov@gmail.com>
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

There's a number of failure paths in spi_gpio_probe() that do not call
spi_master_put() potentially leaking memory. Fix this problem by
registering a cleanup funciont via devm_add_action_or_reset() right
after SPI controller is allocated.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 3a6a9c6966c0..668f2cd82d98 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -363,6 +363,11 @@ static int spi_gpio_probe_pdata(struct platform_device *pdev,
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
@@ -378,6 +383,10 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
+	status = devm_add_action_or_reset(&pdev->dev, spi_gpio_put, master);
+	if (status)
+		return status;
+
 	if (of_id)
 		status = spi_gpio_probe_dt(pdev, master);
 	else
@@ -429,11 +438,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
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
@@ -445,8 +450,6 @@ static int spi_gpio_remove(struct platform_device *pdev)
 	/* stop() unregisters child devices too */
 	spi_bitbang_stop(&spi_gpio->bitbang);
 
-	spi_master_put(spi_gpio->bitbang.master);
-
 	return 0;
 }
 
-- 
2.20.1
