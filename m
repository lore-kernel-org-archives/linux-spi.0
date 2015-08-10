From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init
	of WM510205 codec via ACPI (resend)
Date: Mon, 10 Aug 2015 09:10:01 +0100
Message-ID: <20150810081001.GG25225@opensource.wolfsonmicro.com>
References: <CAKor6TdKk2OUz4o12RiQBSVZyhD=L4JpBJcYkGE=_6X+ZeQY_g@mail.gmail.com> <20150713095359.GM16517@opensource.wolfsonmicro.com> <CAKor6Td83zgOS+iHGHGhFW4n26H=tC-QQDuzaHHfybhLeH-jvw@mail.gmail.com> <CAKor6TdheYM73aqti362bOnP2GZmX60uuDY5v2eow1vqO9tcKw@mail.gmail.com> <20150715081224.GN16517@opensource.wolfsonmicro.com> <20150715091709.GK11162@sirena.org.uk> <CAKor6TcSc7n=Rd9NJAf-6cYXr50Z62cbcsbuaEutRMPAiM=2NQ@mail.gmail.com> <20150717085434.GO16517@opensource.wolfsonmicro.com> <CAKor6Tcof3PA3JGD2=4X8mtSak8ka9BVD2L4zdYC4M1yEYEXjg@mail.gmail.com> <CAKor6TdLkGZbARmV1CfqUiguH8HAD+oC8VSsH_OkNQ6E-7YVAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
To: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKor6TdLkGZbARmV1CfqUiguH8HAD+oC8VSsH_OkNQ6E-7YVAw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Aug 10, 2015 at 10:00:38AM +0200, Christian Hartmann wrote:
> Hi again,
> 
> in the case of CONFIG_OF (this machine has no OF) the arizona_of_get_core_pdata
> sets also gpio_defaults for struct pdata, which I had not added into
> the #else switch (CONFIG_OF is not set).
> 
> All I have is an one example in
> Documentation/devicetree/bindings/mfd/arizona.txt.
> 
> What should I do here cause I do not now the defaults but they seem to
> be needed too and I cannot use devicetree here.
> Where can I get the gpio-defaults or how can I use gpiolib to extract
> these defaults and gpio pins as expected?
> 

Those defaults are for the GPIOs on the CODEC and have nothing to
do with getting the reset and ldo enable working. You only need
to set them if you are going to use pins on the CODEC to control
something else.

> 
> 
> Looking again ( and again at the code), I have to use a function
> similar to arizona_of_get_named_gpio to find all of these pins, is
> there a function for the acpi case?

No as we have discussed currently the driver has no support for
ACPI. I would imagine there is an ACPI equivalent of
of_get_named_gpio which is what the function you mention uses to
get the actual GPIO number though. But I don't know what the
exact function is.

Thanks,
Charles

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
