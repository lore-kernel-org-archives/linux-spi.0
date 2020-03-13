From: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V2 5/8] i2c: i2c-qcom-geni: Add interconnect support
Date: Fri, 13 Mar 2020 18:42:11 +0530
Message-ID: <1584105134-13583-6-git-send-email-akashast@codeaurora.org>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1584105134-13583-1-git-send-email-akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Get the interconnect paths for I2C based Serial Engine device
and vote according to the bus speed of the driver.

Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
Changes in V2:
 - As per Bjorn's comment, removed se == NULL check from geni_i2c_icc_get
 - As per Bjorn's comment, removed code to set se->icc_path* to NULL in failure
 - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
   path handle
 - As per Matthias comment, added error handling for icc_set_bw call

 drivers/i2c/busses/i2c-qcom-geni.c | 110 +++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 17abf60c..33ab685 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -163,6 +163,23 @@ static void qcom_geni_i2c_conf(struct geni_i2c_dev *gi2c)
 	writel_relaxed(val, gi2c->se.base + SE_I2C_SCL_COUNTERS);
 }
 
+static int geni_i2c_icc_get(struct geni_se *se)
+{
+	se->icc_path_geni_to_core = devm_of_icc_get(se->dev, "qup-core");
+	if (IS_ERR(se->icc_path_geni_to_core))
+		return PTR_ERR(se->icc_path_geni_to_core);
+
+	se->icc_path_cpu_to_geni = devm_of_icc_get(se->dev, "qup-config");
+	if (IS_ERR(se->icc_path_cpu_to_geni))
+		return PTR_ERR(se->icc_path_cpu_to_geni);
+
+	se->icc_path_geni_to_ddr = devm_of_icc_get(se->dev, "qup-memory");
+	if (IS_ERR(se->icc_path_geni_to_ddr))
+		return PTR_ERR(se->icc_path_geni_to_ddr);
+
+	return 0;
+}
+
 static void geni_i2c_err_misc(struct geni_i2c_dev *gi2c)
 {
 	u32 m_cmd = readl_relaxed(gi2c->se.base + SE_GENI_M_CMD0);
@@ -563,6 +580,39 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	gi2c->adap.dev.of_node = pdev->dev.of_node;
 	strlcpy(gi2c->adap.name, "Geni-I2C", sizeof(gi2c->adap.name));
 
+	ret = geni_i2c_icc_get(&gi2c->se);
+	if (ret)
+		return ret;
+	/*
+	 * Set the bus quota for core and cpu to a reasonable value for
+	 * register access.
+	 * Set quota for DDR based on bus speed, assume peak requirement
+	 * as twice of avg bw.
+	 */
+	gi2c->se.avg_bw_core = Bps_to_icc(1000);
+	gi2c->se.peak_bw_core = Bps_to_icc(CORE_2X_100_MHZ);
+	gi2c->se.avg_bw_cpu = Bps_to_icc(1000);
+	gi2c->se.peak_bw_cpu = Bps_to_icc(1000);
+	gi2c->se.avg_bw_ddr = Bps_to_icc(gi2c->clk_freq_out);
+	gi2c->se.peak_bw_ddr = Bps_to_icc(2 * gi2c->clk_freq_out);
+
+	/* Vote for core clocks and CPU for register access */
+	ret = icc_set_bw(gi2c->se.icc_path_geni_to_core, gi2c->se.avg_bw_core,
+				gi2c->se.peak_bw_core);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: ICC BW voting failed for core\n",
+			__func__);
+		return ret;
+	}
+
+	ret = icc_set_bw(gi2c->se.icc_path_cpu_to_geni, gi2c->se.avg_bw_cpu,
+				gi2c->se.peak_bw_cpu);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: ICC BW voting failed for cpu\n",
+			__func__);
+		return ret;
+	}
+
 	ret = geni_se_resources_on(&gi2c->se);
 	if (ret) {
 		dev_err(&pdev->dev, "Error turning on resources %d\n", ret);
@@ -584,6 +634,19 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Error turning off resources %d\n", ret);
 		return ret;
 	}
+	/* Remove vote from core clocks and CPU */
+	ret = icc_set_bw(gi2c->se.icc_path_geni_to_core, 0, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: ICC BW remove failed for core\n",
+			__func__);
+		return ret;
+	}
+
+	ret = icc_set_bw(gi2c->se.icc_path_cpu_to_geni, 0, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: ICC BW remove failed for cpu\n",
+			__func__);
+	}
 
 	dev_dbg(&pdev->dev, "i2c fifo/se-dma mode. fifo depth:%d\n", tx_depth);
 
@@ -629,6 +692,28 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 		gi2c->suspended = 1;
 	}
 
+	/* Remove BW votes */
+	ret = icc_set_bw(gi2c->se.icc_path_geni_to_core, 0, 0);
+	if (ret) {
+		dev_err_ratelimited(gi2c->se.dev, "%s: ICC BW remove failed for core\n",
+			__func__);
+		return ret;
+	}
+
+	ret = icc_set_bw(gi2c->se.icc_path_cpu_to_geni, 0, 0);
+	if (ret) {
+		dev_err_ratelimited(gi2c->se.dev, "%s: ICC BW remove failed for cpu\n",
+			__func__);
+		return ret;
+	}
+
+	ret = icc_set_bw(gi2c->se.icc_path_geni_to_ddr, 0, 0);
+	if (ret) {
+		dev_err_ratelimited(gi2c->se.dev, "%s: ICC BW remove failed for ddr\n",
+			__func__);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -637,6 +722,31 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 	int ret;
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 
+	/* Vote on Core, CPU and DDR path respectively */
+	ret = icc_set_bw(gi2c->se.icc_path_geni_to_core, gi2c->se.avg_bw_core,
+		gi2c->se.peak_bw_core);
+	if (ret) {
+		dev_err_ratelimited(gi2c->se.dev, "%s: ICC BW voting failed for core\n",
+			__func__);
+		return ret;
+	}
+
+	ret = icc_set_bw(gi2c->se.icc_path_cpu_to_geni, gi2c->se.avg_bw_cpu,
+		gi2c->se.peak_bw_cpu);
+	if (ret) {
+		dev_err_ratelimited(gi2c->se.dev, "%s: ICC BW voting failed for cpu\n",
+			__func__);
+		return ret;
+	}
+
+	ret = icc_set_bw(gi2c->se.icc_path_geni_to_ddr, gi2c->se.avg_bw_ddr,
+		gi2c->se.peak_bw_ddr);
+	if (ret) {
+		dev_err_ratelimited(gi2c->se.dev, "%s: ICC BW voting failed for ddr\n",
+			__func__);
+		return ret;
+	}
+
 	ret = geni_se_resources_on(&gi2c->se);
 	if (ret)
 		return ret;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
