From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-atmel: Use devm_*() functions
Date: Wed, 4 Dec 2013 13:07:48 +0100
Message-ID: <529F1B14.3000606@atmel.com>
References: <002b01cef0ae$c8261dc0$58725940$%han@samsung.com> <529EFA38.7050404@atmel.com> <20131204115921.GL29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131204115921.GL29268-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 04/12/2013 12:59, Mark Brown :
> On Wed, Dec 04, 2013 at 10:47:36AM +0100, Nicolas Ferre wrote:
>> On 04/12/2013 06:07, Jingoo Han :
>
>>>   out_free_irq:
>>> -	free_irq(irq, master);
>>>   out_unmap_regs:
>>>   out_free_buffer:
>
>> What about taking advantage of this cleanup patch to remove the 3
>> above unneeded tags?
>
>> Otherwise, you can add my:
>> Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>
> That's a good idea but it means going and changing all the gotos as well
> so it probably warrants a separate patch.  I applied this one as-is.

True! Thanks Mark.

Bye,
-- 
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
