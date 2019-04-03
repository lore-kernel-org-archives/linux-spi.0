From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 09/12] spi: gpio: Drop unused pdev field in struct spi_gpio
Date: Tue,  2 Apr 2019 21:01:30 -0700
Message-ID: <20190403040133.1459-10-andrew.smirnov@gmail.com>
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

There's no code using 'pdev' field in struct spi_gpio. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 84ca803f6f69..3a6a9c6966c0 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -42,7 +42,6 @@
 
 struct spi_gpio {
 	struct spi_bitbang		bitbang;
-	struct platform_device		*pdev;
 	struct gpio_desc		*sck;
 	struct gpio_desc		*miso;
 	struct gpio_desc		*mosi;
@@ -391,8 +390,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, spi_gpio);
 
-	spi_gpio->pdev = pdev;
-
 	status = spi_gpio_request(dev, spi_gpio);
 	if (status)
 		return status;
-- 
2.20.1
