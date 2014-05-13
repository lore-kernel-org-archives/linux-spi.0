From: Andy Gross <agross@codeaurora.org>
Subject: [PATCH 3/4] spi: qup: Fix order of spi_register_master
Date: Tue, 13 May 2014 16:34:43 -0500
Message-ID: <1400016884-9568-4-git-send-email-agross@codeaurora.org>
References: <1400016884-9568-1-git-send-email-agross@codeaurora.org>
Cc: linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Ivan T. Ivanov" <iivanov@mm-sol.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Andy Gross <agross@codeaurora.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1400016884-9568-1-git-send-email-agross@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch moves the devm_spi_register_master below the initialization of the
runtime_pm.  If done in the wrong order, the spi_register_master fails if any
probed slave devices issue SPI transactions.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 drivers/spi/spi-qup.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 57b65e9..b518b51 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -616,16 +616,19 @@ static int spi_qup_probe(struct platform_device *pdev)
 	if (ret)
 		goto error;
 
-	ret = devm_spi_register_master(dev, master);
-	if (ret)
-		goto error;
-
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
+
+	ret = devm_spi_register_master(dev, master);
+	if (ret)
+		goto disable_pm;
+
 	return 0;
 
+disable_pm:
+	pm_runtime_disable(&pdev->dev);
 error:
 	clk_disable_unprepare(cclk);
 	clk_disable_unprepare(iclk);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
