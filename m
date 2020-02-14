From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] spi: qup: call spi_qup_pm_resume_runtime before suspending
Date: Fri, 14 Feb 2020 13:13:40 +0530
Message-ID: <20200214074340.2286170-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Yuji Sasaki <sasakiy@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Yuji Sasaki <sasakiy@chromium.org>

spi_qup_suspend() will cause synchronous external abort when
runtime suspend is enabled and applied, as it tries to
access SPI controller register while clock is already disabled
in spi_qup_pm_suspend_runtime().

Signed-off-by: Yuji sasaki <sasakiy@chromium.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/spi/spi-qup.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index dd3434a407ea..a364b99497e2 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1217,6 +1217,11 @@ static int spi_qup_suspend(struct device *device)
 	struct spi_qup *controller = spi_master_get_devdata(master);
 	int ret;
 
+	if (pm_runtime_suspended(device)) {
+		ret = spi_qup_pm_resume_runtime(device);
+		if (ret)
+			return ret;
+	}
 	ret = spi_master_suspend(master);
 	if (ret)
 		return ret;
@@ -1225,10 +1230,8 @@ static int spi_qup_suspend(struct device *device)
 	if (ret)
 		return ret;
 
-	if (!pm_runtime_suspended(device)) {
-		clk_disable_unprepare(controller->cclk);
-		clk_disable_unprepare(controller->iclk);
-	}
+	clk_disable_unprepare(controller->cclk);
+	clk_disable_unprepare(controller->iclk);
 	return 0;
 }
 
-- 
2.24.1
