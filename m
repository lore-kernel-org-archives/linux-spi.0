From: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Fri, 14 Aug 2015 12:08:31 +0200
Message-ID: <CAKor6TdKrQrvXTPU=fzL9LTCBbyc9WAbLnYdObY+Wu73g1w6Fg@mail.gmail.com>
References: <CAKor6TdheYM73aqti362bOnP2GZmX60uuDY5v2eow1vqO9tcKw@mail.gmail.com>
	<20150715081224.GN16517@opensource.wolfsonmicro.com>
	<20150715091709.GK11162@sirena.org.uk>
	<CAKor6TcSc7n=Rd9NJAf-6cYXr50Z62cbcsbuaEutRMPAiM=2NQ@mail.gmail.com>
	<20150717085434.GO16517@opensource.wolfsonmicro.com>
	<CAKor6Tcof3PA3JGD2=4X8mtSak8ka9BVD2L4zdYC4M1yEYEXjg@mail.gmail.com>
	<CAKor6TdLkGZbARmV1CfqUiguH8HAD+oC8VSsH_OkNQ6E-7YVAw@mail.gmail.com>
	<20150810081001.GG25225@opensource.wolfsonmicro.com>
	<20150810083540.GE1540@lahna.fi.intel.com>
	<CAKor6Tc26kKG-7ytxBjT41S1h4eORoeTg_T=nZ4dZGM1H0gAMQ@mail.gmail.com>
	<20150810140207.GB1541@lahna.fi.intel.com>
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
In-Reply-To: <20150810140207.GB1541-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2015-08-10 16:02 GMT+02:00 Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>:
> On Mon, Aug 10, 2015 at 03:48:31PM +0200, Christian Hartmann wrote:
>> > You should use devm_gpiod_get() and friends. If you do not have
>> > corresponding Linux device node, then it is fwnode_get_named_gpiod().
>>
>> It seems the fwnode_get_named_gpiod() function will be used in my case,
>> but how can I get the fwnode??

I am trying to use devm_gpiod_get now
but before I have to add the gpios via the mapping as decscribed in
the consumer documentation
>
> There is acpi_fwnode_handle() in include/acpi/acpi_bus.h. However, if
> you have Linux device available you should really use devm_gpio_*
> functions instead.
Hi,

I am actually stucking to get the ACPI handle via
handle = ACPI_HANDLE(&arizona->dev)
it complaints about dev->fwnode

I am looking to get it working with acpi_fwnode_handle() at the moment

cheers
chris
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
