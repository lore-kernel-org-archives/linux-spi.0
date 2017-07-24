From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v5 14/14] spi: qup: Fix QUP version identify method
Date: Mon, 24 Jul 2017 13:17:25 +0530
Message-ID: <1500882445-29008-15-git-send-email-varada@codeaurora.org>
References: <1500882445-29008-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada@codeaurora.org>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500882445-29008-1-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use of_device_get_match_data to identify QUP version instead
of of_device_is_compatible.

Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/spi/spi-qup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 4c3c938..1364516 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -19,6 +19,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
@@ -1058,9 +1059,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	else if (!ret)
 		master->can_dma = spi_qup_can_dma;
 
-	/* set v1 flag if device is version 1 */
-	if (of_device_is_compatible(dev->of_node, "qcom,spi-qup-v1.1.1"))
-		controller->qup_v1 = 1;
+	controller->qup_v1 = (int)of_device_get_match_data(dev);
 
 	if (!controller->qup_v1)
 		master->set_cs = spi_qup_set_cs;
@@ -1256,7 +1255,7 @@ static int spi_qup_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id spi_qup_dt_match[] = {
-	{ .compatible = "qcom,spi-qup-v1.1.1", },
+	{ .compatible = "qcom,spi-qup-v1.1.1", .data = (void *)1, },
 	{ .compatible = "qcom,spi-qup-v2.1.1", },
 	{ .compatible = "qcom,spi-qup-v2.2.1", },
 	{ }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
