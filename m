From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] spi: pxa2xx: Remove the shutdown callback
Date: Mon, 17 Sep 2018 14:11:24 +0200
Message-ID: <20180917121124.21305-1-lkundrak@v3.sk>
Cc: linux-spi@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

It makes no sense to remove the device on shutdown. And it break things
when the hardware crucial for shutdown (such as the embedded controller)
is attached to the SPI bus.

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/spi/spi-pxa2xx.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 14f4ea59caff..b06f37fb29f6 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1764,14 +1764,6 @@ static int pxa2xx_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static void pxa2xx_spi_shutdown(struct platform_device *pdev)
-{
-	int status = 0;
-
-	if ((status = pxa2xx_spi_remove(pdev)) != 0)
-		dev_err(&pdev->dev, "shutdown failed with %d\n", status);
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int pxa2xx_spi_suspend(struct device *dev)
 {
@@ -1851,7 +1843,6 @@ static struct platform_driver driver = {
 	},
 	.probe = pxa2xx_spi_probe,
 	.remove = pxa2xx_spi_remove,
-	.shutdown = pxa2xx_spi_shutdown,
 };
 
 static int __init pxa2xx_spi_init(void)
-- 
2.17.1
