From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: pxa2xx: Fix '"CONFIG_OF" is not defined' warning" to the spi tree
Date: Sat, 17 Nov 2018 03:29:15 +0000 (GMT)
Message-ID: <20181117032915.A847B440078@finisterre.ee.mobilebroadband>
References: <20181115103209.20619-1-lkundrak@v3.sk>
Cc: Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115103209.20619-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: pxa2xx: Fix '"CONFIG_OF" is not defined' warning

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

>From f0915dfc44365b487a720d447ad3faa66de5205c Mon Sep 17 00:00:00 2001
From: Lubomir Rintel <lkundrak@v3.sk>
Date: Thu, 15 Nov 2018 11:32:09 +0100
Subject: [PATCH] spi: pxa2xx: Fix '"CONFIG_OF" is not defined' warning

A careless oversight. Sorry.

Fixes: 0a897143b7c9 ("spi: pxa2xx: Add slave mode support")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e6a606354f62..d84b893a64d7 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1555,19 +1555,13 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	}
 #endif
 
-#if CONFIG_OF
-	if (of_id) {
-		pdata->is_slave = of_property_read_bool(pdev->dev.of_node,
-								"spi-slave");
-	}
-#endif
-
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
 	ssp->irq = platform_get_irq(pdev, 0);
 	ssp->type = type;
 	ssp->pdev = pdev;
 	ssp->port_id = pxa2xx_spi_get_port_id(adev);
 
+	pdata->is_slave = of_property_read_bool(pdev->dev.of_node, "spi-slave");
 	pdata->num_chipselect = 1;
 	pdata->enable_dma = true;
 
-- 
2.19.1
