From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/6] soc: qcom: geni: Support for ICC voting
Date: Mon, 17 Feb 2020 19:03:10 -0800
Message-ID: <20200218030310.GV955802@ripper>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-2-git-send-email-akashast@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gregkh@linuxfoundation.org, agross@kernel.org, wsa@the-dreams.de,
        broonie@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org
To: Akash Asthana <akashast@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1581946205-27189-2-git-send-email-akashast@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon 17 Feb 05:30 PST 2020, Akash Asthana wrote:

> Add necessary enums, macros and structure variables to support ICC BW
> voting from individual SE drivers.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
>  include/linux/qcom-geni-se.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
> index dd46494..b0adbfb 100644
> --- a/include/linux/qcom-geni-se.h
> +++ b/include/linux/qcom-geni-se.h
> @@ -6,6 +6,8 @@
>  #ifndef _LINUX_QCOM_GENI_SE
>  #define _LINUX_QCOM_GENI_SE
>  
> +#include <linux/interconnect.h>
> +
>  /* Transfer mode supported by GENI Serial Engines */
>  enum geni_se_xfer_mode {
>  	GENI_SE_INVALID,
> @@ -22,6 +24,13 @@ enum geni_se_protocol_type {
>  	GENI_SE_I3C,
>  };
>  
> +/* Interconnect paths for GENI */
> +enum geni_se_icc_path {
> +	GENI_TO_CORE,
> +	CPU_TO_GENI,
> +	GENI_TO_DDR
> +};
> +
>  struct geni_wrapper;
>  struct clk;
>  
> @@ -33,6 +42,13 @@ struct clk;
>   * @clk:		Handle to the core serial engine clock
>   * @num_clk_levels:	Number of valid clock levels in clk_perf_tbl
>   * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
> + * @icc_path:		Array of interconnect path handles
> + * @avg_bw_core:	Average bus bandwidth value for QUP core 2x clock
> + * @peak_bw_core:	Peak bus bandwidth value for QUP core 2x clock
> + * @avg_bw_cpu:		Average bus bandwidth value for CPU
> + * @peak_bw_cpu:	Peak bus bandwidth value for CPU
> + * @avg_bw_ddr:		Average bus bandwidth value for DDR
> + * @peak_bw_ddr:	Peak bus bandwidth value for DDR
>   */
>  struct geni_se {
>  	void __iomem *base;
> @@ -41,6 +57,13 @@ struct geni_se {
>  	struct clk *clk;
>  	unsigned int num_clk_levels;
>  	unsigned long *clk_perf_tbl;
> +	struct icc_path *icc_path[3];

In all cases you refer to icc_path[IDENIFIER], so just give the three
paths individual members and drop the enum above.

Reards,
Bjorn

> +	unsigned int avg_bw_core;
> +	unsigned int peak_bw_core;
> +	unsigned int avg_bw_cpu;
> +	unsigned int peak_bw_cpu;
> +	unsigned int avg_bw_ddr;
> +	unsigned int peak_bw_ddr;
>  };
>  
>  /* Common SE registers */
> @@ -229,6 +252,14 @@ struct geni_se {
>  #define GENI_SE_VERSION_MINOR(ver) ((ver & HW_VER_MINOR_MASK) >> HW_VER_MINOR_SHFT)
>  #define GENI_SE_VERSION_STEP(ver) (ver & HW_VER_STEP_MASK)
>  
> +/* Core 2X clock frequency to BCM threshold mapping */
> +#define CORE_2X_19_2_MHZ		960
> +#define CORE_2X_50_MHZ			2500
> +#define CORE_2X_100_MHZ			5000
> +#define CORE_2X_150_MHZ			7500
> +#define CORE_2X_200_MHZ			10000
> +#define CORE_2X_236_MHZ			16383
> +
>  #if IS_ENABLED(CONFIG_QCOM_GENI_SE)
>  
>  u32 geni_se_get_qup_hw_version(struct geni_se *se);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
