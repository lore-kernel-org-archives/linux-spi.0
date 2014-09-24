From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 24/27] spi: core: use pm_runtime_last_busy_and_autosuspend helper
Date: Wed, 24 Sep 2014 21:45:14 +0530
Message-ID: <1411575342-31048-25-git-send-email-vinod.koul@intel.com>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Cc: subhransu.s.prusty@intel.com, vinod.koul@intel.com,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
coding the same code

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/spi/spi.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e0531ba..6ec5330 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -893,10 +893,8 @@ static void spi_pump_messages(struct kthread_work *work)
 		    master->unprepare_transfer_hardware(master))
 			dev_err(&master->dev,
 				"failed to unprepare transfer hardware\n");
-		if (master->auto_runtime_pm) {
-			pm_runtime_mark_last_busy(master->dev.parent);
-			pm_runtime_put_autosuspend(master->dev.parent);
-		}
+		if (master->auto_runtime_pm)
+			pm_runtime_last_busy_and_autosuspend(master->dev.parent);
 		trace_spi_master_idle(master);
 		return;
 	}
-- 
1.7.0.4
