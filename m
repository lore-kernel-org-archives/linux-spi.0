From: Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH V2 3/8] soc: qcom-geni-se: Add interconnect support to fix earlycon crash
Date: Fri, 13 Mar 2020 18:42:09 +0530
Message-ID: <1584105134-13583-4-git-send-email-akashast@codeaurora.org>
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

V1 patch@https://patchwork.kernel.org/patch/11386469/ caused SC7180 system
to reset at boot time.

As QUP core clock is shared among all the SE drivers present on particular
QUP wrapper, the reset seen is due to earlycon usage after QUP core clock
is put to 0 from other SE drivers before real console comes up.

As earlycon can't vote for it's QUP core need, to fix this add ICC
support to common/QUP wrapper driver and put vote for QUP core from
probe on behalf of earlycon and remove vote during sys suspend.

Signed-off-by: Akash Asthana <akashast@codeaurora.org>
Reported-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/soc/qcom/qcom-geni-se.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 7d622ea..d244dfc 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -90,6 +90,7 @@ struct geni_wrapper {
 	struct device *dev;
 	void __iomem *base;
 	struct clk_bulk_data ahb_clks[NUM_AHB_CLKS];
+	struct icc_path *icc_path_geni_to_core;
 };
 
 #define QUP_HW_VER_REG			0x4
@@ -747,11 +748,50 @@ static int geni_se_probe(struct platform_device *pdev)
 		}
 	}
 
+#ifdef CONFIG_SERIAL_EARLYCON
+	wrapper->icc_path_geni_to_core = devm_of_icc_get(dev, "qup-core");
+	if (IS_ERR(wrapper->icc_path_geni_to_core))
+		return PTR_ERR(wrapper->icc_path_geni_to_core);
+	/*
+	 * Put minmal BW request on core clocks on behalf of early console.
+	 * The vote will be removed in suspend call.
+	 */
+	ret = icc_set_bw(wrapper->icc_path_geni_to_core, Bps_to_icc(1000),
+			Bps_to_icc(1000));
+	if (ret) {
+		dev_err(&pdev->dev, "%s: ICC BW voting failed for core\n",
+			__func__);
+		return ret;
+	}
+#endif
+
 	dev_set_drvdata(dev, wrapper);
 	dev_dbg(dev, "GENI SE Driver probed\n");
 	return devm_of_platform_populate(dev);
 }
 
+static int __maybe_unused geni_se_sys_suspend(struct device *dev)
+{
+	struct geni_wrapper *wrapper = dev_get_drvdata(dev);
+	int ret;
+
+#ifdef CONFIG_SERIAL_EARLYCON
+	ret = icc_set_bw(wrapper->icc_path_geni_to_core, 0, 0);
+	if (ret) {
+		dev_err(dev, "%s: ICC BW remove failed for core\n",
+			__func__);
+		return ret;
+	}
+#endif
+
+	return 0;
+}
+
+static const struct dev_pm_ops geni_se_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(geni_se_sys_suspend,
+				NULL)
+};
+
 static const struct of_device_id geni_se_dt_match[] = {
 	{ .compatible = "qcom,geni-se-qup", },
 	{}
@@ -762,6 +802,7 @@ static struct platform_driver geni_se_driver = {
 	.driver = {
 		.name = "geni_se_qup",
 		.of_match_table = geni_se_dt_match,
+		.pm = &geni_se_pm_ops,
 	},
 	.probe = geni_se_probe,
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
