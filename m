From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] spi: Fix SPI_CS_HIGH setting when using native and GPIO
 CS
Date: Thu, 24 Oct 2019 18:13:16 +0100
Message-ID: <4be58f82-eeb1-83a5-4c83-1e86f3b82769@nvidia.com>
References: <20191018152929.3287-1-gregory.clement@bootlin.com>
 <dfabf9eb-4f81-91e5-55dc-caea0cdabd2d@nvidia.com> <87zhhqp4wf.fsf@FE-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
To: Gregory CLEMENT <gregory.clement@bootlin.com>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <87zhhqp4wf.fsf@FE-laptop>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On 24/10/2019 15:57, Gregory CLEMENT wrote:
> Hello Jon,
> 
>> On 18/10/2019 16:29, Gregory CLEMENT wrote:
>>> When improving the CS GPIO support at core level, the SPI_CS_HIGH
>>> has been enabled for all the CS lines used for a given SPI controller.
>>>
>>> However, the SPI framework allows to have on the same controller native
>>> CS and GPIO CS. The native CS may not support the SPI_CS_HIGH, so they
>>> should not be setup automatically.
>>>
>>> With this patch the setting is done only for the CS that will use a
>>> GPIO as CS
>>>
>>> Fixes: f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>>> ---
>>>  drivers/spi/spi.c | 18 +++++++++---------
>>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>>> index 5414a10afd65..1b68acc28c8f 100644
>>> --- a/drivers/spi/spi.c
>>> +++ b/drivers/spi/spi.c
>>> @@ -1880,15 +1880,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>>>  		spi->mode |= SPI_3WIRE;
>>>  	if (of_property_read_bool(nc, "spi-lsb-first"))
>>>  		spi->mode |= SPI_LSB_FIRST;
>>> -
>>> -	/*
>>> -	 * For descriptors associated with the device, polarity inversion is
>>> -	 * handled in the gpiolib, so all chip selects are "active high" in
>>> -	 * the logical sense, the gpiolib will invert the line if need be.
>>> -	 */
>>> -	if (ctlr->use_gpio_descriptors)
>>> -		spi->mode |= SPI_CS_HIGH;
>>> -	else if (of_property_read_bool(nc, "spi-cs-high"))
>>> +	if (of_property_read_bool(nc, "spi-cs-high"))
>>>  		spi->mode |= SPI_CS_HIGH;
>>>  
>>>  	/* Device DUAL/QUAD mode */
>>> @@ -1952,6 +1944,14 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>>>  	}
>>>  	spi->chip_select = value;
>>>  
>>> +	/*
>>> +	 * For descriptors associated with the device, polarity inversion is
>>> +	 * handled in the gpiolib, so all gpio chip selects are "active high"
>>> +	 * in the logical sense, the gpiolib will invert the line if need be.
>>> +	 */
>>> +	if ((ctlr->use_gpio_descriptors) && ctlr->cs_gpiods[spi->chip_select])
>>> +		spi->mode |= SPI_CS_HIGH;
>>> +
>>
>> This patch is causing a boot regression on one of our Tegra boards. 
>> Bisect is pointing to this commit and reverting on top of today's -next
>> fixes the problem. 
>>
>> This patch is causing the following NULL pointer crash which I assume is
>> because we have not checked if 'ctlr->cs_gpiods' is valid before
>> dereferencing ...
> 
> I've just submitted a fixe for it
> 
> https://patchwork.kernel.org/patch/11209839/

Great! Thanks, Jon

-- 
nvpublic
