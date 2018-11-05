From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-sh-msiof: simplify getting .driver_data" to the spi tree
Date: Mon,  5 Nov 2018 12:01:49 +0000 (GMT)
Message-ID: <20181105120149.A4F341124D98@debutante.sirena.org.uk>
References: <20181021200048.2114-3-wsa+renesas@sang-engineering.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-spi@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021200048.2114-3-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-sh-msiof: simplify getting .driver_data

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

>From 07c7df3ecdba3d8b9a4145edd9cac47b27dd7f67 Mon Sep 17 00:00:00 2001
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Sun, 21 Oct 2018 22:00:46 +0200
Subject: [PATCH] spi: spi-sh-msiof: simplify getting .driver_data

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sh-msiof.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index adf384323934..d495d8604397 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1426,16 +1426,14 @@ MODULE_DEVICE_TABLE(platform, spi_driver_ids);
 #ifdef CONFIG_PM_SLEEP
 static int sh_msiof_spi_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
+	struct sh_msiof_spi_priv *p = dev_get_drvdata(dev);
 
 	return spi_master_suspend(p->master);
 }
 
 static int sh_msiof_spi_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
+	struct sh_msiof_spi_priv *p = dev_get_drvdata(dev);
 
 	return spi_master_resume(p->master);
 }
-- 
2.19.0.rc2
