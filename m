From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 05/12] spi: gpio: Drop unused pdata copy in struct spi_gpio
Date: Tue,  2 Apr 2019 21:01:26 -0700
Message-ID: <20190403040133.1459-6-andrew.smirnov@gmail.com>
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

Drop unused pdata copy in struct spi_gpio. No functional change
intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 137f47e271dc..1cff30adc836 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -42,7 +42,6 @@
 
 struct spi_gpio {
 	struct spi_bitbang		bitbang;
-	struct spi_gpio_platform_data	pdata;
 	struct platform_device		*pdev;
 	struct gpio_desc		*sck;
 	struct gpio_desc		*miso;
@@ -415,8 +414,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	spi_gpio->has_cs = !!pdata->num_chipselect;
 
 	spi_gpio->pdev = pdev;
-	if (pdata)
-		spi_gpio->pdata = *pdata;
 
 	status = spi_gpio_request(dev, spi_gpio,
 				  pdata->num_chipselect, &master_flags);
-- 
2.20.1
