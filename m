From: Padma Venkat <padma.kvr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: s3c64xx: add support for exynos7 SPI controller
Date: Fri, 14 Nov 2014 16:46:06 +0530
Message-ID: <CAAgF-BcARoRZv=BPqQWyp6rJQQ=CE0FEUz_2vgQSpeZyLwbkBw@mail.gmail.com>
References: <1415267509-16653-1-git-send-email-padma.v@samsung.com>
	<20141106102636.GT8509@sirena.org.uk>
	<CAAgF-BfGwcNzMx0meFVkJqNMTbQ4_PP1PZ3i6edOm6U3bc26_Q@mail.gmail.com>
	<20141107101310.GA8509@sirena.org.uk>
	<CAAgF-Bd=S7-PoA7GZoy87W9Dem3OXVhc1tL-eyWEAHvF0LPTKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAgF-Bd=S7-PoA7GZoy87W9Dem3OXVhc1tL-eyWEAHvF0LPTKQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On 11/10/14, Padma Venkat <padma.kvr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Mark,
>
> On 11/7/14, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> On Fri, Nov 07, 2014 at 02:01:57PM +0530, Padma Venkat wrote:
>>
>>> CS can also be controlled automatically by setting AUTO_N_MANUAL to 1
>>> in CS_CFG. When it is auto CS automatically toggles between packet to
>>> packet. NCS_TIME_COUNT in CS_CFG controls the inactive period. The
>>> driver by default uses manual mode. But on exynos7 the manual mode is
>>> removed.
>>
>> OK, but what's a packet here?
>
> Packet is either 1 byte or 4 bytes size depends on width of the SPI
> channel.
>
>>
>>> I tested the driver with wm5110 codec.
>>
>> Did you try firmware downloads or something else that generates multiple
>> transfers in a message?  Normal register writes will use a single
>> transfer so I'd expect them to just work.
>>
>
> OK. I don't have provision to test on this board. I will try to test
> on older boards by disabling manual mode.
>

I tested on exynos5420 peach-pit by enabling auto mode. I used dd
command to read 1MB data from spi flash and I compared the result with
manual mode. Both are same.

> Thanks
> padma
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
