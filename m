From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH V2 3/8] soc: qcom-geni-se: Add interconnect support to
 fix earlycon crash
Date: Fri, 13 Mar 2020 13:44:41 -0700
Message-ID: <20200313204441.GJ144492@google.com>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-4-git-send-email-akashast@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org,
        evgreen@chromium.org
To: Akash Asthana <akashast@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1584105134-13583-4-git-send-email-akashast@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Akash,

On Fri, Mar 13, 2020 at 06:42:09PM +0530, Akash Asthana wrote:
> V1 patch@https://patchwork.kernel.org/patch/11386469/ caused SC7180 system
> to reset at boot time.

The v1 patch isn't relevant in the commit message, please just describe the
problem. Also the crash only occurs when earlycon is used.

> As QUP core clock is shared among all the SE drivers present on particular
> QUP wrapper, the reset seen is due to earlycon usage after QUP core clock
> is put to 0 from other SE drivers before real console comes up.
> 
> As earlycon can't vote for it's QUP core need, to fix this add ICC
> support to common/QUP wrapper driver and put vote for QUP core from
> probe on behalf of earlycon and remove vote during sys suspend.

Only removing the vote on suspend isn't ideal, the system might never get
suspended. That said I don't have a really good alternative suggestion.

One thing you could possibly do is to launch a delayed work, check
console_device() every second or so and remove the vote when it returns
non-NULL. Not claiming this would be a great solution ...

The cleanest solution might be a notifier when the early console is
unregistered, it seems somewhat over-engineered though ... Then again
other (future) uart drivers with interconnect support might run into
the same problem.

> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> Reported-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 7d622ea..d244dfc 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -90,6 +90,7 @@ struct geni_wrapper {
>  	struct device *dev;
>  	void __iomem *base;
>  	struct clk_bulk_data ahb_clks[NUM_AHB_CLKS];
> +	struct icc_path *icc_path_geni_to_core;
>  };
>  
>  #define QUP_HW_VER_REG			0x4
> @@ -747,11 +748,50 @@ static int geni_se_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +#ifdef CONFIG_SERIAL_EARLYCON
> +	wrapper->icc_path_geni_to_core = devm_of_icc_get(dev, "qup-core");
> +	if (IS_ERR(wrapper->icc_path_geni_to_core))
> +		return PTR_ERR(wrapper->icc_path_geni_to_core);
> +	/*
> +	 * Put minmal BW request on core clocks on behalf of early console.
> +	 * The vote will be removed in suspend call.
> +	 */
> +	ret = icc_set_bw(wrapper->icc_path_geni_to_core, Bps_to_icc(1000),
> +			Bps_to_icc(1000));
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s: ICC BW voting failed for core\n",
> +			__func__);
> +		return ret;
> +	}

What is ugly about this is that it's done for every QUP, not only the one
with the early console. Again, I don't have a good solution for it, maybe
it's a limitation we have to live with :(

> +#endif
> +
>  	dev_set_drvdata(dev, wrapper);
>  	dev_dbg(dev, "GENI SE Driver probed\n");
>  	return devm_of_platform_populate(dev);
>  }
>  
> +static int __maybe_unused geni_se_sys_suspend(struct device *dev)
> +{
> +	struct geni_wrapper *wrapper = dev_get_drvdata(dev);
> +	int ret;
> +
> +#ifdef CONFIG_SERIAL_EARLYCON
> +	ret = icc_set_bw(wrapper->icc_path_geni_to_core, 0, 0);

I think you only want to do this on the first suspend.

Do we need to handle the case where no 'real' console is configured?
In this case the early console would be active forever and setting
the bandwidths to 0 might cause a similar crash than the one you are
trying to fix. Not sure if that's a real world use case, but wanted to
mention it. Maybe this is an argument of the notifier approach?

> +	if (ret) {
> +		dev_err(dev, "%s: ICC BW remove failed for core\n",
> +			__func__);
> +		return ret;

Aborting suspend seems too harsh since the QUP should still be fully
functional unless there is a general problem with the interconnects.

I would suggest to change the log to dev_warn() and return 0.
