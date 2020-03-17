From: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V2 4/8] tty: serial: qcom_geni_serial: Add interconnect
 support
Date: Tue, 17 Mar 2020 17:18:34 +0530
Message-ID: <e9293de6-004f-6005-8cb6-66f28c080ebe@codeaurora.org>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-5-git-send-email-akashast@codeaurora.org>
 <20200313212833.GK144492@google.com>
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
In-Reply-To: <20200313212833.GK144492-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Matthias,

On 3/14/2020 2:58 AM, Matthias Kaehlcke wrote:
> Hi Akash,
>
> On Fri, Mar 13, 2020 at 06:42:10PM +0530, Akash Asthana wrote:
>> Get the interconnect paths for Uart based Serial Engine device
>> and vote according to the baud rate requirement of the driver.
>>
>> Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>> Changes in V2:
>>   - As per Bjorn's comment, removed se == NULL check from geni_serial_icc_get
>>   - As per Bjorn's comment, removed code to set se->icc_path* to NULL in failure
>>   - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
>>     path handle
>>   - As per Matthias comment, added error handling for icc_set_bw call
>>
>>   drivers/tty/serial/qcom_geni_serial.c | 69 +++++++++++++++++++++++++++++++++--
>>   1 file changed, 65 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>> index 272bae0..c8ad7e9 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -184,6 +184,19 @@ static struct qcom_geni_serial_port qcom_geni_console_port = {
>>   	},
>>   };
>>   
>> +static int geni_serial_icc_get(struct geni_se *se)
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
>> +
>>   static int qcom_geni_serial_request_port(struct uart_port *uport)
>>   {
>>   	struct platform_device *pdev = to_platform_device(uport->dev);
>> @@ -962,6 +975,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>>   	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>>   	unsigned long clk_rate;
>>   	u32 ver, sampling_rate;
>> +	int ret;
>>   
>>   	qcom_geni_serial_stop_rx(uport);
>>   	/* baud rate */
>> @@ -983,6 +997,18 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>>   	ser_clk_cfg = SER_CLK_EN;
>>   	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
>>   
>> +	/*
>> +	 * Put BW vote only on CPU path as driver supports FIFO mode only.
>> +	 * Assume peak_bw as twice of avg_bw.
>> +	 */
>> +	port->se.avg_bw_cpu = Bps_to_icc(baud);
>> +	port->se.peak_bw_cpu = Bps_to_icc(2 * baud);
>> +	ret = icc_set_bw(port->se.icc_path_cpu_to_geni, port->se.avg_bw_cpu,
>> +			port->se.peak_bw_cpu);
>> +	if (ret)
>> +		dev_err(uport->dev, "%s: ICC BW voting failed for cpu\n",
>> +			__func__);
> Should this return an error? The port might not operate properly if the ICC
> bandwidth couldn't be configured

This is void function we can't return error from here. I guess it would 
be somewhat okay if BW voting failed for CPU path but clk_set_rate 
failure is more serious which is called from this function, I don't 
think it can be move to somewhere else.

>
>
>> +
>>   	/* parity */
>>   	tx_trans_cfg = readl(uport->membase + SE_UART_TX_TRANS_CFG);
>>   	tx_parity_cfg = readl(uport->membase + SE_UART_TX_PARITY_CFG);
>> @@ -1208,16 +1234,40 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
>>   		unsigned int new_state, unsigned int old_state)
>>   {
>>   	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>> -
>> +	int ret;
>>   	/* If we've never been called, treat it as off */
>>   	if (old_state == UART_PM_STATE_UNDEFINED)
>>   		old_state = UART_PM_STATE_OFF;
>>   
>> -	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
>> +	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF) {
>> +		/* Put BW vote for core clocks and CPU */
>> +		ret = icc_set_bw(port->se.icc_path_geni_to_core,
>> +			port->se.avg_bw_core, port->se.peak_bw_core);
>> +		if (ret)
>> +			dev_err(uport->dev, "%s: ICC BW voting failed for core\n",
>> +				__func__);
>> +
>> +		ret = icc_set_bw(port->se.icc_path_cpu_to_geni,
>> +			port->se.avg_bw_cpu, port->se.peak_bw_cpu);
>> +		if (ret)
>> +			dev_err(uport->dev, "%s: ICC BW voting failed for cpu\n",
>> +				__func__);
>> +
>>   		geni_se_resources_on(&port->se);
>> -	else if (new_state == UART_PM_STATE_OFF &&
>> -			old_state == UART_PM_STATE_ON)
>> +	} else if (new_state == UART_PM_STATE_OFF &&
>> +			old_state == UART_PM_STATE_ON) {
>>   		geni_se_resources_off(&port->se);
>> +		/* Remove BW vote from core clocks and CPU */
>> +		ret = icc_set_bw(port->se.icc_path_geni_to_core, 0, 0);
>> +		if (ret)
>> +			dev_err(uport->dev, "%s: ICC BW remove failed for core\n",
>> +				__func__);
>> +
>> +		ret = icc_set_bw(port->se.icc_path_cpu_to_geni, 0, 0);
>> +		if (ret)
>> +			dev_err(uport->dev, "%s: ICC BW remove failed for cpu\n",
>> +				__func__);
>> +	}
>>   }
>>   
>>   static const struct uart_ops qcom_geni_console_pops = {
>> @@ -1308,6 +1358,17 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>>   	port->rx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
>>   	port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
>>   
>> +	ret = geni_serial_icc_get(&port->se);
>> +	if (ret)
>> +		return ret;
>> +	/* Set the bus quota to a reasonable value */
>> +	port->se.avg_bw_core = console ? Bps_to_icc(1000) :
>> +		Bps_to_icc(CORE_2X_50_MHZ);
> Why different settings for console vs. non-console?

QUP FW runs on core clock. To support higher throughput we want FW to 
run at higher speed.

Since Console operate at 115200bps and BT operate at 3.2Mbps baud. We 
are voting higher on core for BT usecase.

These value are recommended from HW team.

>
>> +	port->se.peak_bw_core = console ? Bps_to_icc(1000) :
>> +		Bps_to_icc(CORE_2X_100_MHZ);
>> +	port->se.avg_bw_cpu = Bps_to_icc(1000);
>> +	port->se.peak_bw_cpu = Bps_to_icc(1000);
> 'Bps_to_icc(1000)' is a recurring theme in this series, could it be worth
> to have a constant for that? Could be GENI_DEFAULT_BW or similar.

ok

Thanks for reviewing the patch.

Regards,

Akash

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
