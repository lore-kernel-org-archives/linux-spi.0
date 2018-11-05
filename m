From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-rspi: simplify getting .driver_data" to the spi tree
Date: Mon,  5 Nov 2018 12:01:41 +0000 (GMT)
Message-ID: <20181105120141.553C41124D98@debutante.sirena.org.uk>
References: <20181021200048.2114-2-wsa+renesas@sang-engineering.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-spi@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021200048.2114-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-rspi: simplify getting .driver_data

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

>From be0bf62e3df9afcb3f7a72de347770568dd60af6 Mon Sep 17 00:00:00 2001
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Sun, 21 Oct 2018 22:00:45 +0200
Subject: [PATCH] spi: spi-rspi: simplify getting .driver_data

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 55f8e55327b3..a4ef641b5227 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1347,16 +1347,14 @@ MODULE_DEVICE_TABLE(platform, spi_driver_ids);
 #ifdef CONFIG_PM_SLEEP
 static int rspi_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rspi_data *rspi = platform_get_drvdata(pdev);
+	struct rspi_data *rspi = dev_get_drvdata(dev);
 
 	return spi_master_suspend(rspi->master);
 }
 
 static int rspi_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rspi_data *rspi = platform_get_drvdata(pdev);
+	struct rspi_data *rspi = dev_get_drvdata(dev);
 
 	return spi_master_resume(rspi->master);
 }
-- 
2.19.0.rc2
