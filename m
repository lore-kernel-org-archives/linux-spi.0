From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add Analog Devices AXI SPI Engine controller
 support
Date: Fri, 5 Feb 2016 17:04:11 +0100
Message-ID: <56B4C7FB.3080204@metafoo.de>
References: <1454602410-14049-1-git-send-email-lars@metafoo.de>
 <1454602410-14049-2-git-send-email-lars@metafoo.de>
 <CAHp75VcQ1WrHVxk=6xNrjhsep=2YhcMLiXAPChXeB+fG3MX2fQ@mail.gmail.com>
 <56B4B1E9.7080804@metafoo.de>
 <CAHp75Vd1WEGDaFx99mX3jN5xXNZ9Rc6R_pE8G5kyGfNirF7T6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75Vd1WEGDaFx99mX3jN5xXNZ9Rc6R_pE8G5kyGfNirF7T6A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 02/05/2016 04:32 PM, Andy Shevchenko wrote:
> On Fri, Feb 5, 2016 at 4:30 PM, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:
>>>> +       clk_div = DIV_ROUND_UP(clk_get_rate(spi_engine->ref_clk),
>>>> +               xfer->speed_hz * 2);
>>>
>>>> +       if (clk_div > 255)
>>>> +               clk_div = 255;
>>>> +       else if (clk_div > 0)
>>>> +               clk_div -= 1;
>>>
>>> 255 is okay, 254 is not, 253- is okay. Why 254 is so special?
>>
>> I don't see that. The condition is > 255, so everything greater or equal
>> than 256 gets mapped to 255. Everything else to x - 1, so 255 to 254, 254 to
>> 253.
> 
> Ah, you are right.
> 
>>>> +               for (i = 0; i < m; i++)
>>>> +                       writel_relaxed(buf[i], addr);
>>>
>>> writesl() ?
>>
>> Hm, maybe. Does it really have the same semantics?
> 
> It's a loop inside, so it has a count parameter. Otherwise it should be similar.

It seems to have different semantics in terms of endianness and ordering.

> 
>>>> +static int spi_engine_transfer_one_message(struct spi_master *master,
>>>> +       struct spi_message *msg)
>>>
>>> And you are not using transfer_one() because of..?
>>
>> transfer_one() does flow control in software. Execution is passed back to
>> software after each transfer and it also takes care of handling the chip
>> select assertion/deassertion as well as the delays. It's useful for hardware
>> which does not support hardware flow control. In this case the hardware
>> supports flow control including chip-select logic as well as delays. Making
>> use of this generates far less context switches per message and also has
>> predictable timings between transfers within a message.
> 
> Maybe the hardware flow control implementation is needed?

But wouldn't that be transfer_one_message?


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
