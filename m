From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: mxic: simplify getting .driver_data" to the spi tree
Date: Wed, 20 Mar 2019 17:30:12 +0000 (GMT)
Message-ID: <20190320173012.1F8EF1126E4C@debutante.sirena.org.uk>
References: <20190319163637.30949-1-wsa+renesas@sang-engineering.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-spi@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319163637.30949-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: mxic: simplify getting .driver_data

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

>From f457cb707836e79a88b64ab22230edc2aa8ce0af Mon Sep 17 00:00:00 2001
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Tue, 19 Mar 2019 17:36:37 +0100
Subject: [PATCH] spi: mxic: simplify getting .driver_data

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mxic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index e41ae6ef0f8a..f48563c09b97 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -492,8 +492,7 @@ static int mxic_spi_transfer_one(struct spi_master *master,
 
 static int __maybe_unused mxic_spi_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct mxic_spi *mxic = spi_master_get_devdata(master);
 
 	mxic_spi_clk_disable(mxic);
@@ -504,8 +503,7 @@ static int __maybe_unused mxic_spi_runtime_suspend(struct device *dev)
 
 static int __maybe_unused mxic_spi_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct mxic_spi *mxic = spi_master_get_devdata(master);
 	int ret;
 
-- 
2.20.1
