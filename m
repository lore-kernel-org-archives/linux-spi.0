From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: pxa2xx: Remove the shutdown callback" to the spi tree
Date: Mon, 17 Sep 2018 22:34:52 +0100 (BST)
Message-ID: <20180917213452.EADDC440078@finisterre.ee.mobilebroadband>
References: <20180917121124.21305-1-lkundrak@v3.sk>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917121124.21305-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: pxa2xx: Remove the shutdown callback

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

>From 8089babee17c09cdd51ac1390e444ee0be0c2291 Mon Sep 17 00:00:00 2001
From: Lubomir Rintel <lkundrak@v3.sk>
Date: Mon, 17 Sep 2018 14:11:24 +0200
Subject: [PATCH] spi: pxa2xx: Remove the shutdown callback

It makes no sense to remove the device on shutdown. And it break things
when the hardware crucial for shutdown (such as the embedded controller)
is attached to the SPI bus.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e3cbc66a7061..fc9aac214239 100644
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
@@ -1845,7 +1837,6 @@ static struct platform_driver driver = {
 	},
 	.probe = pxa2xx_spi_probe,
 	.remove = pxa2xx_spi_remove,
-	.shutdown = pxa2xx_spi_shutdown,
 };
 
 static int __init pxa2xx_spi_init(void)
-- 
2.19.0
