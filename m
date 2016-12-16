From: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [patch 1/3] spi: armada-3700: Signedness bug in probe
Date: Fri, 16 Dec 2016 11:29:23 +0100
Message-ID: <9e5f6a38-6177-4026-7930-150c6b281a99@free-electrons.com>
References: <20161216082443.GA7031@elgon.mountain>
 <e1c6a534-6b6c-a83f-390f-b65654ff2bcf@free-electrons.com>
 <20161216095655.GB8244@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161216095655.GB8244@mwanda>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

Le 16/12/2016 à 10:56, Dan Carpenter a écrit :
> On Fri, Dec 16, 2016 at 10:36:29AM +0100, Romain Perier wrote:
>> Hello,
>>
>> Le 16/12/2016 à 10:33, Dan Carpenter a écrit :
>>> We need "irq" to be an int because platform_get_irq() returns negative
>>> error codes.
>>>
>>> Fixes: 5762ab71eb24 ("spi: Add support for Armada 3700 SPI Controller")
>>> Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
>>>
>>> diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
>>> index e89da0af45d2..5c7508dc6f0b 100644
>>> --- a/drivers/spi/spi-armada-3700.c
>>> +++ b/drivers/spi/spi-armada-3700.c
>>> @@ -108,7 +108,7 @@ struct a3700_spi {
>>> 	struct spi_master *master;
>>> 	void __iomem *base;
>>> 	struct clk *clk;
>>> -	unsigned int irq;
>>> +	int irq;
>>> 	unsigned int flags;
>>> 	bool xmit_data;
>>> 	const u8 *tx_buf;
>>>
>>
>> It is already fixed, see https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=f6f0083cca66e673cca6fa26b52b107b5570081d
>>
>
> Ah good.
>
>> And no we cannot just replace the type of the irq field like this
>> because devm_request_irq/request_irq require an unsigned int as
>> "irq" parameter.
>
> That's immaterial, my patch works fine.  There are other place that use
> a signed IRQ like the irq handler and platform_get_irq() which I
> mentioned in my patch description.  It's never going to be perfectly
> consistent.
>
> But this is actually important that you thought it mattered.  Is there
> something that prints a warning?  These irq signedness bugs are some of
> the most common recurring bugs I see so it would help to figure out
> why people are doing this...

Well, Yes technically it is correct as we exclude the case where 
spi->irq is < 0, so even if you pass an int as request_irq is will be 
always positive. That's just more consistent with API of request_irq, 
nothing more.

Originally, that was a mistake from me (to use an unsigned int with the 
return value returned by platform_get_irq).

Thanks for your feedback,

Romain
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
