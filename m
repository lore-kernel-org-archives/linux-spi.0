From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: cadence: change sequence of calling runtime_enable" to the spi tree
Date: Tue, 08 Aug 2017 12:06:53 +0100
Message-ID: <E1df2Ld-0005AW-SS@finisterre>
References: <61b5819082ab2128754f37b7a3440a03f7a90248.1502182771.git.michal.simek@xilinx.com>
Cc: Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-spi@vger.kernel.org
To: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <61b5819082ab2128754f37b7a3440a03f7a90248.1502182771.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: cadence: change sequence of calling runtime_enable

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

>From 48767fd8982d39d90a9e83b1461dc5feedf73e29 Mon Sep 17 00:00:00 2001
From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Date: Tue, 8 Aug 2017 10:59:33 +0200
Subject: [PATCH] spi: cadence: change sequence of calling runtime_enable

call pm_runtime_enable after set_active other wise it will
enable clock always.

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index f0b5c7b91f37..5e02f9b91688 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -576,10 +576,10 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		goto clk_dis_apb;
 	}
 
-	pm_runtime_enable(&pdev->dev);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 
 	ret = of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
 	if (ret < 0)
-- 
2.13.2
