From: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V2 6/8] spi: spi-geni-qcom: Add interconnect support
Date: Tue, 17 Mar 2020 17:41:10 +0530
Message-ID: <384d0184-e7cc-0ee9-75b3-3f1c84e6e99d@codeaurora.org>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-7-git-send-email-akashast@codeaurora.org>
 <20200314004106.GM144492@google.com>
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
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200314004106.GM144492-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Matthias,

On 3/14/2020 6:11 AM, Matthias Kaehlcke wrote:
> Hi Akash,
>
> On Fri, Mar 13, 2020 at 06:42:12PM +0530, Akash Asthana wrote:
>> Get the interconnect paths for SPI based Serial Engine device
>> and vote according to the current bus speed of the driver.
>>
>> Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>   - As per Bjorn's comment, removed se == NULL check from geni_spi_icc_get
>>   - As per Bjorn's comment, removed code to set se->icc_path* to NULL in failure
>>   - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
>>     path handle
>>   - As per Matthias comment, added error handling for icc_set_bw call
>>
>>   drivers/spi/spi-geni-qcom.c | 74 ++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 73 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>> index c397242..09c4709 100644
>> --- a/drivers/spi/spi-geni-qcom.c
>> +++ b/drivers/spi/spi-geni-qcom.c
>> @@ -118,6 +118,19 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
>>   	return ret;
>>   }
>>   
>> +static int geni_spi_icc_get(struct geni_se *se)
>> +{
>> +	se->icc_path_geni_to_core = devm_of_icc_get(se->dev, "qup-core");
>> +	if (IS_ERR(se->icc_path_geni_to_core))
>> +		return PTR_ERR(se->icc_path_geni_to_core);
>> +
>> +	se->icc_path_cpu_to_geni = devm_of_icc_get(se->dev, "qup-config");
>> +	if (IS_ERR(se->icc_path_cpu_to_geni))
>> +		return PTR_ERR(se->icc_path_cpu_to_geni);
>> +
>> +	return 0;
>> +}
> As per my comments on (https://patchwork.kernel.org/patch/11436895/#23222713),
> the above function could be replaced by calling a 'geni_icc_get()' (or so, to
> be created) provided by the geni SE driver.
ok
>
>> +
>>   static void handle_fifo_timeout(struct spi_master *spi,
>>   				struct spi_message *msg)
>>   {
>> @@ -234,6 +247,20 @@ static int setup_fifo_params(struct spi_device *spi_slv,
>>   		return ret;
>>   	}
>>   
>> +	/*
>> +	 * Set BW quota for CPU as driver supports FIFO mode only.
>> +	 * Assume peak bw as twice of avg bw.
>> +	 */
>> +	se->avg_bw_cpu = Bps_to_icc(mas->cur_speed_hz);
>> +	se->peak_bw_cpu = Bps_to_icc(2 * mas->cur_speed_hz);
>> +	ret = icc_set_bw(se->icc_path_cpu_to_geni, se->avg_bw_cpu,
>> +			se->peak_bw_cpu);
>> +	if (ret) {
>> +		dev_err(mas->dev, "%s: ICC BW voting failed for cpu\n",
>> +			__func__);
>> +		return ret;
>> +	}
>> +
>>   	clk_sel = idx & CLK_SEL_MSK;
>>   	m_clk_cfg = (div << CLK_DIV_SHFT) | SER_CLK_EN;
>>   	spi_setup_word_len(mas, spi_slv->mode, spi_slv->bits_per_word);
>> @@ -578,6 +605,15 @@ static int spi_geni_probe(struct platform_device *pdev)
>>   	spin_lock_init(&mas->lock);
>>   	pm_runtime_enable(dev);
>>   
>> +	ret = geni_spi_icc_get(&mas->se);
>> +	if (ret)
>> +		goto spi_geni_probe_runtime_disable;
>> +	/* Set the bus quota to a reasonable value for register access */
>> +	mas->se.avg_bw_core = Bps_to_icc(CORE_2X_50_MHZ);
>> +	mas->se.peak_bw_core = Bps_to_icc(CORE_2X_100_MHZ);
>> +	mas->se.avg_bw_cpu = Bps_to_icc(1000);
>> +	mas->se.peak_bw_cpu = Bps_to_icc(1000);
>> +
>>   	ret = spi_geni_init(mas);
>>   	if (ret)
>>   		goto spi_geni_probe_runtime_disable;
>> @@ -616,14 +652,50 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
>>   {
>>   	struct spi_master *spi = dev_get_drvdata(dev);
>>   	struct spi_geni_master *mas = spi_master_get_devdata(spi);
>> +	int ret;
>> +
>> +	ret = geni_se_resources_off(&mas->se);
>> +	if (ret)
>> +		return ret;
>>   
>> -	return geni_se_resources_off(&mas->se);
>> +	ret = icc_set_bw(mas->se.icc_path_geni_to_core, 0, 0);
>> +	if (ret) {
>> +		dev_err_ratelimited(mas->dev, "%s: ICC BW remove failed for core\n",
>> +			__func__);
>> +		return ret;
>> +	}
>> +
>> +	ret = icc_set_bw(mas->se.icc_path_cpu_to_geni, 0, 0);
>> +	if (ret) {
>> +		dev_err_ratelimited(mas->dev, "%s: ICC BW remove failed for cpu\n",
>> +			__func__);
>> +		return ret;
>> +	}
> the ICC stuff above would become:
>
> 	ret = geni_icc_vote_off(&mas->se);
> 	if (ret)
> 		return ret;
>
> with the consolidated code in geni SE.
ok
>
>> +
>> +	return 0;
>>   }
>>   
>>   static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
>>   {
>>   	struct spi_master *spi = dev_get_drvdata(dev);
>>   	struct spi_geni_master *mas = spi_master_get_devdata(spi);
>> +	int ret;
>> +
>> +	ret = icc_set_bw(mas->se.icc_path_geni_to_core, mas->se.avg_bw_core,
>> +		mas->se.peak_bw_core);
>> +	if (ret) {
>> +		dev_err_ratelimited(mas->dev, "%s: ICC BW voting failed for core\n",
>> +			__func__);
>> +		return ret;
>> +	}
>> +
>> +	ret = icc_set_bw(mas->se.icc_path_cpu_to_geni, mas->se.avg_bw_cpu,
>> +		mas->se.peak_bw_cpu);
>> +	if (ret) {
>> +		dev_err_ratelimited(mas->dev, "%s: ICC BW voting failed for cpu\n",
>> +			__func__);
>> +		return ret;
>> +	}
> and this:
>
> 	ret = geni_icc_vote_on(&mas->se);
> 	if (ret)
> 		return ret;
ok
>>   	return geni_se_resources_on(&mas->se);
> possibly you could even do the ICC voting from geni_se_resources_on/off()
> it seems the two are always done together for UART, I2C and SPI.

I think we should expose geni_icc_vote_on/off API seperately and not 
merge to resources_on/off.

Because if we merge then it will appear that we are just doing 
geni_icc_get() from individual SE driver probe not using any of ICC apis.

It looks somewhat asymmetry.


Thanks for reviewing,

Regards,

Akash

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
