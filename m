From: Thor Thayer <tthayer@opensource.altera.com>
Subject: Re: [PATCH 1/2] spi: dw: Initialize of_node to discover DT node children
Date: Wed, 8 Oct 2014 13:27:25 -0500
Message-ID: <5435820D.3020401@opensource.altera.com>
References: <1412711297-31857-1-git-send-email-tthayer@opensource.altera.com>	 <1412711297-31857-2-git-send-email-tthayer@opensource.altera.com> <1412756241.7701.7.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <jkosina@suse.cz>, <pawel.moll@arm.com>,
	<robh+dt@kernel.org>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<dinguyen@opensource.altera.com>, <linux-spi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<tthayer.linux@gmail.com>, <tthayer@altera.com>,
	<axel.lin@ingics.com>, <baruch@tkos.co.il>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1412756241.7701.7.camel@linux.intel.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On 10/08/2014 03:17 AM, Andy Shevchenko wrote:
> On Tue, 2014-10-07 at 14:48 -0500, tthayer@opensource.altera.com wrote:
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> 1. The of_node element must be initialized to enable discovery of node
>> children. The discovery takes place in the of_register_spi_devices() function.
>> 2. Grabbing the bus-num from the device tree.
>> 3. Update the SOCFPGA configuration.
> []
>
>> --- a/drivers/spi/spi-dw.c
>> +++ b/drivers/spi/spi-dw.c
>> @@ -671,6 +671,9 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>>   	master->cleanup = dw_spi_cleanup;
>>   	master->transfer_one_message = dw_spi_transfer_one_message;
>>   	master->max_speed_hz = dws->max_freq;
>> +#if defined(CONFIG_OF)
>> +	master->dev.of_node = dev->of_node;
>> +#endif
> I'm not sure you need this #ifdef surrounded an assignment.
> If I'm wrong then you probably have to use if (IS_ENABLED(CONFIG_OF)).
>
Hi Andy.

Good point. I will remove those.

Thank you for reviewing.
