From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add Analog Devices AXI SPI Engine controller support
Date: Fri, 5 Feb 2016 18:34:53 +0200
Message-ID: <CAHp75VezOq14okNyYR+JP0Cv-Pkbxng8gOWuKzMhV8dvPEsEBg@mail.gmail.com>
References: <1454602410-14049-1-git-send-email-lars@metafoo.de>
	<1454602410-14049-2-git-send-email-lars@metafoo.de>
	<CAHp75VcQ1WrHVxk=6xNrjhsep=2YhcMLiXAPChXeB+fG3MX2fQ@mail.gmail.com>
	<56B4B1E9.7080804@metafoo.de>
	<CAHp75Vd1WEGDaFx99mX3jN5xXNZ9Rc6R_pE8G5kyGfNirF7T6A@mail.gmail.com>
	<56B4C7FB.3080204@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56B4C7FB.3080204-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Feb 5, 2016 at 6:04 PM, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:
> On 02/05/2016 04:32 PM, Andy Shevchenko wrote:
>> On Fri, Feb 5, 2016 at 4:30 PM, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:

>>>>> +               for (i = 0; i < m; i++)
>>>>> +                       writel_relaxed(buf[i], addr);
>>>>
>>>> writesl() ?
>>>
>>> Hm, maybe. Does it really have the same semantics?
>>
>> It's a loop inside, so it has a count parameter. Otherwise it should be similar.

> It seems to have different semantics in terms of endianness and ordering.

Ouch, I was totally under impression that they are done in a way of
write*/read*.

>> Maybe the hardware flow control implementation is needed?
>
> But wouldn't that be transfer_one_message?

Depends how many common stuff we might have. For now it is indeed.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
