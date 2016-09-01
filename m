From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: qup: skip clk_disable_unprepare if the device is already runtime suspended" to the spi tree
Date: Thu, 01 Sep 2016 21:35:28 +0100
Message-ID: <E1bfYhs-0002xJ-12@debutante>
References: <1472128408-7231-1-git-send-email-sudeep.holla@arm.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Brown <broonie@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472128408-7231-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: qup: skip clk_disable_unprepare if the device is already runtime suspended

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

>From 9d04d8bc4c18765f6a1f7b632fffe47b4578fb26 Mon Sep 17 00:00:00 2001
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 25 Aug 2016 13:33:28 +0100
Subject: [PATCH] spi: qup: skip clk_disable_unprepare if the device is already
 runtime suspended

If the spi device is already runtime suspended, if spi_qup_suspend is
executed during suspend-to-idle or suspend-to-ram it will result in the
a splat from unpreparing a non-prepared clock.

This patch fixes the issue by executing clk_disable_unprepare conditionally
in spi_qup_suspend.

[Reworded commit message to remove irrelevant backtrace -- broonie]
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index c338ef1136f6..a047e9882da8 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -982,8 +982,10 @@ static int spi_qup_suspend(struct device *device)
 	if (ret)
 		return ret;
 
-	clk_disable_unprepare(controller->cclk);
-	clk_disable_unprepare(controller->iclk);
+	if (!pm_runtime_suspended(device)) {
+		clk_disable_unprepare(controller->cclk);
+		clk_disable_unprepare(controller->iclk);
+	}
 	return 0;
 }
 
-- 
2.8.1
