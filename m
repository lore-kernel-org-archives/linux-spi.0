From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: Applied "spi: imx: dynamic burst length adjust for PIO mode"
 to the spi tree
Date: Fri, 30 Jun 2017 07:55:55 -0700
Message-ID: <5956667B.6040903@mentor.com>
References: <20170613083402.22324-1-jiada_wang@mentor.com> <E1dQub0-0008Ep-Hf@finisterre> <20170630121433.piznjqtmhy35zty6@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170630121433.piznjqtmhy35zty6-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Sascha

On 06/30/2017 05:14 AM, Sascha Hauer wrote:
> Hi Mark,
>
> On Fri, Jun 30, 2017 at 01:00:22PM +0100, Mark Brown wrote:
>> The patch
>>
>>     spi: imx: dynamic burst length adjust for PIO mode
>>
>> has been applied to the spi tree at
>>
>>     git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> Argh, I wasn't fast enough. I just ran spi-loopback-test.ko with this
> patch and it doesn't work properly.
>
>> +	if (spi_imx->count == spi_imx->remainder) {
>> +		ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
>> +		ctrl&= ~MX51_ECSPI_CTRL_BL_MASK;
>> +		if (spi_imx->count>  MX51_ECSPI_CTRL_MAX_BURST) {
>> +			spi_imx->remainder = spi_imx->count %
>> +					     MX51_ECSPI_CTRL_MAX_BURST;
>> +			val = MX51_ECSPI_CTRL_MAX_BURST;
> This is wrong. MX51_ECSPI_CTRL_MAX_BURST contains the burst length in
> bytes, but the register 'val' is written to takes the burst length in
> bits - 1, so this should be:
>
> 			val = MX51_ECSPI_CTRL_MAX_BURST * 8 - 1;
>
> instead.
Thanks for pointing this out,
I will submit a fix patch.


Thanks,
Jiada
> Sascha
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
