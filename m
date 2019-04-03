From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 01/12] spi: gpio: Drop unused spi_to_pdata()
Date: Tue,  2 Apr 2019 21:01:22 -0700
Message-ID: <20190403040133.1459-2-andrew.smirnov@gmail.com>
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

Spi_to_pdata() is not used anywhere in the code. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 53b35c56a557..675fd65ebf1d 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -96,12 +96,6 @@ spi_to_spi_gpio(const struct spi_device *spi)
 	return spi_gpio;
 }
 
-static inline struct spi_gpio_platform_data *__pure
-spi_to_pdata(const struct spi_device *spi)
-{
-	return &spi_to_spi_gpio(spi)->pdata;
-}
-
 /* These helpers are in turn called by the bitbang inlines */
 static inline void setsck(const struct spi_device *spi, int is_on)
 {
-- 
2.20.1
