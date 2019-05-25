From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] spi: gpio: fix warning PTR_ERR_OR_ZERO can be used
Date: Sat, 25 May 2019 15:17:05 +0530
Message-ID: <20190525094705.GA23374@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

fix below warning reported by coccicheck

./drivers/spi/spi-gpio.c:302:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/spi/spi-gpio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 487ee55..8c5b98a 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -299,10 +299,8 @@ static int spi_gpio_request(struct device *dev, struct spi_gpio *spi_gpio)
 		return PTR_ERR(spi_gpio->miso);
 
 	spi_gpio->sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_LOW);
-	if (IS_ERR(spi_gpio->sck))
-		return PTR_ERR(spi_gpio->sck);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(spi_gpio->sck);
 }
 
 #ifdef CONFIG_OF
-- 
2.7.4
