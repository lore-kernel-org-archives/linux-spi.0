From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH V2 2/8] soc: qcom: geni: Support for ICC voting
Date: Tue, 17 Mar 2020 12:06:31 -0700
Message-ID: <CAE=gft4_Su4+SXWAW_HWy5BF1mH7QaDHCiwAAhrNaekTeU57rA@mail.gmail.com>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org> <1584105134-13583-3-git-send-email-akashast@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wsa@the-dreams.de, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>
To: Akash Asthana <akashast@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1584105134-13583-3-git-send-email-akashast@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Mar 13, 2020 at 6:12 AM Akash Asthana <akashast@codeaurora.org> wrote:
>
> Add necessary macros and structure variables to support ICC BW
> voting from individual SE drivers.
>
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
> Changes in V2:
>  - As per Bjorn's comment dropped enums for ICC paths, given the three
>    paths individual members
>
>  include/linux/qcom-geni-se.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
> index dd46494..eaae16e 100644
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
>         GENI_SE_INVALID,
> @@ -33,6 +35,15 @@ struct clk;
>   * @clk:               Handle to the core serial engine clock
>   * @num_clk_levels:    Number of valid clock levels in clk_perf_tbl
>   * @clk_perf_tbl:      Table of clock frequency input to serial engine clock
> + * @icc_path_geni_to_core:     ICC path handle for geni to core
> + * @icc_path_cpu_to_geni:      ICC path handle for cpu to geni
> + * @icc_path_geni_to_ddr:      ICC path handle for geni to ddr
> + * @avg_bw_core:       Average bus bandwidth value for QUP core 2x clock
> + * @peak_bw_core:      Peak bus bandwidth value for QUP core 2x clock
> + * @avg_bw_cpu:                Average bus bandwidth value for CPU
> + * @peak_bw_cpu:       Peak bus bandwidth value for CPU
> + * @avg_bw_ddr:                Average bus bandwidth value for DDR
> + * @peak_bw_ddr:       Peak bus bandwidth value for DDR
>   */
>  struct geni_se {
>         void __iomem *base;
> @@ -41,6 +52,15 @@ struct geni_se {
>         struct clk *clk;
>         unsigned int num_clk_levels;
>         unsigned long *clk_perf_tbl;
> +       struct icc_path *icc_path_geni_to_core;
> +       struct icc_path *icc_path_cpu_to_geni;
> +       struct icc_path *icc_path_geni_to_ddr;
> +       unsigned int avg_bw_core;
> +       unsigned int peak_bw_core;
> +       unsigned int avg_bw_cpu;
> +       unsigned int peak_bw_cpu;
> +       unsigned int avg_bw_ddr;
> +       unsigned int peak_bw_ddr;
>  };
>
>  /* Common SE registers */
> @@ -229,6 +249,14 @@ struct geni_se {
>  #define GENI_SE_VERSION_MINOR(ver) ((ver & HW_VER_MINOR_MASK) >> HW_VER_MINOR_SHFT)
>  #define GENI_SE_VERSION_STEP(ver) (ver & HW_VER_STEP_MASK)
>
> +/* Core 2X clock frequency to BCM threshold mapping */
> +#define CORE_2X_19_2_MHZ               960
> +#define CORE_2X_50_MHZ                 2500
> +#define CORE_2X_100_MHZ                        5000
> +#define CORE_2X_150_MHZ                        7500
> +#define CORE_2X_200_MHZ                        10000
> +#define CORE_2X_236_MHZ                        16383

These are all just 50 * clock_rate. Can you instead specify that one
define of CLK_TO_BW_RATIO 50, and then use clk_get_rate() to get the
input clock frequency. That way, if these end up getting clocked at a
different rate, the bandwidth also scales appropriately. Also, can you
enumerate why 50 is an appropriate ratio?
-Evan

-Evan
