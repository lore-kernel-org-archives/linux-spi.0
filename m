From: Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH V2 2/8] soc: qcom: geni: Support for ICC voting
Date: Fri, 13 Mar 2020 18:42:08 +0530
Message-ID: <1584105134-13583-3-git-send-email-akashast@codeaurora.org>
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
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add necessary macros and structure variables to support ICC BW
voting from individual SE drivers.

Signed-off-by: Akash Asthana <akashast@codeaurora.org>
---
Changes in V2:
 - As per Bjorn's comment dropped enums for ICC paths, given the three
   paths individual members

 include/linux/qcom-geni-se.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index dd46494..eaae16e 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -6,6 +6,8 @@
 #ifndef _LINUX_QCOM_GENI_SE
 #define _LINUX_QCOM_GENI_SE
 
+#include <linux/interconnect.h>
+
 /* Transfer mode supported by GENI Serial Engines */
 enum geni_se_xfer_mode {
 	GENI_SE_INVALID,
@@ -33,6 +35,15 @@ struct clk;
  * @clk:		Handle to the core serial engine clock
  * @num_clk_levels:	Number of valid clock levels in clk_perf_tbl
  * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
+ * @icc_path_geni_to_core:	ICC path handle for geni to core
+ * @icc_path_cpu_to_geni:	ICC path handle for cpu to geni
+ * @icc_path_geni_to_ddr:	ICC path handle for geni to ddr
+ * @avg_bw_core:	Average bus bandwidth value for QUP core 2x clock
+ * @peak_bw_core:	Peak bus bandwidth value for QUP core 2x clock
+ * @avg_bw_cpu:		Average bus bandwidth value for CPU
+ * @peak_bw_cpu:	Peak bus bandwidth value for CPU
+ * @avg_bw_ddr:		Average bus bandwidth value for DDR
+ * @peak_bw_ddr:	Peak bus bandwidth value for DDR
  */
 struct geni_se {
 	void __iomem *base;
@@ -41,6 +52,15 @@ struct geni_se {
 	struct clk *clk;
 	unsigned int num_clk_levels;
 	unsigned long *clk_perf_tbl;
+	struct icc_path *icc_path_geni_to_core;
+	struct icc_path *icc_path_cpu_to_geni;
+	struct icc_path *icc_path_geni_to_ddr;
+	unsigned int avg_bw_core;
+	unsigned int peak_bw_core;
+	unsigned int avg_bw_cpu;
+	unsigned int peak_bw_cpu;
+	unsigned int avg_bw_ddr;
+	unsigned int peak_bw_ddr;
 };
 
 /* Common SE registers */
@@ -229,6 +249,14 @@ struct geni_se {
 #define GENI_SE_VERSION_MINOR(ver) ((ver & HW_VER_MINOR_MASK) >> HW_VER_MINOR_SHFT)
 #define GENI_SE_VERSION_STEP(ver) (ver & HW_VER_STEP_MASK)
 
+/* Core 2X clock frequency to BCM threshold mapping */
+#define CORE_2X_19_2_MHZ		960
+#define CORE_2X_50_MHZ			2500
+#define CORE_2X_100_MHZ			5000
+#define CORE_2X_150_MHZ			7500
+#define CORE_2X_200_MHZ			10000
+#define CORE_2X_236_MHZ			16383
+
 #if IS_ENABLED(CONFIG_QCOM_GENI_SE)
 
 u32 geni_se_get_qup_hw_version(struct geni_se *se);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
