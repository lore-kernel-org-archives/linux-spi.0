From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: atmel: fix indenting in atmel_spi_gpio_cs()" to the spi tree
Date: Tue, 15 Nov 2016 18:53:42 +0000
Message-ID: <E1c6irW-0006I9-8T@debutante>
References: <20161114142644.GA6179@mwanda>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20161114142644.GA6179@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: atmel: fix indenting in atmel_spi_gpio_cs()

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From b52b3484eec593a4fe75a68e57f0ade52b55ed8f Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 14 Nov 2016 17:26:44 +0300
Subject: [PATCH] spi: atmel: fix indenting in atmel_spi_gpio_cs()

These lines were indented one extra tab.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index d3affa6afe7e..b2931493cab2 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1510,15 +1510,15 @@ static int atmel_spi_gpio_cs(struct platform_device *pdev)
 		int cs_gpio = of_get_named_gpio(pdev->dev.of_node,
 						"cs-gpios", i);
 
-			if (cs_gpio == -EPROBE_DEFER)
-				return cs_gpio;
-
-			if (gpio_is_valid(cs_gpio)) {
-				ret = devm_gpio_request(&pdev->dev, cs_gpio,
-							dev_name(&pdev->dev));
-				if (ret)
-					return ret;
-			}
+		if (cs_gpio == -EPROBE_DEFER)
+			return cs_gpio;
+
+		if (gpio_is_valid(cs_gpio)) {
+			ret = devm_gpio_request(&pdev->dev, cs_gpio,
+						dev_name(&pdev->dev));
+			if (ret)
+				return ret;
+		}
 	}
 
 	return 0;
-- 
2.10.2

