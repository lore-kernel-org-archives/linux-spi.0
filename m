From: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 1/6] soc: qcom: geni: Support for ICC voting
Date: Mon, 17 Feb 2020 19:00:00 +0530
Message-ID: <1581946205-27189-2-git-send-email-akashast@codeaurora.org>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1581946205-27189-1-git-send-email-akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add necessary enums, macros and structure variables to support ICC BW
voting from individual SE drivers.

Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 include/linux/qcom-geni-se.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index dd46494..b0adbfb 100644
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
@@ -22,6 +24,13 @@ enum geni_se_protocol_type {
 	GENI_SE_I3C,
 };
 
+/* Interconnect paths for GENI */
+enum geni_se_icc_path {
+	GENI_TO_CORE,
+	CPU_TO_GENI,
+	GENI_TO_DDR
+};
+
 struct geni_wrapper;
 struct clk;
 
@@ -33,6 +42,13 @@ struct clk;
  * @clk:		Handle to the core serial engine clock
  * @num_clk_levels:	Number of valid clock levels in clk_perf_tbl
  * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
+ * @icc_path:		Array of interconnect path handles
+ * @avg_bw_core:	Average bus bandwidth value for QUP core 2x clock
+ * @peak_bw_core:	Peak bus bandwidth value for QUP core 2x clock
+ * @avg_bw_cpu:		Average bus bandwidth value for CPU
+ * @peak_bw_cpu:	Peak bus bandwidth value for CPU
+ * @avg_bw_ddr:		Average bus bandwidth value for DDR
+ * @peak_bw_ddr:	Peak bus bandwidth value for DDR
  */
 struct geni_se {
 	void __iomem *base;
@@ -41,6 +57,13 @@ struct geni_se {
 	struct clk *clk;
 	unsigned int num_clk_levels;
 	unsigned long *clk_perf_tbl;
+	struct icc_path *icc_path[3];
+	unsigned int avg_bw_core;
+	unsigned int peak_bw_core;
+	unsigned int avg_bw_cpu;
+	unsigned int peak_bw_cpu;
+	unsigned int avg_bw_ddr;
+	unsigned int peak_bw_ddr;
 };
 
 /* Common SE registers */
@@ -229,6 +252,14 @@ struct geni_se {
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
