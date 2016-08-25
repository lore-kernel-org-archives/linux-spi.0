From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] spi: qup: skip clk_disable_unprepare if the device is already runtime suspended
Date: Thu, 25 Aug 2016 13:33:28 +0100
Message-ID: <1472128408-7231-1-git-send-email-sudeep.holla@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

If the spi device is already runtime suspended, if spi_qup_suspend is
executed during suspend-to-idle or suspend-to-ram it will result in the
following splat:

WARNING: CPU: 3 PID: 1593 at drivers/clk/clk.c:476 clk_core_unprepare+0x80/0x90
Modules linked in:

CPU: 3 PID: 1593 Comm: bash Tainted: G        W       4.8.0-rc3 #14
Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
PC is at clk_core_unprepare+0x80/0x90
LR is at clk_unprepare+0x28/0x40
pc : [<ffff0000086eecf0>] lr : [<ffff0000086f0c58>] pstate: 60000145

Call trace:
 clk_core_unprepare+0x80/0x90
 spi_qup_suspend+0x68/0x90
 platform_pm_suspend+0x24/0x68
 dpm_run_callback.isra.7+0x1c/0x70
 __device_suspend+0xf4/0x298
 dpm_suspend+0x10c/0x228
 dpm_suspend_start+0x68/0x78
 suspend_devices_and_enter+0xb8/0x460
 pm_suspend+0x1ec/0x240
 state_store+0x84/0xf8
 kobj_attr_store+0x14/0x28
 sysfs_kf_write+0x48/0x58
 kernfs_fop_write+0x15c/0x1f8
 __vfs_write+0x1c/0x100
 vfs_write+0x9c/0x1b8
 SyS_write+0x44/0xa0
 el0_svc_naked+0x24/0x28

This patch fixes the issue by executing clk_disable_unprepare conditionally
in spi_qup_suspend.

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
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
2.7.4
