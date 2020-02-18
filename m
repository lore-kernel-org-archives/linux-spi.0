From: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/6] i2c: i2c-qcom-geni: Add interconnect support
Date: Tue, 18 Feb 2020 14:47:09 -0800
Message-ID: <20200218224709.GF15781@google.com>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-4-git-send-email-akashast@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
To: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1581946205-27189-4-git-send-email-akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Feb 17, 2020 at 07:00:02PM +0530, Akash Asthana wrote:
> Get the interconnect paths for I2C based Serial Engine device
> and vote according to the bus speed of the driver.
> 
> Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 84 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 80 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 17abf60c..5de10a1 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -163,6 +163,44 @@ static void qcom_geni_i2c_conf(struct geni_i2c_dev *gi2c)
>  	writel_relaxed(val, gi2c->se.base + SE_I2C_SCL_COUNTERS);
>  }
>  
> +static int geni_i2c_icc_get(struct geni_se *se)
> +{
> +	if (!se)
> +		return -EINVAL;

check is not needed

> +
> +	se->icc_path[GENI_TO_CORE] = of_icc_get(se->dev, "qup-core");
> +	if (IS_ERR(se->icc_path[GENI_TO_CORE]))
> +		return PTR_ERR(se->icc_path[GENI_TO_CORE]);
> +
> +	se->icc_path[CPU_TO_GENI] = of_icc_get(se->dev, "qup-config");
> +	if (IS_ERR(se->icc_path[CPU_TO_GENI])) {
> +		icc_put(se->icc_path[GENI_TO_CORE]);
> +		se->icc_path[GENI_TO_CORE] = NULL;

echoing Bjorn's comments on 'tty: serial: qcom_geni_serial: Add
interconnect support', resetting is not needed since _probe() will
fail.

> +		return PTR_ERR(se->icc_path[CPU_TO_GENI]);
> +	}
> +
> +	se->icc_path[GENI_TO_DDR] = of_icc_get(se->dev, "qup-memory");
> +	if (IS_ERR(se->icc_path[GENI_TO_DDR])) {
> +		icc_put(se->icc_path[GENI_TO_CORE]);
> +		se->icc_path[GENI_TO_CORE] = NULL;

ditto

> +		icc_put(se->icc_path[CPU_TO_GENI]);
> +		se->icc_path[CPU_TO_GENI] = NULL;

ditto

> +		return PTR_ERR(se->icc_path[GENI_TO_DDR]);
> +	}
> +
> +	return 0;
> +}
> +
> +void geni_i2c_icc_put(struct geni_se *se)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(se->icc_path); i++) {
> +		icc_put(se->icc_path[i]);
> +		se->icc_path[i] = NULL;

not needed

> +	}
> +}
> +
>  static void geni_i2c_err_misc(struct geni_i2c_dev *gi2c)
>  {
>  	u32 m_cmd = readl_relaxed(gi2c->se.base + SE_GENI_M_CMD0);
> @@ -563,17 +601,34 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  	gi2c->adap.dev.of_node = pdev->dev.of_node;
>  	strlcpy(gi2c->adap.name, "Geni-I2C", sizeof(gi2c->adap.name));
>  
> +	ret = geni_i2c_icc_get(&gi2c->se);
> +	if (ret)
> +		return ret;
> +	/* Set the bus quota to a reasonable value */
> +	gi2c->se.avg_bw_core = Bps_to_icc(1000);
> +	gi2c->se.peak_bw_core = Bps_to_icc(CORE_2X_100_MHZ);
> +	gi2c->se.avg_bw_cpu = Bps_to_icc(1000);
> +	gi2c->se.peak_bw_cpu = Bps_to_icc(1000);
> +	gi2c->se.avg_bw_ddr = Bps_to_icc(gi2c->clk_freq_out);
> +	gi2c->se.peak_bw_ddr = Bps_to_icc(2 * gi2c->clk_freq_out);
> +
> +	/* Vote for core clocks and CPU for register access */
> +	icc_set_bw(gi2c->se.icc_path[GENI_TO_CORE], gi2c->se.avg_bw_core,
> +				gi2c->se.peak_bw_core);
> +	icc_set_bw(gi2c->se.icc_path[CPU_TO_GENI], gi2c->se.avg_bw_cpu,
> +				gi2c->se.peak_bw_cpu);

error handling needed?
