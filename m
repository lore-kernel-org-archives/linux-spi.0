From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bcm2835aux: remove unneeded NULL check of devm_clk_get" to the spi tree
Date: Wed, 23 Jan 2019 17:58:00 +0000 (GMT)
Message-ID: <20190123175800.7DF351127ABA@debutante.sirena.org.uk>
References: <20190123070507.15404-1-yuehaibing@huawei.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190123070507.15404-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: bcm2835aux: remove unneeded NULL check of devm_clk_get

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

>From bfc7af6d6df8d75b9c693b8eb98c21aa75c1e377 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 23 Jan 2019 15:05:07 +0800
Subject: [PATCH] spi: bcm2835aux: remove unneeded NULL check of devm_clk_get

Fix a static code checker warning:
drivers/spi/spi-bcm2835aux.c:460
 bcm2835aux_spi_probe() warn: passing zero to 'PTR_ERR'

In case of error, the function devm_clk_get() returns ERR_PTR()
and not returns NULL.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835aux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 671e374e1b01..f7e054848ca5 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -456,7 +456,7 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	}
 
 	bs->clk = devm_clk_get(&pdev->dev, NULL);
-	if ((!bs->clk) || (IS_ERR(bs->clk))) {
+	if (IS_ERR(bs->clk)) {
 		err = PTR_ERR(bs->clk);
 		dev_err(&pdev->dev, "could not get clk: %d\n", err);
 		goto out_master_put;
-- 
2.20.1
