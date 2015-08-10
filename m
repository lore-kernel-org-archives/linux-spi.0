From: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Mon, 10 Aug 2015 11:20:04 +0200
Message-ID: <CAKor6TfZC3AY0p-85mFAUJJYQ360NoDu6AppipSqAD73S_EkzQ@mail.gmail.com>
References: <20150713095359.GM16517@opensource.wolfsonmicro.com>
	<CAKor6Td83zgOS+iHGHGhFW4n26H=tC-QQDuzaHHfybhLeH-jvw@mail.gmail.com>
	<CAKor6TdheYM73aqti362bOnP2GZmX60uuDY5v2eow1vqO9tcKw@mail.gmail.com>
	<20150715081224.GN16517@opensource.wolfsonmicro.com>
	<20150715091709.GK11162@sirena.org.uk>
	<CAKor6TcSc7n=Rd9NJAf-6cYXr50Z62cbcsbuaEutRMPAiM=2NQ@mail.gmail.com>
	<20150717085434.GO16517@opensource.wolfsonmicro.com>
	<CAKor6Tcof3PA3JGD2=4X8mtSak8ka9BVD2L4zdYC4M1yEYEXjg@mail.gmail.com>
	<CAKor6TdLkGZbARmV1CfqUiguH8HAD+oC8VSsH_OkNQ6E-7YVAw@mail.gmail.com>
	<20150810081001.GG25225@opensource.wolfsonmicro.com>
	<20150810083540.GE1540@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150810083540.GE1540-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2015-08-10 10:35 GMT+02:00 Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>:
> On Mon, Aug 10, 2015 at 09:10:01AM +0100, Charles Keepax wrote:
>> No as we have discussed currently the driver has no support for
>> ACPI. I would imagine there is an ACPI equivalent of
>> of_get_named_gpio which is what the function you mention uses to
>> get the actual GPIO number though. But I don't know what the
>> exact function is.
>
> You should use devm_gpiod_get() and friends. If you do not have
> corresponding Linux device node, then it is fwnode_get_named_gpiod().

Hello,

thanks Charles and Mika.

@Mika: I actually view a patch by you from 6. May 2015 where you
added dev_gpio_irq_get() and the acpi_dev_gpio_irq_get() functions,
seems to be related here to, right??

So I create the next patch to get the right IRQ and the right GPIOs in
question (ldoena, reset).
Will report soon again

cheers
chris
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
