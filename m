From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: [PATCH] spi: qup: Fix runtime and system PM callbacks.
Date: Fri, 27 Jan 2017 12:02:01 +0530
Message-ID: <20170127063201.13529-1-pramod.gurav@linaro.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pramod Gurav <pramod.gurav@linaro.org>
To: broonie@kernel.org, linux-spi@vger.kernel.org
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The SPI clocks were being turned on every suspend/resume cycle.
This was increamenting the prepare/enable count after every resume.
Fix the same.

Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
---
Tested on db410c

 drivers/spi/spi-qup.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 1bfa889..a9731e8 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -956,8 +956,10 @@ static int spi_qup_pm_resume_runtime(struct device *device)
 		return ret;
 
 	ret = clk_prepare_enable(controller->cclk);
-	if (ret)
+	if (ret) {
+		clk_disable_unprepare(controller->iclk);
 		return ret;
+	}
 
 	/* Disable clocks auto gaiting */
 	config = readl_relaxed(controller->base + QUP_CONFIG);
@@ -983,8 +985,7 @@ static int spi_qup_suspend(struct device *device)
 		return ret;
 
 	if (!pm_runtime_suspended(device)) {
-		clk_disable_unprepare(controller->cclk);
-		clk_disable_unprepare(controller->iclk);
+		pm_runtime_put(device);
 	}
 	return 0;
 }
@@ -995,18 +996,17 @@ static int spi_qup_resume(struct device *device)
 	struct spi_qup *controller = spi_master_get_devdata(master);
 	int ret;
 
-	ret = clk_prepare_enable(controller->iclk);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(controller->cclk);
-	if (ret)
+	ret = pm_runtime_get_sync(device);
+	if (ret < 0) {
+		dev_err(device, "pm runtime failed in resume\n");
 		return ret;
+	}
 
 	ret = spi_qup_set_state(controller, QUP_STATE_RESET);
 	if (ret)
 		return ret;
 
+	pm_runtime_put(device);
 	return spi_master_resume(master);
 }
 #endif /* CONFIG_PM_SLEEP */
-- 
2.10.2
