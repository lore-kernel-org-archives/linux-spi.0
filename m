From: Akash Asthana <akashast@codeaurora.org>
Subject: Re: [PATCH 2/6] tty: serial: qcom_geni_serial: Add interconnect
 support
Date: Wed, 19 Feb 2020 18:58:18 +0530
Message-ID: <89eac104-3912-5947-48bf-8f204aae5628@codeaurora.org>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-3-git-send-email-akashast@codeaurora.org>
 <20200218031552.GW955802@ripper>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gregkh@linuxfoundation.org, agross@kernel.org, wsa@the-dreams.de,
        broonie@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20200218031552.GW955802@ripper>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 2/18/2020 8:45 AM, Bjorn Andersson wrote:
> On Mon 17 Feb 05:30 PST 2020, Akash Asthana wrote:
>
>> Get the interconnect paths for Uart based Serial Engine device
>> and vote according to the baud rate requirement of the driver.
>>
>> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
>> ---
>>   drivers/tty/serial/qcom_geni_serial.c | 84 ++++++++++++++++++++++++++++++-----
>>   1 file changed, 74 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>> index 191abb1..a8fb2b7 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -174,6 +174,35 @@ static struct qcom_geni_serial_port qcom_geni_console_port = {
>>   	},
>>   };
>>   
>> +static int geni_serial_icc_get(struct geni_se *se)
>> +{
>> +	if (!se)
> If se == NULL the kernel has already oopsed as it dereferenced port->se
> a few lines before calling this function.
Ok, I will remove this check.
>> +		return -EINVAL;
>> +
>> +	se->icc_path[GENI_TO_CORE] = of_icc_get(se->dev, "qup-core");
>> +	if (IS_ERR(se->icc_path[GENI_TO_CORE]))
>> +		return PTR_ERR(se->icc_path[GENI_TO_CORE]);
>> +
>> +	se->icc_path[CPU_TO_GENI] = of_icc_get(se->dev, "qup-config");
>> +	if (IS_ERR(se->icc_path[CPU_TO_GENI])) {
>> +		icc_put(se->icc_path[GENI_TO_CORE]);
>> +		se->icc_path[GENI_TO_CORE] = NULL;
> You're going to fail probe when this happens, so why the need to reset
> this path?
Ok, I will remove this
>> +		return PTR_ERR(se->icc_path[CPU_TO_GENI]);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +void geni_serial_icc_put(struct geni_se *se)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(se->icc_path); i++) {
>> +		icc_put(se->icc_path[i]);
> In geni_serial_icc_get() you hard open code this loop, so why not do the
> same here, to maintain some symmetry.
Ok
>
>> +		se->icc_path[i] = NULL;
> Again, what's the purpose of this clear?
Will remove this
>
>> +	}
>> +}
>> +
>>   static int qcom_geni_serial_request_port(struct uart_port *uport)
>>   {
>>   	struct platform_device *pdev = to_platform_device(uport->dev);
>> @@ -949,6 +978,12 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>>   	ser_clk_cfg = SER_CLK_EN;
>>   	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
>>   
>> +	/* Put BW vote only on CPU path as driver supports FIFO mode only */
>> +	port->se.avg_bw_cpu = Bps_to_icc(baud);
>> +	port->se.peak_bw_cpu = Bps_to_icc(2 * baud);
>> +	icc_set_bw(port->se.icc_path[CPU_TO_GENI], port->se.avg_bw_cpu,
>> +			port->se.peak_bw_cpu);
>> +
>>   	/* parity */
>>   	tx_trans_cfg = readl(uport->membase + SE_UART_TX_TRANS_CFG);
>>   	tx_parity_cfg = readl(uport->membase + SE_UART_TX_PARITY_CFG);
>> @@ -1179,11 +1214,20 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
>>   	if (old_state == UART_PM_STATE_UNDEFINED)
>>   		old_state = UART_PM_STATE_OFF;
>>   
>> -	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
>> +	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF) {
>> +		/* Put BW vote for core clocks and CPU */
>> +		icc_set_bw(port->se.icc_path[GENI_TO_CORE],
>> +			port->se.avg_bw_core, port->se.peak_bw_core);
>> +		icc_set_bw(port->se.icc_path[CPU_TO_GENI], port->se.avg_bw_cpu,
>> +			port->se.peak_bw_cpu);
>>   		geni_se_resources_on(&port->se);
>> -	else if (new_state == UART_PM_STATE_OFF &&
>> -			old_state == UART_PM_STATE_ON)
>> +	} else if (new_state == UART_PM_STATE_OFF &&
>> +			old_state == UART_PM_STATE_ON) {
>>   		geni_se_resources_off(&port->se);
>> +		/* Remove BW vote from core clocks and CPU */
>> +		icc_set_bw(port->se.icc_path[GENI_TO_CORE], 0, 0);
>> +		icc_set_bw(port->se.icc_path[CPU_TO_GENI], 0, 0);
>> +	}
>>   }
>>   
>>   static const struct uart_ops qcom_geni_console_pops = {
>> @@ -1274,15 +1318,30 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>>   	port->rx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
>>   	port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
>>   
>> +	ret = geni_serial_icc_get(&port->se);
>> +	if (ret)
>> +		return ret;
>> +	/* Set the bus quota to a reasonable value */
>> +	port->se.avg_bw_core = console ? Bps_to_icc(1000) :
>> +		Bps_to_icc(CORE_2X_50_MHZ);
>> +	port->se.peak_bw_core = console ? Bps_to_icc(1000) :
>> +		Bps_to_icc(CORE_2X_100_MHZ);
>> +	port->se.avg_bw_cpu = Bps_to_icc(1000);
>> +	port->se.avg_bw_cpu = Bps_to_icc(1000);
>> +
>>   	port->name = devm_kasprintf(uport->dev, GFP_KERNEL,
>>   			"qcom_geni_serial_%s%d",
>>   			uart_console(uport) ? "console" : "uart", uport->line);
>> -	if (!port->name)
>> -		return -ENOMEM;
>> +	if (!port->name) {
>> +		ret = -ENOMEM;
>> +		goto geni_serial_put_icc;
> Rather than reworking the error handling like this, please introduce a
> devm_icc_get() function in the interconnect API.
>
> Regards,
> Bjorn

Ok will introduce devm_icc_get API.

Regards,

Akash

>> +	}
>>   
>>   	irq = platform_get_irq(pdev, 0);
>> -	if (irq < 0)
>> -		return irq;
>> +	if (irq < 0) {
>> +		ret = irq;
>> +		goto geni_serial_put_icc;
>> +	}
>>   	uport->irq = irq;
>>   	uport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CONSOLE);
>>   
>> @@ -1295,7 +1354,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>>   
>>   	ret = uart_add_one_port(drv, uport);
>>   	if (ret)
>> -		return ret;
>> +		goto geni_serial_put_icc;
>>   
>>   	irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
>>   	ret = devm_request_irq(uport->dev, uport->irq, qcom_geni_serial_isr,
>> @@ -1303,7 +1362,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>>   	if (ret) {
>>   		dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
>>   		uart_remove_one_port(drv, uport);
>> -		return ret;
>> +		goto geni_serial_put_icc;
>>   	}
>>   
>>   	/*
>> @@ -1320,11 +1379,15 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>>   		if (ret) {
>>   			device_init_wakeup(&pdev->dev, false);
>>   			uart_remove_one_port(drv, uport);
>> -			return ret;
>> +			goto geni_serial_put_icc;
>>   		}
>>   	}
>>   
>>   	return 0;
>> +
>> +geni_serial_put_icc:
>> +	geni_serial_icc_put(&port->se);
>> +	return ret;
>>   }
>>   
>>   static int qcom_geni_serial_remove(struct platform_device *pdev)
>> @@ -1335,6 +1398,7 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
>>   	dev_pm_clear_wake_irq(&pdev->dev);
>>   	device_init_wakeup(&pdev->dev, false);
>>   	uart_remove_one_port(drv, &port->uport);
>> +	geni_serial_icc_put(&port->se);
>>   
>>   	return 0;
>>   }
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
