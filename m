From: Akash Asthana <akashast@codeaurora.org>
Subject: Re: [PATCH V2 5/8] i2c: i2c-qcom-geni: Add interconnect support
Date: Tue, 17 Mar 2020 17:21:03 +0530
Message-ID: <e9ffd15b-5910-8b15-63cf-2e7fb157d53e@codeaurora.org>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-6-git-send-email-akashast@codeaurora.org>
 <20200314001728.GL144492@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org,
        evgreen@chromium.org
To: Matthias Kaehlcke <mka@chromium.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20200314001728.GL144492@google.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Matthias,

On 3/14/2020 5:47 AM, Matthias Kaehlcke wrote:
> Hi,
>
> On Fri, Mar 13, 2020 at 06:42:11PM +0530, Akash Asthana wrote:
>> Get the interconnect paths for I2C based Serial Engine device
>> and vote according to the bus speed of the driver.
>>
>> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
>> ---
>> Changes in V2:
>>   - As per Bjorn's comment, removed se == NULL check from geni_i2c_icc_get
>>   - As per Bjorn's comment, removed code to set se->icc_path* to NULL in failure
>>   - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
>>     path handle
>>   - As per Matthias comment, added error handling for icc_set_bw call
>>
>>   drivers/i2c/busses/i2c-qcom-geni.c | 110 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 110 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
>> index 17abf60c..33ab685 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -163,6 +163,23 @@ static void qcom_geni_i2c_conf(struct geni_i2c_dev *gi2c)
>>   	writel_relaxed(val, gi2c->se.base + SE_I2C_SCL_COUNTERS);
>>   }
>>   
>> +static int geni_i2c_icc_get(struct geni_se *se)
>> +{
>> +	se->icc_path_geni_to_core = devm_of_icc_get(se->dev, "qup-core");
>> +	if (IS_ERR(se->icc_path_geni_to_core))
>> +		return PTR_ERR(se->icc_path_geni_to_core);
>> +
>> +	se->icc_path_cpu_to_geni = devm_of_icc_get(se->dev, "qup-config");
>> +	if (IS_ERR(se->icc_path_cpu_to_geni))
>> +		return PTR_ERR(se->icc_path_cpu_to_geni);
>> +
>> +	se->icc_path_geni_to_ddr = devm_of_icc_get(se->dev, "qup-memory");
>> +	if (IS_ERR(se->icc_path_geni_to_ddr))
>> +		return PTR_ERR(se->icc_path_geni_to_ddr);
>> +
>> +	return 0;
>> +}
>> +
>>   static void geni_i2c_err_misc(struct geni_i2c_dev *gi2c)
>>   {
>>   	u32 m_cmd = readl_relaxed(gi2c->se.base + SE_GENI_M_CMD0);
>> @@ -563,6 +580,39 @@ static int geni_i2c_probe(struct platform_device *pdev)
>>   	gi2c->adap.dev.of_node = pdev->dev.of_node;
>>   	strlcpy(gi2c->adap.name, "Geni-I2C", sizeof(gi2c->adap.name));
>>   
>> +	ret = geni_i2c_icc_get(&gi2c->se);
>> +	if (ret)
>> +		return ret;
>> +	/*
>> +	 * Set the bus quota for core and cpu to a reasonable value for
>> +	 * register access.
>> +	 * Set quota for DDR based on bus speed, assume peak requirement
>> +	 * as twice of avg bw.
>> +	 */
>> +	gi2c->se.avg_bw_core = Bps_to_icc(1000);
> as commented on the UART patch, you might want to consider adding a constant
> for this recurring default value.
>
>> +	gi2c->se.peak_bw_core = Bps_to_icc(CORE_2X_100_MHZ);
>> +	gi2c->se.avg_bw_cpu = Bps_to_icc(1000);
>> +	gi2c->se.peak_bw_cpu = Bps_to_icc(1000);
>> +	gi2c->se.avg_bw_ddr = Bps_to_icc(gi2c->clk_freq_out);
>> +	gi2c->se.peak_bw_ddr = Bps_to_icc(2 * gi2c->clk_freq_out);
>> +
>> +	/* Vote for core clocks and CPU for register access */
>> +	ret = icc_set_bw(gi2c->se.icc_path_geni_to_core, gi2c->se.avg_bw_core,
>> +				gi2c->se.peak_bw_core);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "%s: ICC BW voting failed for core\n",
>> +			__func__);
>> +		return ret;
>> +	}
>> +
>> +	ret = icc_set_bw(gi2c->se.icc_path_cpu_to_geni, gi2c->se.avg_bw_cpu,
>> +				gi2c->se.peak_bw_cpu);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "%s: ICC BW voting failed for cpu\n",
>> +			__func__);
>> +		return ret;
>> +	}
>> +
>>   	ret = geni_se_resources_on(&gi2c->se);
>>   	if (ret) {
>>   		dev_err(&pdev->dev, "Error turning on resources %d\n", ret);
>> @@ -584,6 +634,19 @@ static int geni_i2c_probe(struct platform_device *pdev)
>>   		dev_err(&pdev->dev, "Error turning off resources %d\n", ret);
>>   		return ret;
>>   	}
>> +	/* Remove vote from core clocks and CPU */
>> +	ret = icc_set_bw(gi2c->se.icc_path_geni_to_core, 0, 0);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "%s: ICC BW remove failed for core\n",
>> +			__func__);
>> +		return ret;
>> +	}
>> +
>> +	ret = icc_set_bw(gi2c->se.icc_path_cpu_to_geni, 0, 0);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "%s: ICC BW remove failed for cpu\n",
>> +			__func__);
> Should this return an error as for the core clocks?
>
>> +	}
>>   
>>   	dev_dbg(&pdev->dev, "i2c fifo/se-dma mode. fifo depth:%d\n", tx_depth);
>>   
>> @@ -629,6 +692,28 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
>>   		gi2c->suspended = 1;
>>   	}
>>   
>> +	/* Remove BW votes */
>> +	ret = icc_set_bw(gi2c->se.icc_path_geni_to_core, 0, 0);
>> +	if (ret) {
>> +		dev_err_ratelimited(gi2c->se.dev, "%s: ICC BW remove failed for core\n",
>> +			__func__);
>> +		return ret;
>> +	}
>> +
>> +	ret = icc_set_bw(gi2c->se.icc_path_cpu_to_geni, 0, 0);
>> +	if (ret) {
>> +		dev_err_ratelimited(gi2c->se.dev, "%s: ICC BW remove failed for cpu\n",
>> +			__func__);
>> +		return ret;
>> +	}
>> +
>> +	ret = icc_set_bw(gi2c->se.icc_path_geni_to_ddr, 0, 0);
>> +	if (ret) {
>> +		dev_err_ratelimited(gi2c->se.dev, "%s: ICC BW remove failed for ddr\n",
>> +			__func__);
>> +		return ret;
>> +	}
> you could consider putting this and the ICC voting in _runtime_resume() in
> separate functions and call them from here and _probe(). The only difference
> in _probe() is that it doesn't vote for the DDR bandwidth, but that slight
> one-time overhead might be worth for consolidating the code.
>
> Actually all this looks very similar for UART, I2C, SPI and QSPI. It seems it
> should be possible to consolidate this further by having functions like these
> in the geni SE driver:
>
> int geni_icc_get(struct geni_se *se, const char *icc_core, const char *icc_cpu,
> 	const char *icc_ddr)
> {
> 	if (icc_core) {
> 		se->icc_path_geni_to_core = devm_of_icc_get(se->dev, icc_core);
> 		if (IS_ERR(se->icc_path_geni_to_core))
> 			return PTR_ERR(se->icc_path_geni_to_core);
> 	}
>
> 	if (icc_cpu) {
>
> 	...
> }
>
> int geni_icc_vote_on(struct geni_se *se)
> {
> 	if (gi2c->se.icc_path_geni_to_core) {
> 		ret = icc_set_bw(gi2c->se.icc_path_geni_to_core, gi2c->se.avg_bw_core,
> 			gi2c->se.peak_bw_core);
> 		if (ret) {
> 			dev_err_ratelimited(gi2c->se.dev, "%s: ICC BW voting failed for core\n",
> 				__func__);
> 			return ret;
> 		}
> 	}
>
> 	/* or to reduce nesting:
> 	if (!gi2c->se.icc_path_geni_to_core)
> 		goto vote_cpu;
>
> 	ret = icc_set_bw(gi2c->se.icc_path_geni_to_core, gi2c->se.avg_bw_core,
> 			gi2c->se.peak_bw_core);
> 	if (ret) {
> 	...
>
> vote_cpu:
> 	*/
>
> 	if (gi2c->se.icc_path_cpu_to_geni) {
>
> 	...
> }
>
> int geni_icc_vote_off(struct geni_se *se)
> {
> 	if (gi2c->se.icc_path_geni_to_core) {
> 		ret = icc_set_bw(gi2c->se.icc_path_geni_to_core, 0, 0);
> 		if (ret) {
> 			dev_err_ratelimited(gi2c->se.dev, "%s: ICC BW remove failed for core\n",
> 				__func__);
> 			return ret;
> 		}
> 	}
>
> 	if (gi2c->se.icc_path_cpu_to_geni) {
>
> 	...
> }
>
> optionally you could even reduce the code further by having an array of
> 'struct geni_icc_path' (as suggested on https://patchwork.kernel.org/patch/11436889/#23221925)
> and iterate over the array instead of spelling everything out for the 3
> ICC paths.
ok
>> +
>>   	return 0;
>>   }
>>   
>> @@ -637,6 +722,31 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
>>   	int ret;
>>   	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
>>   
>> +	/* Vote on Core, CPU and DDR path respectively */
>> +	ret = icc_set_bw(gi2c->se.icc_path_geni_to_core, gi2c->se.avg_bw_core,
>> +		gi2c->se.peak_bw_core);
>> +	if (ret) {
>> +		dev_err_ratelimited(gi2c->se.dev, "%s: ICC BW voting failed for core\n",
>> +			__func__);
>> +		return ret;
>> +	}
>> +
>> +	ret = icc_set_bw(gi2c->se.icc_path_cpu_to_geni, gi2c->se.avg_bw_cpu,
>> +		gi2c->se.peak_bw_cpu);
>> +	if (ret) {
>> +		dev_err_ratelimited(gi2c->se.dev, "%s: ICC BW voting failed for cpu\n",
>> +			__func__);
>> +		return ret;
>> +	}
>> +
>> +	ret = icc_set_bw(gi2c->se.icc_path_geni_to_ddr, gi2c->se.avg_bw_ddr,
>> +		gi2c->se.peak_bw_ddr);
>> +	if (ret) {
>> +		dev_err_ratelimited(gi2c->se.dev, "%s: ICC BW voting failed for ddr\n",
>> +			__func__);
>> +		return ret;
>> +	}
>> +
> as per above this would be just:
>
> 	ret = geni_icc_vote_on(&gi2c->se);
> 	if (ret)
> 		return ret;
>
> with the same benefit for the other 3 drivers.

Yeah this would be better.

Thanks for reviewing.

regards,

Akash

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
