From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/1] spi: pxa2xx: add driver enabling message
Date: Wed, 10 Apr 2019 10:55:29 +0300
Message-ID: <2c853342-f937-30e6-ce6f-010e06f7376c@linux.intel.com>
References: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
 <51e9e073-625d-f5c0-6b2e-410f6ddb6346@linux.intel.com>
 <6cef52a73fb547bb9c0dd84efca8f7f8@asem.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Flavio Suligoi <f.suligoi@asem.it>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6cef52a73fb547bb9c0dd84efca8f7f8@asem.it>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 4/9/19 5:11 PM, Flavio Suligoi wrote:
> Hi Jarkko,
> 
>> Hi
>>
>> On 4/8/19 6:22 PM, Flavio Suligoi wrote:
>>> Add an info message for the PXA2xx device driver start-up,
>>> with the indication of the transfer mode used (DMA or GPIO).
>>>
>>> This info is useful to individuate the timing when
>>> the module starts.
>>>
>>> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
>>> ---
>>>    drivers/spi/spi-pxa2xx.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
>>> index f7068cc..d449501 100644
>>> --- a/drivers/spi/spi-pxa2xx.c
>>> +++ b/drivers/spi/spi-pxa2xx.c
>>> @@ -1826,6 +1826,9 @@ static int pxa2xx_spi_probe(struct platform_device
>> *pdev)
>>>    		goto out_error_clock_enabled;
>>>    	}
>>>
>>> +	dev_info(dev, "PXA2xx SPI master controller (%s mode)\n",
>>> +		 platform_info->enable_dma ? "DMA" : "PIO");
>>> +
>>>    	return status;
>>>
>> Would this look better if moved before devm_spi_register_controller()
>> call?
> 
> Ok, so in case of SPI registering failure, we have two messages, as:
> 
> pxa2xx-spi 80860F0E:00: PXA2xx SPI master controller (DMA mode)
> pxa2xx-spi 80860F0E:00: problem registering spi controller
> 
> Do you think that it is more explicative?
> 
I think yes and it should not cause confusion since the error message is 
the last one.

I was thinking the successful registration case when DMA is not 
available. First there is a warning, followed by a debug message from 
SPI core (if CONFIG_SPI_DEBUG) and then info message.

[    9.506895] pxa2xx-spi pxa2xx-spi.13: no DMA channels available, 
using PIO
[    9.516770] pxa2xx-spi pxa2xx-spi.13: registered master spi2
[    9.518527] pxa2xx-spi pxa2xx-spi.13: PXA2xx SPI master controller 
(PIO mode)

Actually this info message doesn't necessarily tell will the driver end 
up using DMA for transfers. See pxa2xx_spi_can_dma() and 
pxa2xx_spi_transfer_one().

How about replacing "no DMA channels available, using PIO" and have 
instead single info message telling is the DMA available or does the 
driver use PIO only?

-- 
Jarkko
