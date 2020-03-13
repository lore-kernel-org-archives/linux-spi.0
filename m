From: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V2 6/8] spi: spi-geni-qcom: Add interconnect support
Date: Fri, 13 Mar 2020 18:42:12 +0530
Message-ID: <1584105134-13583-7-git-send-email-akashast@codeaurora.org>
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
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1584105134-13583-1-git-send-email-akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Get the interconnect paths for SPI based Serial Engine device
and vote according to the current bus speed of the driver.

Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 - As per Bjorn's comment, removed se == NULL check from geni_spi_icc_get
 - As per Bjorn's comment, removed code to set se->icc_path* to NULL in failure
 - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
   path handle
 - As per Matthias comment, added error handling for icc_set_bw call

 drivers/spi/spi-geni-qcom.c | 74 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index c397242..09c4709 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -118,6 +118,19 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 	return ret;
 }
 
+static int geni_spi_icc_get(struct geni_se *se)
+{
+	se->icc_path_geni_to_core = devm_of_icc_get(se->dev, "qup-core");
+	if (IS_ERR(se->icc_path_geni_to_core))
+		return PTR_ERR(se->icc_path_geni_to_core);
+
+	se->icc_path_cpu_to_geni = devm_of_icc_get(se->dev, "qup-config");
+	if (IS_ERR(se->icc_path_cpu_to_geni))
+		return PTR_ERR(se->icc_path_cpu_to_geni);
+
+	return 0;
+}
+
 static void handle_fifo_timeout(struct spi_master *spi,
 				struct spi_message *msg)
 {
@@ -234,6 +247,20 @@ static int setup_fifo_params(struct spi_device *spi_slv,
 		return ret;
 	}
 
+	/*
+	 * Set BW quota for CPU as driver supports FIFO mode only.
+	 * Assume peak bw as twice of avg bw.
+	 */
+	se->avg_bw_cpu = Bps_to_icc(mas->cur_speed_hz);
+	se->peak_bw_cpu = Bps_to_icc(2 * mas->cur_speed_hz);
+	ret = icc_set_bw(se->icc_path_cpu_to_geni, se->avg_bw_cpu,
+			se->peak_bw_cpu);
+	if (ret) {
+		dev_err(mas->dev, "%s: ICC BW voting failed for cpu\n",
+			__func__);
+		return ret;
+	}
+
 	clk_sel = idx & CLK_SEL_MSK;
 	m_clk_cfg = (div << CLK_DIV_SHFT) | SER_CLK_EN;
 	spi_setup_word_len(mas, spi_slv->mode, spi_slv->bits_per_word);
@@ -578,6 +605,15 @@ static int spi_geni_probe(struct platform_device *pdev)
 	spin_lock_init(&mas->lock);
 	pm_runtime_enable(dev);
 
+	ret = geni_spi_icc_get(&mas->se);
+	if (ret)
+		goto spi_geni_probe_runtime_disable;
+	/* Set the bus quota to a reasonable value for register access */
+	mas->se.avg_bw_core = Bps_to_icc(CORE_2X_50_MHZ);
+	mas->se.peak_bw_core = Bps_to_icc(CORE_2X_100_MHZ);
+	mas->se.avg_bw_cpu = Bps_to_icc(1000);
+	mas->se.peak_bw_cpu = Bps_to_icc(1000);
+
 	ret = spi_geni_init(mas);
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
@@ -616,14 +652,50 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
 {
 	struct spi_master *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	int ret;
+
+	ret = geni_se_resources_off(&mas->se);
+	if (ret)
+		return ret;
 
-	return geni_se_resources_off(&mas->se);
+	ret = icc_set_bw(mas->se.icc_path_geni_to_core, 0, 0);
+	if (ret) {
+		dev_err_ratelimited(mas->dev, "%s: ICC BW remove failed for core\n",
+			__func__);
+		return ret;
+	}
+
+	ret = icc_set_bw(mas->se.icc_path_cpu_to_geni, 0, 0);
+	if (ret) {
+		dev_err_ratelimited(mas->dev, "%s: ICC BW remove failed for cpu\n",
+			__func__);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
 {
 	struct spi_master *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	int ret;
+
+	ret = icc_set_bw(mas->se.icc_path_geni_to_core, mas->se.avg_bw_core,
+		mas->se.peak_bw_core);
+	if (ret) {
+		dev_err_ratelimited(mas->dev, "%s: ICC BW voting failed for core\n",
+			__func__);
+		return ret;
+	}
+
+	ret = icc_set_bw(mas->se.icc_path_cpu_to_geni, mas->se.avg_bw_cpu,
+		mas->se.peak_bw_cpu);
+	if (ret) {
+		dev_err_ratelimited(mas->dev, "%s: ICC BW voting failed for cpu\n",
+			__func__);
+		return ret;
+	}
 
 	return geni_se_resources_on(&mas->se);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
