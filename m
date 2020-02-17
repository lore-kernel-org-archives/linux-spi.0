From: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 3/6] i2c: i2c-qcom-geni: Add interconnect support
Date: Mon, 17 Feb 2020 19:00:02 +0530
Message-ID: <1581946205-27189-4-git-send-email-akashast@codeaurora.org>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1581946205-27189-1-git-send-email-akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Get the interconnect paths for I2C based Serial Engine device
and vote according to the bus speed of the driver.

Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 84 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 17abf60c..5de10a1 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -163,6 +163,44 @@ static void qcom_geni_i2c_conf(struct geni_i2c_dev *gi2c)
 	writel_relaxed(val, gi2c->se.base + SE_I2C_SCL_COUNTERS);
 }
 
+static int geni_i2c_icc_get(struct geni_se *se)
+{
+	if (!se)
+		return -EINVAL;
+
+	se->icc_path[GENI_TO_CORE] = of_icc_get(se->dev, "qup-core");
+	if (IS_ERR(se->icc_path[GENI_TO_CORE]))
+		return PTR_ERR(se->icc_path[GENI_TO_CORE]);
+
+	se->icc_path[CPU_TO_GENI] = of_icc_get(se->dev, "qup-config");
+	if (IS_ERR(se->icc_path[CPU_TO_GENI])) {
+		icc_put(se->icc_path[GENI_TO_CORE]);
+		se->icc_path[GENI_TO_CORE] = NULL;
+		return PTR_ERR(se->icc_path[CPU_TO_GENI]);
+	}
+
+	se->icc_path[GENI_TO_DDR] = of_icc_get(se->dev, "qup-memory");
+	if (IS_ERR(se->icc_path[GENI_TO_DDR])) {
+		icc_put(se->icc_path[GENI_TO_CORE]);
+		se->icc_path[GENI_TO_CORE] = NULL;
+		icc_put(se->icc_path[CPU_TO_GENI]);
+		se->icc_path[CPU_TO_GENI] = NULL;
+		return PTR_ERR(se->icc_path[GENI_TO_DDR]);
+	}
+
+	return 0;
+}
+
+void geni_i2c_icc_put(struct geni_se *se)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(se->icc_path); i++) {
+		icc_put(se->icc_path[i]);
+		se->icc_path[i] = NULL;
+	}
+}
+
 static void geni_i2c_err_misc(struct geni_i2c_dev *gi2c)
 {
 	u32 m_cmd = readl_relaxed(gi2c->se.base + SE_GENI_M_CMD0);
@@ -563,17 +601,34 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	gi2c->adap.dev.of_node = pdev->dev.of_node;
 	strlcpy(gi2c->adap.name, "Geni-I2C", sizeof(gi2c->adap.name));
 
+	ret = geni_i2c_icc_get(&gi2c->se);
+	if (ret)
+		return ret;
+	/* Set the bus quota to a reasonable value */
+	gi2c->se.avg_bw_core = Bps_to_icc(1000);
+	gi2c->se.peak_bw_core = Bps_to_icc(CORE_2X_100_MHZ);
+	gi2c->se.avg_bw_cpu = Bps_to_icc(1000);
+	gi2c->se.peak_bw_cpu = Bps_to_icc(1000);
+	gi2c->se.avg_bw_ddr = Bps_to_icc(gi2c->clk_freq_out);
+	gi2c->se.peak_bw_ddr = Bps_to_icc(2 * gi2c->clk_freq_out);
+
+	/* Vote for core clocks and CPU for register access */
+	icc_set_bw(gi2c->se.icc_path[GENI_TO_CORE], gi2c->se.avg_bw_core,
+				gi2c->se.peak_bw_core);
+	icc_set_bw(gi2c->se.icc_path[CPU_TO_GENI], gi2c->se.avg_bw_cpu,
+				gi2c->se.peak_bw_cpu);
 	ret = geni_se_resources_on(&gi2c->se);
 	if (ret) {
 		dev_err(&pdev->dev, "Error turning on resources %d\n", ret);
-		return ret;
+		goto geni_i2c_put_icc;
 	}
 	proto = geni_se_read_proto(&gi2c->se);
 	tx_depth = geni_se_get_tx_fifo_depth(&gi2c->se);
 	if (proto != GENI_SE_I2C) {
 		dev_err(&pdev->dev, "Invalid proto %d\n", proto);
 		geni_se_resources_off(&gi2c->se);
-		return -ENXIO;
+		ret = -ENXIO;
+		goto geni_i2c_put_icc;
 	}
 	gi2c->tx_wm = tx_depth - 1;
 	geni_se_init(&gi2c->se, gi2c->tx_wm, tx_depth);
@@ -582,8 +637,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	ret = geni_se_resources_off(&gi2c->se);
 	if (ret) {
 		dev_err(&pdev->dev, "Error turning off resources %d\n", ret);
-		return ret;
+		goto geni_i2c_put_icc;
 	}
+	/* Remove vote from core clocks and CPU */
+	icc_set_bw(gi2c->se.icc_path[GENI_TO_CORE], 0, 0);
+	icc_set_bw(gi2c->se.icc_path[CPU_TO_GENI], 0, 0);
 
 	dev_dbg(&pdev->dev, "i2c fifo/se-dma mode. fifo depth:%d\n", tx_depth);
 
@@ -597,12 +655,16 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Error adding i2c adapter %d\n", ret);
 		pm_runtime_disable(gi2c->se.dev);
-		return ret;
+		goto geni_i2c_put_icc;
 	}
 
 	dev_dbg(&pdev->dev, "Geni-I2C adaptor successfully added\n");
 
 	return 0;
+
+geni_i2c_put_icc:
+	geni_i2c_icc_put(&gi2c->se);
+	return ret;
 }
 
 static int geni_i2c_remove(struct platform_device *pdev)
@@ -611,6 +673,7 @@ static int geni_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&gi2c->adap);
 	pm_runtime_disable(gi2c->se.dev);
+	geni_i2c_icc_put(&gi2c->se);
 	return 0;
 }
 
@@ -629,6 +692,11 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 		gi2c->suspended = 1;
 	}
 
+	/* Remove BW votes */
+	icc_set_bw(gi2c->se.icc_path[GENI_TO_CORE], 0, 0);
+	icc_set_bw(gi2c->se.icc_path[CPU_TO_GENI], 0, 0);
+	icc_set_bw(gi2c->se.icc_path[GENI_TO_DDR], 0, 0);
+
 	return 0;
 }
 
@@ -637,6 +705,14 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 	int ret;
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 
+	/* Vote on Core, DDR and CPU path respectively */
+	icc_set_bw(gi2c->se.icc_path[GENI_TO_CORE], gi2c->se.avg_bw_core,
+		gi2c->se.peak_bw_core);
+	icc_set_bw(gi2c->se.icc_path[CPU_TO_GENI], gi2c->se.avg_bw_cpu,
+		gi2c->se.peak_bw_cpu);
+	icc_set_bw(gi2c->se.icc_path[GENI_TO_DDR], gi2c->se.avg_bw_ddr,
+		gi2c->se.peak_bw_ddr);
+
 	ret = geni_se_resources_on(&gi2c->se);
 	if (ret)
 		return ret;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
