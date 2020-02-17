From: Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH 5/6] spi: spi-qcom-qspi: Add interconnect support
Date: Mon, 17 Feb 2020 19:00:04 +0530
Message-ID: <1581946205-27189-6-git-send-email-akashast@codeaurora.org>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
Cc: linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org, Akash Asthana <akashast@codeaurora.org>
To: gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Get the interconnect paths for QSPI device and vote according to the
current bus speed of the driver.

Signed-off-by: Akash Asthana <akashast@codeaurora.org>
---
 drivers/spi/spi-qcom-qspi.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 3c4f83b..3636438 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
 
 #include <linux/clk.h>
+#include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -134,12 +135,19 @@ enum qspi_clocks {
 	QSPI_NUM_CLKS
 };
 
+enum qspi_icc_path {
+	CPU_TO_QSPI
+};
+
 struct qcom_qspi {
 	void __iomem *base;
 	struct device *dev;
 	struct clk_bulk_data *clks;
 	struct qspi_xfer xfer;
-	/* Lock to protect xfer and IRQ accessed registers */
+	struct icc_path *icc_path[2];
+	unsigned int avg_bw_cpu;
+	unsigned int peak_bw_cpu;
+	/* Lock to protect data accessed by IRQs */
 	spinlock_t lock;
 };
 
@@ -241,6 +249,11 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
 		return ret;
 	}
 
+	/* Set BW quota for CPU as driver supports FIFO mode only */
+	ctrl->avg_bw_cpu = Bps_to_icc(speed_hz);
+	ctrl->peak_bw_cpu = Bps_to_icc(2 * speed_hz);
+	icc_set_bw(ctrl->icc_path[CPU_TO_QSPI], ctrl->avg_bw_cpu, ctrl->peak_bw_cpu);
+
 	spin_lock_irqsave(&ctrl->lock, flags);
 
 	/* We are half duplex, so either rx or tx will be set */
@@ -458,14 +471,23 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	if (ret)
 		goto exit_probe_master_put;
 
+	ctrl->icc_path[CPU_TO_QSPI] = of_icc_get(dev, "qspi-config");
+	if (IS_ERR(ctrl->icc_path[CPU_TO_QSPI])) {
+		ret = PTR_ERR(ctrl->icc_path[CPU_TO_QSPI]);
+		goto exit_probe_master_put;
+	}
+	/* Put BW vote on CPU path for register access */
+	ctrl->avg_bw_cpu = Bps_to_icc(1000);
+	ctrl->peak_bw_cpu = Bps_to_icc(1000);
+
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto exit_probe_master_put;
+		goto exit_probe_icc_put;
 	ret = devm_request_irq(dev, ret, qcom_qspi_irq,
 			IRQF_TRIGGER_HIGH, dev_name(dev), ctrl);
 	if (ret) {
 		dev_err(dev, "Failed to request irq %d\n", ret);
-		goto exit_probe_master_put;
+		goto exit_probe_icc_put;
 	}
 
 	master->max_speed_hz = 300000000;
@@ -489,6 +511,8 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 
 	pm_runtime_disable(dev);
 
+exit_probe_icc_put:
+	icc_put(ctrl->icc_path[CPU_TO_QSPI]);
 exit_probe_master_put:
 	spi_master_put(master);
 
@@ -498,6 +522,9 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 static int qcom_qspi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
+	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
+
+	icc_put(ctrl->icc_path[CPU_TO_QSPI]);
 
 	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
 	spi_unregister_master(master);
@@ -514,6 +541,8 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
 
 	clk_bulk_disable_unprepare(QSPI_NUM_CLKS, ctrl->clks);
 
+	icc_set_bw(ctrl->icc_path[CPU_TO_QSPI], 0, 0);
+
 	return 0;
 }
 
@@ -522,6 +551,9 @@ static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
 
+	icc_set_bw(ctrl->icc_path[CPU_TO_QSPI], ctrl->avg_bw_cpu,
+		ctrl->peak_bw_cpu);
+
 	return clk_bulk_prepare_enable(QSPI_NUM_CLKS, ctrl->clks);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
