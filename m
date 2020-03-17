From: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V2 3/8] soc: qcom-geni-se: Add interconnect support to fix
 earlycon crash
Date: Tue, 17 Mar 2020 16:27:47 +0530
Message-ID: <1f86fdf0-df7c-4e4a-d4d8-8b0162e52cb4@codeaurora.org>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-4-git-send-email-akashast@codeaurora.org>
 <20200313204441.GJ144492@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
To: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200313204441.GJ144492-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Matthias,

On 3/14/2020 2:14 AM, Matthias Kaehlcke wrote:
> Hi Akash,
>
> On Fri, Mar 13, 2020 at 06:42:09PM +0530, Akash Asthana wrote:
>> V1 patch@https://patchwork.kernel.org/patch/11386469/ caused SC7180 system
>> to reset at boot time.
> The v1 patch isn't relevant in the commit message, please just describe the
> problem. Also the crash only occurs when earlycon is used.
ok
>
>> As QUP core clock is shared among all the SE drivers present on particular
>> QUP wrapper, the reset seen is due to earlycon usage after QUP core clock
>> is put to 0 from other SE drivers before real console comes up.
>>
>> As earlycon can't vote for it's QUP core need, to fix this add ICC
>> support to common/QUP wrapper driver and put vote for QUP core from
>> probe on behalf of earlycon and remove vote during sys suspend.
> Only removing the vote on suspend isn't ideal, the system might never get
> suspended. That said I don't have a really good alternative suggestion.
>
> One thing you could possibly do is to launch a delayed work, check
> console_device() every second or so and remove the vote when it returns
> non-NULL. Not claiming this would be a great solution ...
>
> The cleanest solution might be a notifier when the early console is
> unregistered, it seems somewhat over-engineered though ... Then again
> other (future) uart drivers with interconnect support might run into
> the same problem.

We are hitting this problem because QUP core clocks are shared among all 
the SE driver present in particular QUP wrapper, if other HW controllers 
has similar architecture we will hit this issue.

How about if we expose an API from common driver(geni-se) for putting 
QUP core BW vote to 0.

We call this from console probe just after uart_add_one_port call 
(console resources are enabled as part of this call) to put core quota 
to 0 on behalf of earlyconsole?

>
>> Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Reported-by: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> ---
>>   drivers/soc/qcom/qcom-geni-se.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
>> index 7d622ea..d244dfc 100644
>> --- a/drivers/soc/qcom/qcom-geni-se.c
>> +++ b/drivers/soc/qcom/qcom-geni-se.c
>> @@ -90,6 +90,7 @@ struct geni_wrapper {
>>   	struct device *dev;
>>   	void __iomem *base;
>>   	struct clk_bulk_data ahb_clks[NUM_AHB_CLKS];
>> +	struct icc_path *icc_path_geni_to_core;
>>   };
>>   
>>   #define QUP_HW_VER_REG			0x4
>> @@ -747,11 +748,50 @@ static int geni_se_probe(struct platform_device *pdev)
>>   		}
>>   	}
>>   
>> +#ifdef CONFIG_SERIAL_EARLYCON
>> +	wrapper->icc_path_geni_to_core = devm_of_icc_get(dev, "qup-core");
>> +	if (IS_ERR(wrapper->icc_path_geni_to_core))
>> +		return PTR_ERR(wrapper->icc_path_geni_to_core);
>> +	/*
>> +	 * Put minmal BW request on core clocks on behalf of early console.
>> +	 * The vote will be removed in suspend call.
>> +	 */
>> +	ret = icc_set_bw(wrapper->icc_path_geni_to_core, Bps_to_icc(1000),
>> +			Bps_to_icc(1000));
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "%s: ICC BW voting failed for core\n",
>> +			__func__);
>> +		return ret;
>> +	}
> What is ugly about this is that it's done for every QUP, not only the one
> with the early console. Again, I don't have a good solution for it, maybe
> it's a limitation we have to live with :(

There is one more limitation from QUP core side. Core clocks for both 
the QUP wrapper runs at same speed.

core2x_1 = core2x_2 = max(core2x_1, core2x_2);

So with above limitation and if we are removing early con vote from Core 
when real console comes up. It doesn't matter whether it's done for 
every QUP or the only with early console.

>
>> +#endif
>> +
>>   	dev_set_drvdata(dev, wrapper);
>>   	dev_dbg(dev, "GENI SE Driver probed\n");
>>   	return devm_of_platform_populate(dev);
>>   }
>>   
>> +static int __maybe_unused geni_se_sys_suspend(struct device *dev)
>> +{
>> +	struct geni_wrapper *wrapper = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +#ifdef CONFIG_SERIAL_EARLYCON
>> +	ret = icc_set_bw(wrapper->icc_path_geni_to_core, 0, 0);
> I think you only want to do this on the first suspend.
Ok, I can add that logic using global variable.
>
> Do we need to handle the case where no 'real' console is configured?
> In this case the early console would be active forever and setting
> the bandwidths to 0 might cause a similar crash than the one you are
> trying to fix. Not sure if that's a real world use case, but wanted to
> mention it. Maybe this is an argument of the notifier approach?
We can't support earlycon without real console.

As earlyconsole doesn't do any kind of resource enablement(SE clocks, 
pinctrl, etc) it assumes that resources are already enabled from 
previous stages.

So if real console doesn't come up no one will vote for that SE clock, 
and it will be disabled from clk late_init call which will result into 
un-clocked access.


>
>> +	if (ret) {
>> +		dev_err(dev, "%s: ICC BW remove failed for core\n",
>> +			__func__);
>> +		return ret;
> Aborting suspend seems too harsh since the QUP should still be fully
> functional unless there is a general problem with the interconnects.
>
> I would suggest to change the log to dev_warn() and return 0.

Ok

Thanks for reviewing the patch.

regards,

Akash

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
