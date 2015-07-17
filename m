From: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Fri, 17 Jul 2015 08:56:26 +0200
Message-ID: <CAKor6TcSc7n=Rd9NJAf-6cYXr50Z62cbcsbuaEutRMPAiM=2NQ@mail.gmail.com>
References: <20150626115823.GY14071@sirena.org.uk>
	<CAKor6Tf20eC1WQSO=AV2b+XoB5Qv-2Oin_nrrTJUiDV4czxLjA@mail.gmail.com>
	<20150629094854.GB11162@sirena.org.uk>
	<CAKor6TdDPb2qOgdHbeX2w+yQa_ioDM5ak9bk+=jF+cKt_twiXw@mail.gmail.com>
	<20150630103404.GI6321@opensource.wolfsonmicro.com>
	<CAKor6TdKk2OUz4o12RiQBSVZyhD=L4JpBJcYkGE=_6X+ZeQY_g@mail.gmail.com>
	<20150713095359.GM16517@opensource.wolfsonmicro.com>
	<CAKor6Td83zgOS+iHGHGhFW4n26H=tC-QQDuzaHHfybhLeH-jvw@mail.gmail.com>
	<CAKor6TdheYM73aqti362bOnP2GZmX60uuDY5v2eow1vqO9tcKw@mail.gmail.com>
	<20150715081224.GN16517@opensource.wolfsonmicro.com>
	<20150715091709.GK11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150715091709.GK11162-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2015-07-15 11:17 GMT+02:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Wed, Jul 15, 2015 at 09:12:24AM +0100, Charles Keepax wrote:
>
> Folks, please remember to delete irrelevant context from your replies so
> it's possible to find any new content you might have added.
>
>> I suspect we still have some issues with the GPIO lookups, I
>> suspect we want to actually pull them from ACPI rather than
>> putting them into the pdata, as I don't know if the number will
>> translate directly over.
>
> Yes, you shouldn't be fishing numbers directly out of ACPI but instead
> resolving them into Linux GPIO numbers.

Hi,

as mentioned before it should be using the gpiolib.h to get the right
gpios from ACPI space, right??
I am looking how this would be done in this case, hope to understand
and get it today working with gpiolib

By the way I have restest (with a lot more local debugs) and I know
now that the function arizona_dev_init()
wrongly calls the arizona_of_get_core_pdata() which could not work here...

so these two open issues I have to resolve yet before I can have fun
with the new alsa sound device


cheers
chris
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
