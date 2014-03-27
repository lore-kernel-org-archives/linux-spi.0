From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] spi: nuc900: Fix setting multiple bits settings in register
Date: Thu, 27 Mar 2014 08:41:45 +0800
Message-ID: <CAFRkauD5RnrXsiZbkqtXeB=F0nd9GsG3QjtxknKu40tFsCREGw@mail.gmail.com>
References: <1395412823.9974.2.camel@phoenix>
	<20140326164819.GC14287@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140326164819.GC14287-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014-03-27 0:48 GMT+08:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Fri, Mar 21, 2014 at 10:40:23PM +0800, Axel Lin wrote:
>> The correct way to set multiple bits settings is always clear these
>> bit fields before set new settings.
>>
>> Current code does not cause problem because the reset value of these
>> bit fields are 0, and these settings only set once during probe.
>
> This doesn't seem to apply against current code, can you please check
> and resend?
It's because v1 is applied.
I personally do not have strong preference between v1 and v2.
Is it ok to keep it as is since it's applied.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
