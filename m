From: Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH V2 7/8] spi: spi-qcom-qspi: Add interconnect support
Date: Fri, 13 Mar 2020 18:42:13 +0530
Message-ID: <1584105134-13583-8-git-send-email-akashast@codeaurora.org>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
Cc: linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org, evgreen@chromium.org,
        Akash Asthana <akashast@codeaurora.org>
To: gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Get the interconnect paths for QSPI device and vote according to the
current bus speed of the driver.

Signed-off-by: Akash Asthana <akashast@codeaurora.org>
---
 - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
   path handle
 - As per Matthias comment, added error handling for icc_set_bw call

 drivers/spi/spi-qcom-qspi.c | 46 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 3c4f83b..ad48f43 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
 
 #include <linux/clk.h>
+#include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -139,7 +140,10 @@ struct qcom_qspi {
 	struct device *dev;
 	struct clk_bulk_data *clks;
 	struct qspi_xfer xfer;
-	/* Lock to protect xfer and IRQ accessed registers */
+	struct icc_path *icc_path_cpu_to_qspi;
+	unsigned int avg_bw_cpu;
+	unsigned int peak_bw_cpu;
+	/* Lock to protect data accessed by IRQs */
 	spinlock_t lock;
 };
 
@@ -241,6 +245,20 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
 		return ret;
 	}
 
+	/*
+	 * Set BW quota for CPU as driver supports FIFO mode only.
+	 * Assume peak bw as twice of avg bw.
+	 */
+	ctrl->avg_bw_cpu = Bps_to_icc(speed_hz);
+	ctrl->peak_bw_cpu = Bps_to_icc(2 * speed_hz);
+	ret = icc_set_bw(ctrl->icc_path_cpu_to_qspi, ctrl->avg_bw_cpu,
+		ctrl->peak_bw_cpu);
+	if (ret) {
+		dev_err(ctrl->dev, "%s: ICC BW voting failed for cpu\n",
+			__func__);
+		return ret;
+	}
+
 	spin_lock_irqsave(&ctrl->lock, flags);
 
 	/* We are half duplex, so either rx or tx will be set */
@@ -458,6 +476,15 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	if (ret)
 		goto exit_probe_master_put;
 
+	ctrl->icc_path_cpu_to_qspi = devm_of_icc_get(dev, "qspi-config");
+	if (IS_ERR(ctrl->icc_path_cpu_to_qspi)) {
+		ret = PTR_ERR(ctrl->icc_path_cpu_to_qspi);
+		goto exit_probe_master_put;
+	}
+	/* Put BW vote on CPU path for register access */
+	ctrl->avg_bw_cpu = Bps_to_icc(1000);
+	ctrl->peak_bw_cpu = Bps_to_icc(1000);
+
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
 		goto exit_probe_master_put;
@@ -511,9 +538,17 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
+	int ret;
 
 	clk_bulk_disable_unprepare(QSPI_NUM_CLKS, ctrl->clks);
 
+	ret = icc_set_bw(ctrl->icc_path_cpu_to_qspi, 0, 0);
+	if (ret) {
+		dev_err_ratelimited(ctrl->dev, "%s: ICC BW remove failed for cpu\n",
+			__func__);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -521,6 +556,15 @@ static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
+	int ret;
+
+	ret = icc_set_bw(ctrl->icc_path_cpu_to_qspi, ctrl->avg_bw_cpu,
+		ctrl->peak_bw_cpu);
+	if (ret) {
+		dev_err_ratelimited(ctrl->dev, "%s: ICC BW voting failed for cpu\n",
+			__func__);
+		return ret;
+	}
 
 	return clk_bulk_prepare_enable(QSPI_NUM_CLKS, ctrl->clks);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
