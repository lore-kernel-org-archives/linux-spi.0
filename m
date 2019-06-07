From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] spi: spi-gpio: Make probe function __init_or_module
Date: Fri,  7 Jun 2019 17:56:31 +0200
Message-ID: <20190607155631.15072-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: od@zcrc.me, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This allows the probe function to be dropped after the kernel finished
its initialization, in the case where the driver was not compiled as a
module.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/spi/spi-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index eca9d52ecf65..c242c962772d 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -358,7 +358,7 @@ static void spi_gpio_put(void *data)
 	spi_master_put(data);
 }
 
-static int spi_gpio_probe(struct platform_device *pdev)
+static int __init_or_module spi_gpio_probe(struct platform_device *pdev)
 {
 	int				status;
 	struct spi_master		*master;
-- 
2.21.0.593.g511ec345e18
