From: Akash Asthana <akashast@codeaurora.org>
Subject: Re: [PATCH 3/6] i2c: i2c-qcom-geni: Add interconnect support
Date: Wed, 19 Feb 2020 19:17:44 +0530
Message-ID: <84a7d97a-4e10-5509-9c87-af8a545c7385@codeaurora.org>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-4-git-send-email-akashast@codeaurora.org>
 <20200218224709.GF15781@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org
To: Matthias Kaehlcke <mka@chromium.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20200218224709.GF15781@google.com>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Matthias,

On 2/19/2020 4:17 AM, Matthias Kaehlcke wrote:
> On Mon, Feb 17, 2020 at 07:00:02PM +0530, Akash Asthana wrote:
>> Get the interconnect paths for I2C based Serial Engine device
>> and vote according to the bus speed of the driver.
>>
>> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
>> ---
>>   drivers/i2c/busses/i2c-qcom-geni.c | 84 ++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 80 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
>> index 17abf60c..5de10a1 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -163,6 +163,44 @@ static void qcom_geni_i2c_conf(struct geni_i2c_dev *gi2c)
>>   	writel_relaxed(val, gi2c->se.base + SE_I2C_SCL_COUNTERS);
>>   }
>>   
>> +static int geni_i2c_icc_get(struct geni_se *se)
>> +{
>> +	if (!se)
>> +		return -EINVAL;
> check is not needed
ok, will remove.
>
>> +
>> +	se->icc_path[GENI_TO_CORE] = of_icc_get(se->dev, "qup-core");
>> +	if (IS_ERR(se->icc_path[GENI_TO_CORE]))
>> +		return PTR_ERR(se->icc_path[GENI_TO_CORE]);
>> +
>> +	se->icc_path[CPU_TO_GENI] = of_icc_get(se->dev, "qup-config");
>> +	if (IS_ERR(se->icc_path[CPU_TO_GENI])) {
>> +		icc_put(se->icc_path[GENI_TO_CORE]);
>> +		se->icc_path[GENI_TO_CORE] = NULL;
> echoing Bjorn's comments on 'tty: serial: qcom_geni_serial: Add
> interconnect support', resetting is not needed since _probe() will
> fail.
ok, will remove
>> +		return PTR_ERR(se->icc_path[CPU_TO_GENI]);
>> +	}
>> +
>> +	se->icc_path[GENI_TO_DDR] = of_icc_get(se->dev, "qup-memory");
>> +	if (IS_ERR(se->icc_path[GENI_TO_DDR])) {
>> +		icc_put(se->icc_path[GENI_TO_CORE]);
>> +		se->icc_path[GENI_TO_CORE] = NULL;
> ditto
ok
>> +		icc_put(se->icc_path[CPU_TO_GENI]);
>> +		se->icc_path[CPU_TO_GENI] = NULL;
> ditto
ok
>> +		return PTR_ERR(se->icc_path[GENI_TO_DDR]);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +void geni_i2c_icc_put(struct geni_se *se)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(se->icc_path); i++) {
>> +		icc_put(se->icc_path[i]);
>> +		se->icc_path[i] = NULL;
> not needed
ok, will remove
>> +	}
>> +}
>> +
>>   static void geni_i2c_err_misc(struct geni_i2c_dev *gi2c)
>>   {
>>   	u32 m_cmd = readl_relaxed(gi2c->se.base + SE_GENI_M_CMD0);
>> @@ -563,17 +601,34 @@ static int geni_i2c_probe(struct platform_device *pdev)
>>   	gi2c->adap.dev.of_node = pdev->dev.of_node;
>>   	strlcpy(gi2c->adap.name, "Geni-I2C", sizeof(gi2c->adap.name));
>>   
>> +	ret = geni_i2c_icc_get(&gi2c->se);
>> +	if (ret)
>> +		return ret;
>> +	/* Set the bus quota to a reasonable value */
>> +	gi2c->se.avg_bw_core = Bps_to_icc(1000);
>> +	gi2c->se.peak_bw_core = Bps_to_icc(CORE_2X_100_MHZ);
>> +	gi2c->se.avg_bw_cpu = Bps_to_icc(1000);
>> +	gi2c->se.peak_bw_cpu = Bps_to_icc(1000);
>> +	gi2c->se.avg_bw_ddr = Bps_to_icc(gi2c->clk_freq_out);
>> +	gi2c->se.peak_bw_ddr = Bps_to_icc(2 * gi2c->clk_freq_out);
>> +
>> +	/* Vote for core clocks and CPU for register access */
>> +	icc_set_bw(gi2c->se.icc_path[GENI_TO_CORE], gi2c->se.avg_bw_core,
>> +				gi2c->se.peak_bw_core);
>> +	icc_set_bw(gi2c->se.icc_path[CPU_TO_GENI], gi2c->se.avg_bw_cpu,
>> +				gi2c->se.peak_bw_cpu);
> error handling needed?

I will add error handling for GENI_TO_CORE path in all the drivers. Will 
it be okay if we don't handle errors for CPU_TO_GENI and GENI_TO_DDR path

as CPU and DDR will be running at much higher frequency?

Regards,

Akash

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
